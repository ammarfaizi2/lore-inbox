Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbSJYFea>; Fri, 25 Oct 2002 01:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSJYFea>; Fri, 25 Oct 2002 01:34:30 -0400
Received: from packet.digeo.com ([12.110.80.53]:36514 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261288AbSJYFeZ>;
	Fri, 25 Oct 2002 01:34:25 -0400
Message-ID: <3DB8D94B.20D3D5BD@digeo.com>
Date: Thu, 24 Oct 2002 22:40:27 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.44-mm5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Oct 2002 05:40:32.0388 (UTC) FILETIME=[08BB3C40:01C27BE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.44/2.5.44-mm5/

We seem to have found the dud patch.  Things should be a little
more stable...

The CONFIG_PREEMPT+SMP problem I was having went away when gcc-2.95.3
was used in place of 2.91.66.  Which is a bit of a problem because
_someone_ has to keep an eye on 2.91.66 compatibility as long as it
continues to be required for sparc builds.

There is a memory corruption problem happening deep in the scsi code
when the hot-n-cold pages patch is present.  Current theory is that
this is a use-after-free problem in scsi, and that the hot-n-cold
pages patch is exposing it because its LIFO page queue will hand
out a page immediately after this cpu freed it.

The workaround is a patch -R of

	page-reservation.patch
	pagevec-hot-cold-hint.patch
	readahead-cold-pages.patch
	hot_cold_pages.patch

in that order.



Added since 2.5.44-mm4:

+generic-nonlinear-mappings-D0.patch

 Non-file-contiguous mmap support.  Back in.

+md-01-driverfs-core.patch
+md-02-driverfs-topology.patch
+md-03-numa-meminfo.patch
+md-04-memblk_online_map.patch
+md-05-node_online_map.patch

 Export lots of NUMA info via driverfs

+ipclock-2544mm4.patch

 Reduced lock contention in the IPC code

+ipc-akpm.patch

 Reduced inlines inthe IPC code

+kstat.patch

 Use the per_cpu infrastructure for what remains of the old kernel_stat
 accounting.

+kstat-arch.patch

 Teach the non-ia32 architectures about the new kernel_stat regime.



All 107 patches:

rcu-idle-fix.patch
  RCU idle detection fix

read-barrier-depends.patch
  read_barrier_depends fix

deferred-lru-add-fix.patch
  fix for adding mapped pages to the active list

ide-warnings.patch
  Fix some IDE compile warnings

dmi-warning.patch
  fix a compile warning in dmi_scan.c

scsi-reboot-fix.patch

kgdb.patch

misc.patch
  misc fixes

ramfs-aops.patch
  Move ramfs address_space ops into libfs

ramfs-prepare-write-speedup.patch
  correctness fixes in libfs address_space ops

pipe-fix.patch
  use correct wakeups in fs/pipe.c

dio-submit-fix.patch
  rework direct-io for bio_add_page

dio-fine-alignment.patch
  Allow O_DIRECT to use 512-byte alignment

file_ra_state_init.patch
  Add a function to initialise file readahead state

less-unlikelies.patch
  reduced buslocked traffic in the page allocator

running-iowait.patch
  expose nr_running and nr_iowait task counts in /proc

intel-user-copy-taka.patch
  Faster copy_*_user for Intel ia32 CPUs

shrink_slab-overflow.patch

uaccess-uninline.patch

ingo-oom-kill.patch
  oom-killer changes for threaded apps

unbloat-pid.patch
  Reduce RAM use in kernel/pid.c

per-cpu-ratelimits.patch

per-cpu-warning.patch
  Fix per-cpu compile warnings on UP

cpuup-notifiers.patch
  extended cpu hotplug notifiers

per-cpu-02-rcu.patch
  cpu_possible rcu per_cpu data

per-cpu-03-timer.patch
  cpu_possible timer percpu data

per-cpu-04-tasklet.patch
  cpu_possible tasklet percpu data

per-cpu-05-bh.patch
  cpu_possible bh_accounting

export-per-cpu-symbol.patch
  create EXPORT_PER_CPU_SYMBOL

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

mod_timer-race.patch

blkdev-o_direct-short-read.patch
  Fix O_DIRECT blockdev reads at end-of-device

orlov-allocator.patch

blk-queue-bounce.patch
  inline blk_queue_bounce

lseek-ext2_readdir.patch
  remove lock_kernel() from ext2_readdir()

decoded-wchan-output.patch
  pre-decoded wchan output in /proc/pid/wchan

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

hugetlb-prefault.patch
  hugetlbpages: factor out some code for hugetlbfs

hugetlb-header-split.patch
  Move hugetlb declarations into their own header

htlb-update.patch
  hugetlb fixes and cleanups

hugetlb-page-count.patch
  fix hugetlb thinko

hugetlbfs.patch
  hugetlbfs file system

hugetlb-shm.patch
  hugetlbfs backing for SYSV shared memory

truncate-bkl.patch
  don't take the BKL in inode_setattr

akpm-deadline.patch
  deadline scheduler tweaks

pipe-speedup.patch
  user faster wakeups in the pipe code

dcache_rcu.patch
  Use RCU for dcache

mpopulate.patch
  remap_file_pages

shmem_populate.patch
  tmpfs 9/9 Ingo's shmem_populate

ext23-acl-xattr-01.patch

ext23-acl-xattr-02.patch

ext23-acl-xattr-03.patch

ext23-acl-xattr-04.patch

ext23-acl-xattr-05.patch

ext23-acl-xattr-06.patch

ext23-acl-xattr-07.patch

ext23-acl-xattr-08.patch

ext23-acl-xattr-09.patch

ext23-acl-xattr-10.patch

ext23-acl-xattr-11.patch

ext2-mount-fix.patch

acl-xattr-on.patch
  turn on posix acls and extended attributes

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

generic-nonlinear-mappings-D0.patch
  generic nonlinear mappings

md-01-driverfs-core.patch
  Core driverfs Topology

md-02-driverfs-topology.patch
  i386 driverfs Topology

md-03-numa-meminfo.patch
  NUMA meminfo for driverfs Topology

md-04-memblk_online_map.patch
  create memblk_online_map

md-05-node_online_map.patch
  create node_online_map

ipclock-2544mm4.patch
  IPC lock contention reduction

ipc-akpm.patch

kstat.patch

kstat-arch.patch
