Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbSLIWXV>; Mon, 9 Dec 2002 17:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266310AbSLIWXV>; Mon, 9 Dec 2002 17:23:21 -0500
Received: from packet.digeo.com ([12.110.80.53]:5263 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266286AbSLIWXL>;
	Mon, 9 Dec 2002 17:23:11 -0500
Message-ID: <3DF453C8.18B24E66@digeo.com>
Date: Mon, 09 Dec 2002 00:26:48 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.50-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2002 08:26:48.0640 (UTC) FILETIME=[B7A13C00:01C29F5C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.50/2.5.50-mm2/

  -> 2.5.50-mm2.gz        Full patch
  -> 2.5.50-mm2-shpte.gz  Up to `shpte-always-on', for Dave to work against

Lots of fixes. Some things dropped for various reasons.  A decent
amount of rework against the high-level writeback code.


Since 2.5.50-mm1:

-fbcon-timer-fix.patch
-hugepage-fixes.patch
-ext3-oldalloc.patch
-simplified-vm-throttling.patch
-page-reclaim-motion.patch
-handle-fail-writepage.patch
-activate-unreleaseable-pages.patch
-ipc_barriers.patch
-signal-speedup.patch
-pf_memdie.patch
-suppress-write-error-warnings.patch
-truncate-speedup.patch
-spill-lru-lists.patch
-readdir-speedup.patch       (Linus fixed all the bugs in it)

 Merged

-epoll-bits-0.57.patch
+epoll.patch

 Davide's latest

-aio-dio-really-submit.patch
-aio-dio-deferred-dirtying.patch
-dio-counting.patch

 Folded into other patches.

-reiserfs-readpages.patch

 Dropped - it was causing fsx-linux failures.

+cputimes_stat.patch

 Put the per-cpu times back into /proc/pid/stat, CONFIGurably

-poll-1-wqalloc.patch
-poll-2-selectalloc.patch
-poll-3-alloc.patch
-poll-4-fast-select.patch
-poll-5-fast-poll.patch
-poll-6-merge.patch

 Dropped.  Increased stack utilisation was a concern, and the performance
 benefits are patchy.  Manfred is taking another look at it.

+deadsched-fix.patch

 Deadline scheduler fix

+shpte-nonlinear.patch

 Fix shared pagetables for nonlinear mappings

+pmd-allocation-fix.patch

 Always allocate PMD's out to the top of the virtual address space.

-dcache_rcu-2-2.5.48.patch
-dcache_rcu-3-2.5.48.patch

 Dropped.  Other changes broke it, and Dipankar is redoing a few things
 anyway.

+filldir-checks.patch

 Some copy_*_user checks.

+vmstats-fixes.patch

 Small vm stats fix and enhancement.

+hugetlb-fixes.patch

 Fixes from Rohit.

+writeback-interaction-fix.patch

 I had a few oddities and bogons in the fs/fs-writeback.c code.  This
 patch is a fair-sized revamp, cleanup and general sort-things-out in
 there.  It works better.

+scalable-zone-protection.patch

 Allow runtime tuning of the lower-zone protection ratio.  Needs work.

+page-wait-table-min-size.patch

 Don't allow a one-slot hashed wait table for wait_on_page()

+ext3-transaction-reserved-blocks.patch

 Fix an ext3 assertion failure which is triggerable with corrupt disk
 contents.

+remove-PF_SYNC.patch

 remove the current->flags:PF_SYNC abomination.  Adds a `sync' arg to
 all writepage implementations to tell them whether they are being
 called for memory cleansing or for data integrity.

+dont-inherit-mlockall.patch

 Don't inherit mlockall(MCL_FUTURE) across forks

+bootmem-alloc-alignment.patch

 Improved coalescing of bootmem regions

+ext23_free_blocks-check.patch

 Additional sanity checks in the block allocator.

+blkdev-rlimit.patch

 Don't apply rlimits to blockdev writes.

+readahead-pinned-memory.patch

 Don't allow gargantuan amounts of memory to be pinned in readahead

-page-walk-api-improvements.patch
-page-walk-api-bugfix.patch

 Folded into page-walk-api.patch

+page-walk-api-update.patch

 New stuff from Ingo (needs splitting up and changelogging...)




All 55 patches:


linus.patch
  cset-1.797.133.2-to-1.857.txt.gz

epoll.patch
  epoll bits 0.59 ...

kgdb.patch

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

deprecate-bdflush.patch
  deprecate use of bdflush()

reduce-random-context-switch-rate.patch
  Reduce context switch rate due to the random driver

bcrl-printk.patch

read_zero-speedup.patch
  speed up read_zero() for !CONFIG_MMU

nommu-rmap-locking.patch
  Fix rmap locking for CONFIG_SWAP=n

semtimedop.patch
  semtimedop - semop() with a timeout

writeback-handle-memory-backed.patch
  skip memory-backed filesystems in writeback

remove-fail_writepage.patch
  Remove fail_writepage()

page-reservation.patch
  Page reservation API

wli-show_free_areas.patch
  show_free_areas extensions

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

pmd-allocation-fix.patch
  make sure all PMDs are allocated under PAE mode

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

pentium-II.patch
  Pentium-II support bits

radix-tree-overflow-fix.patch
  handle overflows in radix_tree_gang_lookup()

rcu-stats.patch
  RCU statistics reporting

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

sync_fs.patch
  Add a sync_fs super_block operation

ext3_sync_fs.patch
  implement ext3_sync_fs

ext3-fsync-speedup.patch
  Clean up ext3_sync_file()

filldir-checks.patch
  copy_user checks in filldir()

vmstats-fixes.patch
  vm accounting fixes and addition

hugetlb-fixes.patch
  hugetlb fixes

writeback-interaction-fix.patch
  fs-writeback rework.

scalable-zone-protection.patch
  Add /proc/sys/vm/lower_zone_protection

page-wait-table-min-size.patch
  Set a minimum hash table size for wait_on_page()

ext3-transaction-reserved-blocks.patch
  Reserve an additional transaction block in ext3_dirty_inode

remove-PF_SYNC.patch

dont-inherit-mlockall.patch
  Don't inherit mm->def_flags across forks

bootmem-alloc-alignment.patch
  bootmem allocator merging fix

ext23_free_blocks-check.patch
  ext2/ext3_free_blocks() extra check

blkdev-rlimit.patch
  don't allpy file size rlimits to blockdevs

readahead-pinned-memory.patch
  limit pinned memory due to readahead

page-walk-api.patch

page-walk-scsi.patch

page-walk-api-update.patch
  pagewalk API update
