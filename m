Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261795AbSJQFNK>; Thu, 17 Oct 2002 01:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261800AbSJQFNJ>; Thu, 17 Oct 2002 01:13:09 -0400
Received: from packet.digeo.com ([12.110.80.53]:4760 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261795AbSJQFNF>;
	Thu, 17 Oct 2002 01:13:05 -0400
Message-ID: <3DAE483F.D20EFAC6@digeo.com>
Date: Wed, 16 Oct 2002 22:18:55 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.43-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2002 05:18:56.0269 (UTC) FILETIME=[B0E12BD0:01C2759C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.43/2.5.43-mm2/


. I've pretty much dropped the per-cpu pages patches which Martin and
  I developed.

  These patches gave a 1-2% benefit in kernel compiles, up to 4% in
  Randy Hron's testing of the autoconf build tests.  2.2% in specweb. 
  And a 60% speedup in a little app which just looped writing 80k to a
  file and truncating it off again.

  All the above came from the cache-warmth effect.  The patches would
  give an overall 15% speedup due to reduced lock contention in Anton's
  testing on the big PPC64 machines, but he fixed that anyway by
  getting NUMA working properly.

  In my opinion, all the above is just too thin to justify throwing a
  bunch of new stuff into the page allocator.

  I shall continue to distribute these patches.  Maybe someone will
  find them sufficiently beneficial for something at a future time.

  But it simply seems to be the case that no interesting workloads
  repeatedly allocate and free small numbers of pages (in the 10-50
  range).

. The shared pagetable code is not in the main diff - it has a few
  problems at present.  The patches are over in the experimental/
  directory.  order of application is:

	shpte.patch
	shpte-lock-ranking-fix.patch
	shmmap.patch
	handle-mm-fault-locking.patch
	mremap-shared-pagetable-fix.patch
	shpte-unmap_all_pages_fix.patch
	unmap_page_range-fix.patch

. The slab rework is stable now and Manfred has some good
  microbenchmark numbers from that.  But we're still not quite ready
  with that code because the hotplug CPU APIs have, shall we say, a few
  shortcomings.


Since 2.5.43-mm1:

-disable-ppc-lbd.patch
-fs-inlines.patch
-md-fix.patch
-mpparse-fix.patch
-no-reclaim-throttle.patch
-refill-inactive-lockup-fix.patch
-reiserfs-kmap-fix.patch
-simple_rename-link-count.patch
-static-filemap_sync.patch
-uninline-highmem.patch
-vmalloc-overalloc.patch

 Merged

-meminfo-numa.patch

 Dropped.  To be moved from procfs into the NUMA preentation in
 driverfs.

+3c59x-udp-csum.patch

 Make the 3c59x driver work with UDP in Linus's current tree

+dmi-warning.patch
+ide-warnings.patch

 Stomp some compilation warnings

+dhowells-readahead.patch
+file_ra_state_init.patch

 Expose some finer-grained readahead facilities.

+less-unlikelies.patch

 Less buslocked traffic in the page allocator

+running-iowait.patch

 Expose nr_running and nr_iowait task counts in /proc

+uaccess-uninline.patch

 Uninline the ia32 copy_*_user functions.  (Now showing a 33kbyte
 shrink from this work)

+slab-cleanup.patch

 Less typedefs and macros in slab.c

+mm1-incr1.patch
+mm1-incr2.patch

 POSIX ACL and EA updates



All patches:


linus.patch
  cset-1.781.24.13-to-1.793.txt.gz

3c59x-udp-csum.patch
  Enable UDP checksums in 3c59x

ide-warnings.patch
  Fix some IDE compile warnings

dmi-warning.patch
  fix a compile warning in dmi_scan.c

kgdb.patch

ramfs-aops.patch
  Move ramfs address_space ops into libfs

ramfs-prepare-write-speedup.patch
  correctness fixes in libfs address_space ops

dio-fine-alignment.patch
  Allow O_DIRECT to use 512-byte alignment

dhowells-readahead.patch
  readahead generalisations

file_ra_state_init.patch
  Add a function to initialise file readahead state

less-unlikelies.patch
  reduced buslocked traffic in the page allocator

running-iowait.patch
  expose nr_running and nr_iowait task counts in /proc

intel-user-copy-taka.patch
  Faster copy_*_user for Intel ia32 CPUs

uaccess-uninline.patch

ingo-oom-kill.patch
  oom-killer changes for threaded apps

add_timer_on.patch
  add_timer_on(): function to start a timer on a particular CPU

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

slab-timer.patch

slab-use-sem.patch

slab-cleanup.patch
  Slab cleanup

ingo-mmap-speedup.patch
  Ingo's mmap speedup

mm-inlines.patch
  remove some inlines from mm/*

o_streaming.patch
  O_STREAMING support

page_reserved-accounting.patch
  Global PageReserved accounting

use-page_reserved_accounting.patch
  Use PG_reserved accounting in the VM

mod_timer-race.patch

net-loopback.patch
  Disable second copy in the network loopback driver

blkdev-o_direct-short-read.patch
  Fix O_DIRECT blockdev reads at end-of-device

orlov-allocator.patch

blk-queue-bounce.patch
  inline blk_queue_bounce

lseek-ext2_readdir.patch
  remove lock_kernel() from ext2_readdir()

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

hugetlb-prefault.patch
  hugetlbpages: factor out some code for hugetlbfs

hugetlb-header-split.patch
  Move hugetlb declarations into their own header

hugetlbfs.patch
  hugetlbfs file system

hugetlb-shm.patch
  hugetlbfs backing for SYSV shared memory

truncate-bkl.patch
  don't take the BKL in inode_setattr

akpm-deadline.patch
  deadline scheduler tweaks

xattr-01-metablock-cache.patch
  EA: meta block cache

xattr-02-ext3.patch
  EA: ext3 support

xattr-03-ext2.patch
  EA: ext2 support

fix-xattr.patch
  EA: compile warning fix

posix-acl-01-core.patch
  posixacl: core support

posix-acl-02-umask.patch
  posixacl: umask support

posix-acl-03-user-api.patch
  posixacl: user API

posix-acl-04-ext3.patch
  posixacl: ext3 support

acl-ext3-fix-tree.patch

acl-ext3-inode.patch

posix-acl-05-ext2.patch
  posixacl: ext2 support

mm1-incr1.patch

mm1-incr2.patch
  posixacl: use getxattr in nfsd_get_posix_acl()

ext23-mount-options.patch
  ext2/3 mount option processing cleanup

read_barrier_depends.patch
  extended barrier primitives

dcache_rcu.patch
  Use RCU for dcache

mpopulate.patch
  remap_file_pages

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

wli-show_free_areas.patch
  show_free_areas extensions
