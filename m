Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268876AbTGJDe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 23:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268875AbTGJDe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 23:34:26 -0400
Received: from pcp02462394pcs.chrchv01.md.comcast.net ([68.33.20.149]:40201
	"EHLO mail.jettisonnetworks.com") by vger.kernel.org with ESMTP
	id S268876AbTGJDd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 23:33:57 -0400
From: "David Lewis" <dlewis@vnxsolutions.com>
To: <linux-kernel@vger.kernel.org>
Subject: PCI Bridge problems
Date: Wed, 9 Jul 2003 23:47:24 -0400
Message-ID: <EMEOIBCHEHCPNABJGHGOKEJOCOAA.dlewis@vnxsolutions.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am running into a problem with some PCI cards and I believe I have it
narrowed down to the fact that they have PCI-PCI bridges and they dont seem
to be agreeing with the kernel (2.4.18, 2.4.20, 2.4.21-ac4).

The cards are a Adlink PCI-8214 dual ethernet nic (Intel 82559 eth
controller and 21154 pci bridge) and IDS imaging Falcon quatto (4 Bt878
frame grabbers and a ethernet bridge). Both cards work well with 2.4.18 in a
motherboard with a single pci bus (Tyan Tiger 200 Apollo Pro 133A dual P3),
but when used with an Intel SE7500CW2 Dual Xeon (multiple pci busses) they
become very flaky. My suspicion is that the busses are not being recognized
correctly, but everything does show up in lspci.

Following is the lspci and dmesg output. Please let me know what further
information I can supply.

David Lewis
Senior Security Engineer
VNX Solutions, Inc
dlewis@vnxsolutions.com
410-459-7428 Cell

lspci

[root@vnx-ids-test root]# lspci
00:00.0 Host bridge: Intel Corp. e7500 [Plumas] DRAM Controller (rev 03)
00:00.1 Class ff00: Intel Corp. e7500 [Plumas] DRAM Controller Error
Reporting (rev 03)
00:02.0 PCI bridge: Intel Corp. e7500 [Plumas] HI_B Virtual PCI Bridge (F0)
(rev 03)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CA IDE U100 (rev 02)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
02:02.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge
03:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
08)
03:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
08)
05:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
05:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
0d)

dmesg

[root@vnx-ids-test root]# dmesg
 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 Pentium 4(tm) XEON(tm) APIC version 16
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:   Product ID: SE7500CW2 APIC at: 0xFEE00000
I/O APIC #2 Version 32 at 0xFEC00000.
I/O APIC #3 Version 32 at 0xFEC80000.
I/O APIC #4 Version 32 at 0xFEC80400.
Processors: 4
xAPIC support is not present
Enabling APIC mode: Flat.       Using 3 I/O APICs
Kernel command line: ro root=/dev/hda3
Initializing CPU#0
Detected 1794.233 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3578.26 BogoMIPS
Memory: 904860k/917504k available (1080k kernel code, 12240k reserved, 459k
data, 104k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Xeon(TM) CPU 1.80GHz stepping 07
per-CPU timeslice cutoff: 1462.89 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3578.26 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU1: Intel(R) Xeon(TM) CPU 1.80GHz stepping 07
Booting processor 2/6 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3578.26 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#2.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU2: Intel(R) Xeon(TM) CPU 1.80GHz stepping 07
Booting processor 3/7 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3578.26 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#3.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU3: Intel(R) Xeon(TM) CPU 1.80GHz stepping 07
Total of 4 processors activated (14313.06 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
cpu_sibling_map[2] = 3
cpu_sibling_map[3] = 2
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-18, 2-20, 2-22, 3-0, 3-1, 3-2,
3-3, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 3-16,
3-17, 3-18, 3-19, 3-20, 3-21, 3-22, 3-23, 4-0, 4-1, 4-2, 4-3, 4-4, 4-5, 4-6,
4-7, 4-8, 4-9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15, 4-16, 4-17, 4-18, 4-19,
4-20, 4-21, 4-22, 4-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 20.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 24.
number of IO-APIC #4 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02008000
.......    : physical APIC id: 02
.......    : Delivery Type: 1
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 0FF 0F  0    0    0   0   0    1    1    39
 02 004 04  0    0    0   0   0    1    1    31
 03 0FF 0F  0    0    0   0   0    1    1    41
 04 0FF 0F  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 0FF 0F  0    0    0   0   0    1    1    51
 07 0FF 0F  0    0    0   0   0    1    1    59
 08 0FF 0F  0    0    0   0   0    1    1    61
 09 0FF 0F  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 0FF 0F  0    0    0   0   0    1    1    71
 0d 0FF 0F  0    0    0   0   0    1    1    79
 0e 0FF 0F  0    0    0   0   0    1    1    81
 0f 0FF 0F  0    0    0   0   0    1    1    89
 10 0FF 0F  1    1    0   1   0    1    1    91
 11 0FF 0F  1    1    0   1   0    1    1    99
 12 000 00  1    0    0   0   0    0    0    00
 13 0FF 0F  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 0FF 0F  1    1    0   1   0    1    1    A9
 16 000 00  1    0    0   0   0    0    0    00
 17 0FF 0F  1    1    0   1   0    1    1    B1

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 03000000
.......     : arbitration: 03
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 0FF 0F  1    1    0   1   0    1    1    B9
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 04000000
.......     : arbitration: 04
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
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
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ19 -> 0:19
IRQ21 -> 0:21
IRQ23 -> 0:23
IRQ28 -> 1:4
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1794.0791 MHz.
..... host bus clock speed is 99.6710 MHz.
cpu: 0, clocks: 996710, slice: 199342
CPU0<T0:996704,T1:797360,D:2,S:199342,C:996710>
cpu: 1, clocks: 996710, slice: 199342
cpu: 3, clocks: 996710, slice: 199342
cpu: 2, clocks: 996710, slice: 199342
CPU1<T0:996704,T1:598016,D:4,S:199342,C:996710>
CPU2<T0:996704,T1:398672,D:6,S:199342,C:996710>
CPU3<T0:996704,T1:199328,D:8,S:199342,C:996710>
migration_task 0 on cpu=0
migration_task 1 on cpu=1
migration_task 2 on cpu=2
migration_task 3 on cpu=3
PCI: PCI BIOS revision 2.10 entry at 0xfd921, last bus=5
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX [8086/2480] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I31,P0) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B3,I12,P0) -> 28
PCI->APIC IRQ transform: (B3,I13,P0) -> 28
PCI->APIC IRQ transform: (B5,I3,P0) -> 21
PCI->APIC IRQ transform: (B5,I5,P0) -> 23
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x7040-0x7047, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x7048-0x704f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD1200JB-00DUA3, ATA DISK drive
blk: queue c03245e0, I/O limit 4095Mb (mask 0xffffffff)
hdc: WDC WD1200JB-00DUA3, ATA DISK drive
blk: queue c0324a5c, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63,
UDMA(100)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63,
UDMA(100)
Partition check:
 hda: hda1 hda2 hda3
 hdc:
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning (device ide0(3,3)): ext2_read_super: mounting ext3
filesystem as ext2

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 104k freed
Adding Swap: 1052248k swap-space (priority -1)
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro
100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:30:64:01:CB:D1, IRQ 28.
  Board assembly 721383-016, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth1: Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2), 00:30:64:01:CB:D2, IRQ
28.
  Board assembly 721383-016, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth2: OEM i82557/i82558 10/100 Ethernet, 00:02:B3:B0:10:4D, IRQ 23.
  Board assembly ffffff-255, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xb874c1d3).
NET4: Ethernet Bridge 008 for NET4.0
device eth0 entered promiscuous mode
device eth1 entered promiscuous mode
snort0: port 2(eth1) entering learning state
snort0: port 1(eth0) entering learning state
snort0: port 2(eth1) entering forwarding state
snort0: topology change detected, propagating
snort0: port 1(eth0) entering forwarding state
snort0: topology change detected, propagating
[root@vnx-ids-test root]#


