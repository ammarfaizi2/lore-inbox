Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbTFYMOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 08:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263915AbTFYMOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 08:14:38 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:58125 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263749AbTFYMOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 08:14:30 -0400
Subject: 2.5.73-mm1: lots of oopses I can't decipher
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1056544113.705.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 25 Jun 2003 14:28:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at dmesg, I found the following oopses that I can't decipher. I
have been running VMWare 4.0 with a RHL 7.3 guest. Any ideas on what's
happening here? Should I enable additional kernel logging support and
then try again? Thanks!

0001549 00001549 c011cb61 0000155b 
       00001578 00000004 0000158a dff8c000 00001593 00000092 000015a5
000015b7 
       c0314588 00000046 00000009 dff8ddbc c011cdbd 00000020 00000400
c0268e85 
Call Trace:
 [<c011cb61>] call_console_drivers+0x5d/0x113
 [<c011cb61>] call_console_drivers+0x5d/0x113
 [<c012b932>] kernel_text_address+0x39/0x47
 [<c0109531>] show_trace+0x59/0x8c
 [<c0109531>] show_trace+0x59/0x8c
 [<c010960f>] show_stack+0x80/0x95
 [<c0119fde>] show_task+0x164/0x1c1
 [<c0118d40>] schedule+0x666/0x6a0
 [<c01eba98>] do_ide_request+0x1d/0x21
 [<c01e0cff>] generic_unplug_device+0x77/0x79
 [<c01e0e43>] blk_run_queues+0x79/0xae
 [<c0119d0f>] io_schedule+0xe/0x16
 [<c0135c1b>] __lock_page_wq+0xae/0xdb
 [<c011a781>] autoremove_wake_function+0x0/0x4f
 [<c011a781>] autoremove_wake_function+0x0/0x4f
 [<c0135987>] add_to_page_cache_lru+0x4a/0x4c
 [<c013731a>] read_cache_page+0x148/0x21a
 [<c01573d5>] blkdev_get_block+0x0/0x56
 [<c017eb1c>] read_dev_sector+0x3e/0xd7
 [<c0157528>] blkdev_readpage+0x0/0x15
 [<c017ef4b>] msdos_partition+0x4d/0x28e
 [<c017e4ef>] check_partition+0xce/0x13a
 [<c017e94c>] register_disk+0x100/0x191
 [<c01e3cd7>] add_disk+0x65/0x97
 [<c01e3c4c>] exact_match+0x0/0x8
 [<c01e3c54>] exact_lock+0x0/0x1e
 [<c01f8047>] idedisk_attach+0x11e/0x1b3
 [<c01f43e4>] ata_attach+0xdb/0x1a2
 [<c01f53bf>] ide_register_driver+0xfd/0x110
 [<c01f80eb>] idedisk_init+0xf/0x14
 [<c02fa6f1>] do_initcalls+0x27/0x92
 [<c012a96d>] init_workqueues+0xf/0x26
 [<c0105099>] init+0x32/0x1b5
 [<c0105067>] init+0x0/0x1b5
 [<c0107211>] kernel_thread_helper+0x5/0xb

 hda1 hda2 hda3
hdb: max request size: 128KiB
hdb: host protected area => 1
hdb: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63,
UDMA(100)
 hdb: hdb1 hdb2
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: (supports S0 S3 S4bios S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 96k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
PCI: Setting latency timer of device 00:1f.2 to 64
uhci-hcd 0000:00:1f.2: Intel Corp. 82801BA/BAM USB (Hub
uhci-hcd 0000:00:1f.2: irq 11, io base 0000d000
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is
deprecated.
uhci-hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PCI: Setting latency timer of device 00:1f.4 to 64
uhci-hcd 0000:00:1f.4: Intel Corp. 82801BA/BAM USB (Hub
uhci-hcd 0000:00:1f.4: irq 9, io base 0000d800
uhci-hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda2, internal journal
Adding 524280k swap on /swap.  Priority:-1 extents:390
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:0d.0: 3Com PCI 3c905C Tornado at 0xc000. Vers LK1.1.19
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Module nfsd cannot be unloaded due to unsafe usage in
include/linux/module.h:479
Module lockd cannot be unloaded due to unsafe usage in
include/linux/module.h:479
vmmon: no version magic, tainting kernel.
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
/dev/vmmon: Module vmmon: unloaded
vmnet: no version magic, tainting kernel.
vmnet: module license 'unspecified' taints kernel.
vmmon: no version magic, tainting kernel.
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
vmnet: no version magic, tainting kernel.
vmnet: module license 'unspecified' taints kernel.
/dev/vmnet: open called by PID 12015 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: up
bridge-eth0: attached
/dev/vmnet: open called by PID 12034 (vmnet-netifup)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 12033 (vmnet-natd)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmmon: Vmx86_ReleaseVM: unlocked pages: 0, unlocked dirty pages: 0
/dev/vmnet: open called by PID 12347 (vmware-vmx)
bridge-eth0: set IFF_PROMISC
eth0: Setting promiscuous mode.
/dev/vmnet: port on hub 0 successfully opened
hdc: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdc: cdrom_decode_status: error=0x40LastFailedSense 0x04 
hdc: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdc: cdrom_decode_status: error=0x40LastFailedSense 0x04 
hdc: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdc: cdrom_decode_status: error=0x40LastFailedSense 0x04 
hdc: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdc: cdrom_decode_status: error=0x40LastFailedSense 0x04 
hdc: DMA disabled
hdc: ide_intr: huh? expected NULL handler on exit
hdc: ATAPI reset complete
vmware-vmx    R current  12352  12347               12351 (NOTLB)
d29fff84 00003082 434e1000 000000fb dd94e780 0000b11d 00000000 00000000 
       00000000 d89e4cc0 cc02d7fc c3e4d380 d29fe000 db7b0f80 e08cd4c6
000000d0 
       db7b0f80 e08cd4c6 ffffffe7 c0161bf7 cb6e9dfc db7b0f80 000000d0
00000000 
Call Trace:
 [<e08cd4c6>] LinuxDriver_Ioctl+0x0/0x47c [vmmon]
 [<e08cd4c6>] LinuxDriver_Ioctl+0x0/0x47c [vmmon]
 [<c0161bf7>] sys_ioctl+0xfd/0x272
 [<c0109115>] sysenter_past_esp+0x52/0x71

process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
wine          R current   2530   2529                     (NOTLB)
00000282 c032250c d83b6000 c01f90df c0322460 dfe2d340 04000001 00000000 
       d83b7f54 c010a8b3 0000000f dfe25680 d83b7f54 d83b6000 0000000f
00000780 
       c02f5180 c010abea 0000000f d83b7f54 dfe2d340 dfe2d340 0000000a
c0318b80 
Call Trace:
 [<c01f90df>] cdrom_read_intr+0x0/0x371
 [<c010a8b3>] handle_IRQ_event+0x3a/0x64
 [<c010abea>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c011fddc>] do_softirq+0x40/0x94
 [<c010ac58>] do_IRQ+0x102/0x135
 [<c01092d4>] common_interrupt+0x18/0x20

wineserver    R current   2532      1          3371  2397 (NOTLB)
dfe25680 c032250c 00000001 c032007b d861007b ffffff00 c01ebf31 00000060 
       00000286 c032250c d861c000 c01f90df c0322460 dfe2d340 04000001
00000000 
       d861df58 c010a8b3 0000000f dfe25680 d861df58 d861c000 0000000f
00000780 
Call Trace:
 [<c01ebf31>] ide_intr+0x12d/0x17d
 [<c01f90df>] cdrom_read_intr+0x0/0x371
 [<c010a8b3>] handle_IRQ_event+0x3a/0x64
 [<c010abea>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c011fddc>] do_softirq+0x40/0x94
 [<c010ac58>] do_IRQ+0x102/0x135
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c01090c6>] sysenter_past_esp+0x3/0x71

kdeinit       R current   2368      1          2381  2365 (NOTLB)
00000000 db317eb8 db316000 00000000 00000000 c02f4a00 c010abea 00000000 
       db317eb8 c0298ea8 c0298ea8 db316000 00000282 dfe25680 c032250c
c01092d4 
       db316000 00052dad 00000005 00000282 dfe25680 c032250c 00000001
c032007b 
Call Trace:
 [<c010abea>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c01ebf31>] ide_intr+0x12d/0x17d
 [<c01f90df>] cdrom_read_intr+0x0/0x371
 [<c010a8b3>] handle_IRQ_event+0x3a/0x64
 [<c010abea>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c011fddc>] do_softirq+0x40/0x94
 [<c010ac58>] do_IRQ+0x102/0x135
 [<c01092d4>] common_interrupt+0x18/0x20

kjournald     R current    689      1          2094   688 (L-TLB)
c09211b0 c0921180 c0921fc0 c0921e10 c0921de0 c0921db0 c0921d80 c0921f90 
       c0921f60 c5dd5360 c5dd5390 c5dd53c0 df210000 00000000 00000000
dfdea280 
       c0195ec0 dfdea280 00000005 00000000 00000000 dfdea2c4 dfdea2d4
00000000 
Call Trace:
 [<c0195ec0>] kjournald+0x156/0x3d5
 [<c011a781>] autoremove_wake_function+0x0/0x4f
 [<c011a781>] autoremove_wake_function+0x0/0x4f
 [<c010903e>] ret_from_fork+0x6/0x14
 [<c0195d60>] commit_timeout+0x0/0x9
 [<c0195d6a>] kjournald+0x0/0x3d5
 [<c0107211>] kernel_thread_helper+0x5/0xb

kdeinit       R current   2389      1          2397  2387 (NOTLB)
00000000 d9813eb8 d9812000 00000000 00000000 c02f4a00 c010abea 00000000 
       d9813eb8 c0298ea8 c0298ea8 d9812000 00000282 dfe25680 c032250c
c01092d4 
       d9812000 00053dee 00000002 00000282 dfe25680 c032250c 00000001
c032007b 
Call Trace:
 [<c010abea>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c01ebf31>] ide_intr+0x12d/0x17d
 [<c01f90df>] cdrom_read_intr+0x0/0x371
 [<c010a8b3>] handle_IRQ_event+0x3a/0x64
 [<c010abea>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c011fddc>] do_softirq+0x40/0x94
 [<c010ac58>] do_IRQ+0x102/0x135
 [<c01092d4>] common_interrupt+0x18/0x20

Xvnc          R current   2257      1          2260  2236 (NOTLB)
0000000f dfe25680 dd9fdfc4 dd9fc000 0000000f 00000780 c02f5180 c010abea 
       0000000f dd9fdfc4 dfe2d340 dfe2d340 4127a800 082e4168 08520600
bffff4d8 
       c01092d4 4127a800 0000a18c 0000a18b 082e4168 08520600 bffff4d8
00000000 
Call Trace:
 [<c010abea>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20

klogd         R current   2098      1          2108  2094 (NOTLB)
dec70000 00000000 00000000 c02f4a00 c010abea 00000000 dec71f28 c0298ea8 
       c0298ea8 dec70000 00000286 dfe25680 c032250c c01092d4 dec70000
00053ec6 
       00000000 00000286 dfe25680 c032250c 00000001 bfff007b dec7007b
ffffff00 
Call Trace:
 [<c010abea>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c01ebf31>] ide_intr+0x12d/0x17d
 [<c01f90df>] cdrom_read_intr+0x0/0x371
 [<c010a8b3>] handle_IRQ_event+0x3a/0x64
 [<c010abea>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20

vmware-mks    R current  12348  12347         12349       (NOTLB)
d44d9ea0 c0118671 c40a2cc0 00000000 00000004 c0113283 dfe25c84 00000000 
       00000001 00000000 d44d9f28 c0123b80 00000000 00000001 00000001
00000000 
       d44d9f28 20000001 c0123dab 00000000 d44d9f28 c010e694 d44d9f28
c0298ea8 
Call Trace:
 [<c0118671>] scheduler_tick+0x32a/0x38e
 [<c0113283>] mark_offset_tsc+0x223/0x2b3
 [<c0123b80>] update_process_times+0x46/0x52
 [<c0123dab>] do_timer+0x34/0xe4
 [<c010e694>] timer_interrupt+0x2c/0x115
 [<c010a8b3>] handle_IRQ_event+0x3a/0x64
 [<c010abea>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c01ebf31>] ide_intr+0x12d/0x17d
 [<c01f90df>] cdrom_read_intr+0x0/0x371
 [<c010a8b3>] handle_IRQ_event+0x3a/0x64
 [<c010abea>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20

vmware-vmx    R current  12351  12347         12352 12350 (NOTLB)
d4e5be74 00000008 c01501bf d4e5be98 0828a19c 00000008 00000000 00000000 
       00003246 d5eb4080 00000000 00000001 ffffffff c3d98b00 c3e4d2ac
00000000 
       c0123f8c d4e5bec8 08000000 d5eb4cc0 00000000 00000000 00000000
00000000 
Call Trace:
 [<c01501bf>] do_sync_read+0xb6/0xe3
 [<c0123f8c>] schedule_timeout+0x69/0xb3
 [<c0162319>] poll_freewait+0x38/0x40
 [<c013838a>] generic_file_writev+0x3f/0xab
 [<c0150929>] do_readv_writev+0x22d/0x2b6
 [<c0150305>] do_sync_write+0x0/0xe3
 [<c01629d8>] sys_select+0x225/0x4aa
 [<c01502b5>] vfs_read+0xc9/0x119
 [<c0150a61>] vfs_writev+0x53/0x5c
 [<c0150b0f>] sys_writev+0x42/0x63
 [<c0109115>] sysenter_past_esp+0x52/0x71

kswapd0       R current      7      1             8     6 (L-TLB)
0000000f 00000780 c02f5180 c010abea 0000000f dfe05e18 dfe2d340 dfe2d340 
       dfe04000 dfe05e8c dfe05e50 c0321660 c01092d4 dfe04000 c02ccac0
dfe05e98 
       dfe05e8c dfe05e50 c0321660 ffffe000 c029007b c013007b ffffff0f
c01e0e56 
Call Trace:
 [<c010abea>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c013007b>] simplify_symbols+0xb3/0xf9
 [<c01e0e56>] blk_run_queues+0x8c/0xae
 [<c01e186c>] blk_congestion_wait_wq+0x6f/0xae
 [<c011a781>] autoremove_wake_function+0x0/0x4f
 [<c011a781>] autoremove_wake_function+0x0/0x4f
 [<c01e18ca>] blk_congestion_wait+0x1f/0x23
 [<c014041f>] balance_pgdat+0x8b/0x191
 [<c0140637>] kswapd+0x112/0x122
 [<c011a781>] autoremove_wake_function+0x0/0x4f
 [<c010903e>] ret_from_fork+0x6/0x14
 [<c011a781>] autoremove_wake_function+0x0/0x4f
 [<c0140525>] kswapd+0x0/0x122
 [<c0107211>] kernel_thread_helper+0x5/0xb

kdeinit       R current   2387      1          2389  2384 (NOTLB)
00000000 d9db3eb8 d9db2000 00000000 00000000 c02f4a00 c010abea 00000000 
       d9db3eb8 c0298ea8 c0298ea8 d9db2000 00200282 dfe25680 c032250c
c01092d4 
       d9db2000 000570c3 00000001 00200282 dfe25680 c032250c 00000001
c032007b 
Call Trace:
 [<c010abea>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c01ebf31>] ide_intr+0x12d/0x17d
 [<c01f90df>] cdrom_read_intr+0x0/0x371
 [<c010a8b3>] handle_IRQ_event+0x3a/0x64
 [<c010abea>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c011fddc>] do_softirq+0x40/0x94
 [<c010ac58>] do_IRQ+0x102/0x135
 [<c01092d4>] common_interrupt+0x18/0x20

vmware-vmx    R current  12347  12341 12348               (NOTLB)
00000060 00003282 c0139a1d c029abac 00000000 00000000 00000000 00000000 
       00003246 d5eb4cc0 00003246 c0318e00 0005714c d9545ec8 0000001a
0000001a 
       c0123f82 d9545ec8 00800000 00000017 c0319068 e08d4130 0005714c
4b87ad6e 
Call Trace:
 [<c0139a1d>] __alloc_pages+0x8a/0x2f5
 [<c0123f82>] schedule_timeout+0x5f/0xb3
 [<e08d4130>] linuxState+0x490/0x4c0 [vmmon]
 [<c0123f1a>] process_timeout+0x0/0x9
 [<c0162654>] do_select+0x18e/0x2c8
 [<c0162321>] __pollwait+0x0/0xc6
 [<c0162a63>] sys_select+0x2b0/0x4aa
 [<c01502d4>] vfs_read+0xe8/0x119
 [<c0109115>] sysenter_past_esp+0x52/0x71

bridge-eth0: clear IFF_PROMISC
/dev/vmmon: Vmx86_ReleaseVM: unlocked pages: 90494, unlocked dirty
pages: 78600
/dev/vmnet: open called by PID 12347 (vmware-vmx)
bridge-eth0: set IFF_PROMISC
eth0: Setting promiscuous mode.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: clear IFF_PROMISC
/dev/vmmon: Vmx86_ReleaseVM: unlocked pages: 21978, unlocked dirty
pages: 6166

