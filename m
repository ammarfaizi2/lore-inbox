Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312445AbSCUSru>; Thu, 21 Mar 2002 13:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312447AbSCUSrl>; Thu, 21 Mar 2002 13:47:41 -0500
Received: from web13308.mail.yahoo.com ([216.136.175.44]:10769 "HELO
	web13308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312445AbSCUSr0>; Thu, 21 Mar 2002 13:47:26 -0500
Message-ID: <20020321184724.70917.qmail@web13308.mail.yahoo.com>
Date: Thu, 21 Mar 2002 10:47:24 -0800 (PST)
From: Joerg Pommnitz <pommnitz@yahoo.com>
Subject: Re: Bad interaction of SO_BINDTODEVICE and ARP in Linux 2.4.10
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lists,
I worked around my previous problem by deleting the routing
entry that sent packets for my subnet directly to their
destination. Using our default router works (somewhat).

I can now see the ICMP packets on eth1:

jpo> /sbin/ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:E0:4C:71:05:92
          inet addr:10.1.12.87  Bcast:10.1.12.255  Mask:255.255.255.0
eth1      Link encap:Ethernet  HWaddr 00:E0:4C:71:05:91
          inet addr:10.1.12.151  Bcast:10.1.12.255  Mask:255.255.255.0
jpo> netstat -rn
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt
Iface
0.0.0.0         10.1.12.1       0.0.0.0         UG       40 0          0
eth0

jpo> ping -I eth0 10.1.12.151
jpo> sudo /usr/sbin/tcpdump -i eth1 host 10.1.12.151 -n
tcpdump: listening on eth1
20:40:46.289402 10.1.12.87 > 10.1.12.151: icmp: echo request (DF)
20:40:47.289402 10.1.12.87 > 10.1.12.151: icmp: echo request (DF)
20:40:48.289402 10.1.12.87 > 10.1.12.151: icmp: echo request (DF)
20:40:49.289402 10.1.12.87 > 10.1.12.151: icmp: echo request (DF)
20:40:50.289402 10.1.12.87 > 10.1.12.151: icmp: echo request (DF)

It seems that no answer is sent at all. Any ideas?

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
