Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbTADIwR>; Sat, 4 Jan 2003 03:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbTADIwR>; Sat, 4 Jan 2003 03:52:17 -0500
Received: from packet.digeo.com ([12.110.80.53]:11684 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266622AbTADIwN>;
	Sat, 4 Jan 2003 03:52:13 -0500
Message-ID: <3E16A2B6.A741AE17@digeo.com>
Date: Sat, 04 Jan 2003 01:00:38 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: 2.5.54-mm3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2003 09:00:39.0258 (UTC) FILETIME=[C0B673A0:01C2B3CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.54/2.5.54-mm3/

Several patches here which fix pretty much the last source of long
scheduling latency stalls in the core kernel - long-held page_table_lock
during pagetable teardown.

The preemptible kernel now achieves around 500 microsecond worst-case
latency on a 500MHz PIII (with a slow memory system).  This is about as
good as the 2.4 low-latency patch.  Maybe better.

This is with ext2, and only with ext2.  Other filesystems need work
to reach that level of performance.

Non-preemptible kernels will benefit as well.  This sort of means that
preemptibility is only really needed for specialised multimedia/control
type apps.   Opinions vary ;)

Filesystem mount and unmount is a problem.  Probably, this will not be
addressed.  People who have specialised latency requirements should avoid
using automounters and those gadgets which poll CDROMs for insertion events.

This work has broken the shared pagetable patch - it touches the same code
in many places.   I shall put Humpty together again, but will not be 
including it for some time.  This is because there may be bugs in this
patch series which are accidentally fixed in the shared pagetable patch. So
shared pagetables will be reintegrated when these changes have had sufficient
testing.

Hugh, could you please closely review these changes sometime?   Thanks.




Changes since 2.4.54-mm2:


-no-stem-compression.patch

 It got fixed.

+linus.patch

 latest drop from Linus

+devfs-mount-fix.patch

 Fix a problem with mounting a devfs=y system with root=<number>

+nfsd-fix.patch

 Fix a knfsd problem

+3c920.patch

 3c920 support for 3c59x.c

-shpte-ng.patch

 See above

+untypedef-mmu_gather.patch

 Replace the mmu_gather_t typedef with `struct mmu_gather'.

+low-latency-page-unmapping.patch

 Fix long-held spinlocks in exit_mmap() and unmap_region()

+smp-preempt-latency-fix.patch

 Fix a cross-cpu problem which causes long scheduling stalls
 on SMP+preempt

-#smaller-head-arrays.patch
+smaller-head-arrays.patch

 I really do think those slab head arrays are too big.

-fix-ethernet-hash.patch

 Jeff merged a fix



All 70 patches:

linus.patch
  cset-1.930.1.15-to-1.977.txt.gz

kgdb.patch

log_buf_size.patch
  move LOG_BUF_SIZE to header/config

nfsd-fix.patch
  Subject: Re: nfsd woes

rcf.patch
  run-child-first after fork

devfs-fix.patch

devfs-mount-fix.patch
  devfs mount-time readdir fix and cleanup

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

misc.patch
  misc fixes

3c920.patch
  3c59x: 3c920 support

inlines-net.patch

rbtree-iosched.patch
  rbtree-based IO scheduler

deadsched-fix.patch
  deadline scheduler fix

copy_page_range-cleanup.patch
  copy_page_range: minor cleanup

pte_chain_alloc-fix.patch
  infrastructure for handling pte_chain_alloc() failures

page_add_rmap-rework.patch
  handle fix pte_chain_alloc() failures

rat-preload.patch
  infrastructure for handling radix_tree_node allocation failures

use-rat-preallocation.patch
  handle radix_tree_node allocation failures

i_shared_sem.patch
  turn i_shared_lock into a semaphore

cond_resched_lock-rework.patch
  simplify and generalise cond_resched_lock

untypedef-mmu_gather.patch
  replace `typedef mmu_gather_t' with `struct mmu_gather'

low-latency-page-unmapping.patch
  low-latency pagetable teardown

smp-preempt-latency-fix.patch
  Fix an SMP+preempt latency problem

smaller-head-arrays.patch

mempool_resize-fix.patch
  mempool_resize fix

slab-redzone-cleanup.patch
  slab: redzoning cleanup

shrink-kmap-space.patch
  shrink the amount of vmalloc space reserved for kmap

setuid-exec-no-lock_kernel.patch
  remove lock_kernel() from exec of setuid apps

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

pentium-II.patch
  Pentium-II support bits

rcu-stats.patch
  RCU statistics reporting

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

ext3-fsync-speedup.patch
  Clean up ext3_sync_file()

lockless-current_kernel_time.patch
  Lockless current_kernel_timer()

scheduler-tunables.patch
  scheduler tunables

dio-always-kmalloc.patch
  direct-io: dynamically allocate struct dio

set_page_dirty_lock.patch
  fix set_page_dirty vs truncate&free races

htlb-2.patch
  hugetlb: fix MAP_FIXED handling

route-cache-kmalloc-per-cpu.patch
  use kmalloc-per-cpu for the routecache stats

wli-01_numaq_io.patch
  (undescribed patch)

wli-02_do_sak.patch
  (undescribed patch)

wli-03_proc_super.patch
  (undescribed patch)

wli-06_uml_get_task.patch
  (undescribed patch)

wli-07_numaq_mem_map.patch
  (undescribed patch)

wli-08_numaq_pgdat.patch
  (undescribed patch)

wli-09_has_stopped_jobs.patch
  (undescribed patch)

wli-10_inode_wait.patch
  (undescribed patch)

wli-11_pgd_ctor.patch
  (undescribed patch)

wli-11_pgd_ctor-update.patch
  pgd_ctor update

wli-12_pidhash_size.patch
  Dynamically size the pidhash hash table.

wli-13_rmap_nrpte.patch
  (undescribed patch)

dcache_rcu-2.patch
  dcache_rcu-2-2.5.51.patch

dcache_rcu-3.patch
  dcache_rcu-3-2.5.51.patch

page-walk-api.patch

page-walk-api-2.5.53-mm2-update.patch
  pagewalk API update

page-walk-scsi.patch

page-walk-scsi-2.5.53-mm2.patch
  pagewalk scsi update
