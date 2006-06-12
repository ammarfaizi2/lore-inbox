Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWFLTwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWFLTwI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWFLTwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:52:08 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:53211 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S932151AbWFLTwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:52:07 -0400
Subject: BUG: write-lock lockup
From: "Charles C. Bennett, Jr." <ccb@acm.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-/1upIfomwv4ouS5NqqDR"
Date: Mon, 12 Jun 2006 15:53:43 -0400
Message-Id: <1150142023.3621.22.camel@cbox.memecycle.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
X-ELNK-Trace: 428d7bd11d3f91d4416dc04816f3191cb189b78835b9419f626e9914c2497862fb54eacf4b01f354350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.31.94
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/1upIfomwv4ouS5NqqDR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Hi All -

	I'm seeing write-lock lockups...  this is happening with
the Fedora kernels from at least as far back as their 2.6.15-1.1833_FC4
(2.6.15.5) and as recently as their 2.6.16-1.2111_FC4 (2.6.16.17).

It's a beefy box:
 Gateway 9515R - Intel ICH5/ICH5R
 Two Dual Core 3.0 ghz Xeons, 4GB RAM
 All disks via Emulex LP101-H (thor), switched fabric to
  Hitachi WMS SAN storage.

The lockups are not process-specific.  Running mke2fs on large
filesystems seems to get it happen sooner rather than later.

I can fish out any other data you need, run tests, etc.

Thanks,
ccb


-- 
Charles C. Bennett, Jr. <ccb@acm.org>

--=-/1upIfomwv4ouS5NqqDR
Content-Disposition: attachment; filename=lockup
Content-Type: text/plain; name=lockup; charset=UTF-8
Content-Transfer-Encoding: 7bit


Jun  9 20:43:40 localhost kernel: BUG: write-lock lockup on CPU#6, mkfs.ext2/3258, f799c864 (Not tainted)
Jun  9 20:43:40 localhost kernel:  [<c01f21d7>] __write_lock_debug+0xb4/0xdd  [<c01f223f>] _raw_write_lock+0x3f/0x7c
Jun  9 20:43:40 localhost kernel:  [<c015532c>] shrink_list+0x197/0x45d     [<c01557a3>] shrink_cache+0xe7/0x29b
Jun  9 20:43:40 localhost kernel:  [<c014d955>] bad_range+0x22/0x2f     [<c014dfe3>] __rmqueue+0xd1/0x156
Jun  9 20:43:40 localhost kernel:  [<c0155db9>] shrink_zone+0x89/0xd8     [<c0155e6e>] shrink_caches+0x66/0x74
Jun  9 20:43:40 localhost kernel:  [<c0155f29>] try_to_free_pages+0xad/0x1b7  [<c014e8a5>] __alloc_pages+0x136/0x2ec
Jun  9 20:43:40 localhost kernel:  [<c016ca3e>] __block_commit_write+0x83/0x8f    [<c014be23>] generic_file_buffered_write+0x16b/0x655
Jun  9 20:43:40 localhost kernel:  [<c012a04b>] current_fs_time+0x5a/0x75     [<c012a04b>] current_fs_time+0x5a/0x75
Jun  9 20:43:40 localhost kernel:  [<c0182cd8>] inode_update_time+0x2d/0x99 [<c014c5b0>] __generic_file_aio_write_nolock+0x2a3/0x4d9
Jun  9 20:43:40 localhost kernel:  [<c014c822>] generic_file_aio_write_nolock+0x3c/0x92     [<c01719e0>] blkdev_file_write+0x0/0x24
Jun  9 20:43:40 localhost kernel:  [<c014c99c>] generic_file_write_nolock+0x85/0x9f     [<c0139196>] autoremove_wake_function+0x0/0x37
Jun  9 20:43:40 localhost kernel:  [<c0171a00>] blkdev_file_write+0x20/0x24 [<c01699f2>] vfs_write+0xa2/0x15a
Jun  9 20:43:40 localhost kernel:  [<c0169b55>] sys_write+0x41/0x6a     [<c0104035>] syscall_call+0x7/0xb
Jun  9 21:02:58 localhost kernel: BUG: write-lock lockup on CPU#1, mkfs.ext2/3259, f799c864 (Not tainted)
Jun  9 21:02:58 localhost kernel:  [<c01f21d7>] __write_lock_debug+0xb4/0xdd  [<c01f223f>] _raw_write_lock+0x3f/0x7c
Jun  9 21:02:58 localhost kernel:  [<c032bd15>] _write_lock_irqsave+0x9/0xd [<c015070d>] test_clear_page_writeback+0x2d/0xa6
Jun  9 21:02:58 localhost kernel:  [<c014a09c>] end_page_writeback+0x76/0x84  [<c016b2c9>] end_buffer_async_write+0xbf/0x12a
Jun  9 21:02:58 localhost kernel:  [<c01f1167>] memmove+0x24/0x2d     [<c014d292>] mempool_free+0x3a/0x73
Jun  9 21:02:58 localhost kernel:  [<c016db6a>] end_bio_bh_io_sync+0x0/0x4f [<c016db6a>] end_bio_bh_io_sync+0x0/0x4f
Jun  9 21:02:58 localhost kernel:  [<c016db8d>] end_bio_bh_io_sync+0x23/0x4f  [<c016f307>] bio_endio+0x3e/0x69
Jun  9 21:02:58 localhost kernel:  [<c01e2e88>] __end_that_request_first+0x101/0x235     [<f885c8af>] scsi_end_request+0x1b/0xb0 [scsi_mod]
Jun  9 21:02:58 localhost kernel:  [<f885cbd5>] scsi_io_completion+0x151/0x4d2 [scsi_mod]     [<f8833c97>] sd_rw_intr+0x70/0x3c1 [sd_mod]
Jun  9 21:02:58 localhost kernel:  [<f8857cad>] scsi_finish_command+0x82/0xd0 [scsi_mod]     [<f8857b8e>] scsi_softirq+0xc0/0x137 [scsi_mod]
Jun  9 21:02:58 localhost kernel:  [<c012a1f2>] __do_softirq+0x72/0xdc     [<c0106383>] do_softirq+0x4b/0x4f
Jun  9 21:02:58 localhost kernel:  =======================
Jun  9 21:02:58 localhost kernel:  [<c0106265>] do_IRQ+0x55/0x86     [<c0104a7a>] common_interrupt+0x1a/0x20
Jun  9 21:03:05 localhost kernel:  [<c014e387>] free_hot_cold_page+0xd5/0x126   [<c014eaf4>] __pagevec_free+0x1f/0x2e
Jun  9 21:03:08 localhost kernel:  [<c0154371>] __pagevec_release_nonlru+0x29/0x8b     [<c01553aa>] shrink_list+0x215/0x45d
Jun  9 21:03:09 localhost kernel:  [<c01557a3>] shrink_cache+0xe7/0x29b     [<c0155db9>] shrink_zone+0x89/0xd8
Jun  9 21:03:09 localhost kernel:  [<c0155e6e>] shrink_caches+0x66/0x74     [<c0155f29>] try_to_free_pages+0xad/0x1b7
Jun  9 21:03:09 localhost kernel:  [<c014e8a5>] __alloc_pages+0x136/0x2ec     [<c016ca3e>] __block_commit_write+0x83/0x8f
Jun  9 21:03:10 localhost kernel:  [<c014be23>] generic_file_buffered_write+0x16b/0x655     [<c012a04b>] current_fs_time+0x5a/0x75
Jun  9 21:03:11 localhost kernel:  [<c0182cd8>] inode_update_time+0x2d/0x99 [<c014c5b0>] __generic_file_aio_write_nolock+0x2a3/0x4d9
Jun  9 21:03:11 localhost kernel:  [<c014c822>] generic_file_aio_write_nolock+0x3c/0x92     [<c01719e0>] blkdev_file_write+0x0/0x24
Jun  9 21:03:12 localhost kernel:  [<c014c99c>] generic_file_write_nolock+0x85/0x9f     [<c0139196>] autoremove_wake_function+0x0/0x37
Jun  9 21:03:12 localhost kernel:  [<c0171a00>] blkdev_file_write+0x20/0x24 [<c01699f2>] vfs_write+0xa2/0x15a
Jun  9 21:03:12 localhost kernel:  [<c0169b55>] sys_write+0x41/0x6a     [<c0104035>] syscall_call+0x7/0xb
Jun  9 21:28:07 localhost mgetty[3159]: failed dev=ttyS0, pid=3159, login time out
Jun  9 21:42:31 localhost kernel: BUG: write-lock lockup on CPU#3, mkfs.ext2/3257, f5e0ef24 (Not tainted)
Jun  9 21:42:31 localhost kernel: BUG: write-lock lockup on CPU#1, mkfs.ext2/3259, f5e0ef24 (Not tainted)
Jun  9 21:42:31 localhost kernel:  [<c01f21d7>] __write_lock_debug+0xb4/0xdd  [<c01f223f>] _raw_write_lock+0x3f/0x7c
Jun  9 21:42:31 localhost kernel:  [<c032bd15>] _write_lock_irqsave+0x9/0xd [<c015070d>] test_clear_page_writeback+0x2d/0xa6
Jun  9 21:42:31 localhost kernel:  [<c014a09c>] end_page_writeback+0x76/0x84  [<c016b2c9>] end_buffer_async_write+0xbf/0x12a
Jun  9 21:42:31 localhost kernel:  [<c014d292>] mempool_free+0x3a/0x73     [<c016db6a>] end_bio_bh_io_sync+0x0/0x4f
Jun  9 21:42:31 localhost kernel:  [<c016db6a>] end_bio_bh_io_sync+0x0/0x4f [<c016db8d>] end_bio_bh_io_sync+0x23/0x4f
Jun  9 21:42:31 localhost kernel:  [<c016f307>] bio_endio+0x3e/0x69     [<c0120685>] __wake_up+0x32/0x43
Jun  9 21:42:31 localhost kernel:  [<c01e2e88>] __end_that_request_first+0x101/0x235     [<f885c8af>] scsi_end_request+0x1b/0xb0 [scsi_mod]
Jun  9 21:42:31 localhost kernel:  [<f885cbd5>] scsi_io_completion+0x151/0x4d2 [scsi_mod]     [<f896681c>] e1000_clean_tx_irq+0x76/0x62d [e1000]alhost kernel:  [<c016f307>] bio_endio+0x3e/0x69     [<c0120685>] __wake_up+0x32/0x43
Jun  9 21:42:48 localhost kernel:  [<c01e2e88>] __end_that_request_first+0x101/0x235     [<f885c8af>] scsi_end_request+0x1b/0xb0 [scsi_mod]
Jun  9 21:42:48 localhost kernel:  [<f885cbd5>] scsi_io_completion+0x151/0x4d2 [scsi_mod]     [<f896681c>] e1000_clean_tx_irq+0x76/0x62d [e1000]
Jun  9 21:42:48 localhost kernel:  [<c01391ab>] autoremove_wake_function+0x15/0x37     [<f8833c97>] sd_rw_intr+0x70/04 (Not tainted)
Jun  9 23:34:03 localhost kernel:  [<c01f21d7>] __write_lock_debug+0xb4/0xdd  [<c01f223f>] _raw_write_lock+0x3f/0x7c
Jun  9 23:34:03 localhost kernel:  [<c032bd15>] _write_lock_irqsave+0x9/0xd [<c015060d>] test_clear_page_dirty+0x2a/0xa9
Jun  9 23:34:03 localhost kernel:  [<c016df8f>] try_to_free_buffers+0_file_aio_write_nolock+0x2a3/0x4d9     [<c014c822>] generic_file_aio_write_nolock+0x3c/0x92
Jun 10 00:53:26 localhost kernel:  [<c01719e0>] blkdev_file_write+0x0/0x24     [<c014c99c>] generic_file_write_nolock+0x85/0x9f
Jun 10 00:53:30 localhost kernel:  [<c0139196>] autoremove_wake_function+0x0/0x37     [<c0171a00>] blkdev_file_write+0x20/0x24
Jun 10 00:53:33 localhost kernel:  [<c01699f2>] vfs_write+0xa2/0x15a     [<c0169b55>] sys_write+0x41/0x6a
Jun 10 00:53:36 localhost kernel:  [<c0104035>] syscall_call+0x7/0xb
Jun 10 01:03:29 localhost kernel: BUG: write-lock lockup on CPU#4, mkfs.exthe+0xe7/0x29b [<c01f21d7>]
Jun 10 01:05:21 localhost kernel:  __write_lock_debug+0xb4/0xdd [<c0152aac>]  cache_alloc_refill+0xfd/0x27c [<c01f223f>]     _raw_write_lock+0x3f/0x7c
Jun 10 01:05:21 localhost kernel:  [<c0155db9>] [<c032bd15>] shrink_zone+0x89/0xd8
Jun 10 01:05:21 localhost kernel:  [<c0155e6e>] shrink_caches+0x66/0x74 _write_lock_irqsave+0x9/0xd         [<c0155f29>] [<c015070d>] try_to_free_pages+0xad/0x1b7 test_clear_page_writeback+0x2d/0xa6
Jun 10 01:05:21 localhost kernel:
Jun 10 01:05:21 localhost kernel:  [<c014a09c3a/0x73     [<c016db6a>] end_bio_bh_io_sync+0x0/0x4f
Jun 10 01:06:14 localhost kernel:  [<c016db6a>] end_bio_bh_io_sync+0x0/0x4f [<c016db8d>] end_bio_bh_io_sync+0x23/0x4f
Jun 10 01:06:17 localhost kernel:  [<c016f307] bio_endio+0x3e/0x69     [<c01e2e88>] __end_that_request_first+0x101/0x235
Jun 10 01:06:20 localhost kernel:  [<f885c8af>] scsi_end_request+0x1b/0xb0 [scsi_mod]     [<f885cbd5>] scsi_io_completion+0x151/0x4d2 [scsi_mod]
Jun 10 01:06:21 localhost kernel:  [<f8833c97>] sd_rw_intr+0x70/0x3c1 [sd_mod]    [<c0120633>] __wake_up_common+0x39/0x59
Jun 10 01:06:22 localhost kernel:  [<c0120685>] __wake_up+0x32/0x43     [<f8857cad>] scsi_finish_command+0x82/0xd0 [scsi_mod]
Jun 10 01:06:24 localhost kernel:  [<c0106265>] do_IRQ+0x55/0x86     [<f8857b8e>] scsi_softirq+0xc0/0x137 [scsi_mod]
Jun 10 01:06:25 localhost kernel:  [<c012a1f2>] __do_softirq+0x72/0xdc     [<c0106383>] do_softirq+0x4b/0x4f
Jun 10 01:06:25 localhost kernel:  =======================
Jun 10 01:06:26 localhost kernel:  [<c0104b08>] apic_timer_interrupt+0x1c/0x24    [<c0155554>] shrink_list+0x3bf/0x45d
Jun 10 01:06:27 localhost kernel:  [<c01557a3>] shrink_cache+0xe7/0x29b     [<c014fdb0>] get_writeback_state+0x30/0x35
Jun 10 01:06:27 localhost kernel:  [<c0195d7e>] mb_cache_shrink_fn+0x182/0x1c4    [<c0155db9>] shrink_zone+0x89/0xd8
Jun 10 01:06:27 localhost kernel:  [<c015622a>] balance_pgdat+0x1f7/0x3d6     [<c01564e5>] kswapd+0xdc/0x127
Jun 10 01:06:27 localhost kernel:  [<c0139196>] autoremove_wake_function+0x0/0x37     [<c0156409>] kswapd+0x0/0x127
Jun 10 01:06:27 localhost kernel:  [<c010243d>] kernel_thread_helper+0x5/0xb
Jun 10 01:09:40 localhost kernel: BUG: write-lock lockup on CPU#1, mkfs.ext2/3258, f513cf24 (Not tainted)
Jun 10 01:09:40 localhost kernel:  [<c01f21d7>] __write_lock_debug+0xb4/0xdd  [<c01f223f>] _raw_write_lock+0x3f/0x7c
Jun 10 01:09:40 localhost kernel:  [<c032bd15>] _write_lock_irqsave+0x9/0xd [<c015070d>] test_clear_page_writeback+0x2d/0xa6
Jun 10 01:09:40 localhost kernel:  [<c014a09c>] end_page_writeback+0x76/0x84  [<c016b2c9>] end_buffer_async_write+0xbf/0x12a
Jun 10 01:09:40 localhost kernel:  [<c014d292>] mempool_free+0x3a/0x73     [<c016db6a>] end_bio_bh_io_sync+0x0/0x4f
Jun 10 01:09:40 localhost kernel:  [<c016db6a>] end_bio_bh_io_sync+0x0/0x4f [<c016db8d>] end_bio_bh_io_sync+0x23/0x4f
Jun 10 01:09:41 localhost kernel:  [<c016f307>] bio_endio+0x3e/0x69     [<c01e2e88>] __end_that_request_first+0x101/0x235
Jun 10 01:09:41 localhost kernel:  [<f885c8af>] scsi_end_request+0x1b/0xb0 [scsi_mod]     [<f885cbd5>] scsi_io_completion+0x151/0x4d2 [scsi_mod]
Jun 10 01:09:41 localhost kernel:  [<c0104b08>] apic_timer_interrupt+0x1c/0x24    [<f8833c97>] sd_rw_intr+0x70/0x3c1 [sd_mod]
Jun 10 01:09:41 localhost kernel:  [<f8857cad>] scsi_finish_command+0x82/0xd0 [scsi_mod]     [<f8857b8e>] scsi_softirq+0xc0/0x137 [scsi_mod]
Jun 10 01:09:41 localhost kernel:  [<c012a1f2>] __do_softirq+0x72/0xdc     [<c0106383>] do_softirq+0x4b/0x4f
Jun 10 01:09:41 localhost kernel:  =======================
Jun 10 01:09:41 localhost kernel:  [<c0106265>] do_IRQ+0x55/0x86     [<c0104a7a>] common_interrupt+0x1a/0x20
Jun 10 01:09:45 localhost kernel:  [<c0150517>] __set_page_dirty_nobuffers+0x71/0xb2     [<c016ca3e>] __block_commit_write+0x83/0x8f
Jun 10 01:09:46 localhost kernel:  [<c016d154>] block_commit_write+0x15/0x1c  [<c0170dc6>] blkdev_commit_write+0x0/0xd
Jun 10 01:09:46 localhost kernel:  [<c014bfc8>] generic_file_buffered_write+0x310/0x655     [<c012a04b>] current_fs_time+0x5a/0x75
Jun 10 01:09:47 localhost kernel:  [<c012a04b>] current_fs_time+0x5a/0x75     [<c0182cd8>] inode_update_time+0x2d/0x99
Jun 10 01:09:47 localhost kernel:  [<c014c5b0>] __generic_file_aio_write_nolock+0x2a3/0x4d9     [<c014c822>] generic_file_aio_write_nolock+0x3c/0x92
Jun 10 01:09:47 localhost kernel:  [<c01719e0>] blkdev_file_write+0x0/0x24     [<c014c99c>] generic_file_write_nolock+0x85/0x9f
Jun 10 01:09:47 localhost kernel:  [<c0139196>] autoremove_wake_function+0x0/0x37     [<c0171a00>] blkdev_file_write+0x20/0x24
Jun 10 01:09:47 localhost kernel:  [<c01699f2>] vfs_write+0xa2/0x15a     [<c0169b55>] sys_write+0x41/0x6a
Jun 10 01:09:48 localhost kernel:  [<c0104035>] syscall_call+0x7/0xb
Jun 10 01:15:55 localhost kernel: BUG: write-lock lockup on CPU#3, kswapd0/482, f69efaa4 (Not tainted)

[restart]


Jun 10 07:12:16 localhost kernel: BUG: write-lock lockup on CPU#5, mkfs.ext2/3107, f650ace4 (Not tainted)
Jun 10 07:12:16 localhost kernel: BUG: write-lock lockup on CPU#2, mkfs.ext2/3108, f650ace4 (Not tainted)
Jun 10 07:12:16 localhost kernel:  [<c01f21d7>] __write_lock_debug+0xb4/0xdd  [<c01f223f>] _raw_write_lock+0x3f/0x7c
Jun 10 07:12:16 localhost kernel:  [<c032bd15>] _write_lock_irqsave+0x9/0xd [<c015070d>] test_clear_page_writeback+0x2d/0xa6
Jun 10 07:12:16 localhost kernel:  [<c014a09c>] end_page_writeback+0x76/0x84  [<c016b2c9>] end_buffer_async_write+0xbf/0x12a
Jun 10 07:12:16 localhost kernel:  [<c01f1167>] memmove+0x24/0x2d     [<c014d292>] mempool_free+0x3a/0x73
Jun 10 07:12:16 localhost kernel:  [<c016db6a>] end_bio_bh_io_sync+0x0/0x4f [<c016db6a>] end_bio_bh_io_sync+0x0/0x4f
Jun 10 07:12:16 localhost kernel:  [<c016db8d>] end_bio_bh_io_sync+0x23/0x4f  [<c016f307>] bio_endio+0x3e/0x69
Jun 10 07:12:16 localhost kernel:  [<c01e2e88>] __end_that_request_first+0x101/0x235     [<f885c8af>] scsi_end_request+0x1b/0xb0 [scsi_mod]
Jun 10 07:12:16 localhost kernel:  [<f885cbd5>] scsi_io_completion+0x151/0x4d2 [scsi_mod]     [<c011e8fa>] try_to_wake_up+0x6e/0x3ec
Jun 10 07:12:16 localhost kernel:  [<f8833c97>] sd_rw_intr+0x70/0x3c1 [sd_mod]    [<c0120633>] __wake_up_common+0x39/0x59
Jun 10 07:12:16 localhost kernel:  [<f8857cad>] scsi_finish_command+0x82/0xd0 [scsi_mod]     [<c0106265>] do_IRQ+0x55/0x86
Jun 10 07:12:16 localhost kernel:  [<c0134a95>] __queue_work+0x45/0x54     [<f8857b8e>] scsi_softirq+0xc0/0x137 [scsi_mod]
Jun 10 07:12:19 localhost kernel:  [<c012a1f2>] __do_softirq+0x72/0xdc     [<c0106383>] do_softirq+0x4b/0x4f
Jun 10 07:12:20 localhost kernel:  =======================
Jun 10 07:12:20 localhost kernel:  [<c0104b08>] apic_timer_interrupt+0x1c/0x24    [<c0154471>] __pagevec_lru_add+0x9e/0xbb
Jun 10 07:12:20 localhost kernel:  [<c014c0a1>] generic_file_buffered_write+0x3e9/0x655     [<c012a04b>] current_fs_time+0x5a/0x75
Jun 10 07:12:21 localhost kernel:  [<c0182cd8>] inode_update_time+0x2d/0x99 [<c014c5b0>] __generic_file_aio_write_nolock+0x2a3/0x4d9
Jun 10 07:12:21 localhost kernel:  [<c014c822>] generic_file_aio_write_nolock+0x3c/0x92     [<c01719e0>] blkdev_file_write+0x0/0x24
Jun 10 07:12:21 localhost kernel:  [<c014c99c>] generic_file_write_nolock+0x85/0x9f     [<c0139196>]BUG: write-lock lockup on CPU#4, safte-monitor/2750, f650ace4 (Not tainted)
Jun 10 07:12:21 localhost kernel:  autoremove_wake_function+0x0/0x37
Jun 10 07:12:22 localhost kernel:  [<c0171a00>] [<c01f21d7>] blkdev_file_write+0x20/0x24     [<c01699f2>] vfs_write+0xa2/0x15a __write_lock_debug+0xb4/0xdd
Jun 10 07:12:22 localhost kernel:      [<c0169b55>] [<c01f223f>] sys_write+0x41/0x6a     _raw_write_lock+0x3f/0x7c [<c0104035>]
Jun 10 07:12:22 localhost kernel:  [<c032bd15>] syscall_call+0x7/0xb
Jun 10 07:12:22 localhost kernel:  _write_lock_irqsave+0x9/0xd     [<c015060d>] test_clear_page_dirty+0x2a/0xa9
Jun 10 07:12:22 localhost kernel:  [<c016df8f>] try_to_free_buffers+0x6b/0x84   [<c0155567>] shrink_list+0x3d2/0x45d
Jun 10 07:12:22 localhost kernel:  [<c01c5a2a>] avc_has_perm_noaudit+0x24/0xce    [<c014dede>] prep_new_page+0x41/0x75
Jun 10 07:12:23 localhost kernel:  [<c01c5b22>] avc_has_perm+0x4e/0x5c     [<c01557a3>] shrink_cache+0xe7/0x29b
Jun 10 07:12:23 localhost kernel:  [<c0155db9>] shrink_zone+0x89/0xd8     [<c0155e6e>] shrink_caches+0x66/0x74
Jun 10 07:12:23 localhost kernel:  [<c0155f29>] try_to_free_pages+0xad/0x1b7  [<c014e8a5>] __alloc_pages+0x136/0x2ec
Jun 10 07:12:23 localhost kernel:  [<c014ea79>] __get_free_pages+0x1e/0x34     [<c017ba85>] __pollwait+0x64/0x97
Jun 10 07:12:23 localhost kernel:  [<c02f0644>] tcp_poll+0x15/0x183     [<c02c0db0>] sock_poll+0xf/0x11
Jun 10 07:12:23 localhost kernel:  [<c017bd30>] do_select+0x177/0x303     [<c01483af>] audit_syscall_entry+0x10a/0x15d
Jun 10 07:12:24 localhost kernel:  [<c017ba21>] __pollwait+0x0/0x97     [<c017c0ba>] sys_select+0x1e6/0x38f
Jun 10 07:12:24 localhost kernel:  [<c01084cd>] do_syscall_trace+0x1ac/0x1c4  [<c0104035>] syscall_call+0x7/0xb
Jun 10 07:12:24 localhost kernel:  [<c01f21d7>] __write_lock_debug+0xb4/0xdd  [<c01f223f>] _raw_write_lock+0x3f/0x7c
Jun 10 07:12:24 localhost kernel:  [<c032bd15>] _write_lock_irqsave+0x9/0xd [<c015070d>] test_clear

--=-/1upIfomwv4ouS5NqqDR--

