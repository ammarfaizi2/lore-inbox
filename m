Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbSKWD5e>; Fri, 22 Nov 2002 22:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbSKWD5e>; Fri, 22 Nov 2002 22:57:34 -0500
Received: from packet.digeo.com ([12.110.80.53]:50426 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266736AbSKWD5a>;
	Fri, 22 Nov 2002 22:57:30 -0500
Message-ID: <3DDEFE51.E1D9F8E7@digeo.com>
Date: Fri, 22 Nov 2002 20:04:33 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.49-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Nov 2002 04:04:34.0247 (UTC) FILETIME=[6E976570:01C292A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.49/2.5.49-mm1/

. Dave found the shared pagetable bug which was causing KDE startup to
  fail.  So pagetable sharing is now fully-stable-as-far-as-we-know.

. The AIO-for-direct-IO code should be all ready to go now.  I added
  some code to get around the problem of running set_page_dirty()
  from interrupt context.  It looks great, but I haven't tested it.

. Ingo Oeser's rework of the get_user_pages() implementation is here.
  This splits the user pagetable walk into a walker engine and a per-page
  callback.  It doesn't actually add anything new yet, but this is
  required infrastructure for doing zerocopy scatter/gather DMA things
  for character drivers (I think - ask Ingo).

. Included Manfred's poll/select speedup work.

. Version 0.8 of the patch management scripts is available at
  http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.8/
  No major changes recently - just little fixes.

. And a mention: 2.5.49 includes an extension to ext2 which will cause
  it to not attach buffer_head structures to file or directory pagecache
  at all, ever.  This is for the big highmem machines.  It is enabled via
  the `-o nobh' mount option.

  It passes my testing, and it would be appreciated if others were to give
  it an exercise.  Stability, correctness and performance testing is needed
  (it actually seemed a little quicker in my testing).



Changes since 2.5.48-mm1:

-axboe-scsi-fix.patch

 A different fix was merged.

-misc.patch
-radix-tree-height-reinit.patch
-loop-balance-pages.patch
-page-state-messages.patch
-congestion-wait.patch
-mmapped-blockdev-warning.patch
-s_dir_count-fix.patch
-rz-bootmem-fix.patch
-back-to-writepage.patch
-dio-reduce-context-switch-rate.patch
-resurrect-incremental-min.patch
-unfreeable-zones.patch
-nobh.patch

 Merged

+epoll-bits-0.57.patch

 Davide's latest epoll update.

+kgdb-use-stabs.patch

 Make the disk image smaller when kgdb is enabled

+timer-mopup.patch

 Initialise a timer

+deferred-bio-dirtying.patch

 Handle the set_page_dirty()-from-interrupts requirement.

+aio-dio-deferred-dirtying.patch

 Use it in aio-for-direct-io

+aio-dio-debug.patch

 Testing stuff

+reduce-random-context-switch-rate.patch

 Lessen the context switch rate caused by add_disk_randomness()

-kmap-atomic-nfs.patch

 Other NFS changes broke this.

+page-walk-api.patch

 get_user_pages() rework.

+signal-speedup.patch

 Makes the signal delivery code more efficient

+poll-1-wqalloc.patch
+poll-2-selectalloc.patch
+poll-3-alloc.patch
+poll-4-fast-select.patch
+poll-5-fast-poll.patch
+poll-6-merge.patch

 poll/select speedups

+shpte-remap-page-range-unsharing.patch
+shpte-mmap-cow-fix.patch
+shpte-address-correctness.patch

 Shared pagetable fixes.



All patches:

epoll-bits-0.57.patch
  epoll bits 0.57 ( on top of 2.5.49 ) ...

plugbug.patch
  plug a plugging bug

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-nmi-signal.patch

kgdb-nr-cpus.patch

kgdb-use-stabs.patch
  use -gstabs for kgdb

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

timer-mopup.patch

writeback-reduced-context-switches.patch
  reduced context switch rate in writeback

scheduling-points.patch
  Add some low-latency scheduling points

radix-tree-overflow-fix.patch
  handle overflows in radix_tree_gang_lookup()

swap-accounting.patch
  realtime swapspace accounting

swapoff-cleanup.patch
  swapoff accounting cleanup

page-reclaim-scheduling-points.patch
  Add a scheduling point to page reclaim

sync_blockdev-lock-kernel.patch
  Don't hold BKL across sync_blockdev() in blkdev_put()

simplified-vm-throttling.patch
  Remove the final per-page throttling site in the VM

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

page-reclaim-motion.patch
  Move reclaimable pages to the tail ofthe inactive list on IO completion

handle-fail-writepage.patch
  Special-case fail_writepage() in page reclaim

activate-unreleaseable-pages.patch
  Move unreleasable pages onto the active list

incremental-slab-shrink.patch
  reduced latency in dentry and inode cache shrinking

aio-direct-io-infrastructure.patch
  AIO support for raw/O_DIRECT

deferred-bio-dirtying.patch
  bio dirtying infrastructure

aio-direct-io.patch
  AIO support for raw/O_DIRECT

aio-dio-deferred-dirtying.patch
  Use the deferred-page-dirtying code in the AIO-DIO code.

aio-dio-debug.patch

dio-counting.patch

dio-reduce-context-switch-rate.patch
  Reduced wakeup rate in direct-io code

inlines-net.patch

reiserfs-readpages.patch
  reiserfs v3 readpages support

reiserfs-readpages-fix.patch

reduce-random-context-switch-rate.patch
  Reduce context switch rate due to the random driver

rbtree-iosched.patch
  rbtree-based IO scheduler

less-requests.patch
  Go back to 128 read and 128 write requests per queue

page-reservation.patch
  Page reservation API

wli-show_free_areas.patch
  show_free_areas extensions

page-walk-api.patch

genksyms-fix.patch
  modversions fix for exporting per-cpu data

signal-speedup.patch

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

rcu-stats.patch
  RCU statistics reporting

dcache_rcu-2-2.5.48.patch

dcache_rcu-3-2.5.48.patch

shpte-ng.patch
  pagetable sharing for ia32

shpte-protection-fix.patch
  shared pagetable protection fix

shpte-remap-page-range-unsharing.patch
  shared pagetables: handle unsharing for remap_page_range()

shpte-mmap-cow-fix.patch
  shared pagetables: Break COW page tables on mmap

shpte-address-correctness.patch
  shared pagetables: handle addresses correctly
