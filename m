Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262110AbSJFSmU>; Sun, 6 Oct 2002 14:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262118AbSJFSmU>; Sun, 6 Oct 2002 14:42:20 -0400
Received: from packet.digeo.com ([12.110.80.53]:42902 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262110AbSJFSmQ>;
	Sun, 6 Oct 2002 14:42:16 -0400
Message-ID: <3DA0854E.CF9080D7@digeo.com>
Date: Sun, 06 Oct 2002 11:47:42 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.40-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2002 18:47:47.0924 (UTC) FILETIME=[DD74C940:01C26D68]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.40/2.5.40-mm2/

- Peter Chubb's 64-bit sector_t patches have been included.  These
  are working fine and are a 2.6 must-have, IMO.

- Included Manfred's slab rework.  No problems observed there.

- The per-cpu hot-n-cold pages code continues to disappoint.  For some
  weird reason, the enormous lock contention which was observed in 
  rmqueue and __free_pages_ok in 2.5.9 has vanished in 2.5.40 on
  the big ppc64 boxen.  So these patches fix something which isn't
  there any more.  Could be related to the hardware (which changed);
  we're still poking at it.

  One test which involves repeatedly writing and then truncating smallish
  files was sped up 60%, which indicates that the cache locality stuff
  is working correctly, but it's a bit artificial.

  Ingo said that his 2.4-based per-cpu-pages patch was beneficial to
  specweb, but nobody has tested these patches with specweb.  Hint.

- Started work on /proc/sys/vm/swappiness.  Setting it to 100% gives
  you current 2.5 behaviour.  Setting it to 0 feels pretty similar to
  2.4.19.

  I ran it for half a day; seems to work OK.  Although running a KDE
  desktop on dual 25" monitors in 96 megabytes is not a ton of fun.

  More things to be done on this.  If anyone tests this code on a
  small machine, you really do need to set /proc/sys/vm/dirty_async_ratio
  to 15.  I'll be making this dynamic.

- Started work on a page reservation API to solve the problem of ENOMEM
  during radix-tree and pte_chain allocations.  It's untested and unused
  at present.

- Dropped the sard patch for now - it kept on getting stomped by the
  gendisk rework.


+discontig-setup-fix.patch

 A discontigmem compile fix

+remove-get_free_page.patch

 Remove get_free_page() from the kernel API.

+wli-libfs.patch

 Move some library functions from ramfs to libfs

+hugetlb-prefault.patch

 Factor out some hugetlb code - preparation for hugetlbfs

-misc.patch
-ioperm-fix.patch
-radix_tree_gang_lookup.patch
-truncate_inode_pages.patch
-proc_vmstat.patch
-kswapd-reclaim-stats.patch
-iowait.patch
-bd-sard.patch
-dio-bio-add-page.patch
-tcp-wakeups.patch
-swapoff-deadlock.patch
-dirty-and-uptodate.patch
-shmem_rename.patch
-dirent-size.patch
-tmpfs-trivia.patch
-per-zone-vm.patch
 swsusp-feature.patch
-bio-get-nr-vecs.patch
-dio-nr-segs.patch
-remove-page-virtual.patch
-dirty-memory-clamp.patch
-mempool-wakeup-fix.patch
-remove-write_mapping_buffers.patch
-buffer_boundary-scheduling.patch
-ll_rw_block-cleanup.patch

 Merged

+dio-fine-alignment.patch

 Permit 512-byte-aligned direct IO against larger-than-512-byte blocksize
 filesystems.

+lbd1.patch
+lbd2.patch
+lbd3.patch
+lbd4.patch
+lbd5.patch
+lbd6.patch

 64-bit sector_t option.

+64-bit-sector_t.patch

 Make 64-bit sector_t's compulsory in config (accellerated testing)

+page-reservation.patch

 Page reervation API

+slab-split-01-rename.patch
+slab-split-02-SMP.patch
+slab-split-03-tail.patch
+slab-split-04-drain.patch
+slab-split-05-name.patch
+slab-split-06-mand-cpuarray.patch
+slab-split-07-inline.patch
+slab-split-08-reap.patch

 slab rework

+cpucache_init-fix.patch

 Fix the above

+large-queue-throttle.patch

 Fixed writer throttling for tiny machines which have large disk queues

+exit-page-referenced.patch

 Propagate the pte referenced bit into PG_referenced for pagecache pages
 during pagetable teardown

+swappiness.patch

 /proc/sys/vm/swappiness








linus.patch
  cset-1.663.1.1-to-1.752.txt.gz

discontig-setup-fix.patch
  discontigmem compile fix

discontig-no-contig_page_data.patch
  undefine contif_page_data for discontigmem

per-node-mem_map.patch
  ia32 NUMA: per-node ZONE_NORMAL

remove-get_free_page.patch
  remove get_free_page()

alloc_pages_node-cleanup.patch
  alloc_pages_node cleanup

free_area_init-cleanup.patch
  free_area_init_node cleanup

wli-libfs.patch
  Move dentry library functions from ramfs to libfs

hugetlb-prefault.patch
  hugetlbpages: factor out some code for hugetlbfs

ext3-dxdir.patch
  ext3 htree

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

swsusp-feature.patch
  add shrink_all_memory() for swsusp

lseek-ext2_readdir.patch
  remove lock_kernel() from ext2_readdir()

dio-fine-alignment.patch
  Allow O_DIRECT to use 512-byte alignment

batched-slab-asap.patch
  batched slab shrinking

lbd1.patch
  64-bit sector_t 1/5

lbd2.patch
  64-bit sector_t 2/5

lbd3.patch
  64-bit sector_t 3/5

lbd4.patch
  64-bit sector_t 4/5

lbd5.patch
  64-bit sector_t 5/5

lbd6.patch
  64-bit sector_t 6/5

64-bit-sector_t.patch
  Hardwire CONFIG_LBD to "on"

akpm-deadline.patch
  deadline scheduler tweaks

rmqueue_bulk.patch
  bulk page allocator

free_pages_bulk.patch
  Bulk page freeing function

hot_cold_pages.patch
  Hot/Cold pages and zone->lock amortisation

readahead-cold-pages.patch
  Use cache-cold pages for pagecache reads.

pagevec-hot-cold-hint.patch
  hot/cold hints for truncate and page reclaim

page-reservation.patch
  Page reservation API

intel-user-copy.patch
  Faster copt_*_user for Intel ia32 CPUs

slab-split-01-rename.patch
  slab cleanup: rename static functions

slab-split-02-SMP.patch
  slab: enable the cpu arrays on uniprocessor

slab-split-03-tail.patch
  slab: reduced internal fragmentation

slab-split-04-drain.patch
  slab: take the spinlock in the drain function.

slab-split-05-name.patch
  slab: remove spaces from /proc identifiers

slab-split-06-mand-cpuarray.patch
  slab: cleanups and speedups

slab-split-07-inline.patch
  slab: uninline poisoning checks

slab-split-08-reap.patch
  slab: reap timers

cpucache_init-fix.patch
  cpucache_init fix

large-queue-throttle.patch
  Improve writer throttling for small machines

exit-page-referenced.patch
  Propagate pte referenced bit into pagecache during unmap

swappiness.patch
  swappiness control

read_barrier_depends.patch
  extended barrier primitives

rcu_ltimer.patch
  RCU core

dcache_rcu.patch
  Use RCU for dcache
