Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313091AbSDOS3m>; Mon, 15 Apr 2002 14:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313098AbSDOS3l>; Mon, 15 Apr 2002 14:29:41 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:24332 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S313091AbSDOS3i>;
	Mon, 15 Apr 2002 14:29:38 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: axboe@suse.de
Date: Mon, 15 Apr 2002 20:29:13 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] IDE TCQ #4
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <275738D7E75@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Apr 02 at 19:41, Petr Vandrovec wrote:
> 
> If I parsed file correctly (it is 83 decimal word, yes?), WD's
> WDC WD1200JB-00CRA0 supports TCQ too. I'm still deciding which of
> TCQ #X and IDE #YY patches should be aplied to 2.5.8 to get optimal
> results (and I have to disconnect slaves...).

I applied TCQ#4 only...

I have to swap my host, probably, or there is some other problem.
I got two unexpected interrupts, then machine looked fine, but shortly 
thereafter oops appeared. /proc/ide/ide0/hda/tcq showed 'not active'
before it crashed. Machine is SMP.

NULL pointer ...

EAX=EDX=EBX = 0
ECX,ESP,EBP = some stack addresses
ESI=ide_hwifs + 248 / 15400
EDI=ide_hwifs + 0

EIP=idedisk_do_request + 210/632
    start_request + 690/807
    __elv_next_request + 10/14
    ide_queue_command + 422/647
    ide_do_request + 86/122
    do_ide_request + 18/22
    generic_unplug_device + 86/135
    __run_task_queue + 179/190
    do_page_cache_readahead + 351/379
    page_cache_readahead + 256/264
    do_generic_file_read + 95/782
    generic_file_read + 126/304
    file_read_actor + 0 (passed as argument to ^^^)
    sys_read + 150/285
    syscall_call + 7/...

# ATA/IDE/MFM/RLL support
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_IDE_TCQ=y
CONFIG_BLK_DEV_IDE_TCQ_FULL=y
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=8
CONFIG_IDEDMA_AUTO=y

Linux version 2.5.8-smp (root@vana) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Mon Apr 15 19:59:12 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
found SMP MP-table at 000fb120
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: VIA      Product ID: VT3075       APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=Linux ro root=301 ramdisk=0 devfs=nomount video=matrox:vesa:0x105,fv:100,lower:1 pciorder=1:0 video=scrollback:0
Initializing CPU#0
Detected 797.071 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1589.24 BogoMIPS
Memory: 256660k/262080k available (1395k kernel code, 5032k reserved, 549k data, 240k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.12 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1592.52 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (3181.77 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 23.
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
 05 003 03  1    1    0   1   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  1    1    0   1   0    1    1    71
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B1
 12 003 03  1    1    0   1   0    1    1    B9
 13 003 03  1    1    0   1   0    1    1    C1
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
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 797.0946 MHz.
..... host bus clock speed is 99.6368 MHz.
cpu: 0, clocks: 996368, slice: 332122
CPU0<T0:996368,T1:664240,D:6,S:332122,C:996368>
cpu: 1, clocks: 996368, slice: 332122
CPU1<T0:996368,T1:332112,D:12,S:332122,C:996368>
checking TSC synchronization across CPUs: passed.
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI->APIC IRQ transform: (B0,I14,P0) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI: Enabling Via external APIC routing
PCI: Via IRQ fixup for 00:07.3, from 10 to 3
PCI: Via IRQ fixup for 00:07.2, from 10 to 3
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
devfs: v1.13 (20020406) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.11
Non-volatile memory driver v1.1
block: 512 slots per queue, batch=32
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] AGP 0.99 on VIA Apollo Pro @ 0xe0000000 256MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
VIA Technologies, Inc. Bus Master IDE: IDE controller on PCI slot 00:07.1
VIA Technologies, Inc. Bus Master IDE: chipset revision 16
VIA Technologies, Inc. Bus Master IDE: not 100%% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD1200JB-00CRA0, ATA DISK drive
hdc: TOSHIBA MK6409MAV, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide: unexpected interrupt
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=232581/16/63, UDMA(66)
ide: unexpected interrupt
hdc: 12685680 sectors (6495 MB), CHS=13424/15/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
 /dev/ide/host1/bus1/target0/lun0: [PTBL] [839/240/63] p1 p2 p4
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
i2c-core.o: driver maven registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 10922)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
matroxfb: Matrox G450 detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x8bpp (virtual: 1024x16380)
matroxfb: framebuffer at 0xDA000000, mapped to 0xd084d000, size 16777216
Console: switching to colour frame buffer device 128x48
fb0: MATROX VGA frame buffer device
matroxfb_crtc2: secondary head of fb0 was registered as fb1
i2c-dev.o: Registered 'DDC:fb0 #0 on i2c-matroxfb' as minor 0
i2c-core.o: adapter DDC:fb0 #0 on i2c-matroxfb registered as adapter 0.
PCI: Enabling device 00:09.0 (0080 -> 0082)
matroxfb: Matrox Millennium (PCI) detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x8bpp (virtual: 1024x8192)
matroxfb: framebuffer at 0xDE000000, mapped to 0xd2853000, size 8388608
fb2: MATROX VGA frame buffer device
fb2: initializing hardware
i2c-dev.o: Registered 'DDC:fb2 #0 on i2c-matroxfb' as minor 1
i2c-core.o: adapter DDC:fb2 #0 on i2c-matroxfb registered as adapter 1.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 240k freed
Adding Swap: 1024120k swap-space (priority -1)
es1371: version v0.30 time 19:58:57 Apr 15 2002
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x07
es1371: found es1371 rev 7 at io 0xd000 irq 18
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
Linux Tulip driver version 1.1.12 (Mar 07, 2002)
tulip0: Transceiver selection forced to 100baseTx.
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
tulip0:  Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial PHY (2) block.
tulip0:  Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY (4) block.
tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21143 SYM PHY (4) block.
eth0: Digital DS21143 Tulip rev 48 at 0xd30f2f80, 00:80:AD:83:5C:4D, IRQ 11.
eth0: Using user-specified media 100baseTx.
NET4: Linux IPX 0.48 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
