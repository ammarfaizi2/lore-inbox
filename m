Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbTCGFUc>; Fri, 7 Mar 2003 00:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261358AbTCGFUb>; Fri, 7 Mar 2003 00:20:31 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:45326
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S261352AbTCGFUZ>; Fri, 7 Mar 2003 00:20:25 -0500
Subject: Re: 2.5.64-mm1: Badness in request_irq
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <20030306141859.19645.qmail@linuxmail.org>
References: <20030306141859.19645.qmail@linuxmail.org>
Content-Type: multipart/mixed; boundary="=-y7CDO9dmy7njt/q00qpw"
Organization: 
Message-Id: <1047015055.1538.7.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Mar 2003 21:30:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y7CDO9dmy7njt/q00qpw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-03-06 at 06:18, Felipe Alfaro Solana wrote:
> Hello,  
>   
> I have just installed and compiled 2.5.64-mm1 using gcc-3.2.2 and,
> when booting the system, I have found the  
> following error on the kernel ring:  
>   
> Badness in request_irq at arch/i386/kernel/irq.c:475  
> Call Trace: [<c010afdd>]  [<d08b3d3a>]  [<d08b18c0>]  [<d08b42c8>]  [<d08b024e>]  [<d08b42b0>]   
> [<d08b49c0>]  [<d08b49e8>]  [<c0191d6e>]  [<d08b496c>]  [<d08b49e8>]  [<c01947f5>]  [<d08b49e8>]   
> [<c019491c>]  [<d08b49e8>]  [<d08b4a04>]  [<c0194c10>]  [<d08b49e8>]  [<d08bb160>]  [<c0194fff>]   
> [<d08b49e8>]  [<c0191eab>]  [<d08b49e8>]  [<d08a0019>]  [<d08b49c0>]  [<d08bb160>]  [<c01302cd>]   
> [<c010969e>]  

I'm getting this as well on both my desktop and laptop machines.

My desktop is a P4 machine with an Intel 845 chipset.  It seems to be
coming out of the PIIX driver.

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Found IRQ 10 for device 00:1f.1
PCI: Sharing IRQ 10 with 00:1d.2
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD1200JB-00CRA1, ATA DISK drive
Badness in request_irq at arch/i386/kernel/irq.c:475
Call Trace:
 [<c010b240>] request_irq+0xe2/0x116
 [<c020c2ec>] init_irq+0x12e/0x342
 [<c020af9a>] ide_intr+0x0/0x12a
 [<c020c95f>] hwif_init+0xe3/0x27c
 [<c020c060>] probe_hwif_init+0x2c/0x78
 [<c021db14>] ide_setup_pci_device+0x4e/0x74
 [<c0209c4c>] piix_init_one+0x32/0x38
 [<c010507b>] init+0x2d/0x146
 [<c010504e>] init+0x0/0x146
 [<c01073b9>] kernel_thread_helper+0x5/0xc

anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ATAPI 48X CDROM, ATAPI CD/DVD-ROM drive
Badness in request_irq at arch/i386/kernel/irq.c:475
Call Trace:
 [<c010b240>] request_irq+0xe2/0x116
 [<c020c2ec>] init_irq+0x12e/0x342
 [<c020af9a>] ide_intr+0x0/0x12a
 [<c020c95f>] hwif_init+0xe3/0x27c
 [<c020c060>] probe_hwif_init+0x2c/0x78
 [<c021db33>] ide_setup_pci_device+0x6d/0x74
 [<c0209c4c>] piix_init_one+0x32/0x38
 [<c010507b>] init+0x2d/0x146
 [<c010504e>] init+0x0/0x146
 [<c01073b9>] kernel_thread_helper+0x5/0xc

anticipatory scheduling elevator
ide1 at 0x170-0x177,0x376 on irq 15

The laptop is getting the message in the ALSA i810 audio driver:

PCI: Found IRQ 11 for device 00:00.1
PCI: Sharing IRQ 11 with 00:0b.1
Badness in request_irq at arch/i386/kernel/irq.c:475
Call Trace:
 [<cc8b86c0>] snd_intel8x0_interrupt+0x0/0x190 [snd_intel8x0]
 [<c010ad33>] request_irq+0x63/0xd0
 [<cc8ba8e5>] snd_intel8x0_create+0x245/0x460 [snd_intel8x0]
 [<cc8b86c0>] snd_intel8x0_interrupt+0x0/0x190 [snd_intel8x0]
 [<cc8bb2cb>] .LC54+0x0/0x13 [snd_intel8x0]
 [<cc8babdf>] snd_intel8x0_probe+0xdf/0x320 [snd_intel8x0]
 [<cc8beb28>] driver+0x28/0x98 [snd_intel8x0]
 [<c01c237f>] pci_device_probe+0x3f/0x60
 [<cc8be50c>] snd_intel8x0_ids+0x8c/0x1a0 [snd_intel8x0]
 [<cc8beb00>] driver+0x0/0x98 [snd_intel8x0]
 [<cc8beb28>] driver+0x28/0x98 [snd_intel8x0]
 [<cc8beb28>] driver+0x28/0x98 [snd_intel8x0]
 [<c01ca314>] bus_match+0x34/0x60
 [<c01ca3d4>] driver_attach+0x34/0x60
 [<cc8beb28>] driver+0x28/0x98 [snd_intel8x0]
 [<cc8beb48>] driver+0x48/0x98 [snd_intel8x0]
 [<c01ca686>] bus_add_driver+0x96/0xc0
 [<cc8beb28>] driver+0x28/0x98 [snd_intel8x0]
 [<cc8bed40>] +0x0/0x100 [snd_intel8x0]
 [<c01c2496>] pci_register_driver+0x46/0x60
 [<cc8beb28>] driver+0x28/0x98 [snd_intel8x0]
 [<cc85f00f>] +0xf/0x80 [snd_intel8x0]
 [<cc8beb00>] driver+0x0/0x98 [snd_intel8x0]
 [<c012ed8c>] sys_init_module+0x7c/0x200
 [<cc8bed40>] +0x0/0x100 [snd_intel8x0]
 [<c012ee52>] sys_init_module+0x142/0x200
 [<c0108e47>] syscall_call+0x7/0xb

PCI: Setting latency timer of device 00:00.1 to 64
intel8x0: clocking to 48000

lspci output for both machines attached.

	J


--=-y7CDO9dmy7njt/q00qpw
Content-Disposition: attachment; filename=desktop-lspci.txt
Content-Type: text/plain; name=desktop-lspci.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 11)
	Subsystem: Asustek Computer, Inc.: Unknown device 8088
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e6000000-e7dfffff
	Prefetchable memory behind bridge: e7f00000-efffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at d400 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at d000 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at e5800000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000bfff
	Memory behind bridge: e5000000-e57fffff
	Prefetchable memory behind bridge: e7e00000-e7efffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at f000 [size=16]
	Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2 GTS] (rev a3) (prog-if 00 [VGA])
	Subsystem: Elsa AG: Unknown device 0c50
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at e7ff0000 [disabled] [size=64K]
	Capabilities: <available only to root>

02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b800 [size=256]
	Capabilities: <available only to root>

02:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
	Subsystem: Netgear FA310TX Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b400 [size=128]
	Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=256K]

02:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs CT4830 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b000 [size=32]
	Capabilities: <available only to root>

02:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at a800 [size=8]
	Capabilities: <available only to root>


--=-y7CDO9dmy7njt/q00qpw
Content-Disposition: attachment; filename=laptop-lspci.txt
Content-Type: text/plain; name=laptop-lspci.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corporation 82440MX I/O Controller (rev 01)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64

00:00.1 Multimedia audio controller: Intel Corporation 82440MX AC'97 Audio Controller
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at fd00 [size=256]
	Region 1: I/O ports at fcc0 [size=64]

00:02.0 Communication controller: Lucent Microelectronics 56k WinModem (rev 01)
	Subsystem: Toshiba America Info Systems: Unknown device 0002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ffefff00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at 02f8 [size=8]
	Region 2: I/O ports at 1c00 [size=256]
	Capabilities: <available only to root>

00:04.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/MX-/IX (rev 11) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=128M]
	Expansion ROM at 000c0000 [disabled] [size=64K]
	Capabilities: <available only to root>

00:07.0 Bridge: Intel Corporation 82440MX PCI to ISA Bridge (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82440MX EIDE Controller (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f870 [size=16]

00:07.2 USB Controller: Intel Corporation 82440MX USB Universal Host Controller (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at f840 [size=32]

00:07.3 Bridge: Intel Corporation 82440MX Power Management Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 IRDA controller: Toshiba America Info Systems FIR Port Type-DO
	Subsystem: Toshiba America Info Systems FIR Port Type-DO
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at f820 [size=32]
	Capabilities: <available only to root>

00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=0
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=08, sec-latency=0
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00002000-000020ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

05:00.0 Ethernet controller: Bridgecom, Inc: Unknown device 1985 (rev 11)
	Subsystem: Ambicom Inc: Unknown device 2103
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1800 [size=256]
	Region 1: Memory at 11000000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 10c00000 [size=128K]
	Capabilities: <available only to root>


--=-y7CDO9dmy7njt/q00qpw--

