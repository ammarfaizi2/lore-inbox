Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUF3EKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUF3EKh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 00:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUF3EKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 00:10:37 -0400
Received: from 213-216-236-180-Karjasilta-TR10.suomi.net ([213.216.236.180]:61575
	"EHLO xxx.xxx") by vger.kernel.org with ESMTP id S266341AbUF3EKM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 00:10:12 -0400
Date: Wed, 30 Jun 2004 07:10:11 +0300 (EEST)
From: janne <sniff@xxx.ath.cx>
X-X-Sender: sniff@xxx.xxx
To: linux-kernel@vger.kernel.org
Subject: linux 2.6.6, bttv and usb2 data corruption
Message-ID: <Pine.LNX.4.40.0406300638120.20979-100000@xxx.xxx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me on replys.

Hardware:
 Athlon XP 1600+
 Epox 8KHA+ VIA KT266A
 BT878 TV-card (bttv card=36, tuner type=1)
 Edimax Via6302 4port PCI Usb2 controller (ehci-hcd)
 Lacie P3 250GB Usb2 hard drive (usb-storage, reiserfs)
 Edimax Gigabit Ethernet (r8169)


I recently updated my machine with pci usb2 controller and usb2 hard
drive. I have been running the same machine on 2.4 kernels for a long
time and it has never had stability issues.

I decided to upgrade to kernel version 2.6.6 since i couldn't get
usb2 controller to work in 2.4.26, and also realtek gigabit ethernet
driver in 2.4.26 causes hangs.

Soon after i updated i noticed problems whenever bttv, usb2 hard drive
and nfs/GigE were used together at high loads. First of all, usb2
throughput was disappointing, i only got about 8MB/s while the
manufacturer claims sustained datarate of 35MB/s.
I tried to stresstest the drivers by launching TvTime (which uses bttv),
listening to mp3s, and at the same time transferring data to and from
usb2 hdd and nfs partitions on another machine.

Problems while transferring data from usb2 hdd:

- TV picture has weird artifacts
- Constant clicks and snaps from mp3 player
- NFS will hang for about 10sec every now and then
- And finally after a few minutes the machine either hangs completely
  or the usb-storage and ehci drivers freeze and the usb2 hdd isn't
  accessible before the machine is rebooted.

The other machine i have is kt600 athlonxp with just ide hard drives
and the gigabit ethernet nic, it is also running kernel 2.6.6 and
it has been completely stable so far.


Here's a clip from syslog:

Jun 30 04:09:36 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
Jun 30 04:11:30 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
Jun 30 04:13:14 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
Jun 30 04:13:38 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
Jun 30 04:14:32 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
Jun 30 04:15:23 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
Jun 30 04:16:49 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
Jun 30 04:17:04 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
Jun 30 04:17:05 ebola kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
Jun 30 04:17:05 ebola kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 30 04:17:05 ebola kernel: end_request: I/O error, dev sda, sector 283278791
Jun 30 04:17:05 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:05 ebola last message repeated 2 times
Jun 30 04:17:05 ebola kernel: Buffer I/O error on device sda1, logical block 22417398
Jun 30 04:17:05 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:05 ebola kernel: Buffer I/O error on device sda1, logical block 2492
Jun 30 04:17:05 ebola kernel: lost page write due to I/O error on sda1
Jun 30 04:17:05 ebola kernel: Buffer I/O error on device sda1, logical block 2493
Jun 30 04:17:05 ebola kernel: lost page write due to I/O error on sda1
Jun 30 04:17:06 ebola kernel: Buffer I/O error on device sda1, logical block 2494
Jun 30 04:17:06 ebola kernel: lost page write due to I/O error on sda1
Jun 30 04:17:06 ebola kernel: Buffer I/O error on device sda1, logical block 2495
Jun 30 04:17:06 ebola kernel: lost page write due to I/O error on sda1
Jun 30 04:17:06 ebola kernel: Buffer I/O error on device sda1, logical block 2496
Jun 30 04:17:06 ebola kernel: lost page write due to I/O error on sda1
Jun 30 04:17:06 ebola kernel: Buffer I/O error on device sda1, logical block 2497
Jun 30 04:17:06 ebola kernel: lost page write due to I/O error on sda1
Jun 30 04:17:06 ebola kernel: Buffer I/O error on device sda1, logical block 2498
Jun 30 04:17:06 ebola kernel: lost page write due to I/O error on sda1
Jun 30 04:17:06 ebola kernel: journal-601, buffer write failed
Jun 30 04:17:06 ebola kernel: ------------[ cut here ]------------
Jun 30 04:17:06 ebola kernel: kernel BUG at fs/reiserfs/prints.c:338!
Jun 30 04:17:06 ebola kernel: invalid operand: 0000 [#1]
Jun 30 04:17:06 ebola kernel: PREEMPT
Jun 30 04:17:06 ebola kernel: CPU:    0
Jun 30 04:17:06 ebola kernel: EIP:    0060:[__crc_poll_freewait+1357058/3378185]    Tainted: P
Jun 30 04:17:06 ebola kernel: EFLAGS: 00010286   (2.6.6-2-k7)
Jun 30 04:17:06 ebola kernel: EIP is at reiserfs_panic+0x33/0x70 [reiserfs]
Jun 30 04:17:06 ebola kernel: eax: 00000024   ebx: f3ef8e00   ecx: 00000001   edx: c02af378
Jun 30 04:17:06 ebola kernel: esi: f0c8f310   edi: 00000000   ebp: f3ef8e00   esp: c3411d58
Jun 30 04:17:06 ebola kernel: ds: 007b   es: 007b   ss: 0068
Jun 30 04:17:06 ebola kernel: Process pdflush (pid: 11287, threadinfo=c3410000 task=ee52fa30)
Jun 30 04:17:06 ebola kernel: Stack: f8bff124 f8c073a0 f0c8f310 00000000 f8bf2722 f3ef8e00 f8bfd0c0 00000000
Jun 30 04:17:06 ebola kernel:        00001000 f1ebd000 f8b94068 f0c8f328 dd5e36e8 f3ef8e00 00000000 f0c8f310
Jun 30 04:17:06 ebola kernel:        f8b940e4 f8bf7359 f3ef8e00 f0c8f310 00000001 00001000 f0c8f310 c3410000
Jun 30 04:17:06 ebola kernel: Call Trace:
Jun 30 04:17:06 ebola kernel:  [__crc_poll_freewait+1406817/3378185] flush_commit_list+0x282/0x3f0 [reiserfs]
Jun 30 04:17:06 ebola kernel:  [__crc_poll_freewait+1426328/3378185] do_journal_end+0x829/0xb70 [reiserfs]
Jun 30 04:17:06 ebola kernel:  [__crc_poll_freewait+1421724/3378185] journal_end_sync+0x4d/0x90 [reiserfs]
Jun 30 04:17:06 ebola kernel:  [__crc_poll_freewait+1343963/3378185] reiserfs_sync_fs+0x5c/0xb0 [reiserfs]
Jun 30 04:17:06 ebola kernel:  [__down_failed_trylock+7/12]__down_failed_trylock+0x7/0xc
Jun 30 04:17:06 ebola kernel:  [sync_supers+172/192] sync_supers+0xac/0xc0
Jun 30 04:17:06 ebola kernel:  [wb_kupdate+54/288] wb_kupdate+0x36/0x120
Jun 30 04:17:06 ebola kernel:  [schedule+812/1440] schedule+0x32c/0x5a0
Jun 30 04:17:06 ebola kernel:  [__pdflush+202/448] __pdflush+0xca/0x1c0
Jun 30 04:17:06 ebola kernel:  [pdflush+0/48] pdflush+0x0/0x30
Jun 30 04:17:06 ebola kernel:  [pdflush+40/48] pdflush+0x28/0x30
Jun 30 04:17:06 ebola kernel:  [wb_kupdate+0/288] wb_kupdate+0x0/0x120
Jun 30 04:17:06 ebola kernel:  [pdflush+0/48] pdflush+0x0/0x30
Jun 30 04:17:06 ebola kernel:  [kthread+165/176] kthread+0xa5/0xb0
Jun 30 04:17:06 ebola kernel:  [kthread+0/176] kthread+0x0/0xb0
Jun 30 04:17:06 ebola kernel:  [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
Jun 30 04:17:06 ebola kernel:
Jun 30 04:17:06 ebola kernel: Code: 0f 0b 52 01 2a f1 bf f8 c7 04 24 00 bb bf f8 c7 44 24 08 a0
Jun 30 04:17:06 ebola kernel:  <3>scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:06 ebola kernel: Buffer I/O error on device sda1, logical block 22417398
Jun 30 04:17:06 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:06 ebola kernel: Buffer I/O error on device sda1, logical block 35409841
Jun 30 04:17:06 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:06 ebola kernel: zam-7001: io error in reiserfs_find_entry
Jun 30 04:17:10 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:10 ebola kernel: zam-7001: io error in reiserfs_find_entry
Jun 30 04:17:14 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:14 ebola kernel: zam-7001: io error in reiserfs_find_entry
Jun 30 04:17:18 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:18 ebola kernel: zam-7001: io error in reiserfs_find_entry
Jun 30 04:17:23 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:23 ebola kernel: zam-7001: io error in reiserfs_find_entry
Jun 30 04:17:27 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:27 ebola kernel: zam-7001: io error in reiserfs_find_entry
Jun 30 04:17:31 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:31 ebola kernel: zam-7001: io error in reiserfs_find_entry
Jun 30 04:17:36 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:36 ebola kernel: zam-7001: io error in reiserfs_find_entry
Jun 30 04:17:40 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:40 ebola kernel: zam-7001: io error in reiserfs_find_entry
Jun 30 04:17:44 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:44 ebola kernel: zam-7001: io error in reiserfs_find_entry
Jun 30 04:17:53 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:53 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:53 ebola kernel: Buffer I/O error on device sda1, logical block 21740738
Jun 30 04:17:59 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
Jun 30 04:17:59 ebola kernel: Buffer I/O error on device sda1, logical block 2500
Jun 30 04:17:59 ebola kernel: lost page write due to I/O error on sda1
Jun 30 04:17:59 ebola kernel: Buffer I/O error on device sda1, logical block 2501
Jun 30 04:17:59 ebola kernel: lost page write due to I/O error on sda1
Jun 30 04:17:59 ebola kernel: Buffer I/O error on device sda1, logical block 2502
Jun 30 04:17:59 ebola kernel: lost page write due to I/O error on sda1
Jun 30 04:17:59 ebola kernel: Buffer I/O error on device sda1, logical block 2503
Jun 30 04:17:59 ebola kernel: lost page write due to I/O error on sda1





Janne Hayrynen
sniff@xxx.ath.cx


