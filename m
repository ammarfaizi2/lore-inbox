Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280867AbRKLRsk>; Mon, 12 Nov 2001 12:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280875AbRKLRsb>; Mon, 12 Nov 2001 12:48:31 -0500
Received: from sttldslgw16poolA74.sttl.uswest.net ([63.231.36.74]:37976 "EHLO
	jerry-garcia.accessgroupinc.com") by vger.kernel.org with ESMTP
	id <S280867AbRKLRsV>; Mon, 12 Nov 2001 12:48:21 -0500
Date: Mon, 12 Nov 2001 09:47:42 -0800
Message-Id: <200111121747.JAA11329@jerry-garcia.accessgroupinc.com>
From: Bob Ramstad <rramstad@alum.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: IDE SiS730 / SiS5513 incorrect defaults kernel 2.4.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy.  Please CC me directly on any replies.  Thanks!

Using RedHat 7.1 on a system built on the Asus A7S-VM motherboard
(SiS730 chipset with integrated IDE controller SiS5513) we were having
absolutely no problems with kernel 2.4.3-12.  When we upgraded to
2.4.9-6 we started getting errors like the following:

Oct 22 12:46:12 accessgroupinc kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 22 12:46:12 accessgroupinc kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }

These problems occur on both hdb and hdc which are the only IDE
devices in the system.  (If you are curious, hda is an IDE CD-ROM
which is disconnected internally for security reasons.)

We downgraded back to 2.4.3-12 and eventually installed RedHat 7.2 on
that system which contained kernel 2.4.7-10.  Again, no problems.
When we upgraded to 2.4.9-13, the problem recurred.  I've included our
system log below from rebooting the machine this morning.

Let me note a few things which may be of interest.  We had been
getting these errors on and off as the system ran i.e. we'd see errors
every hour or two.  From some experimentation, I created
/etc/sysconfig/harddiskhd{b,c} to be ran from /etc/rc.sysinit and do
the equivalent of

/sbin/hdparm -d1 -u1 -c3 -X69 /dev/hdb
/sbin/hdparm -d1 -u1 -c3 -X69 /dev/hdc

Virtually all of the partitions are raid partitions, including root.
With these parameters set via rc.sysinit, there are errors on initial
boot, but once the kernel fully initializes and all the raid
partitions are mounted, rc.sysinit sets the parameters appropriately
and everything is fine from there.

My primary concern is that the IDE driver seems to be making different
choices in 2.4.9-13 for this chipset, and earlier kernels are making
better choices -- or possibly failing silently?  In any case, I
thought the folks who work on the IDE code would like to see this
example of a problem on what is probably a somewhat rare chipset.  If
the problem has been corrected already in more recent kernels, my
apologies if I've wasted your time.  Thanks!

-- Bob

Nov 12 09:34:39 accessgroupinc syslogd 1.4.1: restart.
Nov 12 09:34:39 accessgroupinc syslog: syslogd startup succeeded
Nov 12 09:34:39 accessgroupinc kernel: klogd 1.4.1, log source = /proc/kmsg started.
Nov 12 09:34:39 accessgroupinc kernel: Inspecting /boot/System.map-2.4.9-13
Nov 12 09:34:39 accessgroupinc syslog: klogd startup succeeded
Nov 12 09:34:39 accessgroupinc kernel: Loaded 15150 symbols from /boot/System.map-2.4.9-13.
Nov 12 09:34:39 accessgroupinc kernel: Symbols match kernel version 2.4.9.
Nov 12 09:34:39 accessgroupinc kernel: Loaded 123 symbols from 7 modules.
Nov 12 09:34:39 accessgroupinc kernel: Linux version 2.4.9-13 (bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Tue Oct 30 20:11:04 EST 2001
Nov 12 09:34:39 accessgroupinc kernel: BIOS-provided physical RAM map:
Nov 12 09:34:39 accessgroupinc kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Nov 12 09:34:39 accessgroupinc kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Nov 12 09:34:39 accessgroupinc kernel:  BIOS-e820: 0000000000100000 - 000000001dfed000 (usable)
Nov 12 09:34:39 accessgroupinc kernel:  BIOS-e820: 000000001dfed000 - 000000001dfef000 (ACPI data)
Nov 12 09:34:39 accessgroupinc kernel:  BIOS-e820: 000000001dfef000 - 000000001dfff000 (reserved)
Nov 12 09:34:39 accessgroupinc kernel:  BIOS-e820: 000000001dfff000 - 000000001e000000 (ACPI NVS)
Nov 12 09:34:39 accessgroupinc kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Nov 12 09:34:39 accessgroupinc kernel: Scanning bios EBDA for MXT signature
Nov 12 09:34:39 accessgroupinc kernel: On node 0 totalpages: 122861
Nov 12 09:34:39 accessgroupinc kernel: zone(0): 4096 pages.
Nov 12 09:34:39 accessgroupinc kernel: zone(1): 118765 pages.
Nov 12 09:34:39 accessgroupinc kernel: zone(2): 0 pages.
Nov 12 09:34:39 accessgroupinc kernel: Kernel command line: ro root=/dev/md1
Nov 12 09:34:39 accessgroupinc kernel: Initializing CPU#0
Nov 12 09:34:39 accessgroupinc kernel: Detected 952.178 MHz processor.
Nov 12 09:34:39 accessgroupinc kernel: Console: colour VGA+ 80x25
Nov 12 09:34:39 accessgroupinc kernel: Calibrating delay loop... 1900.54 BogoMIPS
Nov 12 09:34:39 accessgroupinc kernel: Memory: 478004k/491444k available (1723k kernel code, 10992k reserved, 91k data, 224k init, 0k highmem)
Nov 12 09:34:39 accessgroupinc kernel: Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Nov 12 09:34:39 accessgroupinc kernel: Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Nov 12 09:34:39 accessgroupinc kernel: Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Nov 12 09:34:39 accessgroupinc kernel: Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Nov 12 09:34:39 accessgroupinc kernel: Page-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Nov 12 09:34:39 accessgroupinc kernel: Intel machine check architecture supported.
Nov 12 09:34:39 accessgroupinc kernel: Intel machine check reporting enabled on CPU#0.
Nov 12 09:34:39 accessgroupinc kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Nov 12 09:34:39 accessgroupinc kernel: CPU: L2 Cache: 256K (64 bytes/line)
Nov 12 09:34:39 accessgroupinc kernel: CPU: AMD Athlon(tm) Processor stepping 02
Nov 12 09:34:39 accessgroupinc kernel: Enabling fast FPU save and restore... done.
Nov 12 09:34:39 accessgroupinc kernel: Checking 'hlt' instruction... OK.
Nov 12 09:34:39 accessgroupinc kernel: POSIX conformance testing by UNIFIX
Nov 12 09:34:39 accessgroupinc kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Nov 12 09:34:39 accessgroupinc kernel: mtrr: detected mtrr type: Intel
Nov 12 09:34:39 accessgroupinc kernel: PCI: PCI BIOS revision 2.10 entry at 0xf1270, last bus=1
Nov 12 09:34:39 accessgroupinc keytable: Loading keymap:  succeeded
Nov 12 09:34:39 accessgroupinc kernel: PCI: Using configuration type 1
Nov 12 09:34:39 accessgroupinc kernel: PCI: Probing PCI hardware
Nov 12 09:34:39 accessgroupinc kernel: PCI: Using IRQ router SIS [1039/0008] at 00:01.0
Nov 12 09:34:39 accessgroupinc kernel: isapnp: Scanning for PnP cards...
Nov 12 09:34:39 accessgroupinc kernel: isapnp: No Plug & Play device found
Nov 12 09:34:39 accessgroupinc kernel: Linux NET4.0 for Linux 2.4
Nov 12 09:34:39 accessgroupinc kernel: Based upon Swansea University Computer Society NET3.039
Nov 12 09:34:39 accessgroupinc kernel: Initializing RT netlink socket
Nov 12 09:34:39 accessgroupinc kernel: Simple Boot Flag extension found and enabled.
Nov 12 09:34:39 accessgroupinc kernel: apm: BIOS version 1.2 Flags 0x0b (Driver version 1.14)
Nov 12 09:34:39 accessgroupinc kernel: mxt_scan_bios: enter
Nov 12 09:34:39 accessgroupinc kernel: Starting kswapd v1.8
Nov 12 09:34:39 accessgroupinc kernel: VFS: Diskquotas version dquot_6.5.0 initialized
Nov 12 09:34:39 accessgroupinc kernel: pty: 2048 Unix98 ptys configured
Nov 12 09:34:39 accessgroupinc kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Nov 12 09:34:39 accessgroupinc kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Nov 12 09:34:39 accessgroupinc kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Nov 12 09:34:39 accessgroupinc kernel: Real Time Clock Driver v1.10e
Nov 12 09:34:39 accessgroupinc kernel: block: queued sectors max/low 317298kB/186226kB, 960 slots per queue
Nov 12 09:34:39 accessgroupinc kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Nov 12 09:34:39 accessgroupinc kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Nov 12 09:34:39 accessgroupinc kernel: ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
Nov 12 09:34:39 accessgroupinc kernel: SIS5513: IDE controller on PCI bus 00 dev 01
Nov 12 09:34:39 accessgroupinc kernel: SIS5513: chipset revision 208
Nov 12 09:34:39 accessgroupinc kernel: SIS5513: not 100%% native mode: will probe irqs later
Nov 12 09:34:39 accessgroupinc kernel: SiS730
Nov 12 09:34:39 accessgroupinc keytable: Loading system font:  succeeded
Nov 12 09:34:39 accessgroupinc kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:DMA
Nov 12 09:34:39 accessgroupinc kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
Nov 12 09:34:39 accessgroupinc kernel: hdb: IC35L040AVER07-0, ATA DISK drive
Nov 12 09:34:39 accessgroupinc kernel: hdc: IC35L040AVER07-0, ATA DISK drive
Nov 12 09:34:39 accessgroupinc kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 12 09:34:39 accessgroupinc kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 12 09:34:39 accessgroupinc kernel: hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63, UDMA(100)
Nov 12 09:34:39 accessgroupinc kernel: hdc: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
Nov 12 09:34:39 accessgroupinc kernel: ide-floppy driver 0.97.sv
Nov 12 09:34:39 accessgroupinc kernel: Partition check:
Nov 12 09:34:39 accessgroupinc kernel:  hdb: hdb1 hdb2 hdb3 hdb4
Nov 12 09:34:39 accessgroupinc kernel:  hdc: hdc1 hdc2 hdc3 hdc4
Nov 12 09:34:39 accessgroupinc kernel: Floppy drive(s): fd0 is 1.44M
Nov 12 09:34:39 accessgroupinc kernel: FDC 0 is a post-1991 82077
Nov 12 09:34:39 accessgroupinc kernel: ide-floppy driver 0.97.sv
Nov 12 09:34:39 accessgroupinc kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Nov 12 09:34:39 accessgroupinc kernel: md: Autodetecting RAID arrays.
Nov 12 09:34:39 accessgroupinc kernel: (read) hdb1's sb offset: 10241280 [events: 00000040]
Nov 12 09:34:39 accessgroupinc kernel: (read) hdb2's sb offset: 1028096 [events: 00000040]
Nov 12 09:34:39 accessgroupinc kernel: (read) hdb3's sb offset: 15366080 [events: 00000040]
Nov 12 09:34:39 accessgroupinc kernel: (read) hdc1's sb offset: 10240128 [events: 00000040]
Nov 12 09:34:39 accessgroupinc kernel: (read) hdc2's sb offset: 1024064 [events: 00000040]
Nov 12 09:34:39 accessgroupinc kernel: (read) hdc3's sb offset: 15360320 [events: 00000040]
Nov 12 09:34:39 accessgroupinc kernel: md: autorun ...
Nov 12 09:34:39 accessgroupinc kernel: md: considering hdc3 ...
Nov 12 09:34:39 accessgroupinc kernel: md:  adding hdc3 ...
Nov 12 09:34:39 accessgroupinc kernel: md:  adding hdb3 ...
Nov 12 09:34:39 accessgroupinc kernel: md: created md0
Nov 12 09:34:39 accessgroupinc kernel: md: bind<hdb3,1>
Nov 12 09:34:39 accessgroupinc kernel: md: bind<hdc3,2>
Nov 12 09:34:39 accessgroupinc kernel: md: running: <hdc3><hdb3>
Nov 12 09:34:39 accessgroupinc kernel: md: hdc3's event counter: 00000040
Nov 12 09:34:39 accessgroupinc kernel: md: hdb3's event counter: 00000040
Nov 12 09:34:39 accessgroupinc kernel: RAID level 1 does not need chunksize! Continuing anyway.
Nov 12 09:34:39 accessgroupinc kernel: request_module[md-personality-3]: Root fs not mounted
Nov 12 09:34:39 accessgroupinc kernel: md.c: personality 3 is not loaded!
Nov 12 09:34:39 accessgroupinc kernel: md :do_md_run() returned -22
Nov 12 09:34:39 accessgroupinc kernel: md: md0 stopped.
Nov 12 09:34:39 accessgroupinc kernel: md: unbind<hdc3,1>
Nov 12 09:34:39 accessgroupinc kernel: md: export_rdev(hdc3)
Nov 12 09:34:39 accessgroupinc kernel: md: unbind<hdb3,0>
Nov 12 09:34:39 accessgroupinc kernel: md: export_rdev(hdb3)
Nov 12 09:34:39 accessgroupinc kernel: md: considering hdc2 ...
Nov 12 09:34:39 accessgroupinc kernel: md:  adding hdc2 ...
Nov 12 09:34:39 accessgroupinc random: Initializing random number generator:  succeeded
Nov 12 09:34:39 accessgroupinc kernel: md:  adding hdb2 ...
Nov 12 09:34:39 accessgroupinc kernel: md: created md2
Nov 12 09:34:39 accessgroupinc kernel: md: bind<hdb2,1>
Nov 12 09:34:40 accessgroupinc kernel: md: bind<hdc2,2>
Nov 12 09:34:40 accessgroupinc kernel: md: running: <hdc2><hdb2>
Nov 12 09:34:40 accessgroupinc kernel: md: hdc2's event counter: 00000040
Nov 12 09:34:40 accessgroupinc kernel: md: hdb2's event counter: 00000040
Nov 12 09:34:40 accessgroupinc kernel: RAID level 1 does not need chunksize! Continuing anyway.
Nov 12 09:34:40 accessgroupinc kernel: request_module[md-personality-3]: Root fs not mounted
Nov 12 09:34:40 accessgroupinc kernel: md.c: personality 3 is not loaded!
Nov 12 09:34:40 accessgroupinc kernel: md :do_md_run() returned -22
Nov 12 09:34:40 accessgroupinc kernel: md: md2 stopped.
Nov 12 09:34:40 accessgroupinc kernel: md: unbind<hdc2,1>
Nov 12 09:34:40 accessgroupinc kernel: md: export_rdev(hdc2)
Nov 12 09:34:40 accessgroupinc kernel: md: unbind<hdb2,0>
Nov 12 09:34:40 accessgroupinc kernel: md: export_rdev(hdb2)
Nov 12 09:34:40 accessgroupinc kernel: md: considering hdc1 ...
Nov 12 09:34:40 accessgroupinc kernel: md:  adding hdc1 ...
Nov 12 09:34:40 accessgroupinc kernel: md:  adding hdb1 ...
Nov 12 09:34:40 accessgroupinc kernel: md: created md1
Nov 12 09:34:40 accessgroupinc kernel: md: bind<hdb1,1>
Nov 12 09:34:40 accessgroupinc kernel: md: bind<hdc1,2>
Nov 12 09:34:40 accessgroupinc kernel: md: running: <hdc1><hdb1>
Nov 12 09:34:40 accessgroupinc kernel: md: hdc1's event counter: 00000040
Nov 12 09:34:40 accessgroupinc kernel: md: hdb1's event counter: 00000040
Nov 12 09:34:40 accessgroupinc kernel: RAID level 1 does not need chunksize! Continuing anyway.
Nov 12 09:34:40 accessgroupinc kernel: request_module[md-personality-3]: Root fs not mounted
Nov 12 09:34:40 accessgroupinc kernel: md.c: personality 3 is not loaded!
Nov 12 09:34:40 accessgroupinc kernel: md :do_md_run() returned -22
Nov 12 09:34:40 accessgroupinc sshd: Starting sshd:
Nov 12 09:34:40 accessgroupinc kernel: md: md1 stopped.
Nov 12 09:34:40 accessgroupinc kernel: md: unbind<hdc1,1>
Nov 12 09:34:40 accessgroupinc kernel: md: export_rdev(hdc1)
Nov 12 09:34:40 accessgroupinc kernel: md: unbind<hdb1,0>
Nov 12 09:34:40 accessgroupinc kernel: md: export_rdev(hdb1)
Nov 12 09:34:40 accessgroupinc kernel: md: ... autorun DONE.
Nov 12 09:34:40 accessgroupinc kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Nov 12 09:34:40 accessgroupinc kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Nov 12 09:34:40 accessgroupinc kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Nov 12 09:34:40 accessgroupinc kernel: TCP: Hash tables configured (established 32768 bind 32768)
Nov 12 09:34:40 accessgroupinc kernel: Linux IP multicast router 0.06 plus PIM-SM
Nov 12 09:34:40 accessgroupinc kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Nov 12 09:34:40 accessgroupinc kernel: RAMDISK: Compressed image found at block 0
Nov 12 09:34:40 accessgroupinc kernel: Freeing initrd memory: 330k freed
Nov 12 09:34:40 accessgroupinc kernel: VFS: Mounted root (ext2 filesystem).
Nov 12 09:34:40 accessgroupinc kernel: md: raid1 personality registered as nr 3
Nov 12 09:34:40 accessgroupinc kernel: Journalled Block Device driver loaded
Nov 12 09:34:40 accessgroupinc kernel: md: Autodetecting RAID arrays.
Nov 12 09:34:40 accessgroupinc kernel: (read) hdc3's sb offset: 15360320 [events: 00000040]
Nov 12 09:34:40 accessgroupinc kernel: (read) hdb3's sb offset: 15366080 [events: 00000040]
Nov 12 09:34:40 accessgroupinc kernel: (read) hdc2's sb offset: 1024064 [events: 00000040]
Nov 12 09:34:40 accessgroupinc kernel: (read) hdb2's sb offset: 1028096 [events: 00000040]
Nov 12 09:34:40 accessgroupinc kernel: (read) hdc1's sb offset: 10240128 [events: 00000040]
Nov 12 09:34:40 accessgroupinc kernel: (read) hdb1's sb offset: 10241280 [events: 00000040]
Nov 12 09:34:40 accessgroupinc kernel: md: autorun ...
Nov 12 09:34:40 accessgroupinc kernel: md: considering hdb1 ...
Nov 12 09:34:40 accessgroupinc kernel: md:  adding hdb1 ...
Nov 12 09:34:40 accessgroupinc kernel: md:  adding hdc1 ...
Nov 12 09:34:40 accessgroupinc kernel: md: created md1
Nov 12 09:34:40 accessgroupinc kernel: md: bind<hdc1,1>
Nov 12 09:34:40 accessgroupinc kernel: md: bind<hdb1,2>
Nov 12 09:34:40 accessgroupinc kernel: md: running: <hdb1><hdc1>
Nov 12 09:34:40 accessgroupinc sshd:  succeeded
Nov 12 09:34:40 accessgroupinc kernel: md: hdb1's event counter: 00000040
Nov 12 09:34:40 accessgroupinc kernel: md: hdc1's event counter: 00000040
Nov 12 09:34:40 accessgroupinc kernel: RAID level 1 does not need chunksize! Continuing anyway.
Nov 12 09:34:40 accessgroupinc sshd: 
Nov 12 09:34:40 accessgroupinc kernel: md1: max total readahead window set to 124k
Nov 12 09:34:40 accessgroupinc rc: Starting sshd:  succeeded
Nov 12 09:34:40 accessgroupinc kernel: md1: 1 data-disks, max readahead per data-disk: 124k
Nov 12 09:34:40 accessgroupinc kernel: raid1: device hdb1 operational as mirror 0
Nov 12 09:34:40 accessgroupinc kernel: raid1: device hdc1 operational as mirror 1
Nov 12 09:34:40 accessgroupinc kernel: raid1: raid set md1 active with 2 out of 2 mirrors
Nov 12 09:34:40 accessgroupinc kernel: md: updating md1 RAID superblock on device
Nov 12 09:34:41 accessgroupinc kernel: md: hdb1 [events: 00000041](write) hdb1's sb offset: 10241280
Nov 12 09:34:41 accessgroupinc kernel: hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Nov 12 09:34:41 accessgroupinc kernel: hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
Nov 12 09:34:41 accessgroupinc kernel: hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Nov 12 09:34:41 accessgroupinc kernel: hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
Nov 12 09:34:41 accessgroupinc kernel: hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Nov 12 09:34:41 accessgroupinc kernel: hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
Nov 12 09:34:41 accessgroupinc kernel: hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Nov 12 09:34:41 accessgroupinc kernel: hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
Nov 12 09:34:41 accessgroupinc kernel: ide0: reset: master: error (0x0a?)
Nov 12 09:34:41 accessgroupinc kernel: md: hdc1 [events: 00000041](write) hdc1's sb offset: 10240128
Nov 12 09:34:41 accessgroupinc kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Nov 12 09:34:41 accessgroupinc kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
Nov 12 09:34:41 accessgroupinc kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Nov 12 09:34:41 accessgroupinc kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
Nov 12 09:34:41 accessgroupinc kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Nov 12 09:34:41 accessgroupinc kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
Nov 12 09:34:41 accessgroupinc kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Nov 12 09:34:41 accessgroupinc kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
Nov 12 09:34:41 accessgroupinc kernel: ide1: reset: success
Nov 12 09:34:41 accessgroupinc kernel: md: considering hdb2 ...
Nov 12 09:34:41 accessgroupinc kernel: md:  adding hdb2 ...
Nov 12 09:34:41 accessgroupinc kernel: md:  adding hdc2 ...
Nov 12 09:34:41 accessgroupinc kernel: md: created md2
Nov 12 09:34:41 accessgroupinc kernel: md: bind<hdc2,1>
Nov 12 09:34:41 accessgroupinc kernel: md: bind<hdb2,2>
Nov 12 09:34:41 accessgroupinc kernel: md: running: <hdb2><hdc2>
Nov 12 09:34:41 accessgroupinc kernel: md: hdb2's event counter: 00000040
Nov 12 09:34:41 accessgroupinc kernel: md: hdc2's event counter: 00000040
Nov 12 09:34:41 accessgroupinc kernel: RAID level 1 does not need chunksize! Continuing anyway.
Nov 12 09:34:41 accessgroupinc kernel: md2: max total readahead window set to 124k
Nov 12 09:34:41 accessgroupinc kernel: md2: 1 data-disks, max readahead per data-disk: 124k
Nov 12 09:34:41 accessgroupinc kernel: raid1: device hdb2 operational as mirror 0
Nov 12 09:34:41 accessgroupinc kernel: raid1: device hdc2 operational as mirror 1
Nov 12 09:34:41 accessgroupinc kernel: raid1: raid set md2 active with 2 out of 2 mirrors
Nov 12 09:34:41 accessgroupinc kernel: md: updating md2 RAID superblock on device
Nov 12 09:34:41 accessgroupinc kernel: md: hdb2 [events: 00000041](write) hdb2's sb offset: 1028096
Nov 12 09:34:41 accessgroupinc kernel: md: hdc2 [events: 00000041](write) hdc2's sb offset: 1024064
Nov 12 09:34:41 accessgroupinc kernel: md: considering hdb3 ...
Nov 12 09:34:41 accessgroupinc kernel: md:  adding hdb3 ...
Nov 12 09:34:41 accessgroupinc kernel: md:  adding hdc3 ...
Nov 12 09:34:41 accessgroupinc kernel: md: created md0
Nov 12 09:34:41 accessgroupinc kernel: md: bind<hdc3,1>
Nov 12 09:34:41 accessgroupinc kernel: md: bind<hdb3,2>
Nov 12 09:34:41 accessgroupinc kernel: md: running: <hdb3><hdc3>
Nov 12 09:34:41 accessgroupinc kernel: md: hdb3's event counter: 00000040
Nov 12 09:34:41 accessgroupinc mysqld: Starting MySQL:  succeeded
Nov 12 09:34:41 accessgroupinc kernel: md: hdc3's event counter: 00000040
Nov 12 09:34:41 accessgroupinc kernel: RAID level 1 does not need chunksize! Continuing anyway.
Nov 12 09:34:41 accessgroupinc kernel: md0: max total readahead window set to 124k
Nov 12 09:34:41 accessgroupinc kernel: md0: 1 data-disks, max readahead per data-disk: 124k
Nov 12 09:34:41 accessgroupinc kernel: raid1: device hdb3 operational as mirror 0
Nov 12 09:34:41 accessgroupinc kernel: raid1: device hdc3 operational as mirror 1
Nov 12 09:34:41 accessgroupinc kernel: raid1: raid set md0 active with 2 out of 2 mirrors
Nov 12 09:34:32 accessgroupinc rc.sysinit: Mounting proc filesystem:  succeeded 
Nov 12 09:34:41 accessgroupinc kernel: md: updating md0 RAID superblock on device
Nov 12 09:34:32 accessgroupinc rc.sysinit: Unmounting initrd:  succeeded 
Nov 12 09:34:41 accessgroupinc kernel: md: hdb3 [events: 00000041](write) hdb3's sb offset: 15366080
Nov 12 09:34:32 accessgroupinc sysctl: net.ipv4.ip_forward = 0 
Nov 12 09:34:41 accessgroupinc kernel: md: hdc3 [events: 00000041](write) hdc3's sb offset: 15360320
Nov 12 09:34:32 accessgroupinc sysctl: net.ipv4.conf.default.rp_filter = 1 
Nov 12 09:34:41 accessgroupinc kernel: md: ... autorun DONE.
Nov 12 09:34:32 accessgroupinc sysctl: kernel.sysrq = 0 
Nov 12 09:34:41 accessgroupinc kernel: kjournald starting.  Commit interval 5 seconds
Nov 12 09:34:32 accessgroupinc rc.sysinit: Configuring kernel parameters:  succeeded 
Nov 12 09:34:42 accessgroupinc kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 12 09:34:32 accessgroupinc date: Mon Nov 12 09:34:26 PST 2001 
Nov 12 09:34:42 accessgroupinc kernel: Freeing unused kernel memory: 224k freed
Nov 12 09:34:32 accessgroupinc rc.sysinit: Setting clock  (localtime): Mon Nov 12 09:34:26 PST 2001 succeeded 
Nov 12 09:34:42 accessgroupinc kernel: Adding Swap: 1024056k swap-space (priority -1)
Nov 12 09:34:32 accessgroupinc rc.sysinit: Loading default keymap succeeded 
Nov 12 09:34:42 accessgroupinc kernel: usb.c: registered new driver usbdevfs
Nov 12 09:34:32 accessgroupinc rc.sysinit: Setting default font (lat0-sun16):  succeeded 
Nov 12 09:34:42 accessgroupinc kernel: usb.c: registered new driver hub
Nov 12 09:34:32 accessgroupinc rc.sysinit: Activating swap partitions:  succeeded 
Nov 12 09:34:42 accessgroupinc kernel: PCI: Found IRQ 12 for device 00:01.2
Nov 12 09:34:32 accessgroupinc rc.sysinit: Setting hostname accessgroupinc.com:  succeeded 
Nov 12 09:34:43 accessgroupinc kernel: PCI: Sharing IRQ 12 with 00:01.3
Nov 12 09:34:32 accessgroupinc rc.sysinit: Mounting USB filesystem:  succeeded 
Nov 12 09:34:43 accessgroupinc kernel: PCI: Sharing IRQ 12 with 00:09.0
Nov 12 09:34:32 accessgroupinc rc.sysinit: Initializing USB controller (usb-ohci):  succeeded 
Nov 12 09:34:43 accessgroupinc kernel: usb-ohci.c: USB OHCI at membase 0xde8b5000, IRQ 12
Nov 12 09:34:32 accessgroupinc fsck: /dev/md1: clean, 57045/1281696 files, 248862/2560032 blocks 
Nov 12 09:34:43 accessgroupinc kernel: usb-ohci.c: usb-00:01.2, Silicon Integrated Systems [SiS] 7001
Nov 12 09:34:32 accessgroupinc rc.sysinit: Checking root filesystem succeeded 
Nov 12 09:34:43 accessgroupinc kernel: usb.c: new USB bus registered, assigned bus number 1
Nov 12 09:34:32 accessgroupinc rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
Nov 12 09:34:43 accessgroupinc kernel: hub.c: USB hub found
Nov 12 09:34:32 accessgroupinc hdparm:  setting unmaskirq to 1 (on) 
Nov 12 09:34:43 accessgroupinc kernel: hub.c: 3 ports detected
Nov 12 09:34:32 accessgroupinc hdparm:  setting xfermode to 69 (UltraDMA mode5) 
Nov 12 09:34:43 accessgroupinc kernel: PCI: Found IRQ 12 for device 00:01.3
Nov 12 09:34:32 accessgroupinc hdparm:  unmaskirq    =  1 (on) 
Nov 12 09:34:43 accessgroupinc kernel: PCI: Sharing IRQ 12 with 00:01.2
Nov 12 09:34:32 accessgroupinc rc.sysinit: Setting hard drive parameters for hdb:  succeeded 
Nov 12 09:34:43 accessgroupinc kernel: PCI: Sharing IRQ 12 with 00:09.0
Nov 12 09:34:32 accessgroupinc hdparm:  setting unmaskirq to 1 (on) 
Nov 12 09:34:44 accessgroupinc kernel: usb-ohci.c: USB OHCI at membase 0xde8b7000, IRQ 12
Nov 12 09:34:32 accessgroupinc hdparm:  setting xfermode to 69 (UltraDMA mode5) 
Nov 12 09:34:44 accessgroupinc kernel: usb-ohci.c: usb-00:01.3, Silicon Integrated Systems [SiS] 7001 (#2)
Nov 12 09:34:32 accessgroupinc hdparm:  unmaskirq    =  1 (on) 
Nov 12 09:34:44 accessgroupinc kernel: usb.c: new USB bus registered, assigned bus number 2
Nov 12 09:34:32 accessgroupinc rc.sysinit: Setting hard drive parameters for hdc:  succeeded 
Nov 12 09:34:44 accessgroupinc kernel: hub.c: USB hub found
Nov 12 09:34:32 accessgroupinc rc.sysinit: Finding module dependencies:  succeeded 
Nov 12 09:34:44 accessgroupinc kernel: hub.c: 3 ports detected
Nov 12 09:34:33 accessgroupinc fsck: /home: clean, 25/1921984 files, 68539/3840080 blocks 
Nov 12 09:34:44 accessgroupinc kernel: EXT3 FS 2.4-0.9.11, 3 Oct 2001 on md(9,1), internal journal
Nov 12 09:34:33 accessgroupinc fsck: /jerry: clean, 70/1697280 files, 830731/3391723 blocks 
Nov 12 09:34:44 accessgroupinc kernel: kjournald starting.  Commit interval 5 seconds
Nov 12 09:34:33 accessgroupinc fsck: /phil: clean, 1253/1700608 files, 357235/3396078 blocks 
Nov 12 09:34:44 accessgroupinc kernel: EXT3 FS 2.4-0.9.11, 3 Oct 2001 on md(9,0), internal journal
Nov 12 09:34:33 accessgroupinc rc.sysinit: Checking filesystems succeeded 
Nov 12 09:34:44 accessgroupinc kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 12 09:34:33 accessgroupinc rc.sysinit: Mounting local filesystems:  succeeded 
Nov 12 09:34:44 accessgroupinc kernel: kjournald starting.  Commit interval 5 seconds
Nov 12 09:34:33 accessgroupinc rc.sysinit: Enabling local filesystem quotas:  succeeded 
Nov 12 09:34:44 accessgroupinc kernel: EXT3 FS 2.4-0.9.11, 3 Oct 2001 on ide0(3,68), internal journal
Nov 12 09:34:34 accessgroupinc rc.sysinit: Enabling swap space:  succeeded 
Nov 12 09:34:44 accessgroupinc kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 12 09:34:35 accessgroupinc init: Entering runlevel: 3 
Nov 12 09:34:44 accessgroupinc kernel: kjournald starting.  Commit interval 5 seconds
Nov 12 09:34:36 accessgroupinc ipchains: Flushing all current rules and user defined chains: succeeded 
Nov 12 09:34:44 accessgroupinc kernel: EXT3 FS 2.4-0.9.11, 3 Oct 2001 on ide1(22,4), internal journal
Nov 12 09:34:36 accessgroupinc ipchains: Clearing all current rules and user defined chains: succeeded 
Nov 12 09:34:44 accessgroupinc kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 12 09:34:36 accessgroupinc ipchains: Applying ipchains firewall rules succeeded 
Nov 12 09:34:44 accessgroupinc kernel: ip_conntrack (3839 buckets, 30712 max)
Nov 12 09:34:36 accessgroupinc sysctl: net.ipv4.ip_forward = 0 
Nov 12 09:34:44 accessgroupinc kernel: 8139too Fast Ethernet driver 0.9.18a
Nov 12 09:34:36 accessgroupinc sysctl: net.ipv4.conf.default.rp_filter = 1 
Nov 12 09:34:44 accessgroupinc kernel: PCI: Found IRQ 12 for device 00:09.0
Nov 12 09:34:36 accessgroupinc sysctl: kernel.sysrq = 0 
Nov 12 09:34:44 accessgroupinc kernel: PCI: Sharing IRQ 12 with 00:01.2
Nov 12 09:34:36 accessgroupinc network: Setting network parameters:  succeeded 
Nov 12 09:34:44 accessgroupinc kernel: PCI: Sharing IRQ 12 with 00:01.3
Nov 12 09:34:36 accessgroupinc network: Bringing up interface lo:  succeeded 
Nov 12 09:34:44 accessgroupinc kernel: eth0: RealTek RTL8139 Fast Ethernet at 0xde8f3000, 00:e0:18:25:ef:4e, IRQ 12
Nov 12 09:34:39 accessgroupinc network: Bringing up interface eth0:  succeeded 
Nov 12 09:34:44 accessgroupinc kernel: eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
Nov 12 09:34:45 accessgroupinc httpd: httpd startup succeeded
Nov 12 09:34:46 accessgroupinc crond: crond startup succeeded

