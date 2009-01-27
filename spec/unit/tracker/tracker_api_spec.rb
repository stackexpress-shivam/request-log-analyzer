require File.dirname(__FILE__) + '/../../spec_helper'

describe RequestLogAnalyzer::Tracker::Timespan do

  include RequestLogAnalyzer::Spec::Helper

  before(:each) do
    @tracker = RequestLogAnalyzer::Tracker::Timespan.new
    @tracker.prepare
  end

  it "should set the first request timestamp correctly" do
    @tracker.update(testing_format.request(:timestamp => 20090102000000))
    @tracker.update(testing_format.request(:timestamp => 20090101000000))    
    @tracker.update(testing_format.request(:timestamp => 20090103000000))        
    
    @tracker.first_timestamp.should == DateTime.parse('Januari 1, 2009 00:00:00')
  end

  it "should set the last request timestamp correctly" do
    @tracker.update(testing_format.request(:timestamp => 20090102000000))
    @tracker.update(testing_format.request(:timestamp => 20090101000000))    
    @tracker.update(testing_format.request(:timestamp => 20090103000000))        

    @tracker.last_timestamp.should == DateTime.parse('Januari 3, 2009 00:00:00')
  end
  
  it "should return the correct timespan in days when multiple requests are given" do
    @tracker.update(testing_format.request(:timestamp => 20090102000000))
    @tracker.update(testing_format.request(:timestamp => 20090101000000))    
    @tracker.update(testing_format.request(:timestamp => 20090103000000))  
    
    @tracker.timespan.should == 2          
  end

  it "should return a timespan of 0 days when only one timestamp is set" do
    @tracker.update(testing_format.request(:timestamp => 20090103000000))  
    @tracker.timespan.should == 0
  end

  it "should raise an error when no timestamp is set" do
    lambda { @tracker.timespan }.should raise_error
  end
end