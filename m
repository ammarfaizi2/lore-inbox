Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279937AbRKBCWb>; Thu, 1 Nov 2001 21:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279931AbRKBCWU>; Thu, 1 Nov 2001 21:22:20 -0500
Received: from mx.adelphiacom.com ([24.48.58.197]:13744 "EHLO
	mx.adelphiacom.com") by vger.kernel.org with ESMTP
	id <S279940AbRKBCWP>; Thu, 1 Nov 2001 21:22:15 -0500
Message-ID: <69DCAE8DF2BFD411AACC0002A50A63F00B693CDA@cdptex1.adelphiacom.com>
From: Sam James <sam.james@adelphia.com>
To: linux-kernel@vger.kernel.org
Subject: bonding problems?
Date: Thu, 1 Nov 2001 21:22:47 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been expermenting with the bonding driver and well, it works, but..
if you unplug the cable to one of the bonded interfaces it never appears to
figure out that that part of the channel is down, hense it drops every other
ping you send it(or any other packet for that matter).  Is this the way it
is supposed to work?  I know when I configure cisco etherchannel between
swithes, if you lose a link, all traffic is then sent across the remaining
link[s].

also if this is not the right way to achieve my goal, please point me in the
correct direction.

well anyways here is my setup

compaq proliant 2500 (linux does not detect the memory correctly in this
box,
requiring me to pass:append="mem=exactmap mem=640K@0 mem=255M@1M" in
lilo.conf)  
any plans to fix that??

2xPPro200, 256M ram, 400meg swap, raid5 blah blah

Kernel: 2.4.14-pre6 SMP

[root@flounder /etc]# ifconfig -a
bond0     Link encap:Ethernet  HWaddr 00:80:C8:5A:F1:8B  
          inet addr:10.156.15.20  Bcast:10.156.15.255  Mask:255.255.252.0
          UP BROADCAST RUNNING MASTER MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1547 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 

eth0      Link encap:Ethernet  HWaddr 00:80:C8:5A:F1:8B  
          inet addr:10.156.15.20  Bcast:10.156.15.255  Mask:255.255.252.0
          UP BROADCAST RUNNING SLAVE MULTICAST  MTU:1500  Metric:1
          RX packets:19492 errors:1 dropped:0 overruns:0 frame:0
          TX packets:774 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:5 Base address:0x8000 

eth1      Link encap:Ethernet  HWaddr 00:80:C8:5A:F1:8B  
          inet addr:10.156.15.20  Bcast:10.156.15.255  Mask:255.255.252.0
          UP BROADCAST RUNNING SLAVE MULTICAST  MTU:1500  Metric:1
          RX packets:9317 errors:0 dropped:0 overruns:0 frame:0
          TX packets:773 errors:6 dropped:0 overruns:0 carrier:6
          collisions:0 txqueuelen:100 
          Interrupt:10 Base address:0x7400 

here is the config on the cisco(3524XL) side:

joe-dc3524#sh port group 1
Group  Interface              Transmit Distribution
-----  ---------------------  ---------------------
    1  FastEthernet0/21       source address
    1  FastEthernet0/22       source address

