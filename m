Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423182AbWJQJB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423182AbWJQJB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 05:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423180AbWJQJB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 05:01:59 -0400
Received: from 84-72-7-39.dclient.hispeed.ch ([84.72.7.39]:18925 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S1423182AbWJQJB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 05:01:58 -0400
Message-ID: <45349BFB.8060201@steudten.org>
Date: Tue, 17 Oct 2006 11:01:47 +0200
From: "alpha @ steudten Engineering" <alpha@steudten.com>
Organization: Steudten Engineering
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: INFO: possible circular locking dependency detected ],2.6.18-1.2200_selfsmp
 #1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Mailer
X-Check: 064bde0a5523e0b295c094b219946b81 on steudten.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.18-1.2200_selfsmp #1
-------------------------------------------------------
init/1 is trying to acquire lock:
 (&bdev_part_lock_key){--..}, at: [<c0476e89>] bd_claim_by_disk+0x5d/0x166

but task is already holding lock:
 (&new->reconfig_mutex){--..}, at: [<c05ced5c>] autorun_devices+0x128/0x2b4

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&new->reconfig_mutex){--..}:
       [<c0435e4e>] add_lock_to_list+0x5e/0x79
       [<c0437fa6>] __lock_acquire+0x91c/0x9fd
       [<c05d27bf>] md_open+0x22/0x53
       [<c0438040>] __lock_acquire+0x9b6/0x9fd
       [<c04383cf>] lock_acquire+0x6d/0x8a
       [<c05d27bf>] md_open+0x22/0x53
       [<c063b74e>] __mutex_lock_interruptible_slowpath+0xde/0x286
       [<c05d27bf>] md_open+0x22/0x53
       [<c063bc57>] __mutex_lock_slowpath+0x22a/0x232
       [<c05d27bf>] md_open+0x22/0x53
       [<c047733a>] do_open+0x85/0x2e2
       [<c04776ee>] blkdev_open+0x0/0x42
       [<c0477708>] blkdev_open+0x1a/0x42
       [<c046eb4a>] __dentry_open+0xc7/0x1ab
       [<c046eca8>] nameidata_to_filp+0x24/0x33
       [<c046ece9>] do_filp_open+0x32/0x39
       [<c063cd63>] _spin_unlock+0x14/0x1c
       [<c046ea79>] get_unused_fd+0xb9/0xc3
       [<c046ed32>] do_sys_open+0x42/0xbe
       [<c046ede7>] sys_open+0x1c/0x1e
       [<c0403f73>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

-> #1 (&bdev->bd_mutex){--..}:
       [<c0435e4e>] add_lock_to_list+0x5e/0x79
       [<c0437fa6>] __lock_acquire+0x91c/0x9fd
       [<c047730d>] do_open+0x58/0x2e2
       [<c063ba1f>] __mutex_unlock_slowpath+0x10a/0x113
       [<c0436f6c>] mark_held_locks+0x46/0x62
       [<c04383cf>] lock_acquire+0x6d/0x8a
       [<c047730d>] do_open+0x58/0x2e2
       [<c063bb0b>] __mutex_lock_slowpath+0xde/0x232
       [<c047730d>] do_open+0x58/0x2e2
       [<c0577c4d>] kobj_lookup+0x10d/0x168
       [<c047730d>] do_open+0x58/0x2e2
       [<c04775ea>] blkdev_get+0x53/0x5e
       [<c04773b2>] do_open+0xfd/0x2e2
       [<c04775ea>] blkdev_get+0x53/0x5e
       [<c047782c>] open_by_devnum+0x2d/0x38
       [<c05ccd53>] md_import_device+0x229/0x247
       [<c04db768>] task_has_capability+0x56/0x5e
       [<c0420c61>] printk+0x1f/0xaf
       [<c05d14b7>] md_ioctl+0xbe/0x13a4
       [<c0430620>] __kernel_text_address+0x18/0x23
       [<c040516c>] dump_trace+0x87/0x91
       [<c0430620>] __kernel_text_address+0x18/0x23
       [<c040516c>] dump_trace+0x87/0x91
       [<c0430620>] __kernel_text_address+0x18/0x23
       [<c040516c>] dump_trace+0x87/0x91
       [<c0436a55>] find_usage_backwards+0x64/0x88
       [<c0436a55>] find_usage_backwards+0x64/0x88
       [<c0436a92>] check_usage_backwards+0x19/0x41
       [<c05d27bf>] md_open+0x22/0x53
       [<c0436eaa>] mark_lock+0x324/0x3a0
       [<c04f6395>] blkdev_driver_ioctl+0x4e/0x5e
       [<c04f69f1>] blkdev_ioctl+0x64c/0x69b
       [<c04370ab>] trace_hardirqs_on+0x123/0x14d
       [<c04dafe9>] avc_has_perm+0x4e/0x58
       [<c04db64d>] inode_has_perm+0x5b/0x63
       [<c0438040>] __lock_acquire+0x9b6/0x9fd
       [<c047fbd0>] set_close_on_exec+0x24/0x41
       [<c046e994>] fd_install+0x24/0x50
       [<c04db6e1>] file_has_perm+0x8c/0x94
       [<c0476b6d>] block_ioctl+0x18/0x1b
       [<c0476b55>] block_ioctl+0x0/0x1b
       [<c04801d7>] do_ioctl+0x1f/0x62
       [<c0480464>] vfs_ioctl+0x24a/0x25c
       [<c04804c2>] sys_ioctl+0x4c/0x66
       [<c0403f73>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

-> #0 (&bdev_part_lock_key){--..}:
       [<c0437eb4>] __lock_acquire+0x82a/0x9fd
       [<c0476e89>] bd_claim_by_disk+0x5d/0x166
       [<c046b65d>] cache_alloc_debugcheck_after+0xc4/0x13a
       [<c04383cf>] lock_acquire+0x6d/0x8a
       [<c0476e89>] bd_claim_by_disk+0x5d/0x166
       [<c063bb0b>] __mutex_lock_slowpath+0xde/0x232
       [<c0476e89>] bd_claim_by_disk+0x5d/0x166
       [<c0476e89>] bd_claim_by_disk+0x5d/0x166
       [<c05ccf76>] bind_rdev_to_array+0x205/0x223
       [<c04370ab>] trace_hardirqs_on+0x123/0x14d
       [<c05ced5c>] autorun_devices+0x128/0x2b4
       [<c05cee0a>] autorun_devices+0x1d6/0x2b4
       [<c0420c61>] printk+0x1f/0xaf
       [<c05d1518>] md_ioctl+0x11f/0x13a4
       [<c0430620>] __kernel_text_address+0x18/0x23
       [<c040516c>] dump_trace+0x87/0x91
       [<c0430620>] __kernel_text_address+0x18/0x23
       [<c040516c>] dump_trace+0x87/0x91
       [<c0430620>] __kernel_text_address+0x18/0x23
       [<c040516c>] dump_trace+0x87/0x91
       [<c0436a55>] find_usage_backwards+0x64/0x88
       [<c0436a55>] find_usage_backwards+0x64/0x88
       [<c0436a92>] check_usage_backwards+0x19/0x41
       [<c05d27bf>] md_open+0x22/0x53
       [<c0436eaa>] mark_lock+0x324/0x3a0
       [<c04f6395>] blkdev_driver_ioctl+0x4e/0x5e
       [<c04f69f1>] blkdev_ioctl+0x64c/0x69b
       [<c04370ab>] trace_hardirqs_on+0x123/0x14d
       [<c04dafe9>] avc_has_perm+0x4e/0x58
       [<c04db64d>] inode_has_perm+0x5b/0x63
       [<c0438040>] __lock_acquire+0x9b6/0x9fd
       [<c047fbd0>] set_close_on_exec+0x24/0x41
       [<c046e994>] fd_install+0x24/0x50
       [<c04db6e1>] file_has_perm+0x8c/0x94
       [<c0476b6d>] block_ioctl+0x18/0x1b
       [<c0476b55>] block_ioctl+0x0/0x1b
       [<c04801d7>] do_ioctl+0x1f/0x62
       [<c0480464>] vfs_ioctl+0x24a/0x25c
       [<c04804c2>] sys_ioctl+0x4c/0x66
       [<c0403f73>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff


other info that might help us debug this:

1 lock held by init/1:
 #0:  (&new->reconfig_mutex){--..}, at: [<c05ced5c>] autorun_devices+0x128/0x2b4

stack backtrace:
 [<c0437682>] print_circular_bug_tail+0x5d/0x65
 [<c0437eb4>] __lock_acquire+0x82a/0x9fd
 [<c0476e89>] bd_claim_by_disk+0x5d/0x166
 [<c046b65d>] cache_alloc_debugcheck_after+0xc4/0x13a
 [<c04383cf>] lock_acquire+0x6d/0x8a
 [<c0476e89>] bd_claim_by_disk+0x5d/0x166
 [<c063bb0b>] __mutex_lock_slowpath+0xde/0x232
 [<c0476e89>] bd_claim_by_disk+0x5d/0x166
 [<c0476e89>] bd_claim_by_disk+0x5d/0x166
 [<c05ccf76>] bind_rdev_to_array+0x205/0x223
 [<c04370ab>] trace_hardirqs_on+0x123/0x14d
 [<c05ced5c>] autorun_devices+0x128/0x2b4
 [<c05cee0a>] autorun_devices+0x1d6/0x2b4
 [<c0420c61>] printk+0x1f/0xaf
 [<c05d1518>] md_ioctl+0x11f/0x13a4
 [<c0430620>] __kernel_text_address+0x18/0x23
 [<c040516c>] dump_trace+0x87/0x91
 [<c0430620>] __kernel_text_address+0x18/0x23
 [<c040516c>] dump_trace+0x87/0x91
 [<c0430620>] __kernel_text_address+0x18/0x23
 [<c040516c>] dump_trace+0x87/0x91
 [<c0436a55>] find_usage_backwards+0x64/0x88
 [<c0436a55>] find_usage_backwards+0x64/0x88
 [<c0436a92>] check_usage_backwards+0x19/0x41
 [<c05d27bf>] md_open+0x22/0x53
 [<c0436eaa>] mark_lock+0x324/0x3a0
 [<c04f6395>] blkdev_driver_ioctl+0x4e/0x5e
 [<c04f69f1>] blkdev_ioctl+0x64c/0x69b
 [<c04370ab>] trace_hardirqs_on+0x123/0x14d
 [<c04dafe9>] avc_has_perm+0x4e/0x58
 [<c04db64d>] inode_has_perm+0x5b/0x63
 [<c0438040>] __lock_acquire+0x9b6/0x9fd
 [<c047fbd0>] set_close_on_exec+0x24/0x41
 [<c046e994>] fd_install+0x24/0x50
 [<c04db6e1>] file_has_perm+0x8c/0x94
 [<c0476b6d>] block_ioctl+0x18/0x1b
 [<c0476b55>] block_ioctl+0x0/0x1b
 [<c04801d7>] do_ioctl+0x1f/0x62
 [<c0480464>] vfs_ioctl+0x24a/0x25c
 [<c04804c2>] sys_ioctl+0x4c/0x66
 [<c0403f73>] syscall_call+0x7/0xb
 =======================

