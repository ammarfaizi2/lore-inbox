Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264914AbSJPG5s>; Wed, 16 Oct 2002 02:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSJPG5s>; Wed, 16 Oct 2002 02:57:48 -0400
Received: from packet.digeo.com ([12.110.80.53]:49652 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264914AbSJPG5i>;
	Wed, 16 Oct 2002 02:57:38 -0400
Message-ID: <3DAD0F3D.39E5B5DC@digeo.com>
Date: Wed, 16 Oct 2002 00:03:25 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.43-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2002 07:03:26.0184 (UTC) FILETIME=[1FA08680:01C274E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.43/2.5.43-mm1/

- The faster copy_*_user patch for Intel ia32 CPUs has been updated to
  be a little faster.

- A few 2.5.43 compilation fixes are included.

- Ingo's get_unmapped_area() speedup is added

- Included the extended attributes and posix ACL code.  This feature
  is late, IMO.  People who want this would be advised to help shake
  it down.

- There are still a few problems with the shared pagetable code.  One
  of David's fixup patches didn't work out, so there are two followup
  patches over in the experimental/ directory.  They're for David - don't
  use them.

- There's a little tweak here (no-reclaim-throttle.patch) which will
  improve interactivity on small machines during heavy writeout.

  But generally, for those people who have had problems with sluggishness
  and swappiness in the 2.5 VM: 2.5.43 pretty much has it all.  Please
  give it a shot.

  /proc/sys/vm/swappiness is available for playing with.  Default value
  is 60%, and 100 gives you the previous 2.5 behaviour.

  Some things are slower - most notably things which involve simultaneous
  reading from and writing to the same disk.  Such workloads were traded
  off against latency under write loads.  I expect that with careful attention
  some of this can be pulled back, but it's not a large regression.  Maybe
  up to 10-20%.


Since 2.5.42-mm3:

+mpparse-fix.patch
+md-fix.patch

 2.5.43 compile fixes

-oprofile-25.patch

 Merged

+disable-ppc-lbd.patch

 Don't offer 64-bit sector_t on PPC32

+reiserfs-kmap-fix.patch

 Fix a highmem oops in reiserfs_ioctl()

+refill-inactive-lockup-fix.patch

 Fix a VM lockup under weird loads

+simple_rename-link-count.patch

 Fix fs/libfs:simple_rename()

+static-filemap_sync.patch

 Make filemap_sync() static, don't export to modules

-raid0-fix.patch
-fsync_buffers_list-fix.patch

 Merged

-intel-user-copy.patch
+intel-user-copy-taka.patch

 New, improved

+meminfo-numa.patch

 Add /proc/meminfo.numa

+ingo-mmap-speedup.patch

 Faster search heuristic for mmap()

+ingo-oom-kill.patch

 Make the oom killer smarter for threaded apps

+vmalloc-overalloc.patch

 Don't allocate an extra page in vmalloc()

+no-reclaim-throttle.patch

 Don't make writers wait on writeback in page reclaim

+shpte-lock-ranking-fix.patch

 shared pagetable locking fix

+handle-mm-fault-locking.patch
+mremap-shared-pagetable-fix.patch

 shared pagetable fixes

-xattr-2.patch
-xattr-shrinker.patch
-xattr-3.patch
-xattr-4.patch

 Obsoleted

+xattr-01-metablock-cache.patch
+xattr-02-ext3.patch
+xattr-03-ext2.patch
+fix-xattr.patch

 Extended Attributes, and a fix thereto

+posix-acl-01-core.patch
+posix-acl-02-umask.patch
+posix-acl-03-user-api.patch
+posix-acl-04-ext3.patch

 Posix ACLs

+acl-ext3-fix-tree.patch
+acl-ext3-inode.patch

 Fixes to the above

+posix-acl-05-ext2.patch

 Posix ACLs

+ext23-mount-options.patch

 Clean up parsing of ext2/3 mount options

-rcu_ltimer.patch

 Merged




mpparse-fix.patch

md-fix.patch

kgdb.patch

disable-ppc-lbd.patch
  Disable CONFIG_LBD for ppc32

mod_timer-race.patch

net-loopback.patch
  Disable second copy in the network loopback driver

reiserfs-kmap-fix.patch
  reiserfs: remove stray kunmap

blkdev-o_direct-short-read.patch
  Fix O_DIRECT blockdev reads at end-of-device

refill-inactive-lockup-fix.patch
  Fix a refill_inactive_zone lockup

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

simple_rename-link-count.patch
  Fix link count in simple_rename()

truncate-bkl.patch
  don't take the BKL in inode_setattr

static-filemap_sync.patch
  Make filemap_sync() static

akpm-deadline.patch
  deadline scheduler tweaks

intel-user-copy-taka.patch
  Faster copy_*_user for Intel ia32 CPUs

meminfo-numa.patch
  NUMA: /proc/meminfo.numa

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

ingo-mmap-speedup.patch
  Ingo's mmap speedup

ingo-oom-kill.patch
  oom-killer changes for threaded apps

vmalloc-overalloc.patch
  Avoid overallocating pages in vmalloc()

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

no-reclaim-throttle.patch
  Don't wait on page writeout in page reclaim

fs-inlines.patch
  Kill some inlining in fs/*

mm-inlines.patch
  remove some inlines from mm/*

uninline-highmem.patch
  uninline the highmem mapping functions

shpte.patch

shpte-lock-ranking-fix.patch
  shared pte lock ranking fix

shmmap.patch
  Proactively share page tables for shared memory

handle-mm-fault-locking.patch
  handle_mm_fault locking fix

mremap-shared-pagetable-fix.patch
  fix mremap for shared page tables

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

ext23-mount-options.patch
  ext2/3 mount option processing cleanup

read_barrier_depends.patch
  extended barrier primitives

dcache_rcu.patch
  Use RCU for dcache

mpopulate.patch
  remap_file_pages
