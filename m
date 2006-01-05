Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWAEUaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWAEUaS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWAEUaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:30:17 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:42619 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S932168AbWAEUaQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:30:16 -0500
Date: Thu, 5 Jan 2006 21:29:54 +0100 (CET)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
cc: linux-netdev@vger.kernel.org
Subject: e1000_watchdog_task: NIC Link is Up/Down on kernels 2.4.15 2.4.14
Message-ID: <Pine.LNX.4.64.0601052121270.8434@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (portraits.wsisiz.edu.pl [127.0.0.1]); Thu, 05 Jan 2006 21:30:14 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have machine with build in ethernet interafce, system is Linux Fedora 
Core 4.
Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet 
Controller. It's connected to cisco Catalyst 4000 switch:

#show interface GigabitEthernet3/5

GigabitEthernet3/5 is up, line protocol is up (connected)
   Hardware is Gigabit Ethernet Port, address is xxx
   Description: xxx
   MTU 1500 bytes, BW 1000000 Kbit, DLY 10 usec,
      reliability 255/255, txload 1/255, rxload 1/255
   Encapsulation ARPA, loopback not set
   Keepalive set (10 sec)
   Full-duplex, 1000Mb/s, link type is auto, media type is 10/100/1000-TX
   input flow-control is off, output flow-control is off


configuration on switch interface:

interface GigabitEthernet3/5
  switchport mode access
  switchport nonegotiate
  logging event link-status
  no cdp enable
end



on linux machine:

[root@w3cache ~]# ethtool eth0
Settings for eth0:
         Supported ports: [ TP ]
         Supported link modes:   10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
                                 1000baseT/Full
         Supports auto-negotiation: Yes
         Advertised link modes:  10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
                                 1000baseT/Full
         Advertised auto-negotiation: Yes
         Speed: 1000Mb/s
         Duplex: Full
         Port: Twisted Pair
         PHYAD: 0
         Transceiver: internal
         Auto-negotiation: on
         Supports Wake-on: umbg
         Wake-on: g
         Current message level: 0x00000007 (7)
         Link detected: yes

Some times I observe flaping eth0 interface:

Jan  5 18:31:19 w3cache kernel: e1000: eth0: e1000_watchdog_task: NIC Link 
is Down
Jan  5 18:31:21 w3cache kernel: e1000: eth0: e1000_watchdog_task: NIC Link 
is Up 1000 Mbps Full Duplex
Jan  5 18:31:25 w3cache kernel: e1000: eth0: e1000_watchdog_task: NIC Link 
is Down
Jan  5 18:31:27 w3cache kernel: e1000: eth0: e1000_watchdog_task: NIC Link 
is Up 1000 Mbps Full Duplex
Jan  5 18:56:30 w3cache kernel: e1000: eth0: e1000_watchdog_task: NIC Link 
is Down
Jan  5 18:56:33 w3cache kernel: e1000: eth0: e1000_watchdog_task: NIC Link 
is Up 1000 Mbps Full Duplex

Patchcords and other physical layer is OK. Tested kernels 
kernel-2.6.14-1.1653_FC4 and latest vanilla 2.4.15. I have tried set full 
duplex, speed 1000 on switch but it's happan again.
On cisco switch i don't have seen any flaps this interface or any errors.

Any idea? Thank You.

I have also commited this problem to redhat bugzilla:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177043


-- 
£T
