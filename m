Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276069AbSIVFZD>; Sun, 22 Sep 2002 01:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276278AbSIVFZD>; Sun, 22 Sep 2002 01:25:03 -0400
Received: from packet.digeo.com ([12.110.80.53]:9702 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S276069AbSIVFY7>;
	Sun, 22 Sep 2002 01:24:59 -0400
Message-ID: <3D8D5559.AF112E57@digeo.com>
Date: Sat, 21 Sep 2002 22:30:01 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.37-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2002 05:30:01.0919 (UTC) FILETIME=[194F8CF0:01C261F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.37/2.5.37-mm1/

Reminder: it breaks top(1) and vmstat(1).  Updates to these tools
are at http://surriel.com/procps/

+ide-high-1.patch

 Fix block-highmem for IDE.  From Jens.

+ide-block-fix-1.patch

 Fix some boot-time hang which I had.  From Jens.

-writeback-control.patch
-free_area_init-cleanup.patch
-alloc_pages-cleanup.patch
-statm_pgd_range-sucks.patch
-remove-sync_thresh.patch
-vm-mapping-fix.patch
-taka-writev.patch
-writev-fix.patch
-pf_nowarn.patch
-misc.patch
-release_pages-speedup.patch
-highmem-huge-tlb.patch

 Merged

+might_sleep.patch

 Debug patch to catch people calling things like kmalloc(__GFP_WAIT),
 down(), etc from inside spinlocks.  This is a much stronger test than
 the one in schedule().  It's really only effective with CONFIG_PREEMPT=y.

 Causes a storm of complaints and stack backtraces at boot due to
 drivers/ide/ide-probe.c:init_irq() calling lots of things which it
 shouldn't under ide_lock.  It will find other bugs.

+set_page_dirty-locking-fix.patch

 We don't need to hold mapping->private_lock while moving the page
 onto its mapping's dirty_pages list.

+swsusp-feature.patch

 Feature for software suspend to force page reclaim.  Doesn't work right.

+adaptec-fix.patch

 Fix the lockup which happens each time the aic7xxx driver encounters
 an IO error.

+remove-page-virtual.patch

 Remove page->virtual, hash for it.

+dirty-memory-clamp.patch

 Kill off the secret benchmarking feature which allowed the dirty memory
 threshold to be exceeded when running dbench.  Makes the kernel really
 strict about limiting the amount of dirty memory and should make the
 buffer_head stripping code more effective.

+mempool-wakeup-fix.patch

 Fix a task lockup which can happen in mempool_alloc() when the number
 of sleeping tasks exceeds the size of the mempool.

+remove-write_mapping_buffers.patch

 Remove the write_mapping_buffers() function.  It didn't work out.

+buffer_boundary-scheduling.patch

 Use the buffer_boundary() block-mapping hint for scheduling of IO
 against indirect blocks.  This _does_ work out.  Large-file writeback
 is now smooth and seekless.

+ll_rw_block-cleanup.patch

 Clean up the ll_rw_block() function.

+lseek-ext2_readdir.patch

 Remove the lock_kernel() in ext2_readdir().  I'm fairly sure that it's
 superfluous, and it was being irritating.

+discontig-no-contig_page_data.patch

 Make sure that contig_page_data is undefined on discontigmem builds.

+per-node-zone_normal.patch

 Make the normal zone per-node rather than global on the NUMAQ's.

+alloc_pages_node-cleanup.patch

 Clean up alloc_pages_node()

+read_barrier_depends.patch
+rcu_ltimer.patch
+dcache_rcu.patch

 The dcache RCU code.

 I do not intend to send this on to Linus.  It is not my area and I
 do not understand the code.

 But a 15% hit in specweb99 on an 8-way is sigificant and no other
 solution has presented itself.  So this way, this code gets some extra
 testing.  Plus clearing away this problem helps us to identify other
 bottlenecks.

 I shall keep these patches ticking over as a general service to the
 people who are interested in, and working on 2.5 performance.


No real progress has been made on the writer-starves-reader problem
which is impacting the `contest' io_fullload test.   This is a severe
problem - a streaming write is decreasing read performance from the
same disk by a factor of 4000.  Working on it.




linus.patch
  cset-1.565.1.13-to-1.565.6.1.txt.gz

ide-high-1.patch

ide-block-fix-1.patch

scsi_hack.patch
  Fix block-highmem for scsi

ext3-htree.patch
  Indexed directories for ext3

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

might_sleep.patch
  debug code to detect might-sleep-inside-spinlock bugs

queue-congestion.patch
  Infrastructure for communicating request queue congestion to the VM

nonblocking-ext2-preread.patch
  avoid ext2 inode prereads if the queue is congested

nonblocking-pdflush.patch
  non-blocking writeback infrastructure, use it for pdflush

nonblocking-vm.patch
  Non-blocking page reclaim

set_page_dirty-locking-fix.patch
  don't call __mark_inode_dirty under spinlock

prepare_to_wait.patch
  prepare_to_wait/finish_wait: new sleep/wakeup API

vm-wakeups.patch
  Use the faster wakeups in the VM and block layers

sync-helper.patch
  Speed up sys_sync() against multiple spindles

slabasap.patch
  Early and smarter shrinking of slabs

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

buddyinfo.patch
  Add /proc/buddyinfo - stats on the free pages pool

free_area.patch
  Remove struct free_area_struct and free_area_t, use `struct free_area'

per-node-kswapd.patch
  Per-node kswapd instance

topology-api.patch
  Simple topology API

radix_tree_gang_lookup.patch
  radix tree gang lookup

truncate_inode_pages.patch
  truncate/invalidate_inode_pages rewrite

proc_vmstat.patch
  Move the vm accounting out of /proc/stat

kswapd-reclaim-stats.patch
  Add kswapd_steal to /proc/vmstat

iowait.patch
  I/O wait statistics

sard.patch
  SARD disk accounting

remove-gfp_nfs.patch
  remove GFP_NFS

tcp-wakeups.patch
  Use fast wakeups in TCP/IPV4

swapoff-deadlock.patch
  Fix a tmpfs swapoff deadlock

dirty-and-uptodate.patch
  page state cleanup

shmem_rename.patch
  shmem_rename() directory link count fix

dirent-size.patch
  tmpfs: show a non-zero size for directories

tmpfs-trivia.patch
  tmpfs: small fixlets

per-zone-vm.patch
  separate the kswapd and direct reclaim code paths

swsusp-feature.patch
  add shrink_all_memory() for swsusp

adaptec-fix.patch
  partial fix for aic7xxx error recovery

remove-page-virtual.patch
  remove page->virtual for !WANT_PAGE_VIRTUAL

dirty-memory-clamp.patch
  sterner dirty-memory clamping

mempool-wakeup-fix.patch
  Fix for stuck tasks in mempool_alloc()

remove-write_mapping_buffers.patch
  Remove write_mapping_buffers

buffer_boundary-scheduling.patch
  IO schduling for indirect blocks

ll_rw_block-cleanup.patch
  cleanup ll_rw_block()

lseek-ext2_readdir.patch
  remove lock_kernel() from ext2_readdir()

discontig-no-contig_page_data.patch
  undefine contif_page_data for discontigmem

per-node-zone_normal.patch
  ia32 NUMA: per-node ZONE_NORMAL

alloc_pages_node-cleanup.patch
  alloc_pages_node cleanup

read_barrier_depends.patch
  extended barrier primitives

rcu_ltimer.patch
  RCU core

dcache_rcu.patch
  Use RCU for dcache
