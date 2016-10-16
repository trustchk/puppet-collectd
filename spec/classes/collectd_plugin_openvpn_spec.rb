require 'spec_helper'

describe 'collectd::plugin::openvpn', type: :class do
  ######################################################################
  # Default param validation, compilation succeeds
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7'
    }
  end

  context ':ensure => present, default params' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7'
      }
    end

    it 'Will create /etc/collectd.d/10-openvpn.conf' do
      should contain_file('openvpn.load').with(ensure: 'present',
                                               path: '/etc/collectd.d/10-openvpn.conf',
                                               content: "#\ Generated by Puppet\n<LoadPlugin openvpn>\n  Globals false\n</LoadPlugin>\n\n<Plugin openvpn>\n  StatusFile \"/etc/openvpn/openvpn-status.log\"\n  ImprovedNamingSchema false\n  CollectCompression true\n  CollectIndividualUsers true\n  CollectUserCount false\n</Plugin>\n\n")
    end
  end

  context ':statusfile param is an array' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7'
      }
    end

    let :params do
      { statusfile: ['/etc/openvpn/openvpn-tcp.status', '/etc/openvpn/openvpn-udp.status'] }
    end

    it 'Will create /etc/collectd.d/10-openvpn.conf with two :statusfile params' do
      should contain_file('openvpn.load').with(ensure: 'present',
                                               path: '/etc/collectd.d/10-openvpn.conf',
                                               content: "#\ Generated by Puppet\n<LoadPlugin openvpn>\n  Globals false\n</LoadPlugin>\n\n<Plugin openvpn>\n  StatusFile \"/etc/openvpn/openvpn-tcp.status\"\n  StatusFile \"/etc/openvpn/openvpn-udp.status\"\n  ImprovedNamingSchema false\n  CollectCompression true\n  CollectIndividualUsers true\n  CollectUserCount false\n</Plugin>\n\n")
    end
  end

  ######################################################################
  # Remaining parameter validation, compilation fails

  context ':statusfile is a string but not an absolute path' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7'
      }
    end

    let :params do
      { statusfile: 'megafrobber' }
    end

    it 'Will raise an error about :statusfile not being an absolute path' do
      should compile.and_raise_error(%r{"megafrobber" is not an absolute path.})
    end
  end

  context ':statusfile param is not a string or array' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7'
      }
    end

    let :params do
      { statusfile: true }
    end

    it 'Will raise an error about :statusfile not being a string or array' do
      should compile.and_raise_error(%r{array or string:})
    end
  end

  context ':improvednamingschema is not a bool' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7'
      }
    end
    let :params do
      { improvednamingschema: 'true' }
    end

    it 'Will raise an error about :improvednamingschema not being a boolean' do
      should compile.and_raise_error(%r{"true" is not a boolean.  It looks to be a String})
    end
  end

  context ':collectcompression is not a bool' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7'
      }
    end
    let :params do
      { collectcompression: 'true' }
    end

    it 'Will raise an error about :collectcompression not being a boolean' do
      should compile.and_raise_error(%r{"true" is not a boolean.  It looks to be a String})
    end
  end

  context ':collectindividualusers is not a bool' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7'
      }
    end
    let :params do
      { collectindividualusers: 'true' }
    end

    it 'Will raise an error about :collectindividualusers not being a boolean' do
      should compile.and_raise_error(%r{"true" is not a boolean.  It looks to be a String})
    end
  end

  context ':collectusercount is not a bool' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7'
      }
    end
    let :params do
      { collectusercount: 'true' }
    end

    it 'Will raise an error about :collectusercount not being a boolean' do
      should compile.and_raise_error(%r{"true" is not a boolean.  It looks to be a String})
    end
  end

  context ':interval is not default and is an integer' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7'
      }
    end
    let :params do
      { interval: 15 }
    end

    it 'Will create /etc/collectd.d/10-openvpn.conf' do
      should contain_file('openvpn.load').with(ensure: 'present',
                                               path: '/etc/collectd.d/10-openvpn.conf',
                                               content: %r{^  Interval 15})
    end
  end

  context ':ensure => absent' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7'
      }
    end
    let :params do
      { ensure: 'absent' }
    end

    it 'Will not create /etc/collectd.d/10-openvpn.conf' do
      should contain_file('openvpn.load').with(ensure: 'absent',
                                               path: '/etc/collectd.d/10-openvpn.conf')
    end
  end
end
