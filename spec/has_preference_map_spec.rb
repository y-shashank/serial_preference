require 'spec_helper'
require 'fixtures/dummy_class'
describe SerialPreference::HasSerialPreferences do

  before(:all) do
    rebuild_model
  end

  context "default behaviour" do
    it "should return preferences as a default _preferences_attribute" do
      DummyClass._preferences_attribute.should eq(:preferences)
    end
    it "should return settings as a _preferences_attribute" do
      class OverriddenPreferenceAttributeClass < ActiveRecord::Base
        include SerialPreference::HasSerialPreferences
        preferences :settings  do
          preference :abc
        end
      end
      OverriddenPreferenceAttributeClass._preferences_attribute.should eq(:settings)
    end
  end

  context "class methods behaviour" do
    it "should be possible to describe preference map thru preferences" do
      DummyClass.respond_to?(:preferences).should be_true
    end

    it "should be possble to retrieve preference groups from class" do
      DummyClass.respond_to?(:preference_groups).should be_true
    end
  end


  context "should define accessors" do
    it "should have readers available" do
      d = DummyClass.new
      d.respond_to?(:taxable).should be_true
      d.respond_to?(:vat_no).should be_true
      d.respond_to?(:max_invoice_items).should be_true
      d.respond_to?(:income_ledger_id).should be_true
      d.respond_to?(:read_preference_attribute).should be_true
      d.respond_to?(:write_preference_attribute).should be_true
    end

    it "should have writers available" do
      d = DummyClass.new
      d.respond_to?(:taxable=).should be_true
      d.respond_to?(:vat_no=).should be_true
      d.respond_to?(:max_invoice_items=).should be_true
      d.respond_to?(:income_ledger_id=).should be_true
    end

    it "should have query methods available for booleans" do
      DummyClass.new.respond_to?(:taxable?)
    end

  end

=begin
  context "should define validations" do
    it "should define presence validation on required preferences" do
      d = DummyClass.new
      d.should validate_presence_of(:taxable)
    end

    it "should define presence and numericality on required preference which are numeric" do
      d = DummyClass.new
      d.taxable = true
      d.should validate_presence_of(:required_number)
      d.should validate_numericality_of(:required_number)
    end

    it "should define numericality on preference which are numeric" do
      d = DummyClass.new
      d.should validate_numericality_of(:required_number)
      d.should validate_numericality_of(:income_ledger_id)
    end
  end

=end

end
