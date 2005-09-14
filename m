Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbVINQYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVINQYJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVINQYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:24:09 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:60090 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1030246AbVINQYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:24:08 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: linux-kernel@vger.kernel.org
Subject: cdrom drive problems with 2.6.14-rc1 
Date: Wed, 14 Sep 2005 09:24:06 -0700
Message-ID: <8764t38vo9.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am not really sure what's happening here, trying to rip a cd with
grip after a while i get the following:

kernel: cdrom: dropping to single frame dma
kernel: hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: packet command error: error=0x40 { LastFailedSense=0x04 }
kernel: ide: failed opcode was: unknown
kernel: ATAPI device hdc:
kernel:   Error: Hardware error -- (Sense key=0x04)
kernel:   Track following error -- (asc=0x09, ascq=0x00)
kernel:   The failed "Play Audio MSF" packet command was: 
kernel:   "47 00 00 00 02 20 2e 18 00 00 00 00 00 00 00 00 "
kernel: hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: packet command error: error=0x40 { LastFailedSense=0x04 }
kernel: ide: failed opcode was: unknown
kernel: ATAPI device hdc:
kernel:   Error: Hardware error -- (Sense key=0x04)
kernel:   Track following error -- (asc=0x09, ascq=0x00)
kernel:   The failed "Play Audio MSF" packet command was: 
kernel:   "47 00 00 00 02 20 2e 18 00 00 00 00 00 00 00 00 "
kernel: arq->state: 4
kernel: Badness in as_insert_request at drivers/block/as-iosched.c:1519
kernel:  [as_insert_request+104/448] as_insert_request+0x68/0x1c0
kernel:  [__elv_add_request+158/224] __elv_add_request+0x9e/0xe0
kernel:  [elv_add_request+60/144] elv_add_request+0x3c/0x90
kernel:  [blk_execute_rq_nowait+60/80] blk_execute_rq_nowait+0x3c/0x50
kernel:  [blk_execute_rq+95/192] blk_execute_rq+0x5f/0xc0
kernel:  [blk_end_sync_rq+0/32] blk_end_sync_rq+0x0/0x20
kernel:  [bio_phys_segments+20/32] bio_phys_segments+0x14/0x20
kernel:  [blk_rq_bio_prep+51/160] blk_rq_bio_prep+0x33/0xa0
kernel:  [blk_rq_map_user+166/224] blk_rq_map_user+0xa6/0xe0
kernel:  [cdrom_read_cdda_bpc+367/496] cdrom_read_cdda_bpc+0x16f/0x1f0
kernel:  [cdrom_read_cdda+82/176] cdrom_read_cdda+0x52/0xb0
kernel:  [mmc_ioctl+1771/2432] mmc_ioctl+0x6eb/0x980
kernel:  [reiserfs_dirty_inode+140/160] reiserfs_dirty_inode+0x8c/0xa0
kernel:  [scsi_cmd_ioctl+174/1152] scsi_cmd_ioctl+0xae/0x480
kernel:  [reiserfs_submit_file_region_for_write+424/800] reiserfs_submit_file_region_for_write+0x1a8/0x320
kernel:  [reiserfs_copy_from_user_to_file_region+158/224] reiserfs_copy_from_user_to_file_region+0x9e/0xe0
kernel:  [buffered_rmqueue+221/528] buffered_rmqueue+0xdd/0x210
kernel:  [cdrom_ioctl+207/3280] cdrom_ioctl+0xcf/0xcd0
kernel:  [idecd_ioctl+107/128] idecd_ioctl+0x6b/0x80
kernel:  [blkdev_driver_ioctl+109/128] blkdev_driver_ioctl+0x6d/0x80
kernel:  [blkdev_ioctl+314/432] blkdev_ioctl+0x13a/0x1b0
kernel:  [block_ioctl+24/32] block_ioctl+0x18/0x20
kernel:  [block_ioctl+0/32] block_ioctl+0x0/0x20
kernel:  [do_ioctl+43/160] do_ioctl+0x2b/0xa0
kernel:  [vfs_ioctl+96/528] vfs_ioctl+0x60/0x210
kernel:  [sys_ioctl+61/112] sys_ioctl+0x3d/0x70
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

and then this last message is repeated over and over again. rebooting
"fixes" the problem. i am not sure this is only a cdrom problem or has
something to do with the filesystem (reiserfs). the computer is an ibm
thinkpad t40 laptop (but this also happened on my desktop at work with
a different cd so its probably not the cdrom drive going bad).

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
