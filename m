Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTJRRSx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 13:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTJRRSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 13:18:53 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:63616
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S261311AbTJRRSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:18:46 -0400
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: PPC: slab error in cache_free_debugcheck() from sd_revalidate_disk
Message-Id: <E1AAuj6-0000ty-00@penngrove.fdns.net>
Date: Sat, 18 Oct 2003 10:18:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached log is from 'test7-bk3', it also happens for 'test7-bk7'.  It
seems to happen for each disk that's attached, and appears to be benign.

Alas, the framebuffer console won't sync on 2.6.0 yet and so i don't know
if this fails in the same way for 'test8', as it get far enough to allow
'ssh' to work.

Hardware: PowerMac 8500 (see attached 'lspci' and 'dmesg' for details), 
	  ADB keyboard/mouse, USB mouse, Sony 100ES monitor
Software: Debian 'Testing' branch

Sorry, this may not be a very helpful bug report.  Let me know what additional
information might be helpful and perhaps i can rig up a serial console for
this beast.
				      -- JM

(Please CC: for faster responses -  reading mailing list intermitting via
web interface as on TOO MANY mailing lists already.)


Attachments: 'dmesg' from booting '2.6.0-test7-bk3'
	     'lspci'
-------------------------------------------------------------------------------
Oct 14 15:47:34 penngrove kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
Oct 14 15:47:34 penngrove kernel: Cannot find map file.
Oct 14 15:47:34 penngrove kernel: No module symbols loaded - kernel modules not enabled. 
Oct 14 15:47:34 penngrove kernel: Total memory = 224MB; using 512kB for hash table (at c0280000)
Oct 14 15:47:34 penngrove kernel: Linux version 2.6.0-test7-bk3 (kd6pag@qsl.net.net) (gcc version 3.3.2 20030908 (Debian prerelease)) #2 Tue Oct 14 13:51:11 PDT 2003
Oct 14 15:47:34 penngrove kernel: Found a Grand Central mac-io controller, rev: 2, mapped at 0xfde39000
Oct 14 15:47:34 penngrove kernel: PowerMac motherboard: PowerMac 8500/8600
Oct 14 15:47:34 penngrove kernel: Cache coherency enabled for bandit/PSX
Oct 14 15:47:34 penngrove kernel: Found Bandit PCI host bridge at 0xf2000000. Firmware bus number: 0->0
Oct 14 15:47:34 penngrove kernel: Found Chaos PCI host bridge at 0xf0000000. Firmware bus number: 1->1
Oct 14 15:47:34 penngrove kernel: On node 0 totalpages: 57344
Oct 14 15:47:34 penngrove kernel:   DMA zone: 57344 pages, LIFO batch:14
Oct 14 15:47:34 penngrove kernel:   Normal zone: 0 pages, LIFO batch:1
Oct 14 15:47:34 penngrove kernel:   HighMem zone: 0 pages, LIFO batch:1
Oct 14 15:47:34 penngrove kernel: Building zonelist for node : 0
Oct 14 15:47:34 penngrove kernel: Kernel command line: root=/dev/md0 md=0,/dev/sda7,/dev/sdb7,/dev/sdc7 md=1,/dev/sda8,/dev/sdb8,/dev/sdc8  sing           
Oct 14 15:47:34 penngrove kernel: md: Will configure md0 (super-block) from /dev/sda7,/dev/sdb7,/dev/sdc7, below.
Oct 14 15:47:34 penngrove kernel: md: Will configure md1 (super-block) from /dev/sda8,/dev/sdb8,/dev/sdc8, below.
Oct 14 15:47:34 penngrove kernel: System has 32 possible interrupts
Oct 14 15:47:34 penngrove kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Oct 14 15:47:34 penngrove kernel: GMT Delta read from XPRAM: -420 minutes, DST: on
Oct 14 15:47:34 penngrove kernel: via_calibrate_decr: ticks per jiffy = 124987 (749925 ticks)
Oct 14 15:47:34 penngrove kernel: Console: colour dummy device 80x25
Oct 14 15:47:34 penngrove kernel: Memory: 223664k available (1444k kernel code, 976k data, 132k init, 0k highmem)
Oct 14 15:47:34 penngrove kernel: Calibrating delay loop... 799.53 BogoMIPS
Oct 14 15:47:34 penngrove kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Oct 14 15:47:34 penngrove kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Oct 14 15:47:34 penngrove kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Oct 14 15:47:34 penngrove kernel: POSIX conformance testing by UNIFIX
Oct 14 15:47:34 penngrove kernel: NET: Registered protocol family 16
Oct 14 15:47:34 penngrove kernel: PCI: Probing PCI hardware
Oct 14 15:47:34 penngrove kernel: Registering pmac pic with sysfs...
Oct 14 15:47:34 penngrove kernel: SCSI subsystem initialized
Oct 14 15:47:34 penngrove kernel: drivers/usb/core/usb.c: registered new driver usbfs
Oct 14 15:47:34 penngrove kernel: drivers/usb/core/usb.c: registered new driver hub
Oct 14 15:47:34 penngrove kernel: controlfb: VRAM Total = 4MB (2MB @ bank 1, 2MB @ bank 2)
Oct 14 15:47:34 penngrove kernel: controlfb: using video mode 16 and color mode 0.
Oct 14 15:47:34 penngrove kernel: fb0: control display adapter
Oct 14 15:47:34 penngrove kernel: MacOS display is /chaos/control
Oct 14 15:47:34 penngrove kernel: Thermal assist unit using timers, shrink_timer: 200 jiffies
Oct 14 15:47:34 penngrove kernel: ikconfig 0.7 with /proc/config*
Oct 14 15:47:34 penngrove kernel: pty: 256 Unix98 ptys configured
Oct 14 15:47:34 penngrove kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Oct 14 15:47:34 penngrove kernel: eth0: MACE at 00:05:02:f0:28:54, chip revision 25.64
Oct 14 15:47:34 penngrove kernel: MacIO PCI driver attached to Grand Central chipset
Oct 14 15:47:34 penngrove kernel: PowerMac Z8530 serial driver version 2.0
Oct 14 15:47:34 penngrove kernel: tty00 at 0xcf8cf020 (irq = 15) is a Z8530 ESCC, port = modem
Oct 14 15:47:34 penngrove kernel: tty01 at 0xcf8d6000 (irq = 16) is a Z8530 ESCC, port = printer
Oct 14 15:47:34 penngrove kernel: Macintosh non-volatile memory driver v1.0
Oct 14 15:47:34 penngrove kernel: input: Macintosh mouse button emulation
Oct 14 15:47:34 penngrove kernel: Macintosh CUDA driver v0.5 for Unified ADB.
Oct 14 15:47:34 penngrove kernel: mesh: configured for synchronous 5 MB/s
Oct 14 15:47:34 penngrove kernel: adb: starting probe task...
Oct 14 15:47:34 penngrove kernel: adb devices: [2]: 2 2 [3]: 3 1 [15]: 3 1
Oct 14 15:47:34 penngrove kernel: ADB keyboard at 2, handler set to 3
Oct 14 15:47:34 penngrove kernel: Detected ADB keyboard, type ANSI.
Oct 14 15:47:34 penngrove kernel: input: ADB keyboard on adb2:2.02/input
Oct 14 15:47:34 penngrove kernel: ADB mouse at 3, handler set to 2
Oct 14 15:47:34 penngrove kernel: input: ADB mouse on adb3:3.01/input
Oct 14 15:47:34 penngrove kernel: ADB mouse at 15, handler 1
Oct 14 15:47:34 penngrove kernel: input: ADB mouse on adb15:3.01/input
Oct 14 15:47:34 penngrove kernel: adb: finished probe task...
Oct 14 15:47:34 penngrove kernel: mesh: performing initial bus reset...
Oct 14 15:47:34 penngrove kernel: scsi0 : MESH
Oct 14 15:47:34 penngrove kernel: Using anticipatory io scheduler
Oct 14 15:47:34 penngrove kernel: mesh: target 2 synchronous at 5.0 MB/s
Oct 14 15:47:34 penngrove kernel:   Vendor: IBM       Model: DORS-32160    !#  Rev: WA1A
Oct 14 15:47:34 penngrove kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Oct 14 15:47:34 penngrove kernel: mesh: target 3 synchronous at 5.0 MB/s
Oct 14 15:47:34 penngrove kernel:   Vendor: MATSHITA  Model: CD-ROM CR-8005A   Rev: 4.0i
Oct 14 15:47:34 penngrove kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Oct 14 15:47:34 penngrove kernel: mesh: target 4 synchronous at 5.0 MB/s
Oct 14 15:47:34 penngrove kernel:   Vendor: TANDEM    Model: 4265-1            Rev: 1717
Oct 14 15:47:34 penngrove kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Oct 14 15:47:34 penngrove kernel: mesh: target 5 synchronous at 5.0 MB/s
Oct 14 15:47:34 penngrove kernel:   Vendor: SEAGATE   Model: ST15150N          Rev: 4611
Oct 14 15:47:34 penngrove kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Oct 14 15:47:34 penngrove kernel: SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)
Oct 14 15:47:34 penngrove kernel: SCSI device sda: drive cache: write back
Oct 14 15:47:34 penngrove kernel: slab error in cache_free_debugcheck(): cache `size-512(DMA)': double free, or memory outside object was overwritten
Oct 14 15:47:34 penngrove kernel: Call trace:
Oct 14 15:47:34 penngrove kernel:  [c000b1ec] dump_stack+0x18/0x28
Oct 14 15:47:34 penngrove kernel:  [c003db40] __slab_error+0x2c/0x3c
Oct 14 15:47:34 penngrove kernel:  [c00403d4] kfree+0x290/0x384
Oct 14 15:47:34 penngrove kernel:  [c00e70f0] sd_revalidate_disk+0xb8/0x148
Oct 14 15:47:34 penngrove kernel:  [c00e7334] sd_probe+0x1b4/0x2a0
Oct 14 15:47:34 penngrove kernel:  [c00bf090] bus_match+0x50/0x8c
Oct 14 15:47:34 penngrove kernel:  [c00bf210] driver_attach+0x88/0xc8
Oct 14 15:47:34 penngrove kernel:  [c00bf560] bus_add_driver+0x90/0xe0
Oct 14 15:47:34 penngrove kernel:  [c00bf9c0] driver_register+0x30/0x40
Oct 14 15:47:34 penngrove kernel:  [c00e188c] scsi_register_driver+0x1c/0x2c
Oct 14 15:47:34 penngrove kernel:  [c022e2cc] init_sd+0x5c/0x70
Oct 14 15:47:34 penngrove kernel:  [c02185dc] do_initcalls+0x54/0xe0
Oct 14 15:47:34 penngrove kernel:  [c0003958] init+0x1c/0xc0
Oct 14 15:47:34 penngrove kernel:  [c000a970] kernel_thread+0x44/0x60
Oct 14 15:47:34 penngrove kernel: cddeec88: redzone 1: 0x0, redzone 2: 0x170fc2a5.
Oct 14 15:47:34 penngrove kernel:  sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12
Oct 14 15:47:34 penngrove kernel: Attached scsi disk sda at scsi0, channel 0, id 2, lun 0
Oct 14 15:47:34 penngrove kernel: SCSI device sdb: 8888544 512-byte hdwr sectors (4551 MB)
Oct 14 15:47:34 penngrove kernel: SCSI device sdb: drive cache: write through
Oct 14 15:47:34 penngrove kernel: slab error in cache_free_debugcheck(): cache `size-512(DMA)': double free, or memory outside object was overwritten
Oct 14 15:47:34 penngrove kernel: Call trace:
Oct 14 15:47:34 penngrove kernel:  [c000b1ec] dump_stack+0x18/0x28
Oct 14 15:47:34 penngrove kernel:  [c003db40] __slab_error+0x2c/0x3c
Oct 14 15:47:34 penngrove kernel:  [c00403d4] kfree+0x290/0x384
Oct 14 15:47:34 penngrove kernel:  [c00e70f0] sd_revalidate_disk+0xb8/0x148
Oct 14 15:47:34 penngrove kernel:  [c00e7334] sd_probe+0x1b4/0x2a0
Oct 14 15:47:34 penngrove kernel:  [c00bf090] bus_match+0x50/0x8c
Oct 14 15:47:34 penngrove kernel:  [c00bf210] driver_attach+0x88/0xc8
Oct 14 15:47:34 penngrove kernel:  [c00bf560] bus_add_driver+0x90/0xe0
Oct 14 15:47:34 penngrove kernel:  [c00bf9c0] driver_register+0x30/0x40
Oct 14 15:47:34 penngrove kernel:  [c00e188c] scsi_register_driver+0x1c/0x2c
Oct 14 15:47:34 penngrove kernel:  [c022e2cc] init_sd+0x5c/0x70
Oct 14 15:47:34 penngrove kernel:  [c02185dc] do_initcalls+0x54/0xe0
Oct 14 15:47:34 penngrove kernel:  [c0003958] init+0x1c/0xc0
Oct 14 15:47:34 penngrove kernel:  [c000a970] kernel_thread+0x44/0x60
Oct 14 15:47:34 penngrove kernel: cddeec88: redzone 1: 0x0, redzone 2: 0x170fc2a5.
Oct 14 15:47:34 penngrove kernel:  sdb: [mac] sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7 sdb8 sdb9 sdb10
Oct 14 15:47:34 penngrove kernel: Attached scsi disk sdb at scsi0, channel 0, id 4, lun 0
Oct 14 15:47:34 penngrove kernel: SCSI device sdc: 8388315 512-byte hdwr sectors (4295 MB)
Oct 14 15:47:34 penngrove kernel: SCSI device sdc: drive cache: write back
Oct 14 15:47:34 penngrove kernel: slab error in cache_free_debugcheck(): cache `size-512(DMA)': double free, or memory outside object was overwritten
Oct 14 15:47:34 penngrove kernel: Call trace:
Oct 14 15:47:34 penngrove kernel:  [c000b1ec] dump_stack+0x18/0x28
Oct 14 15:47:34 penngrove kernel:  [c003db40] __slab_error+0x2c/0x3c
Oct 14 15:47:34 penngrove kernel:  [c00403d4] kfree+0x290/0x384
Oct 14 15:47:34 penngrove kernel:  [c00e70f0] sd_revalidate_disk+0xb8/0x148
Oct 14 15:47:34 penngrove kernel:  [c00e7334] sd_probe+0x1b4/0x2a0
Oct 14 15:47:34 penngrove kernel:  [c00bf090] bus_match+0x50/0x8c
Oct 14 15:47:34 penngrove kernel:  [c00bf210] driver_attach+0x88/0xc8
Oct 14 15:47:34 penngrove kernel:  [c00bf560] bus_add_driver+0x90/0xe0
Oct 14 15:47:34 penngrove kernel:  [c00bf9c0] driver_register+0x30/0x40
Oct 14 15:47:34 penngrove kernel:  [c00e188c] scsi_register_driver+0x1c/0x2c
Oct 14 15:47:34 penngrove kernel:  [c022e2cc] init_sd+0x5c/0x70
Oct 14 15:47:34 penngrove kernel:  [c02185dc] do_initcalls+0x54/0xe0
Oct 14 15:47:34 penngrove kernel:  [c0003958] init+0x1c/0xc0
Oct 14 15:47:34 penngrove kernel:  [c000a970] kernel_thread+0x44/0x60
Oct 14 15:47:34 penngrove kernel: cddeec88: redzone 1: 0x0, redzone 2: 0x170fc2a5.
Oct 14 15:47:34 penngrove kernel:  sdc: [mac] sdc1 sdc2 sdc3 sdc4 sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 sdc11 sdc12 sdc13 sdc14 sdc15
Oct 14 15:47:34 penngrove kernel: Attached scsi disk sdc at scsi0, channel 0, id 5, lun 0
Oct 14 15:47:34 penngrove kernel: mice: PS/2 mouse device common for all mice
Oct 14 15:47:34 penngrove kernel: md: raid5 personality registered as nr 4
Oct 14 15:47:34 penngrove kernel: raid5: measuring checksumming speed
Oct 14 15:47:34 penngrove kernel:    8regs     :   483.200 MB/sec
Oct 14 15:47:34 penngrove kernel:    8regs_prefetch:   392.000 MB/sec
Oct 14 15:47:34 penngrove kernel:    32regs    :   479.600 MB/sec
Oct 14 15:47:34 penngrove kernel:    32regs_prefetch:   402.400 MB/sec
Oct 14 15:47:34 penngrove kernel: raid5: using function: 8regs (483.200 MB/sec)
Oct 14 15:47:34 penngrove kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Oct 14 15:47:34 penngrove kernel: NET: Registered protocol family 2
Oct 14 15:47:34 penngrove kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Oct 14 15:47:34 penngrove kernel: TCP: Hash tables configured (established 16384 bind 32768)
Oct 14 15:47:34 penngrove kernel: NET: Registered protocol family 1
Oct 14 15:47:34 penngrove kernel: NET: Registered protocol family 17
Oct 14 15:47:34 penngrove kernel: md: Autodetecting RAID arrays.
Oct 14 15:47:34 penngrove kernel: md: autorun ...
Oct 14 15:47:34 penngrove kernel: md: ... autorun DONE.
Oct 14 15:47:34 penngrove kernel: md: Loading md0: /dev/sda7
Oct 14 15:47:34 penngrove kernel: md: bind<sda7>
Oct 14 15:47:34 penngrove kernel: md: bind<sdb7>
Oct 14 15:47:34 penngrove kernel: md: bind<sdc7>
Oct 14 15:47:34 penngrove kernel: raid5: device sdc7 operational as raid disk 2
Oct 14 15:47:34 penngrove kernel: raid5: device sdb7 operational as raid disk 1
Oct 14 15:47:34 penngrove kernel: raid5: device sda7 operational as raid disk 0
Oct 14 15:47:34 penngrove kernel: raid5: allocated 3146kB for md0
Oct 14 15:47:34 penngrove kernel: raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
Oct 14 15:47:34 penngrove kernel: RAID5 conf printout:
Oct 14 15:47:34 penngrove kernel:  --- rd:3 wd:3 fd:0
Oct 14 15:47:34 penngrove kernel:  disk 0, o:1, dev:sda7
Oct 14 15:47:34 penngrove kernel:  disk 1, o:1, dev:sdb7
Oct 14 15:47:34 penngrove kernel:  disk 2, o:1, dev:sdc7
Oct 14 15:47:34 penngrove kernel: md: Loading md1: /dev/sda8
Oct 14 15:47:34 penngrove kernel: md: bind<sda8>
Oct 14 15:47:34 penngrove kernel: md: bind<sdb8>
Oct 14 15:47:34 penngrove kernel: md: bind<sdc8>
Oct 14 15:47:34 penngrove kernel: raid5: device sdc8 operational as raid disk 2
Oct 14 15:47:34 penngrove kernel: raid5: device sdb8 operational as raid disk 1
Oct 14 15:47:34 penngrove kernel: raid5: device sda8 operational as raid disk 0
Oct 14 15:47:34 penngrove kernel: raid5: allocated 3146kB for md1
Oct 14 15:47:34 penngrove kernel: raid5: raid level 5 set md1 active with 3 out of 3 devices, algorithm 2
Oct 14 15:47:34 penngrove kernel: RAID5 conf printout:
Oct 14 15:47:34 penngrove kernel:  --- rd:3 wd:3 fd:0
Oct 14 15:47:34 penngrove kernel:  disk 0, o:1, dev:sda8
Oct 14 15:47:34 penngrove kernel:  disk 1, o:1, dev:sdb8
Oct 14 15:47:34 penngrove kernel:  disk 2, o:1, dev:sdc8
Oct 14 15:47:34 penngrove kernel: VFS: Mounted root (ext2 filesystem) readonly.
Oct 14 15:47:34 penngrove kernel: Freeing unused kernel memory: 132k init 4k chrp 8k prep
Oct 14 15:47:34 penngrove kernel: Adding 223992k swap on /dev/sdc14.  Priority:-1 extents:1
Oct 14 15:47:34 penngrove kernel: Adding 88304k swap on /dev/sdc15.  Priority:-2 extents:1
Oct 14 15:53:51 penngrove kernel: Kernel logging (proc) stopped.
-------------------------------------------------------------------------------
00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
00:0d.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 10/100 model NC100 (rev 11)
00:0e.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01)    [NOT IN USE]
00:0f.0 USB Controller: OPTi Inc. 82C861 (rev 10)
00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
01:0b.0 Non-VGA unclassified device: Apple Computer Inc. Control Video
01:0d.0 Class ff00: Apple Computer Inc. PlanB Video-In (rev 01)
===============================================================================
