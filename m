Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbUKFFWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbUKFFWi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 00:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbUKFFWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 00:22:38 -0500
Received: from port-222-152-48-85.fastadsl.net.nz ([222.152.48.85]:16768 "EHLO
	tornado.reub.net") by vger.kernel.org with ESMTP id S261318AbUKFFWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 00:22:34 -0500
Message-Id: <6.2.0.10.2.20041106181618.01e8caa8@tornado.reub.net>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.0.10 (Beta)
Date: Sat, 06 Nov 2004 18:22:31 +1300
To: linux-kernel@vger.kernel.org
From: Reuben Farrelly <reuben-lkml@reub.net>
Subject: Oops with 2.6.10-rc1-mm3
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm experiencing a problem with -mm3 on FC3-rawhide.  -mm2 did not do 
this...but it had another problem (for some reason, -mm2 broke php binaries 
on FC3-rawhide).  I haven't seen any mention of either of these problems on 
LKML.

Box is a P4-2.8/SMP/HT with multiple raid-1 volumes on reiser3.  Below is 
the oops shown when booting up -mm3.


Setting up Logical Volume Management: [  OK  ]
Checking filesystems
Checking all file systems.
[/sbin/fsck.ext2 (1) -- /boot] fsck.ext2 -a /dev/sda1
/dev/sda1: clean, 39/6024 files, 10973/24064 blocks
[  OK  ]
Mounting local filesystems:  Unable to handle kernel paging request at 
virtual 0
  printing eip:
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: dm_mod i2c_i801 sr_mod
CPU:    0
EIP:    0060:[<c019c9e2>]    Not tainted VLI
EFLAGS: 00010206   (2.6.10-rc1-mm3)
EIP is at allocate_cnodes+0x2d/0x79
eax: 00000000   ebx: 00090000   ecx: 0001f400   edx: df4e0d01
esi: e0bed000   edi: e0c00000   ebp: 00004000   esp: df4e0db8
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 1324, threadinfo=df4e0000 task=df96ba40)
Stack: 00000000 e0bd1000 e0be112c df7a6400 c019fb8f df7a6400 c0304694 df4e0e04
        00002000 00000012 00000400 00000384 0000001e 0000001e c03fe7cb def35dac
        00004000 00000000 00000000 38626473 df7a6400 dfc2ca80 dec904f4 c0119800
Call Trace:
  [<c019fb8f>] journal_init+0x42c/0x610
  [<c0119800>] printk+0x17/0x1b
  [<c019255f>] reiserfs_info+0x37/0x55
  [<c019150b>] reiserfs_fill_super+0x36c/0x6da
  [<c01b4d31>] snprintf+0x1c/0x21
  [<c0179350>] disk_name+0x50/0x95
  [<c0153e10>] get_sb_bdev+0xb1/0x10c
  [<c0165cf0>] alloc_vfsmnt+0x80/0xad
  [<c01918c6>] get_super_block+0x18/0x22
  [<c019119f>] reiserfs_fill_super+0x0/0x6da
  [<c0153fe1>] do_kern_mount+0x41/0xba
  [<c0166bf9>] do_new_mount+0x74/0xa9
  [<c01672af>] do_mount+0x15c/0x173
  [<c0167108>] copy_mount_options+0x48/0x93
  [<c01676ee>] sys_mount+0x79/0xb5
  [<c0103b95>] sysenter_past_esp+0x52/0x71
Code: c5 31 c0 57 85 ed 56 53 7e 68 8d 44 ed 00 8d 1c 85 00 00 00 00 89 d8 e8 d
  [FAILED]
Enabling swap space:  <6>Adding 497972k swap on /dev/sda7.  Priority:1 
extents:1
Adding 497972k swap on /dev/sdb7.  Priority:1 extents:1
[  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup


Thanks,
Reuben


