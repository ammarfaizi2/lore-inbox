Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbVINJZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbVINJZP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbVINJZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:25:15 -0400
Received: from mail.permas.de ([195.143.204.226]:30142 "EHLO mail-gw.local")
	by vger.kernel.org with ESMTP id S965108AbVINJZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:25:13 -0400
From: Hartmut Manz <manz@intes.de>
Reply-To: manz@intes.de
Organization: INTES GmbH
To: linux-kernel@vger.kernel.org
Subject: Another 2.6.13-ck3 locks machine after some time, 2.6.12.5 work fine
Date: Wed, 14 Sep 2005 11:25:00 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509141125.00971.manz@intes.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have also tried to switch to kernel 2.6.13-ck3 and after about 2 hours the
machine is completely frozen. I have than applied the proposed patch
from Linus for a simmilar problem on 2.6.13.1 but it didn't help.

My Machine is an Athlon64 running debian 3.1 in 64bit.


Here is the difference between the output of lspci -WX on 2.6.12.5 and
from 2.6.13-ck3 

manz@hardy> diff -W50 lspci-vvx-2.6.12.5 lspci-vvx-2.6.13-ck3
77c77
<       Interrupt: pin A routed to IRQ 11
---
>       Interrupt: pin A routed to IRQ 16
187c187
<       Latency: 64, Cache Line Size: 0x10 (64 bytes)
---
>       Latency: 64, Cache Line Size: 0x08 (32 bytes)
191c191
< 00: 06 11 04 31 17 00 10 02 86 20 03 0c 10 40 80 00
---
> 00: 06 11 04 31 17 00 10 02 86 20 03 0c 08 40 80 00
manz@hardy> diff -U50 lspci-vvx-2.6.12.5 lspci-vvx-2.6.13-ck3
--- lspci-vvx-2.6.12.5  2005-09-13 13:31:56.000000000 +0200
+++ lspci-vvx-2.6.13.1-ck3      2005-09-13 17:09:16.000000000 +0200
@@ -27,101 +27,101 @@
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

 0000:00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3282
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 00: 06 11 82 32 06 00 00 02 00 00 00 06 00 00 00 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

 0000:00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4282
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 00: 06 11 82 42 06 00 00 02 00 00 00 06 00 00 00 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

 0000:00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7282
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 00: 06 11 82 72 06 00 00 02 00 00 00 06 00 00 00 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 
South] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: faf00000-fbffffff
        Prefetchable memory behind bridge: e0000000-f9ffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: <available only to root>
 00: 06 11 88 b1 07 01 30 02 00 00 04 06 00 00 01 00
 10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 20 22
 20: f0 fa f0 fb 00 e0 f0 f9 00 00 00 00 00 00 00 00
 30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0a 00

 0000:00:09.0 Network controller: RaLink Ralink RT2500 802.11 Cardbus 
Reference Card (rev 01)
        Subsystem: Asustek Computer, Inc.: Unknown device 130f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 0x08 (32 bytes)
-       Interrupt: pin A routed to IRQ 11
+       Interrupt: pin A routed to IRQ 16
        Region 0: Memory at faa00000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: <available only to root>
 00: 14 18 01 02 17 01 10 04 01 00 80 02 08 40 00 00
 10: 00 00 a0 fa 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 01 06 00 00 43 10 0f 13
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00

 0000:00:0a.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit 
Ethernet 10/100/1000Base-T Adapter (rev 13)
        Subsystem: Asustek Computer, Inc.: Unknown device 811a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (5750ns min, 7750ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at fac00000 (32-bit, non-prefetchable) [size=16K]
        Region 1: I/O ports at b000 [size=256]
        Expansion ROM at fab00000 [disabled] [size=128K]
        Capabilities: <available only to root>
 00: ab 11 20 43 17 01 b0 02 13 00 00 02 08 40 00 00
 10: 00 00 c0 fa 01 b0 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 1a 81
 30: 00 00 b0 fa 48 00 00 00 00 00 00 00 0a 01 17 1f

 0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID 
Controller (rev 80)
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin B routed to IRQ 20
        Region 0: I/O ports at d000 [size=8]
        Region 1: I/O ports at c800 [size=4]
        Region 2: I/O ports at c400 [size=8]
        Region 3: I/O ports at c000 [size=4]
        Region 4: I/O ports at b800 [size=16]
        Region 5: I/O ports at b400 [size=256]
        Capabilities: <available only to root>
 00: 06 11 49 31 07 00 90 02 80 00 04 01 00 40 80 00
 10: 01 d0 00 00 01 c8 00 00 01 c4 00 00 01 c0 00 00
 20: 01 b8 00 00 01 b4 00 00 00 00 00 00 43 10 ed 80
 30: 00 00 00 00 c0 00 00 00 00 00 00 00 04 02 00 00

 0000:00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a 
[Master SecP PriP])
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 20
        Region 4: I/O ports at fc00 [size=16]
        Capabilities: <available only to root>
 00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -137,105 +137,105 @@
        Region 4: I/O ports at d400 [size=32]
        Capabilities: <available only to root>
 00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 40 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 01 d4 00 00 00 00 00 00 00 00 00 00 43 10 ed 80
 30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

 0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at d800 [size=32]
        Capabilities: <available only to root>
 00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 40 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 01 d8 00 00 00 00 00 00 00 00 00 00 43 10 ed 80
 30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

 0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at e000 [size=32]
        Capabilities: <available only to root>
 00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 40 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 01 e0 00 00 00 00 00 00 00 00 00 00 43 10 ed 80
 30: 00 00 00 00 80 00 00 00 00 00 00 00 05 02 00 00

 0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at e400 [size=32]
        Capabilities: <available only to root>
 00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 40 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 01 e4 00 00 00 00 00 00 00 00 00 00 43 10 ed 80
 30: 00 00 00 00 80 00 00 00 00 00 00 00 05 02 00 00

 0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 
20 [EHCI])
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
-       Latency: 64, Cache Line Size: 0x10 (64 bytes)
+       Latency: 64, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin C routed to IRQ 21
        Region 0: Memory at fae00000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>
-00: 06 11 04 31 17 00 10 02 86 20 03 0c 10 40 80 00
+00: 06 11 04 31 17 00 10 02 86 20 03 0c 08 40 80 00
 10: 00 00 e0 fa 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ed 80
 30: 00 00 00 00 80 00 00 00 00 00 00 00 05 03 00 00

 0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 
South]
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: <available only to root>
 00: 06 11 27 32 87 00 10 02 00 00 01 06 00 00 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ed 80
 30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

 0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: Asustek Computer, Inc.: Unknown device 812a
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at e800 [size=256]
        Capabilities: <available only to root>
 00: 06 11 59 30 01 00 10 02 60 00 01 04 00 00 00 00
 10: 01 e8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 2a 81
 30: 00 00 00 00 c0 00 00 00 00 00 00 00 06 03 00 00

 0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: <available only to root>
 00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

 0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
 00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

 0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
 00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
manz@hardy>               
-- 
-----------------------------------------------------------------------------
Hartmut Manz                                      WWW:    http://www.intes.de
INTES GmbH                                        Phone:  +49-711-78499-29
Schulze-Delitzsch-Str. 16                         Fax:    +49-711-78499-10
D-70565 Stuttgart                                 E-mail: manz@intes.de
   Himmel und Erde werden vergehen; meine Worte aber werden nicht vergehen.
------------------------------------------------------  Markus 13,31 --------

