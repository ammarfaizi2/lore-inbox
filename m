Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTDGBAS (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 21:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTDGBAS (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 21:00:18 -0400
Received: from wotug.org ([194.106.52.201]:22138 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id S263171AbTDGBAN (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 21:00:13 -0400
Date: Mon, 7 Apr 2003 02:13:30 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: linux-kernel@vger.kernel.org
Subject: Problems booting PDC20276 with new IDE setup code.
Message-ID: <Pine.LNX.4.44.0304070201420.8701-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

Since 2.4.20 I have not been able to boot Linux using more recent kernels
(tried 21-pre3, -pre6).

The problem is that my /home is on a raid5 disks array connected to a PDC20276 
motherboard-mounted controller. The BIOS boots and detects all 4 disks, and 
then enables IDE Master mode, as expetced. The kernel in 2.4.20 then uses the 
disks in IDE master mode, but the pre3 and pre6 kernels say the BIOS hasn't 
enabled the controller.

I have appended dmesg output for a bad boot, up to the end of IDE setup, 
below. (Note: the kernel does run and all would be ok if the /home disks 
weren't wanted. However, they are!).

I have thoroughly checked the BIOS and all IDE related switches that might
enable a disk are enabled. There are no Promise specific BIOS controls I am
aware of. The BIOS was updated from the GIGABYTE website about 3 months ago.

A quick code-check would indicate a problem in setup-ide.c or the code it
calls... is there anything I can do?

Regards,

Ruth

[Athlon 1800+/512Mb RAM, VIA-333 SB, onboard VIA IDE, onboard PDC IDE]


 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fb690
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: GIGABYTE Product ID: 7VRXP        APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 2 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 1
Kernel command line: ro root=/dev/hda7 video=rivafb:1280x1024-8 hdc=ide-scsi hdd=ide-scsi
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 1610.053 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3211.26 BogoMIPS
Memory: 514044k/524224k available (2674k kernel code, 9792k reserved, 952k data, 136k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(tm) XP 1900+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000080
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-10, 2-20, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 29.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178002
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0002
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
 0b 001 01  0    0    0   0   0    1    1    79
 0c 001 01  0    0    0   0   0    1    1    81
 0d 001 01  0    0    0   0   0    1    1    89
 0e 001 01  0    0    0   0   0    1    1    91
 0f 001 01  0    0    0   0   0    1    1    99
 10 001 01  1    1    0   1   0    1    1    A1
 11 001 01  1    1    0   1   0    1    1    A9
 12 001 01  1    1    0   1   0    1    1    B1
 13 001 01  1    1    0   1   0    1    1    B9
 14 000 00  1    0    0   0   0    0    0    00
 15 001 01  1    1    0   1   0    1    1    C1
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
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ21 -> 0:21
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1610.0666 MHz.
..... host bus clock speed is 280.0116 MHz.
cpu: 0, clocks: 2800116, slice: 1400058
CPU0<T0:2800112,T1:1400048,D:6,S:1400058,C:2800116>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/3147] at 00:11.0
PCI->APIC IRQ transform: (B0,I8,P0) -> 17
PCI->APIC IRQ transform: (B0,I9,P0) -> 17
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI->APIC IRQ transform: (B0,I12,P0) -> 16
PCI->APIC IRQ transform: (B0,I13,P0) -> 17
PCI->APIC IRQ transform: (B0,I15,P0) -> 19
PCI->APIC IRQ transform: (B0,I17,P0) -> 16
PCI->APIC IRQ transform: (B0,I17,P3) -> 21
PCI->APIC IRQ transform: (B0,I17,P3) -> 21
PCI->APIC IRQ transform: (B0,I19,P0) -> 18
PCI->APIC IRQ transform: (B0,I20,P0) -> 16
PCI->APIC IRQ transform: (B0,I20,P1) -> 17
PCI->APIC IRQ transform: (B0,I20,P2) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI: Via IRQ fixup for 00:11.2, from 10 to 5
PCI: Via IRQ fixup for 00:11.3, from 10 to 5
PCI: Via IRQ fixup for 00:14.0, from 10 to 0
PCI: Via IRQ fixup for 00:14.1, from 10 to 1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver v1.1.22 [Flags: R/O]
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:..........................................................................................................................................................
154 Control Methods found and parsed (516 nodes total)
ACPI Namespace successfully loaded at root c04c5920
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [-29] Acpi_enable           : Transition to ACPI mode successful
Executing device _INI methods:............................................
44 Devices found: 44 _STA, 1 _INI
Completing Region and Field initialization:.................................
24/29 Regions, 9/9 Fields initialized (516 nodes total)
ACPI: Subsystem enabled
Power Resource: found
Power Resource: found
Power Resource: found
Power Resource: found
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1, 8 throttling states
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x60
rivafb: PCI nVidia NV20 framebuffer ver 0.9.4 (GeForce3 Ti 200, 64MB @ 0xD8000000)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 10240K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/100 Network Driver - version 2.1.29-k4
Copyright (c) 2002 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100+ Management Adapter
  Hardware receive checksums enabled
  cpu cycle saver enabled

8139too Fast Ethernet driver 0.9.26
eth1: RealTek RTL8139 Fast Ethernet at 0xe5868f00, 00:20:ed:2f:c4:80, IRQ 18
eth1:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT266 chipset
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe0000000 128MB
[drm] Initialized r128 2.2.0 20010917 on minor 0
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe0000000 128MB
[drm] Initialized radeon 1.1.1 20010405 on minor 1
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe0000000 128MB
[drm] Initialized mga 3.0.2 20010321 on minor 2
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20276: IDE controller at PCI slot 00:0f.0
PDC20276: chipset revision 1
PDC20276: not 100% native mode: will probe irqs later
PDC20276: neither IDE port enabled (BIOS)
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST380021A, ATA DISK drive
blk: queue c04de980, I/O limit 4095Mb (mask 0xffffffff)
hdc: CREATIVE CD-RW RW1210E, ATAPI CD/DVD-ROM drive
hdd: PHILIPS DVDRW228, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

