Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262649AbTCSADU>; Tue, 18 Mar 2003 19:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262761AbTCSADU>; Tue, 18 Mar 2003 19:03:20 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:51330 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S262649AbTCSADQ>;
	Tue, 18 Mar 2003 19:03:16 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.65-mm1
References: <20030318031104.13fb34cc.akpm@digeo.com>
	<87adfs4sqk.fsf@lapper.ihatent.com>
	<87bs08vfkg.fsf@lapper.ihatent.com>
	<20030318160902.C21945@flint.arm.linux.org.uk>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 19 Mar 2003 01:14:13 +0100
In-Reply-To: <20030318160902.C21945@flint.arm.linux.org.uk>
Message-ID: <873clkw6ui.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Tue, Mar 18, 2003 at 04:51:11PM +0100, Alexander Hoogerhuis wrote:
> > Oh well, I've had one hang within 10 minutes of booting, came back and
> > the machine was unresponsive (mouse and keyboard under X, unable to
> > switch to console). Apart from that I've got two funnies in my boot
> > messages:
> 
> Could you send the full bus information for all devices (lspci -vv),
> and the contents of /proc/iomem and /proc/ioports ?
> 
> I don't believe there's anything in my PCI updates which should have
> changed the behaviour - they were touching mainly the scanning for
> devices, and the way we write resources back into the hardware.  The
> latter rarely happens on x86, except for cardbus devices.
> 

I'm not suspecting the PCI in particular for the PCIC-bits, only
making X and the Radeon work again. But here you are:

lapper root # lspci -vv
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
        Subsystem: Compaq Computer Corporation: Unknown device 004a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at a0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [e4] #09 [d104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x4
 
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: 80300000-803fffff
        Prefetchable memory behind bridge: 88000000-900fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
 
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: 80000000-803fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
 
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Compaq Computer Corporation: Unknown device 004a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 4440 [size=16]
        Region 5: Memory at 30000400 (32-bit, non-prefetchable) [size=1K]
 
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device 004a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at 4000 [size=256]
        Region 1: I/O ports at 4400 [size=64]
 
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device 004a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 88000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at 80380000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:04.0 Communication controller: Lucent Microelectronics LT WinModem (rev 02)
        Subsystem: AMBIT Microsystem Corp.: Unknown device 0450
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (63000ns min, 3500ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at 80280000 (32-bit, non-prefetchable) [size=256]
        Region 1: I/O ports at 2440 [size=8]
        Region 2: I/O ports at 2000 [size=256]
        Capabilities: [f8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=160mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:06.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device 004a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 20
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 80080000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 30400000-307ff000 (prefetchable)
        Memory window 1: 30800000-30bff000
        I/O window 0: 00001400-000014ff
        I/O window 1: 00001800-000018ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001
 
02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller (rev 42)
        Subsystem: Compaq Computer Corporation: Unknown device 0093
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 80100000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 2400 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
 
02:0e.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Compaq Computer Corporation: Unknown device 004a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 80180000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:0e.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Compaq Computer Corporation: Unknown device 004a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at 80200000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:0e.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Compaq Computer Corporation: Unknown device 004a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8500ns max), cache line size 20
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at 30000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
lapper root #  cat /proc/iomem /proc/ioports
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-2ffcffff : System RAM
  00100000-002af453 : Kernel code
  002af454-00364003 : Kernel data
2ffd0000-2fff0bff : reserved
2fff0c00-2fffbfff : ACPI Non-volatile Storage
2fffc000-2fffffff : reserved
30000000-300000ff : NEC Corporation USB 2.0
  30000000-300000ff : ehci-hcd
30000400-300007ff : Intel Corp. 82801CAM IDE U100
30400000-307fffff : PCI CardBus #03
30800000-30bfffff : PCI CardBus #03
80080000-80080fff : Texas Instruments PCI1410 PC card Card
80100000-80100fff : Intel Corp. 82801CAM (ICH3) PRO/
  80100000-80100fff : eepro100
80180000-80180fff : NEC Corporation USB
  80180000-80180fff : ohci-hcd
80200000-80200fff : NEC Corporation USB (#2)
  80200000-80200fff : ohci-hcd
80280000-802800ff : Lucent Microelectron LT WinModem
80300000-803fffff : PCI Bus #01
  80380000-8038ffff : ATI Technologies Inc Radeon Mobility M7 L
88000000-900fffff : PCI Bus #01
  88000000-8fffffff : ATI Technologies Inc Radeon Mobility M7 L
a0000000-afffffff : Intel Corp. 82845 845 (Brookdale
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1060-106f : i810 TCO
1400-14ff : PCI CardBus #03
1800-18ff : PCI CardBus #03
2000-20ff : Lucent Microelectron LT WinModem
2400-243f : Intel Corp. 82801CAM (ICH3) PRO/
  2400-243f : eepro100
2440-2447 : Lucent Microelectron LT WinModem
3000-3fff : PCI Bus #01
  3000-30ff : ATI Technologies Inc Radeon Mobility M7 L
4000-40ff : Intel Corp. 82801CA/CAM AC'97 Au
  4000-40ff : Intel ICH3
4400-443f : Intel Corp. 82801CA/CAM AC'97 Au
  4400-443f : Intel ICH3
4440-444f : Intel Corp. 82801CAM IDE U100
  4440-4447 : ide0
  4448-444f : ide1
lapper root #

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
