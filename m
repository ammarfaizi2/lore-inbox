Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbTI0XTO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 19:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbTI0XTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 19:19:14 -0400
Received: from as1-2-5.han.s.bonet.se ([194.236.155.59]:39694 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S262243AbTI0XTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 19:19:11 -0400
Date: Sun, 28 Sep 2003 01:19:06 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: Broadcom BCM5901 NIC
Message-ID: <20030927231904.GA22769@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my new laptop (IBM Thinkpad G40) has an integrated NIC made by broadcom. 
It's a BCM5901 card for which support was added in the tg3 driver a few 
weeks ago (both in 2.4 and 2.6-test). However, the device doesn't work, 
it insmods just fine and claims the hardware, but the machine never 
responds to ping messages and the led indicating network activity is 
never activated.

Broadcom has released a driver of their own (bcm5700) which works with 
kernel 2.4.21. When I try that combination it works fine, however, the 
bcm5700 driver wont work at all on recent 2.4 or 2.6 kernels.

Does anyone know what is wrong with the tg3 driver? Has anyone tried 
using it on a 5901 card with success?

Regards,
David

relevant part of dmesg with 2.4.21 + bcm5700
--------------------------------------------
Broadcom Gigabit Ethernet Driver bcm5700 with Broadcom NIC Extension 
(NICE) ver. 6.2.17 (07/14/03)
eth0: Broadcom BCM5901 100Base-TX found at mem d0200000, IRQ 11, node 
addr 00061bc20348
eth0: Broadcom BCM5705 Integrated Copper transceiver found
eth0: Scatter-gather ON, 64-bit DMA ON, Tx Checksum ON, Rx Checksum ON, 
802.1Q VLAN ON, NAPI ON

lspci -vvv with 2.4.21 + bcm5700
--------------------------------
02:00.0 Ethernet controller: Broadcom Corporation: Unknown device 170d 
(rev 01)
Subsystem: IBM: Unknown device 0545
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 64 (16000ns min), cache line size 08
Interrupt: pin A routed to IRQ 11
Region 0: Memory at d0200000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [48] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=0 DScale=1 PME-
Capabilities: [50] Vital Product Data
Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
Address: 020108086c0e6458 Data: 4002

ifconfig with 2.4.21 + bcm5700
------------------------------
eth0      Link encap:Ethernet  HWaddr 00:06:1B:C2:03:48  
          inet addr:192.168.0.2  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:6 errors:0 dropped:0 overruns:0 frame:0
          TX packets:12 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:627 (627.0 b)  TX bytes:1090 (1.0 KiB)
	  Interrupt:11 Memory:d0200000-d0210000

dmesg on 2.6.0-test5 + tg3
--------------------------
tg3.c:v2.2 (August 24, 2003) eth0: Tigon3 [partno(BCM95901A50) rev 3001 
PHY(5705)] (PCI:33MHz:32-bit) 10/100BaseT Ethernet 00:06:1b:c2:03:48

lspci -vvv on 2.6.0-test5 + tg3
-------------------------------
02:00.0 Ethernet controller: Broadcom Corporation: Unknown device 170d 
(rev 01) Subsystem: IBM: Unknown device 0545
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <T 
Abort- <MAbort- >SERR- <PERR-
Latency: 64 (16000ns min), cache line size 08
Interrupt: pin A routed to IRQ 11
Region 0: Memory at d0200000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [48] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=0 DScale=1 PME-
Capabilities: [50] Vital Product Data
Capabilities: [58] 
Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
Address: 020108086c0e6458  Data: 4002

ifconfig on 2.6.0-test5 + tg3
-----------------------------
eth0      Link encap:Ethernet  HWaddr 00:06:1B:C2:03:48  
          inet addr:192.168.0.2  Bcast:192.168.0.255  Mask:255.255.255.0
          inet6 addr: fe80::206:1bff:fec2:348/64 Scope:Link
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
	  collisions:0 txqueuelen:100 
	  RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:11
