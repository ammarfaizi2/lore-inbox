Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbSLPI2p>; Mon, 16 Dec 2002 03:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbSLPI2p>; Mon, 16 Dec 2002 03:28:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:40911 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265705AbSLPI2l>;
	Mon, 16 Dec 2002 03:28:41 -0500
Message-ID: <3DFD908D.14D7F6E7@digeo.com>
Date: Mon, 16 Dec 2002 00:36:29 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.52-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Dec 2002 08:36:30.0202 (UTC) FILETIME=[3B28CDA0:01C2A4DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zipworld.com.au/~akpm/linux/patches/2.5/2.5.52/2.5.52-mm1/

  -> 2.5.52-mm1-shpte.gz       For Dave
  -> 2.5.52-mm1.gz             Full patch

A bunch of random stuff.  Most notably I now have restored ext2/ext3
dbench throughput on SMP to about the same level as it was before the
introduction of the Orlov allocator.

This was not the fault of the Orlov allocator - it just exposed some
weaknesses in the block allocation algorithms.  These changes should
benefit a range of workloads.


Changes since 2.5.51-mm2:

-PF_MEMALLOC-no-recur.patch
-deprecate-bdflush.patch
-bcrl-printk.patch
-read_zero-speedup.patch
-nommu-rmap-locking.patch
-semtimedop.patch
-writeback-handle-memory-backed.patch
-2-remove-fail_writepage.patch
-wli-show_free_areas.patch
-pmd-allocation-fix.patch
-radix-tree-overflow-fix.patch
-sync_fs.patch
-ext3_sync_fs.patch
-filldir-checks.patch
-vmstats-fixes.patch
-hugetlb-fixes.patch
-writeback-interaction-fix.patch
-scalable-zone-protection.patch
-page-wait-table-min-size.patch
-ext3-transaction-reserved-blocks.patch
-remove-PF_SYNC.patch
-dont-inherit-mlockall.patch
-bootmem-alloc-alignment.patch
-ext23_free_blocks-check.patch
-blkdev-rlimit.patch
-readahead-pinned-memory.patch
-remove-vmscan-check.patch
-max_sane_readahead.patch
-default-super-ops.patch
-mempool-atomic-check.patch
-page-allocator-off-by-one.patch
-cacheline-aligned-pte_chains.patch
-ext2-sync-dir-fix.patch

 Merged

-mmap-rounding-fix.patch

 Dropped.  Was already fixed in 2.5.

+sync_fs-deadlock-fix.patch

 Fix the fix for the fix for the ext3 journal=data umount bug.  Sigh.

+shrink_list-dirty-page-race.patch

 Fix an SMP race in page reclaim which isn't really there.

+slab-poisoning.patch

 Change the memory poisoning in the slab allocator so you can tell
 whether the oops was due to use-of-uninitialised-memory (0x5a5a5a5a)
 of use-of-freed-memory (0x6b6b6b6b)

+nommu-generic_file_readonly_mmap.patch

 Give !CONFIG_NOMMU a generic_file_readonly_mmap()

+misc.patch

 Minor fixes

+ext3-alloc-spread.patch
+ext2-alloc-spread.patch

 Don't start block allocation for new files at the zeroth block of
 the blockgroup all the time.

+spread-find_group_other.patch

 Don't place S_ISREG inodes into blockgroups which don't have any
 free blocks.

+iosched-doc.patch

 deadline IO scheduler docco.

+ext3-use-after-free.patch

 Fix the ext3 use-after-free bug which occurs when the filesystem runs
 out of space or inodes.

+dio-always-kmalloc.patch

 Never allocate `struct dio' on the stack.

+file-nr-doc-fix.patch

 Docco fix.

+set_page_dirty_lock.patch

 Lock pages when running set_page_dirty(), when there is nothing else
 to pin down page->mapping.

+gup-check-valid.patch

 Minor tweaks to the new page walker API.




All 48 patches:

linus.patch
  cset-1.980-to-1.981.txt.gz

kgdb.patch

sync_fs-deadlock-fix.patch
  sync_fs deadlock fix

shrink_list-dirty-page-race.patch
  fix a page dirtying race in vmscan.c

slab-poisoning.patch
  more informative slab poisoning

nommu-generic_file_readonly_mmap.patch
  Add generic_file_readonly_mmap() for nommu

dio-return-partial-result.patch

aio-direct-io-infrastructure.patch
  AIO support for raw/O_DIRECT

deferred-bio-dirtying.patch
  bio dirtying infrastructure

aio-direct-io.patch
  AIO support for raw/O_DIRECT

aio-dio-debug.patch

dio-reduce-context-switch-rate.patch
  Reduced wakeup rate in direct-io code

cputimes_stat.patch
  Retore per-cpu time accounting, with a config option

reduce-random-context-switch-rate.patch
  Reduce context switch rate due to the random driver

inlines-net.patch

rbtree-iosched.patch
  rbtree-based IO scheduler

deadsched-fix.patch
  deadline scheduler fix

quota-smp-locks.patch
  Subject: [PATCH] Quota SMP locks

shpte-ng.patch
  pagetable sharing for ia32

shpte-nonlinear.patch
  shpte: support nonlinear mappings and clean up clear_share_range()

shpte-always-on.patch
  Force CONFIG_SHAREPTE=y for ia32

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

misc.patch
  misc fixes

warn-null-wakeup.patch

pentium-II.patch
  Pentium-II support bits

rcu-stats.patch
  RCU statistics reporting

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

ext3-fsync-speedup.patch
  Clean up ext3_sync_file()

lockless-current_kernel_time.patch
  Lockless current_kernel_timer()

remove-PF_NOWARN.patch
  Remove PF_NOWARN

scheduler-tunables.patch
  scheduler tunables

blocking-kswapd.patch
  Give kswapd writeback higher priority than pdflush

ext3-alloc-spread.patch
  ext3: smarter block allocation startup

ext2-alloc-spread.patch
  ext2: smarter block allocation startup

spread-find_group_other.patch
  ext2/3: better starting group for S_ISREG files

iosched-doc.patch
  iosched tunables documentation

ext3-use-after-free.patch
  ext3 use-after-free bugfix

dio-always-kmalloc.patch
  direct-io: dynamically allocate struct dio

file-nr-doc-fix.patch
  Docs: fix explanation of file-nr

set_page_dirty_lock.patch
  fix set_page_dirty vs truncate&free races

dcache_rcu-2.patch
  dcache_rcu-2-2.5.51.patch

dcache_rcu-3.patch
  dcache_rcu-3-2.5.51.patch

page-walk-api.patch

page-walk-scsi.patch

page-walk-api-update.patch
  pagewalk API update

gup-check-valid.patch
  valid page test in get_user_pages()
