Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVIAJWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVIAJWr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 05:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVIAJWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 05:22:47 -0400
Received: from mx1.quicknet.ch ([213.202.32.6]:14781 "EHLO mx1.quicknet.ch")
	by vger.kernel.org with ESMTP id S1750886AbVIAJWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 05:22:46 -0400
From: Nicolas Christener <niki.christener@dtc.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13 doesn't find AGP device
Date: Thu, 1 Sep 2005 11:22:44 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509011122.45044.niki.christener@dtc.ch>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FRqFDyiMz+SxQlW";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

On my machine, 2.6.13 doesn't detect my AGP ATI VGA card. 2.6.12.5 works just 
fine.
However if I boot 2.6.13 with pci=biosirq the VGA card get's detected and 
works fine. 

Suggestions, anyone?

Mainboard = Asus P4B
VGA Card = Ati Rage 128 Pro

Kind Regards Nicolas

lspci:

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge 
(rev 03)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 
03)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 12)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 12)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 12)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 12)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 12)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 12)
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 
12)
02:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 02)
02:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
02)
02:0b.0 SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 01)
02:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 
78)


diff -u of lspci -vvx:

--- lspci-2.6.12.log	2005-09-01 08:29:28.000000000 +0200
+++ lspci-2.6.13.log	2005-08-31 23:31:30.000000000 +0200
@@ -7,7 +7,7 @@
 	Capabilities: [e4] #09 [0104]
 	Capabilities: [a0] AGP version 2.0
 		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ 
AGP3- Rate=x1,x2,x4
-		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
+		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
 00: 86 80 30 1a 06 00 90 20 03 00 00 06 00 00 00 00
 10: 08 00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 70 80
@@ -23,7 +23,7 @@
 	Prefetchable memory behind bridge: f3f00000-f7ffffff
 	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
 00: 86 80 31 1a 07 00 a0 00 03 00 04 06 00 40 01 00
-10: 00 00 00 00 00 00 00 00 00 01 01 00 d0 d0 a0 22
+10: 00 00 00 00 00 00 00 00 00 01 01 00 d0 d0 a0 02
 20: 80 f1 60 f2 f0 f3 f0 f7 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08 00
 
@@ -37,7 +37,7 @@
 	Prefetchable memory behind bridge: f2700000-f3efffff
 	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
 00: 86 80 4e 24 07 01 80 00 12 00 04 06 00 00 01 00
-10: 00 00 00 00 00 00 00 00 00 02 02 20 b0 b0 80 a2
+10: 00 00 00 00 00 00 00 00 00 02 02 20 b0 b0 80 82
 20: 80 f0 70 f1 70 f2 e0 f3 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 00
 
@@ -66,7 +66,7 @@
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 	Latency: 0
-	Interrupt: pin D routed to IRQ 19
+	Interrupt: pin D routed to IRQ 16
 	Region 4: I/O ports at a400 [size=32]
 00: 86 80 42 24 05 00 80 02 12 00 03 0c 00 00 00 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -89,7 +89,7 @@
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 	Latency: 0
-	Interrupt: pin C routed to IRQ 23
+	Interrupt: pin C routed to IRQ 17
 	Region 4: I/O ports at a000 [size=32]
 00: 86 80 44 24 05 00 80 02 12 00 03 0c 00 00 00 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -101,7 +101,7 @@
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 	Latency: 0
-	Interrupt: pin B routed to IRQ 17
+	Interrupt: pin B routed to IRQ 18
 	Region 0: I/O ports at 9800 [size=256]
 	Region 1: I/O ports at 9400 [size=64]
 00: 86 80 45 24 05 00 80 02 12 00 01 04 00 00 00 00
@@ -114,14 +114,14 @@
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 	Latency: 64 (2000ns min), cache line size 08
-	Interrupt: pin A routed to IRQ 11
+	Interrupt: pin A routed to IRQ 20
 	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
 	Region 1: I/O ports at d800 [size=256]
 	Region 2: Memory at f1800000 (32-bit, non-prefetchable) [size=16K]
-	Expansion ROM at f3fe0000 [disabled] [size=128K]
+	Expansion ROM at f3f00000 [disabled] [size=128K]
 	Capabilities: [50] AGP version 2.0
 		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- 
AGP3- Rate=x1,x2,x4
-		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
+		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
 	Capabilities: [5c] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
@@ -159,10 +159,10 @@
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 	Latency: 32, cache line size 08
-	Interrupt: pin A routed to IRQ 23
+	Interrupt: pin A routed to IRQ 17
 	Region 0: I/O ports at b800 [size=256]
 	Region 1: Memory at f1000000 (32-bit, non-prefetchable) [size=4K]
-	Expansion ROM at <unassigned> [disabled] [size=64K]
+	Expansion ROM at f2720000 [disabled] [size=64K]
 	Capabilities: [dc] Power Management version 1
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
@@ -176,10 +176,10 @@
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 	Latency: 32 (2500ns min, 2500ns max), cache line size 08
-	Interrupt: pin A routed to IRQ 20
+	Interrupt: pin A routed to IRQ 19
 	Region 0: I/O ports at b400 [size=128]
 	Region 1: Memory at f0800000 (32-bit, non-prefetchable) [size=128]
-	Expansion ROM at <unassigned> [disabled] [size=128K]
+	Expansion ROM at f2700000 [disabled] [size=128K]
 	Capabilities: [dc] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
