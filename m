Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270198AbRHMNbG>; Mon, 13 Aug 2001 09:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270201AbRHMNa5>; Mon, 13 Aug 2001 09:30:57 -0400
Received: from houston.jhuapl.edu ([128.244.26.10]:42178 "EHLO
	houston.jhuapl.edu") by vger.kernel.org with ESMTP
	id <S270198AbRHMNak>; Mon, 13 Aug 2001 09:30:40 -0400
Date: Mon, 13 Aug 2001 09:30:30 -0400
From: Chris Schanzle <chris.schanzle@jhuapl.edu>
Subject: 3COM 3c575 3CCFE575BT PCMCIA network card challenged w/2.4.x
To: linux-kernel@vger.kernel.org
Message-id: <5.1.0.14.0.20010813091858.009ea140@bach>
MIME-version: 1.0
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried getting a 3CCFE575BT Cyclone CardBus PCMCIA card going with 
2.4.x for a while in an oldish Gateway Solo 366MHz. I'm told it worked 
under kernel 2.2.x. My guess is the 3c59x driver is not reading the EEPROM 
properly. The card works fine under Win98. Older IBM Ethernet II card 
(NE2000 clone) works fine, so I think the PCMCIA bridge works. Baseline 
distribution is RH 7.1 with updates. Tried several kernels, including 
redhat's 2.4.3-12, 2.4.3-15 (for reiserfs umount fix), and hand-building 
2.4.7-ac9 (sorry, should have been -ac11; Alan, please consider -acNN to 
easily find the most recent, or use a LATEST-IS file). Note the "Failed to 
allocate resource 0 (1000-fff)" line - the second part of the region is a 
*smaller* number, and the MAC address is obviously incorrect.

When pcmcia services are started with the card inserted, I get these syslog 
messages:

Aug 10 133615 xxx kernel Linux Kernel Card Services 3.1.22
Aug 10 133615 xxx kernel options [pci] [cardbus] [pm]
Aug 10 133616 xxx kernel PCI Found IRQ 10 for device 000a.0
Aug 10 133616 xxx kernel PCI Sharing IRQ 10 with 0004.0
Aug 10 133616 xxx kernel PCI Found IRQ 10 for device 000a.1
Aug 10 133616 xxx kernel Yenta IRQ list 0000, PCI irq10
Aug 10 133616 xxx kernel Socket status 30000007
Aug 10 133616 xxx kernel Yenta IRQ list 0000, PCI irq10
Aug 10 133616 xxx kernel Socket status 30000821
Aug 10 133616 xxx kernel cs cb_alloc(bus 5) vendor 0x10b7, device 0x5157
Aug 10 133616 xxx kernel PCI Failed to allocate resource 0(1000-fff) for 
0500.0
Aug 10 133616 xxx kernel PCI Enabling device 0500.0 (0000 -> 0003)
Aug 10 133616 xxx cardmgr[1636] starting, version is 3.1.22
Aug 10 133616 xxx cardmgr[1636] watching 2 sockets
Aug 10 133616 xxx kernel cs IO port probe 0x0c00-0x0cff clean.
Aug 10 133616 xxx kernel cs IO port probe 0x0100-0x04ff excluding 
0x200-0x207 0x220-0x22f 0x330-0x337 0x378-0x37f 0x388-0x38f 0x398-0x39f 
0x4d0-0x4d7
Aug 10 133616 xxx kernel cs IO port probe 0x1000-0x1fff clean.
Aug 10 133616 xxx kernel cs IO port probe 0x0a00-0x0aff clean.
Aug 10 133616 xxx cardmgr[1636] initializing socket 1
Aug 10 133616 xxx cardmgr[1636] socket 1 3Com 3CCFE575B/3CXFE575B Fast 
EtherLink XL
Aug 10 133617 xxx kernel 3c59x Donald Becker and others. 
www.scyld.com/network/vortex.html
Aug 10 133617 xxx kernel 0500.0 3Com PCI 3CCFE575BT Cyclone CardBus at 
0x1000. Vers LK1.1.16
Aug 10 133617 xxx kernel PCI Setting latency timer of device 0500.0 to 64
Aug 10 133617 xxx cardmgr[1636] executing 'modprobe 3c59x debug=7'
Aug 10 133617 xxx kernel NET4 Linux IPX 0.47 for NET4.0
Aug 10 133617 xxx kernel IPX Portions Copyright (c) 1995 Caldera, Inc.
Aug 10 133617 xxx kernel IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
Aug 10 133617 xxx kernel NET4 AppleTalk 0.18a for Linux NET4.0
Aug 10 133617 xxx cardmgr[1636] executing './network start 3c59x'
Aug 10 133617 xxx /etc/hotplug/net.agent register event not handled
Aug 10 133619 xxx kernel eth0 command 0x5800 did not complete! Status=0xffff
Aug 10 133619 xxx kernel eth0 command 0x2804 did not complete! Status=0xffff

Here is the interesting tail of lspci -vvxx output:

00:0a.0 CardBus bridge: Cirrus Logic PD 6832 (rev c1)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
Latency: 168
Interrupt: pin A routed to IRQ 10
Region 0: Memory at 18000000 (32-bit, non-prefetchable) [size=4K]
Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
Memory window 0: 18400000-187ff000
Memory window 1: 18800000-18bff000
I/O window 0: 00000000-00000003
I/O window 1: 00000000-00000003
BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
16-bit legacy interface ports at 0001
00: 13 10 10 11 07 00 00 02 c1 00 07 06 00 a8 82 00
10: 00 00 00 18 00 00 00 00 00 01 04 b0 00 00 40 18
20: 00 f0 7f 18 00 00 80 18 00 f0 bf 18 01 00 00 00
30: 01 00 00 00 01 00 00 00 01 00 00 00 0a 01 c0 04
40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00:0a.1 CardBus bridge: Cirrus Logic PD 6832 (rev c1)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
Latency: 168
Interrupt: pin B routed to IRQ 10
Region 0: Memory at 18001000 (32-bit, non-prefetchable) [size=4K]
Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
Memory window 0: 18c00000-18fff000
Memory window 1: 19000000-193ff000
I/O window 0: 00000000-00000003
I/O window 1: 00000000-00000003
BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
00: 13 10 10 11 07 00 00 02 c1 00 07 06 00 a8 82 00
10: 00 10 00 18 00 00 00 00 00 05 08 b0 00 00 c0 18
20: 00 f0 ff 18 00 00 00 19 00 f0 3f 19 01 00 00 00
30: 01 00 00 00 01 00 00 00 01 00 00 00 0a 02 00 04
40: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
05:00.0 Ethernet controller: 3Com Corporation 3CCFE575BT Cyclone CardBus 
(rev 01)
Subsystem: 3Com Corporation 3C575 Megahertz 10/100 LAN Cardbus PC Card
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
Latency: 64 (2500ns min, 1250ns max)
Interrupt: pin A routed to IRQ 10
Region 0: I/O ports at 1000
Region 1: Memory at 19000000 (32-bit, non-prefetchable) [size=128]
Region 2: Memory at 19000080 (32-bit, non-prefetchable) [size=128]
Expansion ROM at 18c00000 [size=128K]
Capabilities: [50] Power Management version 1
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b7 10 57 51 07 00 10 02 01 00 00 02 00 40 00 00
10: 01 00 00 00 00 00 00 19 80 00 00 19 00 00 00 00
20: 00 00 00 00 00 00 00 00 90 00 00 00 b7 10 57 5b
30: 01 00 c0 18 50 00 00 00 00 00 00 00 0a 01 0a 05

Many thanks for assistance,

Chris Schanzle


