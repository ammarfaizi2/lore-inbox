Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSHXWZ3>; Sat, 24 Aug 2002 18:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSHXWZ3>; Sat, 24 Aug 2002 18:25:29 -0400
Received: from cats-mx1.ucsc.edu ([128.114.129.36]:61569 "EHLO cats.ucsc.edu")
	by vger.kernel.org with ESMTP id <S316842AbSHXWZR>;
	Sat, 24 Aug 2002 18:25:17 -0400
Subject: 3 x PDC20267 (ultra100) + software raid5 => kernel panic: Attempted
	to kill init!
From: "T. Ryan Halwachs" <halwachs@cats.ucsc.edu>
To: kernel mailing list <linux-kernel@vger.kernel.org>,
       ataraid mailing list <ataraid-list@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Aug 2002 15:26:07 -0700
Message-Id: <1030227978.2290.231.camel@p500m700>
Mime-Version: 1.0
X-UCSC-CATS-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
hoping you can help me diagnose and correct some problems I am having
with 3 promise ultra100 cards I am trying to use with 6 WD1200 drives to
create an ide raid5 array.

I posted this to the ataraid list originally.
https://listman.redhat.com/pipermail/ataraid-list/2002-August/001029.html

since then, using 2.4.19-ac4 I was able to successfully build a raid5
array on 5 disks attached to 3 Promise ultra100 pci add-in cards
(described in the original thread). I put some files on the array and
they passed md5check. 
I couldn't unmount the array. 
I couldn't raidstop it.  
When I restarted the machine, it intermittently would not talk to the
drive on the third card. 

dmesg from successful(ish) kernel:

Linux version 2.4.19-ac4-loca (ryan@TRH-RH72) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #3 SMP Fri Aug 9 15:14:10 PDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e7000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000011ffdc00 (usable)
 BIOS-e820: 0000000011ffdc00 - 0000000011fffc00 (ACPI data)
 BIOS-e820: 0000000011fffc00 - 0000000012000000 (ACPI NVS)
 BIOS-e820: 00000000fffe7000 - 0000000100000000 (reserved)
287MB LOWMEM available.
On node 0 totalpages: 73725
zone(0): 4096 pages.
zone(1): 69629 pages.
zone(2): 0 pages.
Kernel command line: nousb noacpi ro root=/dev/hda1 hdc=ide-scsi 
ide_setup: hdc=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 399.068 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 796.26 BogoMIPS
Memory: 288084k/294900k available (1476k kernel code, 6424k reserved, 363k data, 284k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=36010 max_file_pages=0 max_inodes=0 max_dentries=36010
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Celeron (Mendocino) stepping 00
per-CPU timeslice cutoff: 365.10 usecs.
task migration cache decay timeout: 10 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 399.0458 MHz.
..... host bus clock speed is 66.5075 MHz.
cpu: 0, clocks: 665075, slice: 332537
CPU0<T0:665072,T1:332528,D:7,S:332537,C:665075>
migration_task 0 on cpu=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver v1.1.22 [Flags: R/O]
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
block: 544 slots per queue, batch=136
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x14e0-0x14e7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x14e8-0x14ef, BIOS settings: hdc:DMA, hdd:pio
PDC20267: IDE controller on PCI bus 00 dev 68
PCI: Found IRQ 11 for device 00:0d.0
PCI: Sharing IRQ 11 with 00:11.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x1400-0x1407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1408-0x140f, BIOS settings: hdg:pio, hdh:pio
PDC20267: IDE controller on PCI bus 00 dev 78
PCI: Found IRQ 10 for device 00:0f.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide4: BM-DMA at 0x1440-0x1447, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0x1448-0x144f, BIOS settings: hdk:pio, hdl:pio
PDC20267: IDE controller on PCI bus 00 dev 80
PCI: Found IRQ 9 for device 00:10.0
PCI: Sharing IRQ 9 with 00:07.2
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20267: FORCING BURST BIT 0x00 -> 0x01 ACTIVE
    ide6: BM-DMA at 0x1480-0x1487, BIOS settings: hdm:pio, hdn:pio
    ide7: BM-DMA at 0x1488-0x148f, BIOS settings: hdo:pio, hdp:pio
hda: QUANTUM FIREBALL_TM3840A, ATA DISK drive
hdc: RICOH CD-R/RW MP7040A, ATAPI CD/DVD-ROM drive
hdf: WDC WD1200AB-00CBA1, ATA DISK drive
hdh: WDC WD1200AB-00CBA1, ATA DISK drive
hdj: WDC WD1200AB-00CBA1, ATA DISK drive
hdl: WDC WD1200AB-00CBA1, ATA DISK drive
hdm: WDC WD1200JB-75CRA0, ATA DISK drive
hdp: WDC WD1200BB-00CAA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x1800-0x1807,0x14f6 on irq 11
ide3 at 0x14f8-0x14ff,0x14f2 on irq 11
ide4 at 0x1818-0x181f,0x180e on irq 10
ide5 at 0x1810-0x1817,0x180a on irq 10
ide6 at 0x1830-0x1837,0x1826 on irq 9
ide7 at 0x1828-0x182f,0x1822 on irq 9
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 7539840 sectors (3860 MB) w/76KiB Cache, CHS=935/128/63, DMA
hdf: host protected area => 1
hdf: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
hdh: host protected area => 1
hdh: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
hdj: host protected area => 1
hdj: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
hdl: host protected area => 1
hdl: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
hdm: host protected area => 1
hdm: setmax LBA 234375120, native  234375000
hdm: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=232514/16/63, UDMA(100)
hdp: host protected area => 1
hdp: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
Partition check:
 hda: [PTBL] [469/255/63] hda1 hda2
 hdf: hdf1
 hdh: hdh1
 hdj: hdj1
 hdl: hdl1
 hdm: [PTBL] [14589/255/63] hdm1
 hdp: [PTBL] [14593/255/63] hdp1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.25
PCI: Found IRQ 11 for device 00:11.0
PCI: Sharing IRQ 11 with 00:0d.0
eth0: SMC1211TX EZCard 10/100 (RealTek RTL8139) at 0x1000, 00:e0:29:46:7f:97, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139A'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 232M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xf8000000
SCSI subsystem driver Revision: 1.00
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   736.000 MB/sec
   32regs    :   346.000 MB/sec
   pII_mmx   :   912.400 MB/sec
   p5_mmx    :   950.800 MB/sec
raid5: using function: p5_mmx (950.800 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 0000000c]
 [events: 0000000c]
 [events: 0000000c]
 [events: 00000004]
md: autorun ...
md: considering hdl1 ...
md:  adding hdl1 ...
md:  adding hdj1 ...
md:  adding hdh1 ...
md:  adding hdf1 ...
md: created md0
md: bind<hdf1,1>
md: bind<hdh1,2>
md: bind<hdj1,3>
md: bind<hdl1,4>
md: running: <hdl1><hdj1><hdh1><hdf1>
md: hdl1's event counter: 00000004
md: hdj1's event counter: 0000000c
md: hdh1's event counter: 0000000c
md: hdf1's event counter: 0000000c
md: superblock update time inconsistency -- using the most recent one
md: freshest: hdj1
md: kicking non-fresh hdl1 from array!
md: unbind<hdl1,3>
md: export_rdev(hdl1)
md0: max total readahead window set to 744k
md0: 3 data-disks, max readahead per data-disk: 248k
raid5: device hdj1 operational as raid disk 2
raid5: device hdh1 operational as raid disk 1
raid5: device hdf1 operational as raid disk 0
raid5: md0, not all disks are operational -- trying to recover array
raid5: allocated 4339kB for md0
raid5: raid level 5 set md0 active with 3 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:3 fd:1
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hdf1
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdh1
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdj1
 disk 3, s:0, o:0, n:3 rd:3 us:1 dev:[dev 00:00]
RAID5 conf printout:
 --- rd:4 wd:3 fd:1
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hdf1
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdh1
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdj1
 disk 3, s:0, o:0, n:3 rd:3 us:1 dev:[dev 00:00]
md: updating md0 RAID superblock on device
md: hdj1 [events: 0000000d]<6>(write) hdj1's sb offset: 117220672
md: recovery thread got woken up ...
md0: no spare disk to reconstruct array! -- continuing in degraded mode
md: recovery thread finished ...
md: hdh1 [events: 0000000d]<6>(write) hdh1's sb offset: 117220672
md: hdf1 [events: 0000000d]<6>(write) hdf1's sb offset: 117220672
md: ... autorun DONE.
LVM version 1.0.3(19/02/2002)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 284k freed
Adding Swap: 610460k swap-space (priority -1)
raid5: switching cache buffer size, 4096 --> 1024
EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,1), internal journal
hdc: driver not present
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1. 
and the config:
can't find it --oops. raid5 was in. Promise stuff was in.

many kernels/patches later... 

kernel 2.5.25 with 0 drives on 2nd card and 0 drives on 3rd card
2 drives on PDC20267(#1)
0 drives on PDC20267(#2)
0 drives on PDC20267(#3)

Linux version 2.5.25 (ryan@TRH-RH72) (gcc version 2.96 20000731 (Red Hat
Linux 7.1 2.96-98)) #1 SMP Sat Aug 24 02:03:03 PDT 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e7000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000011ffdc00 (usable)
 BIOS-e820: 0000000011ffdc00 - 0000000011fffc00 (ACPI data)
 BIOS-e820: 0000000011fffc00 - 0000000012000000 (ACPI NVS)
 BIOS-e820: 00000000fffe7000 - 0000000100000000 (reserved)
287MB LOWMEM available.
On node 0 totalpages: 73725
zone(0): 4096 pages.
zone(1): 69629 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda1
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 399.111 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 784.38 BogoMIPS
Memory: 289280k/294900k available (1411k kernel code, 5228k reserved,
349k data, 272k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Celeron (Mendocino) stepping 00
per-CPU timeslice cutoff: 365.10 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 398.0986 MHz.
..... host bus clock speed is 66.0497 MHz.
cpu: 0, clocks: 66497, slice: 2015
CPU0<T0:66496,T1:64480,D:1,S:2015,C:66497>
migration_task 0 on cpu=0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd983, last bus=1
PCI: Using configuration type 1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
__iounmap: bad address d2800e96
__iounmap: bad address d2804b8c
__iounmap: bad address d2802e96
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Limiting direct PCI/PCI transfers.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
lp: driver loaded but no devices found
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 232M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 on Intel 440BX @ 0xf8000000 64MB
[drm] Initialized radeon 1.3.1 20020611 on minor 1
block: 256 slots per queue, batch=32
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.25
PCI: Found IRQ 10 for device 00:11.0
PCI: Sharing IRQ 10 with 00:0d.0
eth0: SMC1211TX EZCard 10/100 (RealTek RTL8139) at 0x1000,
00:e0:29:46:7f:97, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139A'
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: Intel Corp. 82371AB PIIX4 IDE, PCI slot 00:07.1
ATA: chipset rev.: 1
ATA: non-legacy mode: IRQ probe delayed
PIIX: Intel Corp. 82371AB PIIX4 IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0x14e0-0x14e7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x14e8-0x14ef, BIOS settings: hdc:DMA, hdd:pio
ATA: Promise Technology, Inc. 20267, PCI slot 00:0d.0
PCI: Found IRQ 10 for device 00:0d.0
PCI: Sharing IRQ 10 with 00:11.0
ATA: chipset rev.: 2
ATA: non-legacy mode: IRQ probe delayed
Promise Technology, Inc. 20267: device reseted.
Promise Technology, Inc. 20267: (U)DMA BURST enabled, primary PCI mode,
secondary PCI mode.
    ide2: BM-DMA at 0x1400-0x1407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x1408-0x140f, BIOS settings: hdg:DMA, hdh:pio
ATA: Promise Technology, Inc. 20267 (#2), PCI slot 00:0e.0
PCI: Found IRQ 7 for device 00:0e.0
ATA: chipset rev.: 2
ATA: non-legacy mode: IRQ probe delayed
Promise Technology, Inc. 20267 (#2): device reseted.
Promise Technology, Inc. 20267 (#2): (U)DMA BURST enabled, primary PCI
mode, secondary PCI mode.
    ide4: BM-DMA at 0x1440-0x1447, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x1448-0x144f, BIOS settings: hdk:pio, hdl:pio
ATA: Promise Technology, Inc. 20267 (#3), PCI slot 00:0f.0
PCI: Found IRQ 5 for device 00:0f.0
ATA: chipset rev.: 2
ATA: non-legacy mode: IRQ probe delayed
Promise Technology, Inc. 20267 (#3): device reseted.
Promise Technology, Inc. 20267 (#3): forcing (U)DMA BURST.
Promise Technology, Inc. 20267 (#3): (U)DMA BURST disabled, primary PCI
mode, secondary PCI mode.
    ide6: BM-DMA at 0x1480-0x1487, BIOS settings: hdm:DMA, hdn:pio
    ide7: BM-DMA at 0x1488-0x148f, BIOS settings: hdo:pio, hdp:pio
hda: QUANTUM FIREBALL_TM3840A, DISK drive
hdc: RICOH CD-R/RW MP7040A, ATAPI CD/DVD-ROM drive
hde: WDC WD1200AB-00CBA1, DISK drive
hdg: WDC WD1200AB-00CBA1, DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x1800-0x1807,0x14f6 on irq 10
ide3 at 0x14f8-0x14ff,0x14f2 on irq 10
 hda: 7539840 sectors w/76KiB Cache, CHS=7480/16/63, DMA
 hda: [PTBL] [469/255/63] hda1 hda2
 hde: 234441648 sectors w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
 hde:
 hdg: 234441648 sectors w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
 hdg:
hdc: ATAPI 20X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   728.000 MB/sec
   32regs    :   344.000 MB/sec
   pII_mmx   :   920.000 MB/sec
   p5_mmx    :   952.000 MB/sec
raid5: using function: p5_mmx (952.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 272k freed
Adding 610460k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
eth0: Setting 100mbps full-duplex based on auto-negotiated partner
ability 45e1.

and the config:
#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_SMP=y
# CONFIG_PREEMPT is not set
# CONFIG_MULTIQUAD is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#

#
# ACPI Support
#
# CONFIG_ACPI is not set
CONFIG_PM=y
# CONFIG_APM is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
CONFIG_MD_RAID5=y
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set

#
# ATA host chip set support
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=y

#
#   PCI host chip set support
#
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_SL82C105 is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_IVB is not set
CONFIG_ATAPI=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_ATARAID is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
CONFIG_8139TOO_TUNE_TWISTER=y
CONFIG_8139TOO_8129=y
CONFIG_8139_NEW_RX_RESET=y
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input device support
#
# CONFIG_INPUT is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_TSDEV_SCREEN_X=240
CONFIG_INPUT_TSDEV_SCREEN_Y=320

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
# CONFIG_SERIO is not set
CONFIG_I8042_REG_BASE=60
CONFIG_I8042_KBD_IRQ=1
CONFIG_I8042_AUX_IRQ=12

#
# Input Device Drivers
#

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
CONFIG_DRM_TDFX=y
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_REISERFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
# CONFIG_FAT_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
# CONFIG_NLS is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_LONG_TIMEOUT is not set
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD_ALT is not set

#
# USB Device Class drivers
#
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
#   SCSI support is needed for USB Storage
#

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set

#
#     Input core support is needed for USB HID input layer or HIDBP support
#

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_DEBUG_KERNEL is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set

kernel 2.5.25 with 2 drives on 2nd card:
2 drives on PDC20267(#1)
2 drives on PDC20267(#2)
0 drives on PDC20267(#3)

booting gets to the raid stuff then dies:
.
.
.
md0 max total readahead window set to OK

then panics:

divide error: 0000
.
.
.
Process swapper...
.
.
.
<0> kernel panic: Attempt to kill init!


help, please.
cheers,
ryan







