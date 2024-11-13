import ballerina/http;
import ballerina/log;

# A service representing a network-accessible API
# bound to port `9090`.
# 
configurable string test = ?;

configurable CallbackEndpoint[] externalCallbacks = ?;

type CallbackEndpoint record {|   
    string name;   
    string url;    
    string msgType = "application/json";   
    string certPath = "";
|};

service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + name - the input string name
    # + return - string name with hello message or error
    resource function get greeting(string name) returns string|error {
        // Send a response back to the caller.
        log:printInfo("This is info log", ctx={"name":"choreo"}, randomValue="10");

        if name is "" {
            return error("name should not be empty!");
        }
        return "Hello, Hi n " + name + " , Hiii " + test;
    }

    resource function get callback() returns CallbackEndpoint[]|error {
        // Send a response back to the caller.
        log:printInfo("This is info log", ctx={"name":"choreo"}, randomValue="10");

        if externalCallbacks.length() == 0 {
            return error("No callbacks found");
        }

        return externalCallbacks;
    }
}
