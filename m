Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267231AbTAFWAm>; Mon, 6 Jan 2003 17:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267233AbTAFWAl>; Mon, 6 Jan 2003 17:00:41 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:9230 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id <S267231AbTAFWAR>;
	Mon, 6 Jan 2003 17:00:17 -0500
Date: Mon, 6 Jan 2003 23:08:48 +0100
From: romieu@fr.zoreil.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre2 + hpt366 + IBM-DTLA-307030 + bi-celeron failure
Message-ID: <20030106230848.A12579@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o Symptoms:

boots, detects hda and hdc, starts raid1 array and sooner or later before
init dies (keyboard led dead, ide led solid, sysrq dead) with:
[partial usual boot output]
hdc: dma_timer_expiry: dma status == 0x21
hdc: timeout waiting for DMA
hdc: timeout waiting for DMA
hdc: (__ide_dma_test_irq) called while not waiting

o lspci -vx

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Flags: bus master, medium devsel, latency 32
	Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>
00: 86 80 90 71 06 00 10 22 03 00 00 06 00 20 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: d4000000-d5ffffff
	Prefetchable memory behind bridge: d6000000-d7ffffff
00: 86 80 91 71 07 01 20 02 03 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 f0 00 a0 22
20: 00 d4 f0 d5 00 d6 f0 d7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 88 00

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0
00: 86 80 10 71 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 32
	I/O ports at f000 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 32, IRQ 19
	I/O ports at d000 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 04 00 00

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Flags: medium devsel, IRQ 9
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF (rev 09)
	Subsystem: Standard Microsystems Corp [SMC]: Unknown device a020
	Flags: bus master, fast devsel, latency 32, IRQ 18
	I/O ports at d400 [size=256]
	Memory at d9011000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>
00: b8 10 05 00 07 00 90 00 09 00 00 02 08 20 00 00
10: 01 d4 00 00 00 10 01 d9 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 01 00 00 b8 10 20 a0
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 08 1c

00:0f.0 Network controller: Siemens Nixdorf AG: Unknown device 2102 (rev 20)
	Flags: bus master, medium devsel, latency 32, IRQ 16
	Memory at d9010000 (32-bit, non-prefetchable) [size=2K]
	Memory at d9000000 (32-bit, non-prefetchable) [size=64K]
00: 0a 11 02 21 07 00 80 02 20 00 80 02 00 20 00 00
10: 00 00 01 d9 00 00 00 d9 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 03 0a

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 01)
	Flags: bus master, medium devsel, latency 120, IRQ 18
	I/O ports at d800 [size=8]
	I/O ports at dc00 [size=4]
	I/O ports at e000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
00: 03 11 04 00 05 00 00 02 01 00 80 01 08 78 80 00
10: 01 d8 00 00 01 dc 00 00 00 00 00 00 00 00 00 00
20: 01 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 08 08

00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 01)
	Flags: bus master, medium devsel, latency 120, IRQ 18
	I/O ports at e400 [size=8]
	I/O ports at e800 [size=4]
	I/O ports at ec00 [size=256]
00: 03 11 04 00 07 00 00 02 01 00 80 01 08 78 80 00
10: 01 e4 00 00 01 e8 00 00 00 00 00 00 00 00 00 00
20: 01 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 08 08

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 16
	Memory at d4000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d6000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>
00: de 10 2d 00 07 00 b0 02 15 00 00 03 00 f8 00 00
10: 00 00 00 d4 08 00 00 d6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 05 01

o Normal dmesg output (2.4.20)

Linux version 2.4.20 (romieu@crap.fr.zoreil.com) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #2 SMP mer déc 18 23:24:57 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000018000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 0000000010000000 (usable)
256MB LOWMEM available.
found SMP MP-table at 000f5ae0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=2.4.20 ro root=903 BOOT_FILE=/boot/bzImage-2.4.20 root=/dev/md3 ide=reverse devfs=nomount mem=256M
ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
Initializing CPU#0
Detected 501.150 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 256320k/262144k available (1435k kernel code, 5436k reserved, 538k data, 156k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Celeron (Mendocino) stepping 05
per-CPU timeslice cutoff: 365.52 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 999.42 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU1: Intel Celeron (Mendocino) stepping 05
Total of 2 processors activated (1998.84 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-17, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 20.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89
 10 003 03  1    1    0   1   0    1    1    91
 11 000 00  1    0    0   0   0    0    0    00
 12 003 03  1    1    0   1   0    1    1    99
 13 003 03  1    1    0   1   0    1    1    A1
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
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 501.1621 MHz.
..... host bus clock speed is 66.8214 MHz.
cpu: 0, clocks: 668214, slice: 222738
CPU0<T0:668208,T1:445456,D:14,S:222738,C:668214>
cpu: 1, clocks: 668214, slice: 222738
CPU1<T0:668208,T1:222720,D:12,S:222738,C:668214>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb5c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I11,P0) -> 18
PCI->APIC IRQ transform: (B0,I15,P0) -> 16
PCI->APIC IRQ transform: (B0,I19,P0) -> 18
PCI->APIC IRQ transform: (B0,I19,P1) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller on PCI bus 00 dev 98
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
HPT366: IDE controller on PCI bus 00 dev 99
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0xec00-0xec07, BIOS settings: hdc:DMA, hdd:pio
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xf000-0xf007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xf008-0xf00f, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DTLA-307030, ATA DISK drive
hdc: IBM-DTLA-307030, ATA DISK drive
hde: HITACHI DVD-ROM GD-7500, ATAPI CD/DVD-ROM drive
ide0 at 0xd800-0xd807,0xdc02 on irq 18
ide1 at 0xe400-0xe407,0xe802 on irq 18
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
blk: queue c0367b24, I/O limit 4095Mb (mask 0xffffffff)
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(44)
blk: queue c0367ea8, I/O limit 4095Mb (mask 0xffffffff)
hdc: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(44)
Partition check:
 hda:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
 hdc:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 >
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 000001b5]
 [events: 000001c8]
 [events: 000001c0]
 [events: 000001cf]
 [events: 0000012b]
 [events: 000001b5]
 [events: 000001c8]
 [events: 000001c0]
 [events: 000001cf]
 [events: 0000012b]
md: autorun ...
md: considering hdc8 ...
md:  adding hdc8 ...
md:  adding hda8 ...
md: created md8
md: bind<hda8,1>
md: bind<hdc8,2>
md: running: <hdc8><hda8>
md: hdc8's event counter: 0000012b
md: hda8's event counter: 0000012b
md: md8: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md8: max total readahead window set to 124k
md8: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdc8 operational as mirror 0
raid1: device hda8 operational as mirror 1
raid1: raid set md8 not clean; reconstructing mirrors
raid1: raid set md8 active with 2 out of 2 mirrors
md: syncing RAID array md8
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000 KB/sec) for reconstruction.
md: using 124k window, over a total of 9016832 blocks.
md: updating md8 RAID superblock on device
md: hdc8 [events: 0000012c]<6>(write) hdc8's sb offset: 9016896
md: hda8 [events: 0000012c]<6>(write) hda8's sb offset: 9016960
md: considering hdc7 ...
md:  adding hdc7 ...
md:  adding hda7 ...
md: created md7
md: bind<hda7,1>
md: bind<hdc7,2>
md: running: <hdc7><hda7>
md: hdc7's event counter: 000001cf
md: hda7's event counter: 000001cf
md: md7: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md7: max total readahead window set to 124k
md7: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdc7 operational as mirror 0
raid1: device hda7 operational as mirror 1
raid1: raid set md7 not clean; reconstructing mirrors
raid1: raid set md7 active with 2 out of 2 mirrors
md: delaying resync of md7 until md8 has finished resync (they share one or more physical units)
md: updating md7 RAID superblock on device
md: hdc7 [events: 000001d0]<6>(write) hdc7's sb offset: 8191872
md: hda7 [events: 000001d0]<6>(write) hda7's sb offset: 8191872
md: considering hdc6 ...
md:  adding hdc6 ...
md:  adding hda6 ...
md: created md6
md: bind<hda6,1>
md: bind<hdc6,2>
md: running: <hdc6><hda6>
md: hdc6's event counter: 000001c0
md: hda6's event counter: 000001c0
md: md6: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md6: max total readahead window set to 124k
md6: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdc6 operational as mirror 0
raid1: device hda6 operational as mirror 1
raid1: raid set md6 not clean; reconstructing mirrors
raid1: raid set md6 active with 2 out of 2 mirrors
md: delaying resync of md6 until md8 has finished resync (they share one or more physical units)
md: updating md6 RAID superblock on device
md: hdc6 [events: 000001c1]<6>(write) hdc6's sb offset: 504384
md: hda6 [events: 000001c1]<6>(write) hda6's sb offset: 504384
md: considering hdc3 ...
md:  adding hdc3 ...
md:  adding hda3 ...
md: created md3
md: bind<hda3,1>
md: bind<hdc3,2>
md: running: <hdc3><hda3>
md: hdc3's event counter: 000001c8
md: hda3's event counter: 000001c8
md: md3: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md3: max total readahead window set to 124k
md3: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdc3 operational as mirror 0
raid1: device hda3 operational as mirror 1
raid1: raid set md3 not clean; reconstructing mirrors
raid1: raid set md3 active with 2 out of 2 mirrors
md: delaying resync of md3 until md8 has finished resync (they share one or more physical units)
md: updating md3 RAID superblock on device
md: hdc3 [events: 000001c9]<6>(write) hdc3's sb offset: 4095936
md: hda3 [events: 000001c9]<6>(write) hda3's sb offset: 4095936
md: considering hdc2 ...
md:  adding hdc2 ...
md:  adding hda2 ...
md: created md2
md: bind<hda2,1>
md: bind<hdc2,2>
md: running: <hdc2><hda2>
md: hdc2's event counter: 000001b5
md: hda2's event counter: 000001b5
md: md2: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md2: max total readahead window set to 124k
md2: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdc2 operational as mirror 0
raid1: device hda2 operational as mirror 1
raid1: raid set md2 not clean; reconstructing mirrors
raid1: raid set md2 active with 2 out of 2 mirrors
md: delaying resync of md2 until md8 has finished resync (they share one or more physical units)
md: updating md2 RAID superblock on device
md: hdc2 [events: 000001b6]<6>(write) hdc2's sb offset: 4095936
md: hda2 [events: 000001b6]<6>(write) hda2's sb offset: 4095936
md: ... autorun DONE.
IEEE 802.2 LLC for Linux 2.1 (c) 1996 Tim Alpaerts
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 10922)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 156k freed
Adding Swap: 504312k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 23:08:32 Dec 18 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c131ac60, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: d000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c131ac60
usb.c: kusbd: /sbin/hotplug add 1
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,3), internal journal
isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative ViBRA16X PnP'
isapnp: 1 Plug & Play card detected total
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative ViBRA16X PnP detected
sb: ISAPnP reports 'Creative ViBRA16X PnP' at i/o 0x220, irq 5, dma 1, 3
SB 4.16 detected OK (220)
SB16: Bad or missing 16 bit DMA channel
<Sound Blaster 16 (4.16)> at 0x220 irq 5 dma 1,3
<Sound Blaster 16> at 0x330 irq 5 dma 0,0
sb: 1 Soundblaster PnP card(s) found.
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996
<Yamaha OPL3> at 0x388
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 204M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xd0000000

--
Ueimor
