Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbTBQAfA>; Sun, 16 Feb 2003 19:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbTBQAfA>; Sun, 16 Feb 2003 19:35:00 -0500
Received: from franka.aracnet.com ([216.99.193.44]:59046 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266637AbTBQAe6>; Sun, 16 Feb 2003 19:34:58 -0500
Date: Sun, 16 Feb 2003 16:44:46 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@digeo.com>
Subject: Performance of ext3 on large systems
Message-ID: <66390000.1045442686@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so I guess we all know that ext3 doesn't scale well. But by 
accident, I have some numbers on exactly how bad it really is:

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                                   Elapsed        User      System         CPU
            2.5.61-mjb0.1-ext3       48.47      564.13      143.16     1458.67
            2.5.61-mjb0.1-ext2       46.06      563.04      115.36     1472.33

(look at system time ... eeek!)

diffprofile (+ is worse with ext3, - better)

12702 .text.lock.inode
7786 default_idle
1706 ext3_dirty_inode
1694 start_this_handle
1636 ext3_do_update_inode
1304 .text.lock.dir
983 journal_add_journal_head
903 __find_get_block_slow
797 .text.lock.sem
630 __mark_inode_dirty
567 __brelse
537 __find_get_block
523 __wake_up
459 ext3_get_inode_loc
454 find_get_page
434 __blk_queue_bounce
382 generic_fillattr
360 fd_install
357 do_get_write_access
308 d_lookup
290 vfs_read
289 do_anonymous_page
272 dput
267 file_ra_state_init
249 journal_get_write_access
243 page_remove_rmap
222 link_path_walk
220 may_open
195 vm_enough_memory
189 ext3_readdir
186 journal_stop
185 journal_dirty_metadata
152 __fput
148 update_atime
110 zap_pte_range
105 .text.lock.sched
100 fput
96 buffered_rmqueue
95 filemap_nopage
93 ext3_prepare_write
90 page_add_rmap
86 find_next_usable_block
76 block_write_full_page
71 journal_cancel_revoke
70 bh_lru_install
65 journal_unlock_journal_head
64 .text.lock.namei
63 do_page_cache_readahead
61 log_space_left
61 ext3_check_dir_entry
59 __copy_from_user_ll
58 kfree
58 journal_commit_transaction
54 kmem_cache_free
54 do_sync_read
54 .text.lock.char_dev
50 ext3_get_block_handle
...
-52 find_vma
-58 page_address
-58 get_empty_filp
-60 do_generic_mapping_read
-74 ext2_readdir
-85 generic_file_open
-87 atomic_dec_and_lock
-109 file_move
-513 dentry_open
-1468 follow_mount
-2091 .text.lock.file_table

