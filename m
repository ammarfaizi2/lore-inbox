Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266074AbRGDAUb>; Tue, 3 Jul 2001 20:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbRGDAUW>; Tue, 3 Jul 2001 20:20:22 -0400
Received: from mail1.bigmailbox.com ([209.132.220.32]:9997 "EHLO
	mail1.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S266074AbRGDAUB>; Tue, 3 Jul 2001 20:20:01 -0400
Date: Tue, 3 Jul 2001 17:19:55 -0700
Message-Id: <200107040019.RAA26151@mail1.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [64.40.39.165]
From: "Colin Bayer" <colin_bayer@compnerd.net>
To: linux-kernel@vger.kernel.org
Cc: rddunlap@osdlab.org
Subject: Re: Sticky IO-APIC problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Randy.Dunlap" <rddunlap@osdlab.org> wrote:
>What mobo (model/name) is it?
>Can you give us the output from "lspci -vv"?

OK, it's an Intel BN810E Desktop Board; here's the output from lspci -vv:

[root@fortytwo /root]# lspci -vv
00:00.0 Host bridge: Intel Corporation 82810E GMCH [Graphics Memory Controller Hub] (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0

00:01.0 VGA compatible controller: Intel Corporation 82810E CGC [Chipset Graphics Controller] (rev 03) (prog-if 00 [VGA])
        Subsystem: Intel Corporation: Unknown device 4332
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at ffa80000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ff800000-ff8fffff
        Prefetchable memory behind bridge: f6a00000-f6afffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80 [Master])
        Subsystem: Intel Corporation 82801AA IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation 82801AA USB
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at ef80 [size=32]

00:1f.3 SMBus: Intel Corporation 82801AA SMBus (rev 02)
        Subsystem: Intel Corporation 82801AA SMBus
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at efa0 [size=16]

01:0a.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 09)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort- >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 4
        Region 0: I/O ports at df00 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0b.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01) (prog-if 02 [16550])
        Subsystem: US Robotics/3Com: Unknown device baba
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at dff0 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[root@fortytwo /root]#

>This shows that Linux mapped the APIC (part of the processor).
>It says nothing about mapping any IO APICs (unless you deleted
>that part :).

Oops, sorry -- misunderstood the meaning of the message. 8-P

>So, how does one know if a (UP) system has an IO APIC and that
>Linux can be configured to use the UP IO APIC code?...
>
>(That's a serious question: does an IO APIC show up in lspci output?)
>
>And why do you think that this system has an IO APIC?
>Is it documented to have one?
>[just digging for clues]

There's no IO-APIC in the lspci output, but that's because it's integrated as part of the i810 chipset; it's probably hidden to keep people from tinkering with the settings -- there's not much one can do to modify an interrupt controller that wouldn't end badly 8=;-) (according to Intel's docs, the IO-APIC's carried somewhere on the 82801AA I/O Controller Hub, and I quote:)

>From Intel's 82801AA I/O Controller Hub Datasheet (http://developer.intel.com/design/chipsets/datashts/29065503.pdf):

Features List: (page 3)

...
- Interrupt Controller
     - Two cascaded 82C59
     - Integrated IO-APIC capability
     - 15 Interrupt support in 8259 mode, 24 Interrupt support in
       IO-APIC mode
...

82801AA Simplified Block Diagram: (page 4)
                     ____________
SERIRQ <-----------> |           |
PIRQ[A..D]# <------> |           |
IRQ[14..15] -------> | Interrupt |<---
APICCLK -----------> |           |
APICD[1..0] <------> |___________|

82801AA Datasheet Introduction: (page 25)

Advanced Programmable Interrupt Controller (APIC) 

In addition to the standard ISA compatible interrupt controller (PIC) described in the previous section, the ICH incorporates the Advanced Programmable Interrupt Controller (APIC). While the standard interrupt controller is intended for use in a uni-processor system, APIC can be used in either a uni-processor or multi-processor system.

Hope this clears up some confusion.

     -- Colin

------------------------------------------------------------
The CompNerd Network: http://www.compnerd.com/
Where a nerd can be a nerd.  Get your free webmail@compnerd.net!
