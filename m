Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266302AbUFZQcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266302AbUFZQcY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUFZQcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:32:24 -0400
Received: from mail.gmx.de ([213.165.64.20]:653 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266302AbUFZQcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:32:14 -0400
X-Authenticated: #20629184
Message-ID: <40DDA514.4080204@gmx.de>
Date: Sat, 26 Jun 2004 18:32:20 +0200
From: Johannes Bauer <dfnsonfsduifb@gmx.de>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040625)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 shows blank screen during boot with Radeon 9600 Mobility
References: <2842i-3m8-23@gated-at.bofh.it>
In-Reply-To: <2842i-3m8-23@gated-at.bofh.it>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found another laptop showing the _exact_ symptoms, as soon as

Device Drivers  --->
	Graphics support  --->
		[*] Support for frame buffer devices
		<*>   ATI Radeon display support

is being enabled. This _definitely_ is a kernel bug, as it works with 
2.6.6 just fine. Here's the other laptop's lspci:

ruedilap [~]: lspci
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS645DX Host 
& Memory & AGP Controller (rev 01)
0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual 
PCI-to-PCI bridge (AGP)
0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL 
Media IO] (rev 14)
0000:00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
0000:00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] 
FireWire Controller
0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
0000:00:02.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem 
Controller (rev a0)
0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems 
[SiS] Sound Controller (rev a0)
0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f)
0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f)
0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f)
0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 
Controller
0000:00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] 
SiS900 PCI Fast Ethernet (rev 91)
0000:00:08.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 
[Mobility Radeon 9600 M10]
ruedilap [~]: lspci -v -v
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS645DX Host 
& Memory & AGP Controller (rev 01)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64
         Region 0: Memory at dc000000 (32-bit, non-prefetchable)
         Capabilities: [c0] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- 
FW- Rate=<none>

0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual 
PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000a000-0000afff
         Memory behind bridge: d7e00000-d7efffff
         Prefetchable memory behind bridge: c7c00000-d7cfffff
         Expansion ROM at 0000a000 [disabled] [size=4K]
         BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL 
Media IO] (rev 14)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 5
         Region 4: I/O ports at 0c00 [size=32]

0000:00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] 
FireWire Controller (prog-if 10 [OHCI])
         Subsystem: Uniwill Computer Corp: Unknown device 7007
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (1000ns min, 3000ns max)
         Interrupt: pin B routed to IRQ 5
         Region 0: Memory at dbfff000 (32-bit, non-prefetchable) 
[size=dbfc0000]
         Expansion ROM at 00020000 [disabled]
         Capabilities: [64] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] 
(prog-if 80 [Master])
         Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE 
Controller (A,B step)
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 128
         Region 4: I/O ports at ff00 [size=16]

0000:00:02.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem 
Controller (rev a0) (prog-if 00 [Generic])
         Subsystem: Uniwill Computer Corp: Unknown device 4003
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (13000ns min, 2750ns max)
         Interrupt: pin C routed to IRQ 10
         Region 0: I/O ports at d400
         Region 1: I/O ports at d000 [size=128]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems 
[SiS] Sound Controller (rev a0)
         Subsystem: Uniwill Computer Corp: Unknown device 5203
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (13000ns min, 2750ns max)
         Interrupt: pin C routed to IRQ 10
         Region 0: I/O ports at dc00
         Region 1: I/O ports at d800 [size=128]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
         Subsystem: Uniwill Computer Corp: Unknown device 7001
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (20000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at dbffb000 (32-bit, non-prefetchable)

0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
         Subsystem: Uniwill Computer Corp: Unknown device 7001
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (20000ns max), cache line size 08
         Interrupt: pin B routed to IRQ 10
         Region 0: Memory at dbffc000 (32-bit, non-prefetchable)

0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
         Subsystem: Uniwill Computer Corp: Unknown device 7001
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (20000ns max), cache line size 08
         Interrupt: pin C routed to IRQ 5
         Region 0: Memory at dbffd000 (32-bit, non-prefetchable)

0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 
Controller (prog-if 20 [EHCI])
         Subsystem: Uniwill Computer Corp: Unknown device 7002
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (20000ns max)
         Interrupt: pin D routed to IRQ 11
         Region 0: Memory at dbffe000 (32-bit, non-prefetchable)
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] 
SiS900 PCI Fast Ethernet (rev 91)
         Subsystem: Uniwill Computer Corp: Unknown device 5002
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (13000ns min, 2750ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at cc00 [size=dbfa0000]
         Region 1: Memory at dbffa000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at 00020000 [disabled]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
         Subsystem: Uniwill Computer Corp: Unknown device 3000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 168
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at 20000000 (32-bit, non-prefetchable)
         Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
         Memory window 0: 20400000-207ff000 (prefetchable)
         Memory window 1: 20800000-20bff000
         I/O window 0: 00004000-000040ff
         I/O window 1: 00004400-000044ff
         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- 
PostWrite+
         16-bit legacy interface ports at 0001

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 
[Mobility Radeon 9600 M10] (prog-if 00 [VGA])
         Subsystem: Uniwill Computer Corp: Unknown device 2314
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at c8000000 (32-bit, prefetchable)
         Region 1: I/O ports at a800 [size=256]
         Region 2: Memory at d7ef0000 (32-bit, non-prefetchable) [size=64K]
         Capabilities: [58] AGP version 2.0
                 Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- 
FW- Rate=<none>
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

ruedilap [~]:

Greetings,
Joe
