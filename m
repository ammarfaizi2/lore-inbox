Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264856AbUE0QGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264856AbUE0QGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 12:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUE0QGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 12:06:22 -0400
Received: from h001061b078fa.ne.client2.attbi.com ([24.91.86.110]:35716 "EHLO
	linuxfarms.com") by vger.kernel.org with ESMTP id S264856AbUE0QFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 12:05:53 -0400
Date: Thu, 27 May 2004 12:05:38 -0400 (EDT)
From: Arthur Perry <kernel@linuxfarms.com>
X-X-Sender: kernel@tiamat.perryconsulting.net
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: GART error 11 (fwd)
In-Reply-To: <m3d64pvqlu.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.58.0405271135280.18743@tiamat.perryconsulting.net>
References: <20uGg-17i-23@gated-at.bofh.it> <m3d64pvqlu.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all of your responses!

I understand what you are saying.
And perhaps this may be the case, maybe the hardware should not report
these errors (which may not actually be gart errors after all) just
because the GART has been set up.
However, my failure mode seems to be that I only get these errors when the
agp driver is loaded on a machine that does not have an agp bus.
I also have IOMMUs disabled in the BIOS by default.
The BIOS is not enabling the GART at all, so it must be done by the
kernel. A boot into DOS will show the Gart Aperture Control Register set
to all zeros, where a boot to Linux 2.4 w/AGP will boot with them enabled.
Again, the failure mode recognised so far is that the "gart errors" appear
when this register is set up.

What the user sees at this point is even though they have the
"GART error reporting enable" disabled, they still see "GART" errors.

If you are suggesting that there may be a real hardware error here that is
being misinterpreted by the kernel, my next course of action is to collect
that real error syndrome and decode it.

I can volunteer to assist with fixing this decoding function as well,
since I have a good test case here.

Arjan also suggested:
>> The AGP GART is also used as IOMMU !
>> So "does not do anything" is a incorrect assumption...

I am not really sure why this would be the case if I have disabled IOMMUs
in the BIOS. But I have to first understand what this particular switch is
doing.
Are you suggesting that the kernel is going to use the GART for IOMMU
purposes, or is the GART a part of the IOMMU?


Thanks again for all of your help so far.


Here is a lspci -vvv -x (as requested.. sorry it is a very exhaustive list..)

00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 115
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: ec000000-edffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [c0] #08 [0086]
        Capabilities: [f0] #08 [8000]
00: 22 10 60 74 17 00 30 02 07 00 04 06 00 73 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 44 20 20 00 22
20: 00 ec f0 ed f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 0e 00

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: 22 10 68 74 0f 00 20 02 05 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1000 [size=16]
00: 22 10 69 74 05 00 00 02 03 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 10 00 00 00 00 00 00 00 00 00 00 22 10 80 2b
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 6b 74 00 00 80 02 05 00 80 06 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 80 2b
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1a.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:1a.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1a.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1a.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1b.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:1b.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1b.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1b.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=4K]
00: 22 10 64 74 17 00 80 02 0b 10 03 0c 00 40 80 00
10: 00 00 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 80 2b
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 50

01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at ec001000 (32-bit, non-prefetchable) [size=4K]
00: 22 10 64 74 17 00 80 02 0b 10 03 0c 00 40 00 00
10: 00 10 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 80 2b
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 50

01:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage XL
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at ed000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 2000 [size=256]
        Region 2: Memory at ec002000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 52 47 87 00 90 02 27 00 00 03 10 40 00 00
10: 00 00 00 ed 01 20 00 00 00 20 00 ec 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 08 80
30: 00 00 00 00 5c 00 00 00 00 00 00 00 0b 01 08 00

08:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=08, secondary=09, subordinate=0d, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0] PCI-X non-bridge device.
                Command: DPERE+ ERO+ RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabi
lities: [b8] #08 [8000]
        Capabilities: [c0] #08 [0041]
00: 22 10 50 74 17 00 30 02 12 00 04 06 00 40 81 00
10: 00 00 00 00 00 00 00 00 08 09 0d 40 f1 01 20 22
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 04 00

08:01.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at ee200000 (64-bit, non-prefetchable) [size=4K]
00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
10: 04 00 20 ee 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 80 2b
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

08:02.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=08, secondary=0e, subordinate=12, sec-latency=128
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: f1000000-f10fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0] PCI-X non-bridge device.
                Command: DPERE+ ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabi
lities: [b8] #08 [8000]
00: 22 10 50 74 17 00 30 02 12 00 04 06 00 40 81 00
10: 00 00 00 00 00 00 00 00 08 0e 12 80 31 31 20 22
20: 00 f1 00 f1 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 04 00

08:02.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at ee201000 (64-bit, non-prefetchable) [size=4K]
00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
10: 04 10 20 ee 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 80 2b
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

08:03.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: Memory at ee202000 (64-bit, non-prefetchable) [size=4K]
        Bus: primary=08, secondary=13, subordinate=1a, sec-latency=64
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: ef000000-efffffff
        Prefetchable memory behind bridge: 00000000f4000000-00000000f7f00000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0] PCI-X non-bridge device.
                Command: DPERE+ ERO+ RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabi
lities: [b8] #08 [8000]
        Capabilities: [90] #0c [0009]
        Capabilities: [98] Power Management version 2
                Flags: PMEClk+ DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
        Capabilities: [c0] #08 [0043]
00: 22 10 50 74 17 00 30 02 12 00 04 06 00 40 81 00
10: 04 20 20 ee 00 00 00 00 08 13 1a 40 41 41 20 02
20: 00 ef f0 ef 01 f4 f1 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 0b 01 04 00

08:03.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at ee203000 (64-bit, non-prefetchable) [size=4K]
00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
10: 04 30 20 ee 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 80 2b
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

08:04.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: Memory at ee204000 (64-bit, non-prefetchable) [size=4K]
        Bus: primary=08, secondary=1b, subordinate=22, sec-latency=64
        I/O behind bridge: 00005000-00005fff
        Memory behind bridge: f0000000-f0ffffff
        Prefetchable memory behind bridge: 00000000f8000000-00000000fbf00000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0] PCI-X non-bridge device.
                Command: DPERE+ ERO+ RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabi
lities: [b8] #08 [8000]
        Capabilities: [90] #0c [0009]
        Capabilities: [98] Power Management version 2
                Flags: PMEClk+ DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
00: 22 10 50 74 17 00 30 02 12 00 04 06 00 40 81 00
10: 04 40 20 ee 00 00 00 00 08 1b 22 40 51 51 20 02
20: 00 f0 f0 f0 01 f8 f1 fb 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 0b 01 04 00

08:04.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at ee205000 (64-bit, non-prefetchable) [size=4K]
00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
10: 04 50 20 ee 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 80 2b
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0e:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 136 (4250ns min, 4500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 29
        Region 0: I/O ports at 3000 [size=256]
        Region 1: Memory at f1010000 (64-bit, non-prefetchable) [size=64K]
        Region 3: Memory at f1000000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [68] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=2 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-00: 00 10 30
 00 17 00 30 02 07 00 00 01 10 88 80 00
10: 01 30 00 00 04 00 01 f1 00 00 00 00 04 00 00 f1
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 10 00 10
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 11 12

0e:01.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 136 (4250ns min, 4500ns max), cache line size 10
        Interrupt: pin B routed to IRQ 30
        Region 0: I/O ports at 3400 [size=256]
        Region 1: Memory at f1030000 (64-bit, non-prefetchable) [size=64K]
        Region 3: Memory at f1020000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [68] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=2 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-00: 00 10 30
 00 17 00 30 02 07 00 00 01 10 88 80 00
10: 01 34 00 00 04 00 03 f1 00 00 00 00 04 00 02 f1
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 10 00 10
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 02 11 12

0e:03.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 01)
        Subsystem: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 31
        Region 0: Memory at f1050000 (64-bit, non-prefetchable) [size=64K]
        Region 2: Memory at f1040000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=2 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabi
lities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: 80f061a015220000  Data: 1ac1
00: e4 14 48 16 06 00 b0 02 01 00 00 02 10 40 80 00
10: 04 00 05 f1 00 00 00 00 04 00 04 f1 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 e4 14 48 16
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 40 00

0e:03.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 01)
        Subsystem: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 10
        Interrupt: pin B routed to IRQ 28
        Region 0: Memory at f1070000 (64-bit, non-prefetchable) [size=64K]
        Region 2: Memory at f1060000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabi
lities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: 5403540058601a54  Data: 0800
00: e4 14 48 16 06 00 b0 02 01 00 00 02 10 40 80 00
10: 04 00 07 f1 00 00 00 00 04 00 06 f1 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 e4 14 48 16
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 02 40 00



Arthur Perry
Lead Linux Developer / Linux Systems Architect
Validation, CSU Celestica
Sair/Linux Gnu Certified Professional
Providing professional Linux solutions for 7+ years



On Thu, 27 May 2004, Andi Kleen wrote:

> Arthur Perry <kernel@linuxfarms.com> writes:
>
> > Here is a posting that I dropped off in RedHat's amd64-list.
> > It is a kernel related issue, so if anybody has any insight or opinion of
> > proper implementation here, please jump in!
>
> Machine Check Exceptions are in front of all hardware issues, not kernel
> issues. It is your CPU trying to tell you that something is wrong in the
> hardware.
>
> The 2.4 MCE code tends to label unrelated MCEs as "GART error" because
> of bugs in the MCE decoding functions. There is a full fix for that
> in the works.
>
> In some early 2.4 kernels it also managed to trigger a CPU bug
> by writing directly nb registers.  This should be fixed in later
> 2.4 kernels and also in SuSE SLES8-SP3.
>
> Best alternative is to use 2.6 which has much improved MCE handling.
>
> -Andi
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
