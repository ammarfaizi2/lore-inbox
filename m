Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261798AbTCLRWj>; Wed, 12 Mar 2003 12:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261800AbTCLRWj>; Wed, 12 Mar 2003 12:22:39 -0500
Received: from adsl-63-205-114-68.dsl.lsan03.pacbell.net ([63.205.114.68]:2435
	"HELO mydns2.compustrat.com") by vger.kernel.org with SMTP
	id <S261798AbTCLRWS>; Wed, 12 Mar 2003 12:22:18 -0500
Date: Wed, 12 Mar 2003 09:33:00 -0800 (PST)
From: Mailing Lists <thelittleprince-lists@asteroid-b612.org>
X-X-Sender: thelittleprince-lists@mydns2.compustrat.com
To: linux-kernel@vger.kernel.org
Subject: Re: drastically low perform. - quad, 4G ram, 2.4.20
In-Reply-To: <Pine.LNX.4.44.0303110707070.21108-100000@mydns2.compustrat.com>
Message-ID: <Pine.LNX.4.44.0303120915410.3827-100000@mydns2.compustrat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ok, so here's my comparison tests per Martin's earlier post. (if anyone
has suggestions on comparison tests i SHOULD be doing or things i should 
be checking, let me know).


mem=3072M BOOT

* hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  64 MB in  3.78 seconds = 16.93 MB/sec


* hdparm -t /dev/sdb

/dev/sdb:
 Timing buffered disk reads:  64 MB in  2.75 seconds = 23.27 MB/sec


* /proc/mtrr
reg00: base=0x00000000 (   0MB), size=4096MB: write-back, count=1
reg01: base=0xfc000000 (4032MB), size=  64MB: uncachable, count=1


* /proc/meminfo

        total:    used:    free:  shared: buffers:  cached:
Mem:  3179790336 102227968 3077562368        0  5505024 26247168
Swap: 5239492608        0 5239492608
MemTotal:      3105264 kB
MemFree:       3005432 kB
MemShared:           0 kB
Buffers:          5376 kB
Cached:          25632 kB
SwapCached:          0 kB
Active:          14044 kB
Inactive:        36664 kB
HighTotal:     2228224 kB
HighFree:      2180260 kB
LowTotal:       877040 kB
LowFree:        825172 kB
SwapTotal:     5116692 kB
SwapFree:      5116692 kB


* 'vmstat 5' (30-second sample) during db-4.1.25 compile:


   procs                      memory    swap          io     system         
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  
sy  id
 1  0  0      0 2990252   6212  34432   0   0    50    81  153   239  13   
2  84
 1  0  0      0 2988896   6260  34672   0   0    37    68  148   265  22   
4  74
 1  0  0      0 2986508   6292  34832   0   0    18    70  144    67  24   
1  75
 1  0  0      0 2987552   6328  34980   0   0    25    65  149   168  23   
2  75
 1  0  0      0 2986692   6360  35080   0   0    10    67  147   112  23   
2  76
 1  0  0      0 2988172   6392  35168   0   0    10    65  149   164  24   
2  75


* boot log (sda is megaraid OS array, sdb is promise terabyte array)

20: 00000000fc1f0000 - 00000000fc1ff000 (ACPI data)
 BIOS-e820: 00000000fc1ff000 - 00000000fc200000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000e0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 00000000c0000000 (usable)
2176MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fb4d0
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 786432
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 557056 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: AMI      Product ID: CNB20HE      APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
Processor #2 Pentium(tm) Pro APIC version 17
Processor #3 Pentium(tm) Pro APIC version 17
I/O APIC #4 Version 17 at 0xFEC00000.
I/O APIC #5 Version 17 at 0xFEC01000.
Processors: 4
Kernel command line: ro root=/dev/sda2 scsihosts=megaraid:aic7xxx 
mem=3072M
Initializing CPU#0
Detected 701.611 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1399.19 BogoMIPS
Memory: 3105160k/3145728k available (1915k kernel code, 40180k reserved, 
619k da
ta, 104k init, 2228224k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
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
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Cascades) stepping 01
per-CPU timeslice cutoff: 2927.55 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1402.47 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Cascades) stepping 01
Booting processor 2/2 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1402.47 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#2.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU2: Intel Pentium III (Cascades) stepping 01
Booting processor 3/3 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1402.47 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#3.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU3: Intel Pentium III (Cascades) stepping 01
Total of 4 processors activated (5606.60 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-5, 4-9, 4-11, 5-2, 5-3, 5-5, 5-6, 5-7, 5-8, 
5-9, 5-
11, 5-12, 5-13, 5-14 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
number of MP IRQ sources: 18.
number of IO-APIC #4 registers: 16.
number of IO-APIC #5 registers: 16.
testing the IO APIC.......................

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 00F 0F  0    0    0   0   0    1    1    31
 01 00F 0F  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    1    1    41
 04 00F 0F  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 00F 0F  0    0    0   0   0    1    1    51
 07 00F 0F  0    0    0   0   0    1    1    59
 08 00F 0F  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 00F 0F  1    1    0   1   0    1    1    69
 0b 000 00  1    0    0   0   0    0    0    00
 0c 00F 0F  0    0    0   0   0    1    1    71
 0d 00F 0F  0    0    0   0   0    1    1    79
 0e 00F 0F  0    0    0   0   0    1    1    81
 0f 00F 0F  0    0    0   0   0    1    1    89

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 00F 0F  1    1    0   1   0    1    1    91
 01 00F 0F  1    1    0   1   0    1    1    99
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 00F 0F  1    1    0   1   0    1    1    A1
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 00F 0F  1    1    0   1   0    1    1    A9
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 00F 0F  1    1    0   1   0    1    1    B1
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ10 -> 0:10
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ20 -> 1:4
IRQ26 -> 1:10
IRQ31 -> 1:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 701.5937 MHz.
..... host bus clock speed is 100.2272 MHz.
cpu: 0, clocks: 1002272, slice: 200454
CPU0<T0:1002272,T1:801808,D:10,S:200454,C:1002272>
cpu: 1, clocks: 1002272, slice: 200454
cpu: 3, clocks: 1002272, slice: 200454
cpu: 2, clocks: 1002272, slice: 200454
CPU2<T0:1002272,T1:400896,D:14,S:200454,C:1002272>
CPU3<T0:1002272,T1:200448,D:8,S:200454,C:1002272>
CPU1<T0:1002272,T1:601360,D:4,S:200454,C:1002272>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0xe)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfdbb1, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered peer bus 01
PCI->APIC IRQ transform: (B0,I1,P0) -> 26
PCI->APIC IRQ transform: (B0,I3,P0) -> 31
PCI->APIC IRQ transform: (B0,I15,P0) -> 10
PCI->APIC IRQ transform: (B1,I3,P0) -> 20
PCI->APIC IRQ transform: (B1,I5,P0) -> 16
PCI->APIC IRQ transform: (B1,I5,P1) -> 17
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI en
abled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hdc: MATSHITA CR-176, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.
html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@sa
w.sw.com.sg> and others
eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:30:48:10:88:6D, IRQ 31.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
SCSI subsystem driver Revision: 1.00
scsi: host order: megaraid:aic7xxx
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

blk: queue f796fe18, I/O limit 524287Mb (mask 0x7fffffffff)
  Vendor: Promise   Model: 8 Disk RAID5      Rev: 1.10
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7965018, I/O limit 524287Mb (mask 0x7fffffffff)
(scsi2:A:1): 160.000MB/s transfers (80.000MHz DT, offset 62, 16bit)
scsi2:A:1:0: Tagged Queuing enabled.  Depth 253
megaraid: v1.18 (Release Date: Thu Oct 11 15:02:53 EDT 2001)
megaraid: found 0x8086:0x1960:idx 0:bus 1:slot 3:func 1
scsi0 : Found a MegaRAID controller at 0xf8813000, IRQ: 20
megaraid: [GH6E:1.48] detected 1 logical drives
megaraid: channel[1] is raid.
scsi0 : LSI Logic MegaRAID GH6E 254 commands 16 targs 4 chans 7 luns
scsi0: scanning channel 0 for devices.
  Vendor: SUPER     Model: GEM354 REV001     Rev: 1.04
  Type:   Processor                          ANSI SCSI revision: 02
blk: queue f795e218, I/O limit 4095Mb (mask 0xffffffff)
scsi0: scanning virtual channel 1 for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID5 05006R  Rev: GH6E
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f774de18, I/O limit 4095Mb (mask 0xffffffff)
scsi0: scanning virtual channel 2 for logical drives.
scsi0: scanning virtual channel 3 for logical drives.
scsi0: scanning virtual channel 4 for logical drives.
Attached scsi disk sda at scsi0, channel 1, id 0, lun 0
Attached scsi disk sdb at scsi2, channel 0, id 1, lun 0
SCSI device sda: 215052288 512-byte hdwr sectors (110107 MB)
Partition check:
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 > sda4
SCSI device sdb: 1626952320 512-byte hdwr sectors (-266511 MB)
 sdb: sdb1 sdb2 sdb3
Attached scsi generic sg0 at scsi0, channel 0, id 6, lun 0,  type 3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 104k freed
EXT3-fs warning: maximal mount count reached, running e2fsck is 
recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,2), internal journal
Adding Swap: 5116692k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is 
recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,11), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,17), internal journal
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,18), internal journal
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is 
recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,19), internal journal
EXT3-fs: mounted filesystem with writeback data mode.
(scsi2:A:1:0): Locking max tag count at 32



mem=4096M BOOT

* hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  64 MB in  3.89 seconds = 16.45 MB/sec


* hdparm -t /dev/sdb

/dev/sdb:
 Timing buffered disk reads:  64 MB in  2.73 seconds = 23.44 MB/sec


* /proc/mtrr
reg00: base=0x00000000 (   0MB), size=4096MB: write-back, count=1
reg01: base=0xfc000000 (4032MB), size=  64MB: uncachable, count=1


* /proc/meminfo

        total:    used:    free:  shared: buffers:  cached:
Mem:  4176605184 178626560 3997978624        0  7938048 43974656
Swap: 5239492608        0 5239492608
MemTotal:      4078716 kB
MemFree:       3904276 kB
MemShared:           0 kB
Buffers:          7752 kB
Cached:          42944 kB
SwapCached:          0 kB
Active:          22828 kB
Inactive:        51788 kB
HighTotal:     3213248 kB
HighFree:      3152660 kB
LowTotal:       865468 kB
LowFree:        751616 kB
SwapTotal:     5116692 kB
SwapFree:      5116692 kB


* 'vmstat 5' (30-second sample) during db-4.1.25 compile:

   procs                      memory    swap          io     system         
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  
sy  id
 1  0  1      0 3908076   7552  42768   0   0   200    19   43    20  17   
1  82
 1  0  0      0 3904880   7588  42900   0   0    28    47  148    66  26   
1  73
 1  0  0      0 3908496   7616  42900   0   0     0    50  136    18  27   
0  73
 1  0  0      0 3908276   7624  42900   0   0     0     4  139     7  27   
0  73
 1  0  0      0 3908056   7632  42900   0   0     0     4  150     7  27   
0  73
 1  0  0      0 3907852   7640  42904   0   0     0     4  160     9  27   
0  73

* boot log (sda is megaraid OS array, sdb is promise terabyte array)

: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000fc1f0000 (usable)
 BIOS-e820: 00000000fc1f0000 - 00000000fc1ff000 (ACPI data)
 BIOS-e820: 00000000fc1ff000 - 00000000fc200000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000e0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 00000000fc1f0000 (usable)
 user: 00000000fc1f0000 - 00000000fc1ff000 (ACPI data)
 user: 00000000fc1ff000 - 00000000fc200000 (ACPI NVS)
 user: 00000000fec00000 - 00000000fec01000 (reserved)
 user: 00000000fee00000 - 00000000fee01000 (reserved)
 user: 00000000fff80000 - 0000000100000000 (reserved)
3137MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fb4d0
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 1032688
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 803312 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: AMI      Product ID: CNB20HE      APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
Processor #2 Pentium(tm) Pro APIC version 17
Processor #3 Pentium(tm) Pro APIC version 17
I/O APIC #4 Version 17 at 0xFEC00000.
I/O APIC #5 Version 17 at 0xFEC01000.
Processors: 4
Kernel command line: ro root=/dev/sda2 scsihosts=megaraid:aic7xxx 
mem=4096M
Initializing CPU#0
Detected 701.617 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1399.19 BogoMIPS
Memory: 4078612k/4130752k available (1915k kernel code, 51752k reserved, 
619k da
ta, 104k init, 3213248k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
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
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Cascades) stepping 01
per-CPU timeslice cutoff: 2927.55 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1402.47 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Cascades) stepping 01
Booting processor 2/2 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1402.47 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#2.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU2: Intel Pentium III (Cascades) stepping 01
Booting processor 3/3 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1402.47 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#3.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU3: Intel Pentium III (Cascades) stepping 01
Total of 4 processors activated (5606.60 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-5, 4-9, 4-11, 5-2, 5-3, 5-5, 5-6, 5-7, 5-8, 
5-9, 5-
11, 5-12, 5-13, 5-14 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
number of MP IRQ sources: 18.
number of IO-APIC #4 registers: 16.
number of IO-APIC #5 registers: 16.
testing the IO APIC.......................

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 00F 0F  0    0    0   0   0    1    1    31
 01 00F 0F  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    1    1    41
 04 00F 0F  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 00F 0F  0    0    0   0   0    1    1    51
 07 00F 0F  0    0    0   0   0    1    1    59
 08 00F 0F  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 00F 0F  1    1    0   1   0    1    1    69
 0b 000 00  1    0    0   0   0    0    0    00
 0c 00F 0F  0    0    0   0   0    1    1    71
 0d 00F 0F  0    0    0   0   0    1    1    79
 0e 00F 0F  0    0    0   0   0    1    1    81
 0f 00F 0F  0    0    0   0   0    1    1    89

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 00F 0F  1    1    0   1   0    1    1    91
 01 00F 0F  1    1    0   1   0    1    1    99
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 00F 0F  1    1    0   1   0    1    1    A1
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 00F 0F  1    1    0   1   0    1    1    A9
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 00F 0F  1    1    0   1   0    1    1    B1
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ10 -> 0:10
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ20 -> 1:4
IRQ26 -> 1:10
IRQ31 -> 1:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 701.6028 MHz.
..... host bus clock speed is 100.2289 MHz.
cpu: 0, clocks: 1002289, slice: 200457
CPU0<T0:1002288,T1:801824,D:7,S:200457,C:1002289>
cpu: 2, clocks: 1002289, slice: 200457
cpu: 3, clocks: 1002289, slice: 200457
cpu: 1, clocks: 1002289, slice: 200457
CPU1<T0:1002288,T1:601360,D:14,S:200457,C:1002289>
CPU3<T0:1002288,T1:200448,D:12,S:200457,C:1002289>
CPU2<T0:1002288,T1:400912,D:5,S:200457,C:1002289>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0xe)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfdbb1, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered peer bus 01
PCI->APIC IRQ transform: (B0,I1,P0) -> 26
PCI->APIC IRQ transform: (B0,I3,P0) -> 31
PCI->APIC IRQ transform: (B0,I15,P0) -> 10
PCI->APIC IRQ transform: (B1,I3,P0) -> 20
PCI->APIC IRQ transform: (B1,I5,P0) -> 16
PCI->APIC IRQ transform: (B1,I5,P1) -> 17
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI en
abled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hdc: MATSHITA CR-176, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.
html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@sa
w.sw.com.sg> and others
eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:30:48:10:88:6D, IRQ 31.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
SCSI subsystem driver Revision: 1.00
scsi: host order: megaraid:aic7xxx
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

blk: queue f7a58418, I/O limit 524287Mb (mask 0x7fffffffff)
  Vendor: Promise   Model: 8 Disk RAID5      Rev: 1.10
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7a10e18, I/O limit 524287Mb (mask 0x7fffffffff)
(scsi2:A:1): 160.000MB/s transfers (80.000MHz DT, offset 62, 16bit)
scsi2:A:1:0: Tagged Queuing enabled.  Depth 253
megaraid: v1.18 (Release Date: Thu Oct 11 15:02:53 EDT 2001)
megaraid: found 0x8086:0x1960:idx 0:bus 1:slot 3:func 1
scsi0 : Found a MegaRAID controller at 0xf8813000, IRQ: 20
megaraid: [GH6E:1.48] detected 1 logical drives
megaraid: channel[1] is raid.
scsi0 : LSI Logic MegaRAID GH6E 254 commands 16 targs 4 chans 7 luns
scsi0: scanning channel 0 for devices.
  Vendor: SUPER     Model: GEM354 REV001     Rev: 1.04
  Type:   Processor                          ANSI SCSI revision: 02
blk: queue f75ffc18, I/O limit 4095Mb (mask 0xffffffff)
scsi0: scanning virtual channel 1 for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID5 05006R  Rev: GH6E
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f75fb818, I/O limit 4095Mb (mask 0xffffffff)
scsi0: scanning virtual channel 2 for logical drives.
scsi0: scanning virtual channel 3 for logical drives.
scsi0: scanning virtual channel 4 for logical drives.
Attached scsi disk sda at scsi0, channel 1, id 0, lun 0
Attached scsi disk sdb at scsi2, channel 0, id 1, lun 0
SCSI device sda: 215052288 512-byte hdwr sectors (110107 MB)
Partition check:
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 > sda4
SCSI device sdb: 1626952320 512-byte hdwr sectors (-266511 MB)
 sdb: sdb1 sdb2 sdb3
Attached scsi generic sg0 at scsi0, channel 0, id 6, lun 0,  type 3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 104k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,2), internal journal
Adding Swap: 5116692k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,11), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,17), internal journal
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,18), internal journal
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,19), internal journal
EXT3-fs: mounted filesystem with writeback data mode.


--Tony


On Tue, 11 Mar 2003, Mailing Lists wrote:

> 
> Have a RH 7.3 system , supermicro mobo (SUPER S2QE6 (MBD-S2QE6-U)) with 
> quad P3 xeon 700s and 4G ram. Under 2.4.20, 
> system performance is dractically low. However, telling the kernel to only 
> use 3G of memory (mem= on the boot line) causes system to behave at a 
> normal performance level for the platform.
> As a reference, a compile of the db-4.1.25 package under the normal 4G of 
> ram, took 1hr50m. Under 3G of ram, 4m28s
> System used to run suse 7 with 2.4.4 with 4G without problems
> 
> 2.4.20 kernel config
> 
> CONFIG_X86=y
> CONFIG_UID16=y
> CONFIG_MODULES=y
> CONFIG_MODVERSIONS=y
> CONFIG_KMOD=y
> CONFIG_MPENTIUMIII=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_X86_HAS_TSC=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_PGE=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_F00F_WORKS_OK=y
> CONFIG_X86_MCE=y
> CONFIG_MICROCODE=y
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> CONFIG_HIGHMEM4G=y
> CONFIG_HIGHMEM=y
> CONFIG_HIGHIO=y
> CONFIG_MTRR=y
> CONFIG_SMP=y
> CONFIG_X86_TSC=y
> CONFIG_HAVE_DEC_LOCK=y
> CONFIG_NET=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_PCI=y
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_ISA=y
> CONFIG_PCI_NAMES=y
> CONFIG_HOTPLUG=y
> CONFIG_SYSVIPC=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_SYSCTL=y
> CONFIG_KCORE_ELF=y
> CONFIG_BINFMT_AOUT=y
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_MISC=y
> CONFIG_BLK_DEV_FD=y
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_NBD=y
> CONFIG_BLK_STATS=y
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=y
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_BLK_DEV_ADMA=y
> CONFIG_BLK_DEV_SVWKS=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_BLK_DEV_IDE_MODES=y
> CONFIG_SCSI=y
> CONFIG_BLK_DEV_SD=y
> CONFIG_SD_EXTRA_DEVS=40
> CONFIG_CHR_DEV_ST=y
> CONFIG_CHR_DEV_OSST=y
> CONFIG_BLK_DEV_SR=y
> CONFIG_SR_EXTRA_DEVS=2
> CONFIG_CHR_DEV_SG=y
> CONFIG_SCSI_DEBUG_QUEUES=y
> CONFIG_SCSI_MULTI_LUN=y
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_AIC7XXX=y
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
> CONFIG_AIC7XXX_RESET_DELAY_MS=15000
> CONFIG_SCSI_MEGARAID=y
> CONFIG_NETDEVICES=y
> CONFIG_DUMMY=m
> CONFIG_NET_ETHERNET=y
> CONFIG_NET_PCI=y
> CONFIG_EEPRO100=y
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> CONFIG_MOUSE=y
> CONFIG_PSMOUSE=y
> CONFIG_RTC=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_REISERFS_FS=y
> CONFIG_REISERFS_PROC_INFO=y
> CONFIG_EXT3_FS=y
> CONFIG_JBD=y
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_TMPFS=y
> CONFIG_RAMFS=y
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_PROC_FS=y
> CONFIG_DEVPTS_FS=y
> CONFIG_EXT2_FS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> CONFIG_NFSD=y
> CONFIG_NFSD_V3=y
> CONFIG_SUNRPC=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_ZISOFS_FS=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_VGA_CONSOLE=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_ZLIB_INFLATE=y
> 
> 
> Thanx,
> 
> --Tony
> 
> 
> 

