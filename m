Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266361AbRGFKjd>; Fri, 6 Jul 2001 06:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266363AbRGFKjX>; Fri, 6 Jul 2001 06:39:23 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:31884 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S266361AbRGFKjP>; Fri, 6 Jul 2001 06:39:15 -0400
Date: Fri, 6 Jul 2001 03:39:10 -0700
From: "Daniel A. Nobuto" <ramune@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: natsemi.c failure in 2.4.6
Message-ID: <20010706033910.A28448@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Found that in 2.4.6, Natsetmi card I have doesn't receive
traffic anymore.  It worked in 2.4.5, though.

	The natsemi card is forced to 10/half via mii-diag at boot,
and given a different MAC address (due to some problems I had with
the original MAC address and netbooting a sparc).  Forcing it to
100/full didn't work, either.

	A continuous ping from the Linux box to another system on the
LAN showed only outbound traffic in tcpdump, but the recieving end
(an SS4 running NetBSD) showed both incoming and outgoing packets
(i.e. icmp echo and echo-reply).

	Any ideas on how I can get about tracking the problem down?

	Thanks,

-- DN
Daniel

[PC Linux 2.4.6] <--> p10/100 hub] <--> [SS4 NetBSD 1.5]

PII/233, 256MiB RAM, running on Debian stable/potato.

>From /var/log/kern.log (haven't seen this since using the driver under
2.2.x with Donald Becker's version from scyld.  Never figured out what's
going on, either.):

Jul  6 02:38:12 zippo kernel: eth0: Something Wicked happened! 18000.
Jul  6 02:38:43 zippo last message repeated 8 times
Jul  6 02:39:00 zippo last message repeated 17 times
Jul  6 02:39:01 zippo kernel: eth0: Promiscuous mode enabled.
Jul  6 02:39:01 zippo kernel: eth0: Something Wicked happened! 18000.

ip -s link ls dev eth0:

2: eth0: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 08:00:20:10:20:30 brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast   
    138        2        0       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    278502     2859     0       0       0       0      

lspci -vvv for the NIC:

00:0f.0 Ethernet controller: National Semiconductor Corporation: Unknown device 0020
	Subsystem: Netgear: Unknown device f312
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 11 min, 52 max, 64 set
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at dc00 [size=256]
	Region 1: Memory at ec001000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at eb000000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

mii-diag -v eth0:

mii-diag.c:v2.00 4/19/2000  Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
 MII PHY #1 transceiver registers:
   2100 7849 2000 5c21 05e1 45e1 0005 2801
   0000 0000 0000 0000 0000 0000 0000 0000
   0004 0002 0000 0001 0000 0000 0000 4000
   4f48 189c 0860 00b7 0010 5040 1084 0023.
 Basic mode control register 0x2100: Auto-negotiation disabled, with
 Speed fixed at 100 mbps, full-duplex.
 Basic mode status register 0x7849 ... 7849.
   Link status: not established.
   This transceiver is capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation not complete.
 Your link partner advertised 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT, w/ 802.3X flow control.
 MII PHY #1 transceiver registers:
   2100 7849 2000 5c21 05e1 45e1 0005 2801
   0000 0000 0000 0000 0000 0000 0000 0000
   0004 0002 0000 0001 0000 0000 0000 4000
   4f48 189c 0860 00b7 0010 5040 1084 0024.
 Basic mode control register 0x2100: Auto-negotiation disabled!
   Speed fixed at 100 mbps, full-duplex.
 Basic mode status register 0x7849 ... 7849.
   Link status: not established.
   Capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation not complete.
 Vendor ID is 08:00:17:--:--:--, model 2 rev. 1.
   No specific information is known about this transceiver type.
 I'm advertising 05e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Negotiation  completed.
