Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBZU46>; Mon, 26 Feb 2001 15:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129108AbRBZU4t>; Mon, 26 Feb 2001 15:56:49 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:52096 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S129093AbRBZU4b>;
	Mon, 26 Feb 2001 15:56:31 -0500
Date: Mon, 26 Feb 2001 21:56:23 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.1 hangup: Unable to handle kernel paging request... (maybe
 reiserfs problem?)
Message-ID: <Pine.GSO.4.30.0102262134330.22570-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The most important thing first: afaik this is not a hw problem, the
machine passed memtests.

I was compiling a gcc on one terminal and extracting a kernel on an other.

When i came back, thing message was waiting me:

Unable to handle kernel paging request at virtual address 5c8d0018
 printing eip:
c0179990
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0179990>]
EFLAGS: 00010246
eax: d5c42e00   ebx: 5c8d0000   ecx: 00000000   edx: 5be3ef36
esi: 00000001   edi: 000112db   ebp: d5c42c00   esp: c5ebdbd4
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 10670, stackpage=c5ebd000)
Stack: d5c42e00 896d896d c015d7e7 d5c42e00 5c8d0000 00000001 c5ebdf3c
d5c42e00
       896d896d c0066ba0 c8c4dec8 896d896d 0000004d 0000096d cf2fa310
cf228000
       c0172dfb c5ebdf3c 896d896d c5ebdcb4 c5ebde94 00000001 c5ebde54
00000001
Call Trace: [<c015d7e7>] [<c0172dfb>] [<c0173944>] [<c017407c>]
[<c0173573>]
[<c016305d>] [<c014afae>]
       [<c01497e6>] [<c01428e0>] [<c01429b8>] [<c0109157>]

Code: 8b 43 18 a9 00 00 10 00 74 b6 85 f6 74 06 f6 43 18 04 75 ac


It was still responding, but if tried any io on disk, it hang that
process. (i could still switch to another terminal, but i couldn't do
anything useful there, though i could see what i type).
I pressed SYSRQ+S a few times, but i'm not sure if it could sync (I don't
remember the 'OK'.) Then is pressed SYSRQ+U, then SYSRQ+B.
When it rebooted it had to do fsck, so the umount was unsuccessful.

When i wanted to mount my secondary partition (holding only data) which is
reiserfs, i got this:
# mount -t reiserfs /dev/hda4 /mnt/hda4
reiserfs: checking transaction log (device 03:04) ...
journal-1226: REPLAY FAILURE, fsck required! buffer write failed
Replay Failure, unable to mount
reiserfs_read_super: unable to initialize journal space
mount: wrong fs type, bad option, bad superblock on /dev/hda4,
       or too many mounted file systems

As it said above, i ran reiserfsck:
<-------------reiserfsck, 2000------------->
reiserfsprogs 3.x.0b
Will read-only check consistency of the partition
Will put log info to stderr
Do you want to run this program?[N/Yes] (note need to type Yes):Yes
Analyzing journal..last flushed trans 63, mount_id 11, will replay from 64
up to 66:Yes?Mount_id 11, transaction 64, desc block 1320, commit block
1400: ( 262144 16 8391 8407 8377 8378 8417 8390 8418 8409 8380 8404 8375
8414 8384 8402 8374
8405 8376 8406 8413 8412 8382 8411 8381 8383 8410 8408 8385 8415 8423 8396
8400
8370 17 8420 8401 8373 8372 8387 8379 8421 8394 8437 8365 8325 8371 8294
8213 8280 8278 8300 8295 8293 8288 8287 8315 8327 8347 8397 8398 8340 8363
8299 8426 8427 8428 8429 8430 8431 8433 8361 8422 8424 8388 8425 8362 8442
8443)
Mount_id 11, transaction 65, desc block 1401, commit block 1431: ( 262144
16 8433 8391 17 8420 8300 8213 8434 8418 8423 8448 8402 8340 8415 8299
8449 8450 8451
8361 8452 8453 8362 8454 8455 8426 8435 8436 8302)
Mount_id 11, transaction 66, desc block 1432, commit block 1471: ( 8436
262144 16 8391 8418 8423 8402 8340 8361 8302 8213 8299 8435 17 8438 8420
8428 8429 8433
8278 8452transaction 66, block 21 could not be replayed (554115335)
transaction 66, block 22 could not be replayed (551493855)
transaction 66, block 23 could not be replayed (551952614)
transaction 66, block 24 could not be replayed (552083688)
transaction 66, block 25 could not be replayed (549724356)
transaction 66, block 26 could not be replayed (552149225)
transaction 66, block 27 could not be replayed (554246409)
transaction 66, block 28 could not be replayed (554311946)
transaction 66, block 29 could not be replayed (554377483)
transaction 66, block 30 could not be replayed (554443020)
transaction 66, block 31 could not be replayed (554574094)
transaction 66, block 32 could not be replayed (554639631)
transaction 66, block 33 could not be replayed (554508557)
transaction 66, block 34 could not be replayed (547889320)
transaction 66, block 35 could not be replayed (548020394)
transaction 66, block 36 could not be replayed (554705168)
transaction 66, block 37 could not be replayed (554049798)
)
Journal replaied
Checking S+tree../  1 (of   2)/  1 (of  88)
pass_through_tree: unable to read 538124307 block on device 0x3



Okay, lets try again:

# reiserfsck /dev/hda4
<-------------reiserfsck, 2000------------->
reiserfsprogs 3.x.0b
Will read-only check consistency of the partition
Will put log info to stderr
Do you want to run this program?[N/Yes] (note need to type Yes):Yes
Analyzing journal..nothing to replay (no transactions older than last
flushed one found)
Checking S+tree../  1 (of   2)/  1 (of  88)
pass_through_tree: unable to read 538124307 block on device 0x3



When i repeat, i get exactly the same.
I can now mount the partition:
# mount -o ro -t reiserfs /dev/hda4 /mnt/hda4
reiserfs: checking transaction log (device 03:04) ...
Warning, log replay starting on readonly filesystem
is_tree_node: node level 0 does not match to the expected one 1
vs-5150: search_by_key: invalid format found in block 538124307. Fsck?
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat
data of [1 2 0x0 SD]
Using r5 hash to sort names
ReiserFS version 3.6.25

but if i want to read from it, i get io error:
# ls -l /mnt/hda4
ls: /mnt/hda4: Input/output error

during mount, i get this in syslog:
reiserfs: checking transaction log (device 03:04) ...
attempt to access beyond end of device
03:04: rw=1, want=68977696, limit=8891977
attempt to access beyond end of device
03:04: rw=1, want=58491776, limit=8891977
...

The motherboard is a Abit VP6, with 1 Celeron 433.

# fdisk -l /dev/hda
Disk /dev/hda: 255 heads, 63 sectors, 1247 cylinders
Units = cylinders of 16065 * 512 bytes
   Device Boot    Start       End    Blocks   Id  System
/dev/hda1             1        16    128488+  83  Linux
/dev/hda2            17        78    498015   82  Linux swap
/dev/hda3            79       140    498015   82  Linux swap
/dev/hda4           141      1247   8891977+  83  Linux

# fdisk -l /dev/hdg
Disk /dev/hdg: 16 heads, 63 sectors, 39560 cylinders
Units = cylinders of 1008 * 512 bytes
   Device Boot    Start       End    Blocks   Id  System
/dev/hdg1             1       521    262552+  82  Linux swap
/dev/hdg2           522      1042    262584   82  Linux swap
/dev/hdg3          1043      1563    262584   83  Linux
/dev/hdg4          1564     39560  19150488   83  Linux

Note that i boot from /dev/hdg4, which is ext2. hda4 is reiserfs.

Finally, dmesg says:
Linux version 2.4.1 (root@brefatox.hell) (gcc version 2.95.3 19991030 (prerelease)) #8 SMP Thu Feb 22 17:33:37 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000017ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 0000000017ff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 0000000017ff0000 (ACPI NVS)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f5770
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 98288
zone(0): 4096 pages.
zone(1): 94192 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    Bootup CPU
Bus #0 is PCI
Bus #1 is PCI
Bus #2 is ISA
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 1, trig 1, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 3, trig 3, bus 2, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 3, trig 3, bus 2, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 3, trig 3, bus 2, IRQ 0a, APIC ID 2, APIC INT 0a
Lint: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 0, trig 0, bus 2, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 1
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: root=/dev/hdg4 hdc=ide-scsi hdd=ide-scsi apm=power-off mem=393152K
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 434.813 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 865.07 BogoMIPS
Memory: 384336k/393152k available (1003k kernel code, 8428k reserved, 334k data, 216k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Celeron (Mendocino) stepping 05
per-CPU timeslice cutoff: 365.86 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
CPU present map: 1
Before bogomips.
Error: only one processor found.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
CPU#0 NMI appears to be stuck.
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  1    1    0   1   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   1   0    1    1    71
 0a 001 01  1    1    0   1   0    1    1    79
 0b 001 01  1    1    0   1   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 001 01  0    0    0   0   0    1    1    91
 0f 001 01  0    0    0   0   0    1    1    99
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ10 -> 10
IRQ11 -> 11
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 434.8052 MHz.
..... host bus clock speed is 66.8931 MHz.
cpu: 0, clocks: 668931, slice: 334465
CPU0<T0:668928,T1:334448,D:15,S:334465,C:668931>
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.3 present.
40 structures occupying 1190 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 6.00 PG
BIOS Release: 11/06/2000
System Vendor: VIA Technologies, Inc..
Product Name: VT82C694X.
Version  .
Serial Number  .
Board Vendor: ABIT <http://www.abit.com.tw>.
Board Name: 694X-686B (VP6).
Board Version: v1.0 ~.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Linux video capture interface: v1.00
block: queued sectors max/low 255130kB/124058kB, 768 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:7.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:DMA
HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
hda: WDC WD102AA, ATA DISK drive
hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-105S 012, ATAPI CD/DVD-ROM drive
hdg: QUANTUM FIREBALLlct20 20, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide3 at 0xe400-0xe407,0xe802 on irq 11
hda: 20044080 sectors (10263 MB) w/2048KiB Cache, CHS=1247/255/63, UDMA(33)
hdg: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=39560/16/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
 /dev/ide/host2/bus1/target0/lun0: p1 p2 p3 p4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 128M @ 0xd0000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 216k freed
SCSI subsystem driver Revision: 1.00
CSLIP: code copyright 1989 Regents of the University of California
ISDN subsystem Rev: 1.114/1.94/1.140.6.1/1.85/1.21/1.5 loaded
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (module)
HiSax: Layer1 Revision 2.41.6.1
HiSax: Layer2 Revision 2.25
HiSax: TeiMgr Revision 2.17
HiSax: Layer3 Revision 2.17
HiSax: LinkLayer Revision 2.51
HiSax: Approval certification valid
HiSax: Approved with ELSA Microlink PCI cards
HiSax: Approved with Eicon Technology Diva 2.01 PCI cards
HiSax: Approved with Sedlbauer Speedfax + cards
HiSax: Total 1 card defined
HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
HiSax: AVM PCI driver Rev. 1.22.6.2
AVM PCI: stat 0x2020a
AVM PCI: Class A Rev 2
HiSax: AVM Fritz!PCI config irq:5 base:0xD400
AVM PCI: ISAC version (0): 2086/2186 V1.1
AVM Fritz PnP/PCI: IRQ 5 count 0
AVM Fritz PnP/PCI: IRQ 5 count 4
HiSax: DSS1 Rev. 2.30
HiSax: 2 channels added
HiSax: MAX_WAITING_CALLS added
isdn: Verbose-Level is 2
3c59x.c:LK1.1.12 06 Jan 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905 Boomerang 100baseTx at 0xd800,  00:10:4b:43:68:64, IRQ 10
  product code 'MN' rev 00.0 date 06-12-00
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 7849.
  Enabling bus-master transmits and whole-frame receives.
eth0: first available media type: MII
ippp, open, slot: 0, minor: 0, state: 0000
ippp_ccp: allocated reset data structure d63cf800
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: YAMAHA    Model: CRW2100E          Rev: 1.0G
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
  Vendor: PIONEER   Model: DVD-ROM DVD-105   Rev: 1.22
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Creative EMU10K1 PCI Audio Driver, version 0.7, 17:34:33 Feb 22 2001
emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xcc00-0xcc1f, IRQ 5

Tell me if can send you any useful information or you know what caused the
crash.

Balazs Pozsar.

