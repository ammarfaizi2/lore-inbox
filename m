Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267003AbSL3QnE>; Mon, 30 Dec 2002 11:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267010AbSL3QnE>; Mon, 30 Dec 2002 11:43:04 -0500
Received: from mx2out.umbc.edu ([130.85.25.11]:29650 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S267003AbSL3Qmz>;
	Mon, 30 Dec 2002 11:42:55 -0500
Date: Mon, 30 Dec 2002 11:51:09 -0500 (EST)
From: Stephen Brown <sbrown7@umbc.edu>
X-X-Sender: sbrown7@linux3.gl.umbc.edu
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Micron Samurai chipset in 2.4.x (ide-pci.c)
In-Reply-To: <1041208676.1172.0.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.01.0212301138290.2383-100000@linux3.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Avmilter-Status: Skipped (size)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Dec 2002, Alan Cox wrote:

> Send me an lspci and dmesg of the IDE bits from the failed and ok case
> and I'll see if I can see how to do a workaround
>

Here you go:
from lspci -vvx on the system:

00:01.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 10 71 0f 00 80 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fcd0 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: d1 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at fce0 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 04 00 00

00:01.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
00: 86 80 13 71 03 00 80 02 01 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:11.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 10/100 model NC100 (rev 11)
	Subsystem: Linksys: Unknown device 0574
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at f800 [size=256]
	Region 1: Memory at febff800 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 17 13 85 09 17 00 90 02 11 00 00 02 08 40 00 00
10: 01 f8 00 00 00 f8 bf fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 02 02 00 00 17 13 74 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 01 ff ff

00:12.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
	Subsystem: Unknown device 4942:4c4c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 96 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at fc40 [size=64]
00: 74 12 00 50 05 00 00 34 00 00 01 04 00 60 00 00
10: 41 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 42 49 4c 4c
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 0c 80

00:13.0 VGA compatible controller: NVidia / SGS Thomson (Joint Venture) Riva128 (rev 10) (prog-if 00 [VGA])
	Subsystem: Diamond Multimedia Systems Viper V330
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at b9000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at b7000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at <unassigned> [disabled] [size=4M]
00: d2 12 18 00 03 00 a0 02 10 00 00 03 00 40 00 00
10: 00 00 00 b9 08 00 00 b7 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 92 10 92 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 03 01

00:18.0 Host bridge: Micron Samurai_0 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32, cache line size 08
00: 42 10 00 30 07 00 a0 22 01 00 00 06 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.0 Host bridge: Micron Samurai_1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
00: 42 10 10 30 07 00 a0 02 00 00 00 06 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.1 IDE interface: Micron Samurai_IDE (prog-if 8f [Master SecP SecO PriP PriO])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at fca0 [disabled] [size=8]
	Region 1: I/O ports at fca8 [disabled] [size=8]
	Region 2: I/O ports at fcb0 [disabled] [size=8]
	Region 3: I/O ports at fcb8 [disabled] [size=8]
	Region 4: I/O ports at fcc0 [disabled] [size=16]
00: 42 10 20 30 04 00 00 00 00 8f 01 01 00 00 00 00
10: a1 fc 00 00 a9 fc 00 00 b1 fc 00 00 b9 fc 00 00
20: c1 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

dmesg (actually capture from serial console) during failed boot with
2.4.21-pre2 kernel:

Linux version 2.4.21-pre2 (root@gemini) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #2 SMP Thu Dec 26 10:55:04 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0c00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0c00 - 0000000100000000 (reserved)
128MB LOWMEM available.
found SMP MP-table at 000fdac0
hm, page 000fd000 reserved twice.
hm, page 000fe000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: MICRON   Product ID: SAMURAI      APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 2
Kernel command line: BOOT_IMAGE=linux-pre2 ro root=301 BOOT_FILE=/boot/vmlinuz-2.4.21-pre2 console=ttyS1,9600n8

<<snip>>

PCI: PCI BIOS revision 2.10 entry at 0xf5d4b, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:01.0
PCI->APIC IRQ transform: (B0,I1,P3) -> 19
PCI->APIC IRQ transform: (B0,I17,P0) -> 16
PCI->APIC IRQ transform: (B0,I18,P0) -> 17
PCI->APIC IRQ transform: (B0,I19,P0) -> 19

<<snip>>

Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:01.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfcd8-0xfcdf, BIOS settings: hdc:pio, hdd:pio
SAMURAI: IDE controller at PCI slot 00:19.1
PCI: Enabling device 00:19.1 (0004 -> 0005)
PCI: No IRQ known for interrupt pin A of device 00:19.1. Probably buggy MP table.
SAMURAI: chipset revision 0
SAMURAI: bad irq (0): will probe later
    ide2: BM-DMA at 0xfcc0-0xfcc7, BIOS settings: hde:pio, hdf:pio

<< there was another line on screen while ide3 was probed, but the boot
hung before it was flushed (I guess) -- it read:
    ide3: BM-DMA at 0xfcc8-0xfccf
>>

Same scenario for successful boot using 2.4.20 modified as I originally
posted:

Linux version 2.4.20 (root@gemini) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #2 SMP Sat Dec 28 18:55:17 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0c00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0c00 - 0000000100000000 (reserved)
128MB LOWMEM available.
found SMP MP-table at 000fdac0
hm, page 000fd000 reserved twice.
hm, page 000fe000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: MICRON   Product ID: SAMURAI      APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: BOOT_IMAGE=linux-test ro root=301 BOOT_FILE=/boot/vmlinuz-2.4.20 console=ttyS1,9600n8

<<snip>>

All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf5d4b, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:01.0
PCI->APIC IRQ transform: (B0,I1,P3) -> 19
PCI->APIC IRQ transform: (B0,I17,P0) -> 16
PCI->APIC IRQ transform: (B0,I18,P0) -> 17
PCI->APIC IRQ transform: (B0,I19,P0) -> 19

<<snip>>

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 09
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfcd8-0xfcdf, BIOS settings: hdc:pio, hdd:pio
SAMURAI: ignored by ide_scan_pci_device() (uses own driver)
hda: ST32531A, ATA DISK drive
hdb: IBM-DARA-206000, ATA DISK drive
hdc: FX320S, ATAPI CD/DVD-ROM drive
hdd: Maxtor 90432D2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c037ace4, I/O limit 4095Mb (mask 0xffffffff)
hda: 4996476 sectors (2558 MB), CHS=4956/16/63, DMA
blk: queue c037ae30, I/O limit 4095Mb (mask 0xffffffff)
hdb: 9514260 sectors (4871 MB) w/418KiB Cache, CHS=10068/15/63, UDMA(33)
blk: queue c037b194, I/O limit 4095Mb (mask 0xffffffff)
hdd: 8440992 sectors (4322 MB) w/256KiB Cache, CHS=8374/16/63, UDMA(33)
hdc: ATAPI 32X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: [PTBL] [619/128/63] hda1 hda2
 hdb: [PTBL] [629/240/63] hdb1 hdb2
 hdd: [PTBL] [525/255/63] hdd1 hdd2

<<snip>>

kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 276k freed
INIT: version 2.84 booting
		Welcome to Red Hat Linux

<<much more snippage>>


Steve Brown
sbrown7@umbc.edu

