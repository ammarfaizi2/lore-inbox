Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312429AbSCUSUK>; Thu, 21 Mar 2002 13:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312443AbSCUST4>; Thu, 21 Mar 2002 13:19:56 -0500
Received: from web13303.mail.yahoo.com ([216.136.175.39]:58379 "HELO
	web13303.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312429AbSCUSTm>; Thu, 21 Mar 2002 13:19:42 -0500
Message-ID: <20020321181942.35576.qmail@web13303.mail.yahoo.com>
Date: Thu, 21 Mar 2002 10:19:42 -0800 (PST)
From: Joerg Pommnitz <pommnitz@yahoo.com>
Subject: Bad interaction of SO_BINDTODEVICE and ARP in Linux 2.4.10
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the advise of a coworker I'm resending this message with
a more sexy Subject line. The previous one did sound too newbieish...


Hi List,
I have the following setup:
One host with two interfaces (eth0, eth1):

eth0      Link encap:Ethernet  HWaddr 00:E0:4C:71:05:92
          inet addr:10.1.12.87  Bcast:10.1.12.255  Mask:255.255.255.0
          inet6 addr: fe80::2e0:4cff:fe71:592/10 Scope:Link
          UP BROADCAST NOTRAILERS RUNNING  MTU:1500  Metric:1
          RX packets:4512 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4034 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:345507 (337.4 Kb)  TX bytes:407841 (398.2 Kb)
          Interrupt:11 Base address:0x5000

eth1      Link encap:Ethernet  HWaddr 00:E0:4C:71:05:91
          inet addr:10.1.12.151  Bcast:10.1.12.255  Mask:255.255.255.0
          inet6 addr: fe80::2e0:4cff:fe71:591/10 Scope:Link
          UP BROADCAST NOTRAILERS RUNNING  MTU:1500  Metric:1
          RX packets:2709 errors:0 dropped:0 overruns:0 frame:0
          TX packets:16 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:239132 (233.5 Kb)  TX bytes:2646 (2.5 Kb)
          Interrupt:10 Base address:0x7000

when I do 
ping -I eth0 10.1.12.151
I don't get a reply but ARP requests like this:

19:23:59.219402 arp who-has 10.1.12.151 tell 10.1.12.87
19:24:00.219402 arp who-has 10.1.12.151 tell 10.1.12.87
19:24:01.219402 arp who-has 10.1.12.151 tell 10.1.12.87
19:24:02.219402 arp who-has 10.1.12.151 tell 10.1.12.87

So the host tries to resolve its own MAC address and does
not answer itself. Manually setting the ARP entry fails
as well.

Question: Should this work at all? If yes, is there a fix?

Regards
  Jörg



=====
-- 
Regards
       Joerg


__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
