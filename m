Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSK0JEb>; Wed, 27 Nov 2002 04:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbSK0JEa>; Wed, 27 Nov 2002 04:04:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:44712 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261733AbSK0JE0>;
	Wed, 27 Nov 2002 04:04:26 -0500
Message-ID: <3DE48C4A.98979F0C@digeo.com>
Date: Wed, 27 Nov 2002 01:11:38 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.49-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2002 09:11:38.0739 (UTC) FILETIME=[FE18C430:01C295F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.49/2.5.49-mm2/

Lots of little things.

. Various micro-speedups from the AIM9 testing.

. VM changes to reduce the amount of (pointless) work which is done
  against memory-backed filesystems, leading up to the removal of
  fail_writepage().  (Hugh, please take a look...)

. Various fixes to the AIO-for-direct-IO code.

. An updated rbtree IO scheduler from Jens.

. Some code from Ingo Oeser to start using the expanded and cleaned up
  user pagetable walker code.  This affects the st and sg drivers; I'm
  not sure of the testing status of this?


Changes since 2.5.49-mm1:

+linus.patch

 Latest from Linus

+oprofile-fix.patch

 oprofile compilation fix

-kgdb-ga.patch
-kgdb-nmi-signal.patch
-kgdb-nr-cpus.patch
-kgdb-use-stabs.patch

 I was getting deadlocks (of the NMI watchdog variety) on scheduler
 locks.  Go back to the old stub for now.

-plugbug.patch
-writeback-reduced-context-switches.patch
-scheduling-points.patch
-swap-accounting.patch
-swapoff-cleanup.patch
-page-reclaim-scheduling-points.patch
-sync_blockdev-lock-kernel.patch
-incremental-slab-shrink.patch

 Merged

+kgdb.patch

 The old stub

+aio-dio-really-submit.patch

 AIO/direct-IO fixes

+ipc_barriers.patch

 Some IPC memory barrier fixes

-reiserfs-readpages-fix.patch

 Merged into reiserfs-readpages.patch

-less-requests.patch

 Jens made this change to the updated rbtree-iosched patch

+pf_memdie.patch

 Fix the PF_MEMDIE logic

+truncate-speedup.patch

 Special-case the truncation of zero-length files.  Saves some CPU.

+spill-lru-lists.patch

 Untangle interactions between the deferred lru addition queue and the
 per-cpu page allocator queue.

+readdir-speedup.patch

 Make readdir faster

-genksyms-fix.patch

 Dropped.  It was modules stuff,  and is probably now irrelevant.

+page-walk-api-improvements.patch

 More get_user_pages work from Ingo (Oeser)

+page-walk-scsi.patch

 Start to use Ingo's new APIs in the scsi code.  Basically, remove
 driver-private implementations in favour of new core APIs

+bcrl-printk.patch

 Ben's patch to create /dev/kmsg.  You can write to it from initscripts
 to inject text into the printk buffer.

+read_zero-speedup.patch

 Speed up read_zero() for !CONFIG_MMU

+nommu-rmap-locking.patch

 Fix an rmap deadlock for !CONFIG_SWAP

+semtimedop.patch

 semtimedop() implementation

+writeback-handle-memory-backed.patch

 Don't try to write out memory-backed filesystems at all

+remove-fail_writepage.patch

 fail_writepage() is no longer needed.

+ptrace-flush.patch

 Fix some cache coherency things in the ptrace code (this patch
 isn't right, but I'm keeping it around so the right fix gets
 done one day)

+pentium-II.patch

 Optimisations for Pentium-II config




All 54 patches:

linus.patch
  cset-1.842.2.15-to-1.893.txt.gz

oprofile-fix.patch

epoll-bits-0.57.patch
  epoll bits 0.57 ( on top of 2.5.49 ) ...

kgdb.patch

simplified-vm-throttling.patch
  Remove the final per-page throttling site in the VM

page-reclaim-motion.patch
  Move reclaimable pages to the tail ofthe inactive list on IO completion

handle-fail-writepage.patch
  Special-case fail_writepage() in page reclaim

activate-unreleaseable-pages.patch
  Move unreleasable pages onto the active list

aio-direct-io-infrastructure.patch
  AIO support for raw/O_DIRECT

deferred-bio-dirtying.patch
  bio dirtying infrastructure

aio-direct-io.patch
  AIO support for raw/O_DIRECT

aio-dio-really-submit.patch
  Fix up aio-for-dio

aio-dio-deferred-dirtying.patch
  Use the deferred-page-dirtying code in the AIO-DIO code.

aio-dio-debug.patch

dio-counting.patch

dio-reduce-context-switch-rate.patch
  Reduced wakeup rate in direct-io code

ipc_barriers.patch
  memory barrier work in ipc/util.c

signal-speedup.patch
  speed up signals

reiserfs-readpages.patch
  reiserfs v3 readpages support

reduce-random-context-switch-rate.patch
  Reduce context switch rate due to the random driver

pf_memdie.patch
  Subject: Re: [patch] 2.5: kill PF_MEMDIE

truncate-speedup.patch

spill-lru-lists.patch
  Fix interaction between batched lru addition and hot/cold pages

readdir-speedup.patch
  readdir speedup and fixes

page-walk-api.patch

page-walk-api-improvements.patch

page-walk-scsi.patch

poll-1-wqalloc.patch
  poll 1/6: reduced mempory requirements

poll-2-selectalloc.patch
  poll 2/6: put small bitmaps into a local

poll-3-alloc.patch
  poll 3/6: improved pollfd memory allocation

poll-4-fast-select.patch
  poll 4/6: select() speedups

poll-5-fast-poll.patch
  poll 5/6: poll() speedup

poll-6-merge.patch
  poll6/6: merge poll() and select() common code

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

dcache_rcu-2-2.5.48.patch

dcache_rcu-3-2.5.48.patch

shpte-ng.patch
  pagetable sharing for ia32
