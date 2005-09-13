Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbVIMDiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVIMDiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 23:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbVIMDiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 23:38:15 -0400
Received: from [204.13.84.100] ([204.13.84.100]:46394 "EHLO
	stargazer.tbdnetworks.com") by vger.kernel.org with ESMTP
	id S1750774AbVIMDiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 23:38:15 -0400
Date: Mon, 12 Sep 2005 20:38:14 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.1 locks machine after some time, 2.6.12.5 work fine
Message-ID: <20050913033814.GA879@tbdnetworks.com>
References: <1126569577.25875.25.camel@defiant> <Pine.LNX.4.58.0509121950340.3266@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509121950340.3266@g5.osdl.org>
User-Agent: Mutt/1.5.9i
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

diff is appended.  Regarding the -rc3 and friends, currently I can't as
I jumped directly from 12.5 to 13.  This is my desktop at work, so I
try to keep it somewhat stable.  However, if you have a guess which
versions to try, I can give it a spin.  It takes some time though to
test, as the lockup normally only happens after 1 hour or so (although
I could propably speed this up by doing lots of disk IO).

Best,
  Norbert

On Mon, Sep 12, 2005 at 08:00:24PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 12 Sep 2005, Norbert Kiesel wrote:
> > 
> > I append the lspci -vvv from both 2.6.12.5 and 2.6.13.1  The diff
> > between these two is:
> 
> Can you do "lspci -vvx" instead (the numbers are actually meaningful:  
> they say what the hardware has been told, while the symbolic info contains
> some stuff that lspci actually gathered through other means by querying
> the kernel).
> 
> Also, "diff -U 50 working broken" is a really nice way to show not only
> the differences - it gives enough context that you can see all the
> relevant info from the diff, and you don't even need to show the two
> different versions separately (ie the diff itself ends up containing
> pretty much all relevant info).
> 
> Finally - if you can try to pinpoint it somewhat more (eg "2.6.13-rc3 is
> ok, -rc4 is not"), that would be very helpful..
> 
> 		Linus
> 

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff-U50

--- 2.6.12.5/lspci-vvx	2005-09-12 20:26:21.000000000 -0700
+++ 2.6.13.1/lspci-vvx	2005-09-12 20:29:05.000000000 -0700
@@ -1,62 +1,62 @@
 0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
-	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
+	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
 	Latency: 0
 	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
 	Capabilities: [a0] AGP version 2.0
 		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
-		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
+		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
 	Capabilities: [c0] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
-00: 06 11 05 03 06 00 10 a2 02 00 00 06 00 00 00 00
+00: 06 11 05 03 06 00 10 22 02 00 00 06 00 00 00 00
 10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
 
 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
 	Latency: 0
 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
 	I/O behind bridge: 00009000-00009fff
 	Memory behind bridge: e4000000-e5ffffff
 	Prefetchable memory behind bridge: d0000000-dfffffff
 	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
 	Capabilities: [80] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 00: 06 11 05 83 07 00 30 22 00 00 04 06 00 00 01 00
 10: 00 00 00 00 00 00 00 00 00 01 01 00 90 90 00 00
 20: 00 e4 f0 e5 00 d0 f0 df 00 00 00 00 00 00 00 00
 30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00
 
 0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
 	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
 00: 06 11 86 06 87 00 10 02 22 00 01 06 00 00 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
 0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
 	Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 32
 	Region 4: I/O ports at a000 [size=16]
 	Capabilities: [c0] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 00: 06 11 71 05 07 00 90 02 10 8a 01 01 00 20 00 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 01 a0 00 00 00 00 00 00 00 00 00 00 06 11 71 05
 30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00
 
 0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 10) (prog-if 00 [UHCI])
 	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 32, Cache Line Size: 0x08 (32 bytes)
@@ -74,127 +74,130 @@
 	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 32, Cache Line Size: 0x08 (32 bytes)
 	Interrupt: pin D routed to IRQ 12
 	Region 4: I/O ports at a800 [size=32]
 	Capabilities: [80] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 00: 06 11 38 30 07 00 10 02 10 00 03 0c 08 20 00 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 01 a8 00 00 00 00 00 00 00 00 00 00 25 09 34 12
 30: 00 00 00 00 80 00 00 00 00 00 00 00 0c 04 00 00
 
 0000:00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Interrupt: pin ? routed to IRQ 9
 	Capabilities: [68] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 00: 06 11 57 30 00 00 90 02 30 00 80 06 00 00 00 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00
 
 0000:00:0a.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev 10)
 	Subsystem: Accton Technology Corporation EN-1207D Fast Ethernet Adapter
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 32 (8000ns min, 16000ns max)
 	Interrupt: pin A routed to IRQ 11
 	Region 0: I/O ports at ac00 [size=256]
 	Region 1: Memory at e7001000 (32-bit, non-prefetchable) [size=256]
 	Capabilities: [50] Power Management version 1
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 00: 13 11 11 12 07 00 90 02 10 00 00 02 00 20 00 00
 10: 01 ac 00 00 00 10 00 e7 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 13 11 11 12
 30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40
 
 0000:00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
 	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 bytes)
 	Interrupt: pin A routed to IRQ 10
 	Region 0: I/O ports at b000 [size=128]
 	Region 1: Memory at e7000000 (32-bit, non-prefetchable) [size=128]
+	Expansion ROM at 40080000 [disabled] [size=128K]
 	Capabilities: [dc] Power Management version 1
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 00: b7 10 55 90 07 00 10 02 30 00 00 02 08 20 00 00
 10: 01 b0 00 00 00 00 00 e7 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
 30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 0a 0a
 
 0000:00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
 	Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 32 (500ns min, 6000ns max)
 	Interrupt: pin A routed to IRQ 10
 	Region 0: I/O ports at b400 [size=256]
 	Capabilities: [c0] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 00: f6 13 11 01 05 00 10 02 10 00 01 04 00 20 00 00
 10: 01 b4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 f6 13 11 01
 30: 00 00 00 00 c0 00 00 00 00 00 00 00 0a 01 02 18
 
 0000:00:10.0 RAID bus controller: Silicon Image, Inc. SiI 0649 Ultra ATA/100 PCI to ATA Host Controller (rev 01)
 	Subsystem: Silicon Image, Inc. SiI 0649 Ultra ATA/100 PCI to ATA Host Controller
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (500ns min, 1000ns max)
 	Interrupt: pin A routed to IRQ 12
 	Region 0: I/O ports at b800 [size=8]
 	Region 1: I/O ports at bc00 [size=4]
 	Region 2: I/O ports at c000 [size=8]
 	Region 3: I/O ports at c400 [size=4]
 	Region 4: I/O ports at c800 [size=16]
+	Expansion ROM at 40000000 [disabled] [size=512K]
 	Capabilities: [60] Power Management version 2
 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=3 PME-
 00: 95 10 49 06 07 00 90 02 01 00 04 01 00 40 00 00
 10: 01 b8 00 00 01 bc 00 00 01 c0 00 00 01 c4 00 00
 20: 01 c8 00 00 00 00 00 00 00 00 00 00 95 10 49 06
-30: 00 00 00 00 60 00 00 00 00 00 00 00 0c 01 02 04
+30: 01 00 00 00 60 00 00 00 00 00 00 00 0c 01 02 04
 
 0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (rev 01) (prog-if 00 [VGA])
 	Subsystem: Hightech Information System Ltd.: Unknown device 5960
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
 	Interrupt: pin A routed to IRQ 5
 	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
 	Region 1: I/O ports at 9000 [size=256]
 	Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=64K]
+	Expansion ROM at e4000000 [disabled] [size=128K]
 	Capabilities: [58] AGP version 2.0
 		Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
-		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
+		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
 	Capabilities: [50] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 00: 02 10 60 59 07 00 b0 02 01 00 00 03 08 20 80 00
 10: 08 00 00 d0 01 90 00 00 00 00 00 e5 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 87 17 60 59
 30: 00 00 00 00 58 00 00 00 00 00 00 00 05 01 08 00
 
 0000:01:00.1 Display controller: ATI Technologies Inc: Unknown device 5940 (rev 01)
 	Subsystem: Hightech Information System Ltd.: Unknown device 5961
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
 	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
 	Region 1: Memory at e5010000 (32-bit, non-prefetchable) [size=64K]
 	Capabilities: [50] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 00: 02 10 40 59 07 00 b0 02 01 00 80 03 08 20 00 00
 10: 08 00 00 d8 00 00 01 e5 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 87 17 61 59
 30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 08 00
 

--nFreZHaLTZJo0R7j--
