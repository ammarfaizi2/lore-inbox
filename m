Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263986AbSJTTFq>; Sun, 20 Oct 2002 15:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264004AbSJTTFq>; Sun, 20 Oct 2002 15:05:46 -0400
Received: from packet.digeo.com ([12.110.80.53]:19961 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263986AbSJTTFk>;
	Sun, 20 Oct 2002 15:05:40 -0400
Message-ID: <3DB2FFEA.4048E82@digeo.com>
Date: Sun, 20 Oct 2002 12:11:38 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.44-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2002 19:11:38.0436 (UTC) FILETIME=[83E41840:01C2786C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.44/2.5.44-mm1/


. The shared pagetable code is back in.  Seems to be stabilising. 
  If anyone has any weird problems, please see if a `patch -R -p1 <
  shpte-ng.patch' fixes it up, thanks.


. There have been ongoing travails in the direct-io code since the
  introduction of bio_add_page().

  It was all turning into a bit of a pickle, so I got down and
  rewrote the file-walk, assembly and BIO submission phase in a manner
  which suits the bio_add_page() semantics.  This version is, IMO,
  significantly clearer.  And it now runs the modified-for-O_DIRECT
  fsx-linux code without going BUG.

  This of course broke the allow-512-byte-alignment patch; that needs
  to be redone.

. There is a series of debloat patches here.  Expect to see the
  kernel use 100k less memory on UP and 300k less on SMP.

  Well, more accurately 10k * (NR_CPUS - number_of_cpus).

. A series of updates from Bill on the large page filesystem and shm
  patches

. I'm carrying ninety five diffs here.  People who send me patches
  for integration: please, keep it as small as is practical, and not
  trivial stuff.  Thanks.


Changes since 2.5.43-mm2 (2.5.43-mm3 was a quiet temp thing):


-3c59x-udp-csum.patch
-dhowells-readahead.patch
-read_barrier_depends.patch

 Merged

+dio-submit-fix.patch

 direct-io rework

-dio-fine-alignment.patch

 Broken by direct-io rework

+pipe-fix.patch

 Fix scheduling starvation in pipe-intensive benchmarks

+unbloat-pid.patch

 Drastically shrink the pid hashtable.  (More a trollpatch than a
 serious one, but sheesh).

+per-cpu-ratelimits.patch

 Save almost a kilobyte on SMP.

+for-each-cpu.patch

 for_each_possible_cpu() and for_each_online_cpu() helper macros

+per-cpu-warning.patch

 Fix a generic compile warning from the percpu code

+per-cpu-01-core.patch

 Extend the per-cpu memory area code to not allocate memory or
 not-present CPUs.

 This also extends the hotplug CPU notifiers to provide richer
 notifications.

+per-cpu-02-rcu.patch

 Fix RCU for the new per-cpu infrastructure

+per-cpu-03-timer.patch

 Teach the timer code to use per-cpu areas.

+per-cpu-04-tasklet.patch

 Fix the softirq code for the new per-cpu infrastructure

+per-cpu-05-bh.patch

 Fix the buffer_head code for the new infrastructure, and per-cpuise
 everything in there.

+per-cpu-page_state.patch

 Make page_states per-cpu.

+slab-per-cpu.patch

 Use the new per-cpu notifiers in slab.

+shmem_getpage-unlock_page.patch
+shmem_getpage-beyond-eof.patch
+shmem_getpage-reading-holes.patch
+shmem-fs-cleanup.patch
+shmem_file_sendfile.patch
+shmem_file_write-update.patch
+shmem_getpage-flush_dcache.patch
+loopable-tmpfs.patch

 tmpfs rework

+event-II.patch
+event-ext2.patch

 Some f_version/i_version cleanups from Manfred

+htlb-update.patch

 hugetlbpage core fixes and changes

+hugetlbfs-update.patch

 Extensions and fixes for hugetlbfs

+htlb-shm-update.patch

 Extensions and fixes for hugetlbpage-backed shm

+acl-xattr-on.patch

 Make posix acls and extended attributes non-optional (accelerated
 testing)

+shmem_populate.patch

 Implement shmem_populate()

+shpte-ng.patch

 Shared pagetables



All patches:


ide-warnings.patch
  Fix some IDE compile warnings

dmi-warning.patch
  fix a compile warning in dmi_scan.c

kgdb.patch

ramfs-aops.patch
  Move ramfs address_space ops into libfs

ramfs-prepare-write-speedup.patch
  correctness fixes in libfs address_space ops

pipe-fix.patch
  use correct wakeups in fs/pipe.c

dio-submit-fix.patch
  rework direct-io for bio_add_page

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

unbloat-pid.patch
  Reduce RAM use in kernel/pid.c

per-cpu-ratelimits.patch

for-each-cpu.patch
  for_each_possible_cpu and for_each_online_cpu macros

per-cpu-warning.patch
  Fix per-cpu compile warnings on UP

per-cpu-01-core.patch
  cpu_possible percpu data core

per-cpu-02-rcu.patch
  cpu_possible rcu per_cpu data

per-cpu-03-timer.patch
  cpu_possible timer percpu data

per-cpu-04-tasklet.patch
  cpu_possible tasklet percpu data

per-cpu-05-bh.patch
  cpu_possible bh_accounting

per-cpu-page_state.patch

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

slab-per-cpu.patch
  Use CPU notifiers in slab

ingo-mmap-speedup.patch
  Ingo's mmap speedup

mm-inlines.patch
  remove some inlines from mm/*

o_streaming.patch
  O_STREAMING support

shmem_getpage-unlock_page.patch
  tmpfs 1/9 shmem_getpage unlock_page

shmem_getpage-beyond-eof.patch
  tmpfs 2/9 shmem_getpage beyond eof

shmem_getpage-reading-holes.patch
  tmpfs 3/9 shmem_getpage reading holes

shmem-fs-cleanup.patch
  tmpfs 4/9 shmem fs cleanup

shmem_file_sendfile.patch
  tmpfs 5/9 shmem_file_sendfile

shmem_file_write-update.patch
  tmpfs 6/9 shmem_file_write update

shmem_getpage-flush_dcache.patch
  tmpfs 7/9 shmem_getpage flush_dcache

loopable-tmpfs.patch
  tmpfs 8/9 loopable tmpfs

event-II.patch
  f_version/i_version cleanups

event-ext2.patch
  f_version/i_version cleanups: ext2

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

htlb-update.patch

hugetlbfs.patch
  hugetlbfs file system

hugetlbfs-update.patch

hugetlb-shm.patch
  hugetlbfs backing for SYSV shared memory

htlb-shm-update.patch

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

acl-xattr-on.patch
  turn on posix acls and extended attributes

ext23-mount-options.patch
  ext2/3 mount option processing cleanup

dcache_rcu.patch
  Use RCU for dcache

mpopulate.patch
  remap_file_pages

shmem_populate.patch
  tmpfs 9/9 Ingo's shmem_populate

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

shpte-ng.patch
