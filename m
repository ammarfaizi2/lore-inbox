Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSJOFFB>; Tue, 15 Oct 2002 01:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262364AbSJOFFB>; Tue, 15 Oct 2002 01:05:01 -0400
Received: from packet.digeo.com ([12.110.80.53]:11981 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262360AbSJOFE6>;
	Tue, 15 Oct 2002 01:04:58 -0400
Message-ID: <3DABA351.7E9C1CFB@digeo.com>
Date: Mon, 14 Oct 2002 22:10:41 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       ext2-devel@lists.sourceforge.net, "tytso@mit.edu" <tytso@mit.edu>
Subject: 2.5.43-m3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2002 05:10:42.0166 (UTC) FILETIME=[358B8960:01C27409]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.42/2.5.42-mm3/

- drop SARD again.  It broke RAID0.  Al is working on converting SARD
  to a driverfs interface.

- fix the crashing in the timer code.

- went on an uninlining rampage and shrunk the kernel image by 10k or so.

- merge up the ext2/3 extended attribute code, convert that to use
  the slab shrinking API in Linus's current tree.

- add a new timer API function:

	add_timer_on(struct timer_list *timer, int cpu);

  to start a timer on a different CPU.

- rework the slab shrinking code to use add_timer_on(), so we don't
  need to launch a kernel thread just to get a timer onto another CPU.

- Add Ingo's current remap_file_pages() patch.  I had to renumber his
  syscall from 253 to 254 due to a clash with the oprofile syscall.


-misc.patch
-hugetlb-meminfo.patch
-dio-bio-add-fix-1.patch
-swsusp-feature.patch
-large-queue-throttle.patch
-exit-page-referenced.patch
-swappiness.patch
-mapped-start-active.patch
-rename-dirty_async_ratio.patch
-auto-dirty-memory.patch
-batched-slab-asap.patch
-fix-pgpgout.patch
-msync-correctness.patch
-remove-kiobufs.patch

 Merged

-sard.patch

 Out again

+mod_timer-race.patch

 Fix the timer crashes.

+truncate-bkl.patch

 Random BKL removal

+fsync_buffers_list-fix.patch

 fsync correctness

+wli-show_free_areas.patch

 Show the memory states when the oom-killer strikes

+add_timer_on.patch

 add_timer_on()

-cpucache_init-fix.patch
-slab-split-10-list_for_each_fix.patch

 Folded into slab-split-08-reap.patch

+slab-timer.patch

 Use add_timer_on() for the slab per-cpu cache reaping function.

+slab-use-sem.patch

 Drop the new slab rwlock and just use down_trylock(&cache_chain_sem);

+fs-inlines.patch
+mm-inlines.patch
+uninline-highmem.patch

 Uninline various things.

-shpte-ifdef.patch
-shpte-mprotect-fix.patch
-shpte-unmap-fix.patch

 Folded into shpte.patch

+xattr-2.patch
+xattr-3.patch
+xattr-4.patch

 ext2/3 extended attributes

+xattr-shrinker.patch

 Convert xattr to use set_shrinker/remove_shrinker

+mpopulate.patch

 remap_file_pages()




linus.patch
  cset-1.782-to-1.848.txt.gz

kgdb.patch

oprofile-25.patch

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

dio-fine-alignment.patch
  Allow O_DIRECT to use 512-byte alignment

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

hugetlb-prefault.patch
  hugetlbpages: factor out some code for hugetlbfs

ramfs-aops.patch
  Move ramfs address_space ops into libfs

hugetlb-header-split.patch
  Move hugetlb declarations into their own header

hugetlbfs.patch
  hugetlbfs file system

hugetlb-shm.patch
  hugetlbfs backing for SYSV shared memory

page_reserved-accounting.patch
  Global PageReserved accounting

use-page_reserved_accounting.patch
  Use PG_reserved accounting in the VM

ramfs-prepare-write-speedup.patch
  correctness fixes in libfs address_space ops

truncate-bkl.patch
  don't take the BKL in inode_setattr

akpm-deadline.patch
  deadline scheduler tweaks

intel-user-copy.patch
  Faster copt_*_user for Intel ia32 CPUs

raid0-fix.patch
  RAID0 fix

fsync_buffers_list-fix.patch
  fsync_buffers_list fix

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

o_streaming.patch
  O_STREAMING support

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

fs-inlines.patch
  Kill some inlining in fs/*

mm-inlines.patch
  remove some inlines from mm/*

uninline-highmem.patch
  uninline the highmem mapping functions

shpte.patch

shmmap.patch
  Proactively share page tables for shared memory

xattr-2.patch

xattr-shrinker.patch

xattr-3.patch

xattr-4.patch

read_barrier_depends.patch
  extended barrier primitives

rcu_ltimer.patch
  RCU core

dcache_rcu.patch
  Use RCU for dcache

mpopulate.patch
  remap_file_pages
