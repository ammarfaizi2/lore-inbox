Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264345AbRGNRTi>; Sat, 14 Jul 2001 13:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264329AbRGNRT2>; Sat, 14 Jul 2001 13:19:28 -0400
Received: from usc.edu ([128.125.253.136]:56504 "EHLO usc.edu")
	by vger.kernel.org with ESMTP id <S264345AbRGNRTN>;
	Sat, 14 Jul 2001 13:19:13 -0400
Date: Sat, 14 Jul 2001 10:16:31 -0700 (PDT)
From: Laurent Itti <itti@java.usc.edu>
To: linux-kernel@vger.kernel.org
Subject: Panasonic LF-D211V DVD-RAM hangs IDE
Message-ID: <Pine.SV4.3.96.1010714095055.13782A-100000@java.usc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

I have seen several similar reports already, but could not find 
a solution in the replies I have read so far.  So here we go:
I have a Panasonic LF-D211V 4.7GB DVD-RAM drive (UDMA/33) with a
brand new 80-cond ATA/100 short ribbon cable. Kernel is 2.4.6.

- If I hook it up to a CMD649 IDE controller, the drive is set to
PIO mode and the machine hangs while I attempt a mke2fs on the disk
(no message; just hangs)

- if I hook it up to a motherboard with VIA vt82c686a, the drive
is set to UDMA/33 mode and appears to work for a while, until
some error comes in (while I attempt to transfer a big file),
and comes again until DMA gets disabled, at which point the machine
gets into an infinite loop of trying to reset the drive (see below).

In passing, if I do a mke2fs -b 2048 /dev/hdb on a disk, it works,
but I cannot mount the disk.  Pre-formatted UDF disks mount ok,
though. 

any suggestion would be most appreciated!

  -- laurent

-----------------------------------------------------------------------
Laurent Itti - University of Southern California, Computer Science Dept
Hedco Neuroscience Building, HNB-30A - Los Angeles, CA 90089-2520 - USA
Email: itti@java.usc.edu  - Tel: +1(213)740-3527 - Fax: +1(213)740-5687
-----------------------------------------------------------------------


Jul  4 19:34:04 jukebox kernel: UDF-fs INFO UDF 0.9.4.1-rw (2001/06/13)
Mounting volume 'PANA-UDF', timestamp 2001/04/28 03:30 (1e5c)
Jul  4 19:40:00 jukebox CROND[1302]: (root) CMD (   /sbin/rmmod -as)
Jul  4 19:42:29 jukebox kernel: hdb: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  4 19:42:29 jukebox kernel: hdb: cdrom_decode_status: error=0x30
Jul  4 19:42:29 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:44:00 jukebox kernel: hdb: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  4 19:44:00 jukebox kernel: hdb: cdrom_decode_status: error=0x30
Jul  4 19:44:00 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:45:48 jukebox kernel: hdb: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  4 19:45:48 jukebox kernel: hdb: cdrom_decode_status: error=0x30
Jul  4 19:45:48 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:45:55 jukebox kernel: hdb: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  4 19:45:55 jukebox kernel: hdb: cdrom_decode_status: error=0x30
Jul  4 19:45:55 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:45:57 jukebox kernel: hdb: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  4 19:45:57 jukebox kernel: hdb: cdrom_decode_status: error=0x30
Jul  4 19:45:57 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:45:59 jukebox kernel: hdb: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  4 19:45:59 jukebox kernel: hdb: cdrom_decode_status: error=0x30
Jul  4 19:45:59 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:46:01 jukebox kernel: hdb: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  4 19:46:01 jukebox kernel: hdb: cdrom_decode_status: error=0x30
Jul  4 19:46:01 jukebox kernel: hdb: DMA disabled
Jul  4 19:46:01 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:46:02 jukebox kernel: hdb: ATAPI reset complete
Jul  4 19:46:04 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:46:05 jukebox kernel: hdb: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  4 19:46:05 jukebox kernel: hdb: cdrom_decode_status: error=0x30
Jul  4 19:46:05 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:46:07 jukebox kernel: hdb: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  4 19:46:07 jukebox kernel: hdb: cdrom_decode_status: error=0x30
Jul  4 19:46:07 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:46:09 jukebox kernel: hdb: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  4 19:46:09 jukebox kernel: hdb: cdrom_decode_status: error=0x30
Jul  4 19:46:09 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:46:10 jukebox kernel: hdb: ATAPI reset complete
Jul  4 19:46:11 jukebox kernel: end_request: I/O error, dev 03:40 (hdb),
sector 296820
Jul  4 19:46:11 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:46:12 jukebox kernel: hdb: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  4 19:46:12 jukebox kernel: hdb: cdrom_decode_status: error=0x30
Jul  4 19:46:12 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:46:14 jukebox kernel: hdb: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  4 19:46:14 jukebox kernel: hdb: cdrom_decode_status: error=0x30
Jul  4 19:46:14 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:46:16 jukebox kernel: hdb: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  4 19:46:16 jukebox kernel: hdb: cdrom_decode_status: error=0x30
Jul  4 19:46:16 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:46:18 jukebox kernel: hdb: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  4 19:46:18 jukebox kernel: hdb: cdrom_decode_status: error=0x30
Jul  4 19:46:18 jukebox kernel: ide-cd: write_intr decode_status bad
Jul  4 19:46:20 jukebox kernel: hdb: ATAPI reset complete
Jul  4 19:46:20 jukebox kernel: ide-cd: write_intr deco



and some dmesg just in case:

Linux version 2.4.6 (root@jukebox.humc.edu) (gcc version 2.96 20000731
(Linux-Mandrake 8.0 2.96-0.48mdk)) #7 Thu Jul 5 00:23:35 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fdf0000 (usable)
 BIOS-e820: 000000000fdf0000 - 000000000fdf3000 (ACPI NVS)
 BIOS-e820: 000000000fdf3000 - 000000000fe00000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65008
zone(0): 4096 pages.
zone(1): 60912 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux ro root=900 hdb=noprobe hdb=cdrom
ide_setup: hdb=noprobe
ide_setup: hdb=cdrom
Initializing CPU#0
Detected 1000.069 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1992.29 BogoMIPS
Memory: 252804k/260032k available (1484k kernel code, 6840k reserved, 529k
data, 240k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0387f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387f9ff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb390, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
udf: registering filesystem
vesafb: framebuffer at 0xd5800000, mapped to 0xd0800000, size 2048k
vesafb: mode is 800x600x16, linelength=1600, pages=1
vesafb: protected mode interface info at c000:6740
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
block: queued sectors max/low 167925kB/55975kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
CMD649: IDE controller on PCI bus 00 dev 40
PCI: Found IRQ 10 for device 00:08.0
CMD649: chipset revision 2
CMD649: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:pio, hdh:pio
hda: WDC WD400BB-00AUA1, ATA DISK drive
hdc: WDC WD400BB-00AUA1, ATA DISK drive
hde: WDC WD400BB-00AUA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xcc00-0xcc07,0xd002 on irq 10
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63,
UDMA(66)
hdc: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63,
UDMA(66)
hde: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63,
UDMA(100)
hdb: ATAPI DVD-ROM DVD-RAM drive, 1024kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 < hda5 > hda4
 hdc: hdc1 hdc2 hdc3 < hdc5 > hdc4
 hde: hde1 hde2 hde3 < hde5 > hde4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.18-pre4
PCI: Found IRQ 5 for device 00:09.0
eth0: RealTek RTL8139 Fast Ethernet at 0xd0a01000, 00:02:44:00:fe:84, IRQ
5
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 201M
agpgart: Unsupported Via chipset (device id: 0601), you might want to try
agp_try_unsupported=1.
agpgart: no supported devices found.
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0a.0
i91u: PCI Base=0xE400, IRQ=11, BIOS=0xFF000, SCSI ID=7
i91u: Reset SCSI Bus ...
scsi0 : Initio INI-9X00U/UW SCSI device driver; Revision: 1.03g
es1371: version v0.30 time 18:03:15 Jul  4 2001
usb.c: registered new driver hub
md: raid1 personality registered
md: raid5 personality registered
raid5: measuring checksumming speed
   8regs     :  1843.200 MB/sec
   32regs    :   867.200 MB/sec
   pIII_sse  :  1998.400 MB/sec
   pII_mmx   :  2282.800 MB/sec
   p5_mmx    :  2384.000 MB/sec
raid5: using function: pIII_sse (1998.400 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
(read) hda1's sb offset: 64128 [events: 0000001d]
(read) hda2's sb offset: 4192896 [events: 0000001b]
(read) hdc1's sb offset: 64384 [events: 0000001d]
(read) hdc2's sb offset: 4193216 [events: 0000001b]
(read) hde1's sb offset: 64384 [events: 0000001d]
(read) hde2's sb offset: 4193216 [events: 0000001b]
md: autorun ...
md: considering hde2 ...
md:  adding hde2 ...
md:  adding hdc2 ...
md:  adding hda2 ...
md: created md0
md: bind<hda2,1>
md: bind<hdc2,2>
md: bind<hde2,3>
md: running: <hde2><hdc2><hda2>
md: now!
md: hde2's event counter: 0000001b
md: hdc2's event counter: 0000001b
md: hda2's event counter: 0000001b
md0: max total readahead window set to 496k
md0: 2 data-disks, max readahead per data-disk: 248k
raid5: device hde2 operational as raid disk 2
raid5: device hdc2 operational as raid disk 1
raid5: device hda2 operational as raid disk 0
raid5: allocated 3291kB for md0
raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hda2
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdc2
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hde2
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hda2
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdc2
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hde2
md: updating md0 RAID superblock on device
md: hde2 [events: 0000001c](write) hde2's sb offset: 4193216
md: hdc2 [events: 0000001c](write) hdc2's sb offset: 4193216
md: hda2 [events: 0000001c](write) hda2's sb offset: 4192896
md: considering hde1 ...
md:  adding hde1 ...
md:  adding hdc1 ...
md:  adding hda1 ...
md: created md1
md: bind<hda1,1>
md: bind<hdc1,2>
md: bind<hde1,3>
md: running: <hde1><hdc1><hda1>
md: now!
md: hde1's event counter: 0000001d
md: hdc1's event counter: 0000001d
md: hda1's event counter: 0000001d
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: spare disk hde1
raid1: device hdc1 operational as mirror 1
raid1: device hda1 operational as mirror 0
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: hde1 [events: 0000001e](write) hde1's sb offset: 64384
md: hdc1 [events: 0000001e](write) hdc1's sb offset: 64384
md: hda1 [events: 0000001e](write) hda1's sb offset: 64128
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
raid5:  switching cache buffer size, 4096 --> 1024
raid5: switching cache buffer size, 1024 --> 4096
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 240k freed
Adding Swap: 248968k swap-space (priority -1)
Adding Swap: 249440k swap-space (priority -2)
Adding Swap: 249440k swap-space (priority -3)
(read) hda4's sb offset: 34571776 [events: 00000013]
(read) hdc4's sb offset: 34575296 [events: 00000013]
(read) hde4's sb offset: 34575296 [events: 00000013]
md: autorun ...
md: considering hde4 ...
md:  adding hde4 ...
md:  adding hdc4 ...
md:  adding hda4 ...
md: created md2
md: bind<hda4,1>
md: bind<hdc4,2>
md: bind<hde4,3>
md: running: <hde4><hdc4><hda4>
md: now!
md: hde4's event counter: 00000013
md: hdc4's event counter: 00000013
md: hda4's event counter: 00000013
md2: max total readahead window set to 496k
md2: 2 data-disks, max readahead per data-disk: 248k
raid5: device hde4 operational as raid disk 2
raid5: device hdc4 operational as raid disk 1
raid5: device hda4 operational as raid disk 0
raid5: allocated 3291kB for md2
raid5: raid level 5 set md2 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hda4
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdc4
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hde4
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hda4
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdc4
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hde4
md: updating md2 RAID superblock on device
md: hde4 [events: 00000014](write) hde4's sb offset: 34575296
md: hdc4 [events: 00000014](write) hdc4's sb offset: 34575296
md: hda4 [events: 00000014](write) hda4's sb offset: 34571776
md: ... autorun DONE.
raid5: switching cache buffer size, 4096 --> 1024
raid5: switching cache buffer size, 1024 --> 4096
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
parport_pc: Via 686A parallel port disabled in BIOS
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
parport_pc: Via 686A parallel port disabled in BIOS
lp: driver loaded but no devices found
[root@jukebox juke]#

