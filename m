Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbSKSJJM>; Tue, 19 Nov 2002 04:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSKSJJM>; Tue, 19 Nov 2002 04:09:12 -0500
Received: from packet.digeo.com ([12.110.80.53]:13031 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264690AbSKSJJI>;
	Tue, 19 Nov 2002 04:09:08 -0500
Message-ID: <3DDA0153.A1971C76@digeo.com>
Date: Tue, 19 Nov 2002 01:16:03 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.48-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Nov 2002 09:16:03.0731 (UTC) FILETIME=[48BD5630:01C28FAC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.48/2.5.48-mm1/

Lots of little bits and pieces here.  Most notably I've started to
look at the scheduling latency of the uniprocessor preemptible kernel.
It was actually pretty awful.  Most everything in the MM/VFS area has
been fixed here, and it is now achieving 500 microseconds max latency
at 500MHz.

With the notable exception of the case where a task exits while holding
a large amount of mmapped memory.  300 milliseconds for a 700 megabyte
mapping, and a couple of milliseconds while just running cvs.  This will
take quite some fixing.

Only ext2 has been done.  Other filesystems will need attention.


Since 2.5.47-mm3:

 linus.patch

 Latest from Linus.

+axboe-scsi-fix.patch

 Fix a scsi plugging bug.

+kgdb-nmi-signal.patch
+kgdb-nr-cpus.patch

 Some work against George's patch

+misc.patch

 Little fixes

+radix-tree-height-reinit.patch

 Fix a radix-tree bug

+radix-tree-overflow-fix.patch

 And another (maybe - needs specific testing yet)

-mbcache-cleanup.patch
-rmap-flush-cache-page.patch
-swap-get_page-page-unlock.patch
-swap-writepages-swizzled.patch
-misc.patch
-htlb-combined-2.patch
-htlb-fixes.patch
-slab-no-BUG.patch
-remove-inode-buffers.patch
-mpage-kmap.patch
-inode-reclaim-balancing.patch

 Merged

+loop-balance-pages.patch

 Small optimisation to loop

+page-state-messages.patch

 Handle bad pages in the page allocator without going BUG

+remove-lame-test.patch

 Don't allow NULL pointers to be passed into wake_up any more.

+plugbug.patch

 Fix an SMP race in the disk queue plugging code.

+mmapped-blockdev-warning.patch

 Kill a warning which comes out with MAP_SHARED mappings of blockdevs

+s_dir_count-fix.patch

 Fix ext2/3 directory counting (for the Orlov allocator heuristics; not
 a serious bug)

+rz-bootmem-fix.patch

 Don't assume that physical memory starts at physical address 0

+dio-counting.patch

 Direct-IO cleanups

+dio-reduce-context-switch-rate.patch

 Reduce the context switch rate during direct-IO

+writeback-reduced-context-switches.patch

 Reduced context switch rate during writeback

+scheduling-points.patch

 Fix some long-held locks at the pagecache layer

+swap-accounting.patch

 And in the swap accounting

+swapoff-cleanup.patch

 Stuf from Hugh.

+page-reclaim-scheduling-points.patch

 And in page reclaim

+sync_blockdev-lock-kernel.patch

 And in the blockdev driver.

+incremental-slab-shrink.patch

 And in the slab cache pruner.

+np-deadline.patch

 Deadline scheduler work from Nick Piggin

+less-requests.patch

 I reduced the size of the disk queues.   A quarter-gig per disk
 is excessive.

-dcache_rcu.patch
+dcache_rcu-2-2.5.48.patch
+dcache_rcu-3-2.5.48.patch

 Split up

+shpte-protection-fix.patch

 A shared pagetable fix.




All patches

linus.patch
  cset-1.842-to-1.897.txt.gz

axboe-scsi-fix.patch

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-nmi-signal.patch

kgdb-nr-cpus.patch

misc.patch
  misc fixes

rcu-stats.patch
  RCU statistics reporting

genksyms-fix.patch
  modversions fix for exporting per-cpu data

radix-tree-height-reinit.patch
  Reinitialise radix tree height

radix-tree-overflow-fix.patch
  handle overflows in radix_tree_gang_lookup()

buffer-debug.patch
  buffer.c debugging

loop-balance-pages.patch
  Use balance_dirty_pages_ratelimited() in loop.c

page-state-messages.patch
  Expanded bad page handling

remove-lame-test.patch
  remove a strange test in __wake_up()

congestion-wait.patch
  Fix busy-wait with writeback to large queues

plugbug.patch
  plug a plugging bug

mmapped-blockdev-warning.patch
  remove a warning from __block_write_full_page()

s_dir_count-fix.patch
  ext2/ext3 Orlov directory accounting fix

rz-bootmem-fix.patch
  bootmem crash fix

back-to-writepage.patch
  Remove mapping->vm_writeback

aio-direct-io-infrastructure.patch
  AIO support for raw/O_DIRECT

aio-direct-io.patch
  AIO support for raw/O_DIRECT

dio-counting.patch

dio-reduce-context-switch-rate.patch
  Reduced wakeup rate in direct-io code

inlines-net.patch

reiserfs-readpages.patch
  reiserfs v3 readpages support

reiserfs-readpages-fix.patch

resurrect-incremental-min.patch
  strengthen the `incremental min' logic in the page allocator

unfreeable-zones.patch
  VM: handle zones which are full of unreclaimable pages

nobh.patch
  no-buffer-head ext2 option

writeback-reduced-context-switches.patch
  reduced context switch rate in writeback

scheduling-points.patch
  Add some low-latency scheduling points

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

rbtree-iosched.patch
  rbtree-based IO scheduler

np-deadline.patch
  deadline IO scheduler tweaks

less-requests.patch
  Go back to 128 read and 128 write requests per queue

page-reservation.patch
  Page reservation API

wli-show_free_areas.patch
  show_free_areas extensions

kmap-atomic-nfs.patch
  Subject: Re: [RFC] use kmap_atomic in the NFS client

dcache_rcu-2-2.5.48.patch

dcache_rcu-3-2.5.48.patch

shpte-ng.patch
  pagetable sharing for ia32

shpte-protection-fix.patch
  shared pagetable protection fix
