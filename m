Return-Path: <linux-kernel-owner+w=401wt.eu-S932878AbWL0Brc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932878AbWL0Brc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 20:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932879AbWL0Brc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 20:47:32 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:16147 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878AbWL0Brc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 20:47:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tmzSkq77zCsYRw/HN5NtJT1ZUOSHbStlpDxsKvOfR66MFsf7geNLHGKpi1QCn+pE+TeRVfqzd4jbZKtYlt9+Q4oGKV0GRGHYg0fRq0mQMMXpA0vMvpHSYNnlgDqaeIxhXe8mPbCaIQOREkfW1uVQolO51uK9BEkwUGbQthL8fsI=
Message-ID: <9e4733910612261747s4b32d6ben2e5a55f88f225edf@mail.gmail.com>
Date: Tue, 26 Dec 2006 20:47:31 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: BUG: scheduling while atomic, new libata code
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this is my logs, no idea what triggered it. Using 2.6.20-rc2
I have one PATA and one SATA HD on ICH5 and two PATA CDROM
All using the new libata drivers

 BUG: scheduling while atomic: hald-addon-stor/0x20000000/5170
  [schedule+1529/2816] __sched_text_start+0x5f9/0xb00
  [blk_done_softirq+88/112] blk_done_softirq+0x58/0x70
  [__do_softirq+114/224] __do_softirq+0x72/0xe0
  [do_IRQ+69/128] do_IRQ+0x45/0x80
  [reschedule_interrupt+40/48] reschedule_interrupt+0x28/0x30
  [__cond_resched+22/64] __cond_resched+0x16/0x40
  [cond_resched+35/48] cond_resched+0x23/0x30
  [__reacquire_kernel_lock+28/60] __reacquire_kernel_lock+0x1c/0x3c
  [schedule+1577/2816] __sched_text_start+0x629/0xb00
  [scsi_done+0/32] scsi_done+0x0/0x20
  [ata_scsi_translate+154/320] ata_scsi_translate+0x9a/0x140
  [scsi_request_fn+542/800] scsi_request_fn+0x21e/0x320
  [__cond_resched+22/64] __cond_resched+0x16/0x40
  [cond_resched+35/48] cond_resched+0x23/0x30
  [wait_for_completion+15/192] wait_for_completion+0xf/0xc0
  [blk_execute_rq_nowait+91/160] blk_execute_rq_nowait+0x5b/0xa0
  [cfq_set_request+0/896] cfq_set_request+0x0/0x380
  [cfq_set_request+508/896] cfq_set_request+0x1fc/0x380
  [blk_execute_rq+124/224] blk_execute_rq+0x7c/0xe0
  [blk_end_sync_rq+0/48] blk_end_sync_rq+0x0/0x30
  [cfq_set_request+0/896] cfq_set_request+0x0/0x380
  [elv_set_request+28/64] elv_set_request+0x1c/0x40
  [get_request+289/624] get_request+0x121/0x270
  [get_request_wait+39/288] get_request_wait+0x27/0x120
  [scsi_execute+217/256] scsi_execute+0xd9/0x100
  [pg0+944853162/1069057024] sr_do_ioctl+0x7a/0x240 [sr_mod]
  [__wake_up+56/80] __wake_up+0x38/0x50
  [pg0+944854258/1069057024] sr_drive_status+0x62/0x80 [sr_mod]
  [pg0+945482260/1069057024] cdrom_ioctl+0x514/0xde0 [cdrom]
  [__mark_inode_dirty+52/400] __mark_inode_dirty+0x34/0x190
  [touch_atime+158/272] touch_atime+0x9e/0x110
  [pg0+944852851/1069057024] sr_block_ioctl+0x53/0xb0 [sr_mod]
  [blkdev_driver_ioctl+109/128] blkdev_driver_ioctl+0x6d/0x80
  [blkdev_ioctl+751/2000] blkdev_ioctl+0x2ef/0x7d0
  [kobject_get+15/32] kobject_get+0xf/0x20
  [get_disk+57/112] get_disk+0x39/0x70
  [exact_lock+7/16] exact_lock+0x7/0x10
  [kobject_get+15/32] kobject_get+0xf/0x20
  [pg0+944849884/1069057024] sr_block_open+0x5c/0xa0 [sr_mod]
  [blkdev_open+0/112] blkdev_open+0x0/0x70
  [do_open+439/656] do_open+0x1b7/0x290
  [blkdev_open+0/112] blkdev_open+0x0/0x70
  [blkdev_open+48/112] blkdev_open+0x30/0x70
  [__dentry_open+353/448] __dentry_open+0x161/0x1c0
  [nameidata_to_filp+53/64] nameidata_to_filp+0x35/0x40
  [do_filp_open+75/96] do_filp_open+0x4b/0x60
  [block_ioctl+24/32] block_ioctl+0x18/0x20
  [block_ioctl+0/32] block_ioctl+0x0/0x20
  [do_ioctl+43/144] do_ioctl+0x2b/0x90
  [vfs_ioctl+92/672] vfs_ioctl+0x5c/0x2a0
  [sys_ioctl+114/144] sys_ioctl+0x72/0x90
  [sysenter_past_esp+95/133] sysenter_past_esp+0x5f/0x85
  =======================

-- 
Jon Smirl
jonsmirl@gmail.com
