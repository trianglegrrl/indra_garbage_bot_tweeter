require 'twitter' 
require 'rest-client'

require 'json'
require 'pry'

client = Twitter::REST::Client.new do |config|
  config.consumer_key = "CONSUMER_KEY"
  config.consumer_secret = "CONSUMER_SECRET"
	config.access_token = "ACCESS_TOKEN"
  config.access_token_secret = "ACCESS_TOKEN_SECRET"
end

client.user "INDRAgarbagebot"

def get_current_state 
	response = RestClient.get "https://api.particle.io/v1/devices/54ff70066678574942581067/full_state\?access_token=3766bed852ce344d768142fe1cb41d4416d58b5d"
	
	return unless response

	result = JSON.parse(response)['result']
	return result.to_i
end

full_state = 0

while true do
  current_state = get_current_state

	if current_state != full_state
	  full_state = current_state
    current_state = (get_current_state == 1) ? "full. Please empty me!" : "empty. I'm good for now."
		current_date_time = Time.now.strftime "%d/%m/%Y, %I:%M%p"
		string = "At #{current_date_time} I am #{current_state}"
    client.update string
		puts string
    sleep 10
	end
end




#state = "0"
#while true do
#  current_state = get_current_state
#
#  client.update "I am #{state}
#end
