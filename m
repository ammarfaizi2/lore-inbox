Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVH3WlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVH3WlW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVH3WlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:41:21 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:37006 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932260AbVH3WlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:41:20 -0400
Message-ID: <4314E07F.2080807@fulhack.info>
Date: Wed, 31 Aug 2005 00:41:03 +0200
From: Henrik Persson <root@fulhack.info>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13
References: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------030607090205080403040803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030607090205080403040803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> There it is. 
> 
> The most painful part of 2.6.13 is likely to be the fact that we made x86
> use the generic PCI bus setup code for assigning unassigned resources.  
> That uncovered rather a lot of nasty small details, but should also mean
> that a lot of laptops in particular should be able to discover PCI devices
> behind bridges that the BIOS hasn't set up.
> 
> We've hopefully fixed up all the problems that the longish -rc series
> showed, and it shouldn't be that painful, but if you have device problems,
> please make a report that at a minimum contains the unified diff of the
> output of "lspci -vvx" running on 2.6.12 vs 2.6.13. That might give us
> some clues.

Well. 2.6.13 won't boot if I have my Netgear WG511 in the cardbus slot.
It boots just fine if it isn't inserted, though. If I insert it later
on, the computer will freeze and won't respond, just like it does on boot.

2.6.12.5 works just fine, and I just did make oldconfig and used the
defaults (except for the hardware monitoring).

Suggestions, anyone?

diff -u of lspci -vvx + lspci output attached.

It's an Acer Aspire 1302XV.

--
Henrik Persson

--------------030607090205080403040803
Content-Type: text/plain;
 name="diff-lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-lspci"

--- lspci-2.6.12.5	2005-08-31 00:31:46.274810568 +0200
+++ lspci-2.6.13	2005-08-31 00:26:45.718371000 +0200
@@ -6,7 +6,7 @@
 	Region 0: Memory at a0000000 (32-bit, prefetchable) [size=64M]
 	Capabilities: [a0] AGP version 2.0
 		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
-		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=<none>
+		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
 	Capabilities: [c0] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
@@ -40,16 +40,16 @@
 	Interrupt: pin A routed to IRQ 11
 	Region 0: Memory at 2f000000 (32-bit, non-prefetchable) [size=4K]
 	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
-	Memory window 0: 2f400000-2f7ff000 (prefetchable)
-	Memory window 1: 2f800000-2fbff000
-	I/O window 0: 00004000-000040ff
-	I/O window 1: 00004400-000044ff
-	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
+	Memory window 0: 30000000-31fff000 (prefetchable)
+	Memory window 1: 32000000-33fff000
+	I/O window 0: 00001000-000010ff
+	I/O window 1: 00001400-000014ff
+	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
 	16-bit legacy interface ports at 0001
 00: 17 12 72 69 87 00 10 04 00 00 07 06 00 a8 02 00
-10: 00 00 00 2f a0 00 00 02 00 02 05 b0 00 00 40 2f
-20: 00 f0 7f 2f 00 00 80 2f 00 f0 bf 2f 01 40 00 00
-30: fd 40 00 00 01 44 00 00 fd 44 00 00 0b 01 00 05
+10: 00 00 00 2f a0 00 00 02 00 02 05 b0 00 00 00 30
+20: 00 f0 ff 31 00 00 00 32 00 f0 ff 33 01 10 00 00
+30: fd 10 00 00 01 14 00 00 fd 14 00 00 0b 01 80 05
 40: 25 10 1d 00 01 00 00 00 00 00 00 00 00 00 00 00
 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -163,13 +163,13 @@
 	Interrupt: pin A routed to IRQ 11
 	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=512K]
 	Region 1: Memory at 90000000 (32-bit, prefetchable) [size=128M]
-	Expansion ROM at 000c0000 [disabled] [size=64K]
+	Expansion ROM at 98000000 [disabled] [size=64K]
 	Capabilities: [dc] Power Management version 2
 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [80] AGP version 2.0
 		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x4
-		Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4
+		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x4
 00: 33 53 02 8d 07 00 30 02 01 00 00 03 04 40 00 00
 10: 00 00 00 e0 08 00 00 90 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00

--------------030607090205080403040803
Content-Type: text/plain;
 name="lspci-2.6.12.5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-2.6.12.5"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 80)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 8
	Region 0: Memory at a0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 05 03 06 00 10 a2 80 00 00 06 00 08 00 00
10: 08 00 00 a0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: e0000000-efffffff
	Prefetchable memory behind bridge: 90000000-9fffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 05 83 07 00 30 a2 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 c0 d0 00 00
20: 00 e0 f0 ef 00 90 f0 9f 00 00 00 00 25 10 1d 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00

0000:00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 2f000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 2f400000-2f7ff000 (prefetchable)
	Memory window 1: 2f800000-2fbff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001
00: 17 12 72 69 87 00 10 04 00 00 07 06 00 a8 02 00
10: 00 00 00 2f a0 00 00 02 00 02 05 b0 00 00 40 2f
20: 00 f0 7f 2f 00 00 80 2f 00 f0 bf 2f 01 40 00 00
30: fd 40 00 00 01 44 00 00 fd 44 00 00 0b 01 00 05
40: 25 10 1d 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge] (rev 10)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 31 82 8f 00 10 02 10 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1100 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 11 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1e) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 22
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 1200 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 1e 00 03 0c 00 16 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 12 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 04 00 00

0000:00:11.4 Bridge: VIA Technologies, Inc. VT8235 ACPI (rev 10)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 35 82 00 00 90 02 10 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 40)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at e000 [size=256]
	Region 1: I/O ports at e100 [size=4]
	Region 2: I/O ports at e104 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 58 30 01 00 10 02 40 00 01 04 00 00 00 00
10: 01 e0 00 00 01 e1 00 00 05 e1 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0a 03 00 00

0000:00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem] (rev 20)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at e200 [size=256]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 68 30 01 00 10 02 20 00 80 07 00 00 00 00
10: 01 e2 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 d0 00 00 00 00 00 00 00 0a 03 00 00

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 51)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (750ns min, 2000ns max), Cache Line Size: 0x04 (16 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at f0000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 65 30 07 00 10 02 51 00 00 02 04 10 00 00
10: 01 e8 00 00 00 00 00 f0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 03 08

0000:01:00.0 VGA compatible controller: S3 Inc. VT8636A [ProSavage KN133] AGP4X VGA Controller (TwisterK) (rev 01) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), Cache Line Size: 0x04 (16 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=512K]
	Region 1: Memory at 90000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at 000c0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4
00: 33 53 02 8d 07 00 30 02 01 00 00 03 04 40 00 00
10: 00 00 00 e0 08 00 00 90 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 0c 00 dc 00 00 00 00 00 00 00 0b 01 04 ff


--------------030607090205080403040803
Content-Type: text/plain;
 name="lspci-2.6.13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-2.6.13"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 80)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 8
	Region 0: Memory at a0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 05 03 06 00 10 a2 80 00 00 06 00 08 00 00
10: 08 00 00 a0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: e0000000-efffffff
	Prefetchable memory behind bridge: 90000000-9fffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 05 83 07 00 30 a2 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 c0 d0 00 00
20: 00 e0 f0 ef 00 90 f0 9f 00 00 00 00 25 10 1d 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00

0000:00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 2f000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 30000000-31fff000 (prefetchable)
	Memory window 1: 32000000-33fff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 17 12 72 69 87 00 10 04 00 00 07 06 00 a8 02 00
10: 00 00 00 2f a0 00 00 02 00 02 05 b0 00 00 00 30
20: 00 f0 ff 31 00 00 00 32 00 f0 ff 33 01 10 00 00
30: fd 10 00 00 01 14 00 00 fd 14 00 00 0b 01 80 05
40: 25 10 1d 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge] (rev 10)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 31 82 8f 00 10 02 10 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1100 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 11 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1e) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 22
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 1200 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 1e 00 03 0c 00 16 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 12 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 04 00 00

0000:00:11.4 Bridge: VIA Technologies, Inc. VT8235 ACPI (rev 10)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 35 82 00 00 90 02 10 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 40)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at e000 [size=256]
	Region 1: I/O ports at e100 [size=4]
	Region 2: I/O ports at e104 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 58 30 01 00 10 02 40 00 01 04 00 00 00 00
10: 01 e0 00 00 01 e1 00 00 05 e1 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0a 03 00 00

0000:00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem] (rev 20)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at e200 [size=256]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 68 30 01 00 10 02 20 00 80 07 00 00 00 00
10: 01 e2 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 d0 00 00 00 00 00 00 00 0a 03 00 00

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 51)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (750ns min, 2000ns max), Cache Line Size: 0x04 (16 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at f0000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 65 30 07 00 10 02 51 00 00 02 04 10 00 00
10: 01 e8 00 00 00 00 00 f0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 03 08

0000:01:00.0 VGA compatible controller: S3 Inc. VT8636A [ProSavage KN133] AGP4X VGA Controller (TwisterK) (rev 01) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), Cache Line Size: 0x04 (16 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=512K]
	Region 1: Memory at 90000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at 98000000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x4
00: 33 53 02 8d 07 00 30 02 01 00 00 03 04 40 00 00
10: 00 00 00 e0 08 00 00 90 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1d 00
30: 00 00 0c 00 dc 00 00 00 00 00 00 00 0b 01 04 ff


--------------030607090205080403040803--
