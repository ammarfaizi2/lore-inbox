Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262047AbTCVHAK>; Sat, 22 Mar 2003 02:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262048AbTCVHAK>; Sat, 22 Mar 2003 02:00:10 -0500
Received: from franka.aracnet.com ([216.99.193.44]:34733 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262047AbTCVHAH>; Sat, 22 Mar 2003 02:00:07 -0500
Date: Fri, 21 Mar 2003 23:11:00 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, Alex Tomas <bzzz@tmi.comex.ru>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: SDET runs on ext3
Message-ID: <353100000.1048317060@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For anyone who might doubt that ext3 doesn't scale ;-)
Run on 16x NUMA-Q w/16GB of RAM.

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
              2.5.65-mjb1       100.0%         1.4%
         2.5.65-mjb1-ext3        96.0%         1.5%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
              2.5.65-mjb1       100.0%         2.6%
         2.5.65-mjb1-ext3        80.9%         3.6%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
              2.5.65-mjb1       100.0%         0.9%
         2.5.65-mjb1-ext3        55.2%        11.0%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
              2.5.65-mjb1       100.0%         0.5%
         2.5.65-mjb1-ext3        33.0%        14.2%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
              2.5.65-mjb1       100.0%         0.3%
         2.5.65-mjb1-ext3        19.8%         1.7%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
              2.5.65-mjb1       100.0%         0.3%
         2.5.65-mjb1-ext3        16.6%         1.7%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
              2.5.65-mjb1       100.0%         0.6%
         2.5.65-mjb1-ext3        11.2%         1.2%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
              2.5.65-mjb1       100.0%         0.2%
         2.5.65-mjb1-ext3        12.8%         3.0%

profile w/ ext2 from SDET 128

1547 unmap_all_pages
1265 page_remove_rmap
1256 atomic_dec_and_lock
1218 copy_page_range
1179 d_lookup
1166 .text.lock.dec_and_lock
979 vfs_read
844 page_add_rmap
794 .text.lock.dcache
764 find_get_page
737 follow_mount
724 .text.lock.namei
701 __copy_to_user_ll
678 path_lookup
401 __down
358 do_wp_page
334 do_anonymous_page
324 remove_shared_vm_struct
315 path_release
303 __fput
291 copy_mm
283 schedule
277 pte_alloc_one
262 proc_pid_stat
257 do_no_page
253 kmem_cache_free
253 file_move
245 release_pages
245 copy_process
238 vfs_write
238 link_path_walk
229 do_page_fault
226 .text.lock.base
219 __find_get_block
214 d_alloc
202 free_hot_cold_page


profile w/ ext3 from SDET 128

44940 .text.lock.inode
6051 .text.lock.namei
5663 .text.lock.sched
4804 .text.lock.attr
1684 ext3_prepare_write
1082 unmap_all_pages
952 .text.lock.dir
938 page_remove_rmap
915 ext3_commit_write
904 copy_page_range
903 .text.lock.sem
759 __down
730 schedule
634 d_lookup
605 page_add_rmap
545 find_get_page
539 .text.lock.base
465 __copy_to_user_ll
451 .text.lock.ioctl
417 journal_add_journal_head
417 __blk_queue_bounce
392 inode_change_ok
367 ext3_setattr
362 do_anonymous_page
352 ext3_dirty_inode
347 __wake_up
336 do_wp_page
334 start_this_handle
267 atomic_dec_and_lock
260 __find_get_block
255 do_get_write_access
248 do_no_page
238 ext3_get_block_handle
236 path_lookup
222 kmap_atomic
222 ext3_get_inode_loc
217 remove_shared_vm_struct
211 do_page_fault
202 __mark_inode_dirty
201 vfs_read
201 pte_alloc_one

