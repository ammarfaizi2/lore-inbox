Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262118AbTCUXUV>; Fri, 21 Mar 2003 18:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264097AbTCUXUV>; Fri, 21 Mar 2003 18:20:21 -0500
Received: from rizzo.jerky.net ([204.57.55.99]:64014 "EHLO rizzo.jerky.net")
	by vger.kernel.org with ESMTP id <S262118AbTCUXUT>;
	Fri, 21 Mar 2003 18:20:19 -0500
To: linux-kernel@vger.kernel.org
From: Alon <alon@gamebox.net>
Date: Sat, 22 Mar 2003 00:20:09 +0100
Subject: VIA Rhine timeouts
Message-Id: <20030321232047.D7D771800D2@smtp-2.hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am suffering from what a quick Google search has shown
to be the infamous netdev watchdog lock in Rhine NICs,a
although in a somwhat different way from most cases I've
seen reported. Instead of failing under heavy load, my card
(in fact, an onboard chip in the ECS L7VTA-L motherboard)
completely refuses to make a connection under 2.4.x kernels.
I tried all releases between 2.4.18 and current 2.4.21-pre5
to no avail. The driver provided by VIA at their site
fared no better.

I include below a snippet of the syslog (debug=7)when trying
to connect to a DHCP server. I also have a TCP dump of the
dialog, if it's of any use (the messages about promiscuous
mode are caused by tcpdump, I believe).

..(lots of snipped stuff)...
Mar 21 23:45:52 taragui kernel: via-rhine.c:v1.10-LK1.1.16  February-15-2003  
Written by Donald Becker
Mar 21 23:45:52 taragui kernel:   http://www.scyld.com/network/via-rhine.html
Mar 21 23:45:52 taragui kernel: via-rhine: Reset succeeded.
Mar 21 23:45:52 taragui kernel: eth0: VIA VT6102 Rhine-II at 0xe400, 
00:0a:e6:31:e8:7b, IRQ 16.
Mar 21 23:45:52 taragui kernel: eth0: MII PHY found at address 1, status 0x786d 
advertising 01e1 Link 0021.
Mar 21 23:46:37 taragui dhclient: Internet Software Consortium DHCP Client 
V3.0.1rc9
Mar 21 23:46:37 taragui dhclient: Copyright 1995-2001 Internet Software 
Consortium.
Mar 21 23:46:37 taragui dhclient: All rights reserved.
Mar 21 23:46:37 taragui dhclient: For info, please visit 
http://www.isc.org/products/DHCP
Mar 21 23:46:37 taragui dhclient: 
Mar 21 23:46:37 taragui kernel: eth0: via_rhine_open() irq 16.
Mar 21 23:46:37 taragui kernel: eth0: Reset succeeded.
Mar 21 23:46:37 taragui kernel: eth0: Done via_rhine_open(), status 081a MII 
status: 786d.
Mar 21 23:46:37 taragui kernel: eth0: VIA Rhine monitor tick, status 0000.
Mar 21 23:46:38 taragui dhclient: Listening on LPF/eth0/00:0a:e6:31:e8:7b
Mar 21 23:46:38 taragui dhclient: Sending on   LPF/eth0/00:0a:e6:31:e8:7b
Mar 21 23:46:38 taragui dhclient: Sending on   Socket/fallback
Mar 21 23:46:39 taragui kernel: eth0: Promiscuous mode enabled.
Mar 21 23:46:39 taragui kernel: device eth0 entered promiscuous mode
Mar 21 23:46:40 taragui dhclient: DHCPREQUEST on eth0 to 255.255.255.255 port 
67
Mar 21 23:46:40 taragui kernel: eth0: Transmit frame #0 queued in slot 0.
Mar 21 23:46:47 taragui dhclient: DHCPREQUEST on eth0 to 255.255.255.255 port 
67
Mar 21 23:46:47 taragui kernel: eth0: Transmit frame #1 queued in slot 1.
Mar 21 23:46:47 taragui kernel: eth0: VIA Rhine monitor tick, status 1003.
Mar 21 23:46:57 taragui dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 port 
67 interval 8
Mar 21 23:46:57 taragui kernel: eth0: Transmit frame #2 queued in slot 2.
Mar 21 23:46:57 taragui kernel: eth0: VIA Rhine monitor tick, status 1003.
Mar 21 23:47:05 taragui dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 port 
67 interval 14
(same as above for frames #3 to #9)
Mar 21 23:47:58 taragui dhclient: No DHCPOFFERS received.
Mar 21 23:47:58 taragui dhclient: Trying recorded lease 212.183.239.144
Mar 21 23:48:01 taragui kernel: NETDEV WATCHDOG: eth0: transmit timed out
Mar 21 23:48:01 taragui kernel: eth0: Transmit timed out, status 1003, PHY 
status 786d, resetting...
Mar 21 23:48:01 taragui kernel: eth0: Reset did not complete in 5 us. Trying 
harder.
Mar 21 23:48:01 taragui kernel: eth0: Reset succeeded.
Mar 21 23:48:08 taragui dhclient: No working leases in persistent database - 
sleeping.

The weird thing is, it seems to work perfectly with
Debian Woody's stock 2.2.20 idepci kernel. I'd be glad
to stick to it for the time being, but I can't get
support for most of the mobo's functionality (it sports
a KT400/VT8235 combo) under any kernel earlier than
2.4.20.

TIA,

Alon



