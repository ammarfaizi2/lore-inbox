Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbSKSIpp>; Tue, 19 Nov 2002 03:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSKSIpp>; Tue, 19 Nov 2002 03:45:45 -0500
Received: from ifup.net ([217.160.130.191]:62114 "HELO sit0.ifup.net")
	by vger.kernel.org with SMTP id <S264688AbSKSIpd>;
	Tue, 19 Nov 2002 03:45:33 -0500
Date: Tue, 19 Nov 2002 09:52:54 +0100
From: Karsten Desler <soohrt@soohrt.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: 2.4.20-rc1-ac4 HPT374 doesn't find connected ide drives
Message-ID: <20021119085254.GA22465@soohrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC to linux-smp because of the 'unexpected IO-APIC']

Hi,

Linux detects the two HPT374 controllers, but not the attached drives.

The Mainboard is an EPOX EP-8K5A3+ with 2 VIA vt8235 ide controllers
and 4 Highpoint 374.

I increased the channels: limit for the HPT374 in drivers/ide/pci/hpt366.h
to 4.
--- drivers/ide/pci/hpt366.h.old        2002-11-19 17:41:33.000000000 +0100
+++ drivers/ide/pci/hpt366.h    2002-11-19 17:41:45.000000000 +0100
@@ -508,5 +508,5 @@
		init_hwif:	init_hwif_hpt366,
		init_dma:	init_dma_hpt366,
-               channels:	2,      /* 4 */
+               channels:	4,      /* 2 */
		autodma:	AUTODMA,
		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},

So how do I get Linux to detect the ide2,3,4,5 "devices" and the
attached drives?

dmesg without APIC:
---
Linux version 2.4.20-rc1-ac4 (root@pikelot) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Tue Nov 19 16:54:44 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=303 pci=biosirq
Initializing CPU#0
Detected 1737.305 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3460.30 BogoMIPS
Memory: 513376k/524224k available (917k kernel code, 8280k reserved, 249k data, 220k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=64444 max_file_pages=0 max_inodes=0 max_dentries=64444
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2100+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb3d0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1106/3099] 000600 00
Found 00:08 [1106/b099] 000604 01
Found 00:40 [5333/8811] 000300 00
Found 00:60 [10ec/8139] 000200 00
Found 00:70 [1103/0008] 000104 00
Found 00:71 [1103/0008] 000104 00
Found 00:88 [1106/3177] 000601 00
Found 00:89 [1106/0571] 000101 00
Fixups for bus 00
Scanning behind PCI bridge 00:01.0, config 010100, pass 0
Scanning bus 01
Fixups for bus 01
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:01.0, config 010100, pass 1
Bus scan for 00 returning with max=01
PCI: Using IRQ router VIA [1106/3177] at 00:11.0
PCI: Found IRQ 11 for device 00:08.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT374: IDE controller at PCI slot 00:0e.0
PCI: Found IRQ 10 for device 00:0e.0
PCI: Sharing IRQ 10 with 00:0e.1
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
PCI: Found IRQ 10 for device 00:0e.1
PCI: Sharing IRQ 10 with 00:0e.0
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: No IRQ known for interrupt pin A of device 00:11.1.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xc800-0xc807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc808-0xc80f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DPTA-372050, ATA DISK drive
hda: DMA disabled
blk: queue c02823a0, I/O limit 4095Mb (mask 0xffffffff)
hdc: MAXTOR 4K080H4, ATA DISK drive
hdd: WDC WD800AB-00CBA0, ATA DISK drive
hdc: DMA disabled
blk: queue c028280c, I/O limit 4095Mb (mask 0xffffffff)
hdd: DMA disabled
blk: queue c0282958, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=2495/255/63, UDMA(33)
hdc: host protected area => 1
hdc: 156301488 sectors (80026 MB) w/2000KiB Cache, CHS=155061/16/63, UDMA(100)
hdd: host protected area => 1
hdd: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
[..]
---

dmesg with APIC:
Linux version 2.4.20-rc1-ac4 (root@pikelot) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 Tue Nov 19 17:02:24 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f5d50
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Kernel command line: auto BOOT_IMAGE=Linux ro root=303 pci=biosirq
Initializing CPU#0
Detected 1737.305 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3460.30 BogoMIPS
Memory: 513312k/524224k available (923k kernel code, 8344k reserved,
261k data, 236k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=64436 max_file_pages=0 max_inodes=0 max_dentries=64436
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2100+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-12, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 18.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 001 01  0    0    0   0   0    1    1    89
 10 001 01  1    1    0   1   0    1    1    91
 11 001 01  1    1    0   1   0    1    1    99
 12 001 01  1    1    0   1   0    1    1    A1
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1737.3335 MHz.
..... host bus clock speed is 267.2820 MHz.
cpu: 0, clocks: 2672820, slice: 1336410
CPU0<T0:2672816,T1:1336400,D:6,S:1336410,C:2672820>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb3d0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1106/3099] 000600 00
Found 00:08 [1106/b099] 000604 01
Found 00:40 [5333/8811] 000300 00
Found 00:60 [10ec/8139] 000200 00
Found 00:70 [1103/0008] 000104 00
Found 00:71 [1103/0008] 000104 00
Found 00:88 [1106/3177] 000601 00
Found 00:89 [1106/0571] 000101 00
Fixups for bus 00
Scanning behind PCI bridge 00:01.0, config 010100, pass 0
Scanning bus 01
Fixups for bus 01
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:01.0, config 010100, pass 1
Bus scan for 00 returning with max=01
PCI: Using IRQ router VIA [1106/3177] at 00:11.0
PCI->APIC IRQ transform: (B0,I12,P0) -> 18
PCI->APIC IRQ transform: (B0,I14,P0) -> 17
PCI->APIC IRQ transform: (B0,I14,P0) -> 17
PCI->APIC IRQ transform: (B0,I17,P0) -> 16
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT374: IDE controller at PCI slot 00:0e.0
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xc800-0xc807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc808-0xc80f, BIOS settings: hdc:DMA, hdd:DMA
[..]

lspci -vvv (with APIC):
---
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e5000000 (32-bit, prefetchable) [size=4M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
	        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev 54) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 9000 [size=256]
	Region 1: Memory at e5400000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 RAID bus controller: Triones Technologies, Inc.: Unknown device 0008 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 9400 [size=8]
	Region 1: I/O ports at 9800 [size=4]
	Region 2: I/O ports at 9c00 [size=8]
	Region 3: I/O ports at a000 [size=4]
	Region 4: I/O ports at a400 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.1 RAID bus controller: Triones Technologies, Inc.: Unknown device 0008 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at a800 [size=8]
	Region 1: I/O ports at ac00 [size=4]
	Region 2: I/O ports at b000 [size=8]
	Region 3: I/O ports at b400 [size=4]
	Region 4: I/O ports at b800 [size=256]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8233A ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2 
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at c800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Thanks in advance
 Karsten
