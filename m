Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265037AbUFMKtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbUFMKtU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 06:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUFMKtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 06:49:20 -0400
Received: from tag.witbe.net ([81.88.96.48]:43226 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S265037AbUFMKtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 06:49:06 -0400
Message-Id: <200406131049.i5DAn4X11639@tag.witbe.net>
Reply-To: <rol@witbe.net>
From: "Paul Rolland" <rol@witbe.net>
To: <linux-kernel@vger.kernel.org>
Subject: [2.6.7-rc2] agpgart strange behavior...
Date: Sun, 13 Jun 2004 12:48:59 +0200
Organization: Witbe
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcRRNAf420d0MGO6QwG2tUVoxac7Ww==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Checking my logs, I discovered agpgart trying to set speed to 16x, at the
time I start X :

agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 16x mode
agpgart: SiS chipset with AGP problems detected. Giving bridge time to
recover.
agpgart: Putting AGP V3 device at 0000:01:00.0 into 16x mode

This is rather strange because the mobo is a P4S8X-SATA, and it does support
AGP up to 8x. What's more, the Video card supports up to 4x only, and this
is correctly reported thru lspci.


During boot time, it said (dmesg) :
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 648 chipset
agpgart: Maximum main memory to use for agp memory: 1430M
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] Initialized radeon 1.10.0 20020828 on minor 0: ATI Technologies Inc
Radeon RV200 QW [Radeon 7500]

So, boot time identification is correct.

and lspci -vvv reports :

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0648
(rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 8086
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=256M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x4

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: cf800000-cfffffff
        Prefetchable memory behind bridge: eff00000-febfffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 0963
(rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at e600 [size=32]

00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire
Controller (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 809a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 3000ns max)
        Interrupt: pin B routed to IRQ 17
        Region 0: Memory at cf000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at efee0000 [disabled] [size=128K]
        Capabilities: [64] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if
80 [Master])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin ? routed to IRQ 16
        Region 4: I/O ports at a400 [size=16]

00:03.0 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
(prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at ce800000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
(prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 0: Memory at ce000000 (32-bit, non-prefetchable) [size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
(prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin C routed to IRQ 22
        Region 0: Memory at cd800000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS]: Unknown device
7002 (prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max)
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at cd000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100
Ethernet (rev 91)
        Subsystem: Asustek Computer, Inc.: Unknown device 80a7
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at 8800 [size=256]
        Region 1: Memory at cc800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at efec0000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
        Subsystem: Adaptec AHA-2940U2W SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (9750ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        BIST result: 00
        Region 0: I/O ports at 8400 [disabled] [size=256]
        Region 1: Memory at cc000000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
        Subsystem: Creative Labs: Unknown device 8064
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at 8000 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev
07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at 7800 [disabled] [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at 7400 [size=64]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0c.0 Communication controller: ESS Technology ES2898 Modem (rev 03)
        Subsystem: DIGICOM Systems, Inc.: Unknown device 1063
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 7000 [disabled] [size=8]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=55mA
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW
[Radeon 7500] (prog-if 00 [VGA])
        Subsystem: Giga-byte Technology: Unknown device 4000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at cf800000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at effe0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

