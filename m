Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbUJ3S0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbUJ3S0n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbUJ3SZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:25:23 -0400
Received: from ppp1-adsl-142.the.forthnet.gr ([193.92.232.142]:21290 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S261259AbUJ3SQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:16:16 -0400
From: V13 <v13@priest.com>
To: axboe@suse.de
Subject: ide-cd hangs when trying to read from asus e616p2 dvdrom
Date: Sat, 30 Oct 2004 21:16:27 +0300
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410302116.28370.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. I just got an Asus E616P2 DVD ROM. The ide_cd driver hangs when trying to 
perform any action on the cd

4. Linux version 2.6.9 (root@hell.hell.gr) (gcc version 3.4.2) #44 Thu Oct 21 
21:53:19 EEST 2004

5. The backtrace sysrq+t:

k3b           D C5381D80     0  4769   4634                4725 (NOTLB)
c5381c9c 00000086 c04ef274 c5381d80 d7fcea00 d9db7dc7 d9db7b40 00000064 
       c5381da4 c04ef274 00000000 00071bd4 0586ed51 00000031 ccd3e6b8 c5381000 
       c5381d08 c5381000 c5381cf0 c03a5518 00000000 ccd3e560 c01173c0 00000000 
Call Trace:
 [<d9db7dc7>] cdrom_transfer_packet_command+0x77/0x100 [ide_cd]
 [<d9db7b40>] cdrom_timer_expiry+0x0/0x70 [ide_cd]
 [<c03a5518>] wait_for_completion+0x88/0xe0
 [<c01173c0>] default_wake_function+0x0/0x10
 [<c0104ad8>] common_interrupt+0x18/0x20
 [<c01173c0>] default_wake_function+0x0/0x10
 [<c02ae7f9>] ide_do_drive_cmd+0xf9/0x150
 [<c03a54aa>] wait_for_completion+0x1a/0xe0
 [<d9db8a83>] cdrom_queue_packet_command+0x43/0xc0 [ide_cd]
 [<c0104ad8>] common_interrupt+0x18/0x20
 [<c02ae814>] ide_do_drive_cmd+0x114/0x150
 [<d9db9621>] cdrom_check_status+0x81/0xb0 [ide_cd]
 [<c0135f55>] find_get_pages+0x25/0x70
 [<d9db9a54>] cdrom_read_toc+0x44/0x3d0 [ide_cd]
 [<c01404de>] invalidate_mapping_pages+0x4e/0x100
 [<d9dbb75d>] idecd_revalidate_disk+0xd/0x20 [ide_cd]
 [<c016cf91>] __invalidate_device+0x41/0x60
 [<c015b398>] check_disk_change+0x68/0x80
 [<d9d48d90>] cdrom_open+0x60/0x110 [cdrom]
 [<c029bc12>] kobj_lookup+0x132/0x200
 [<d9dbb64f>] idecd_open+0x5f/0x90 [ide_cd]
 [<c015b77e>] do_open+0x33e/0x470
 [<c015af40>] bdev_set+0x0/0x10
 [<c015b975>] blkdev_open+0x25/0x60
 [<c0152a47>] dentry_open+0x1a7/0x250
 [<c0152890>] filp_open+0x40/0x50
 [<c0152b37>] get_unused_fd+0x47/0xe0
 [<c0160545>] getname+0x55/0xd0
 [<c0152c8c>] sys_open+0x3c/0x80
 [<c010416b>] syscall_call+0x7/0xb

After that, every process that is going to access the drive hangs too:
hdparm        D C136D568     0  4814   4813                     (NOTLB)
c8a17eb8 00200086 d6045b60 c136d568 ccb88005 00000001 c2f22000 c8a17f68 
       d7fd8f20 d6045ea8 cdb6f560 00188967 f00cd98c 00000034 c46086b8 d6cba06c 
       00200286 c8a17000 c4608560 c03a4d0c d6cba074 00000001 c4608560 c01173c0 
Call Trace:
 [<c03a4d0c>] __down+0x7c/0x110
 [<c01173c0>] default_wake_function+0x0/0x10
 [<c02a2070>] exact_match+0x0/0x10
 [<c03a4ef0>] __down_failed+0x8/0xc
 [<c015bdc9>] .text.lock.block_dev+0x19/0x90
 [<c015b975>] blkdev_open+0x25/0x60
 [<c0152a47>] dentry_open+0x1a7/0x250
 [<c0152890>] filp_open+0x40/0x50
 [<c0152b37>] get_unused_fd+0x47/0xe0
 [<c0160545>] getname+0x55/0xd0
 [<c0152c8c>] sys_open+0x3c/0x80
 [<c010416b>] syscall_call+0x7/0xb

I have an Asus DVD recorder and it works without a problem.
After a couple of locks, I installed windows and it worked fine there...
Have not tried other kernel versions...

please CC me.

<<V13>>
