Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbTABCGH>; Wed, 1 Jan 2003 21:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbTABCGG>; Wed, 1 Jan 2003 21:06:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:18620 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265355AbTABCGC>;
	Wed, 1 Jan 2003 21:06:02 -0500
Message-ID: <3E13A07F.AE64BD11@digeo.com>
Date: Wed, 01 Jan 2003 18:14:23 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.53-mm3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jan 2003 02:14:24.0058 (UTC) FILETIME=[AB2299A0:01C2B204]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.53/2.5.53-mm3/

. 2.5.53-mm2 was a bit sick in the timekeeping and slab department.  That
  should be fixed here.

. The idea of using the slab head arrays for object preallocation has been
  abandoned.  It involved too many slab changes, and slab just explodes in
  your face when touched.  So I've used a custom reservation pool in the
  radix-tree code instead.

. I've spent two days chasing the memory leak which Con has reported and
  have thus far not been able to reproduce it (managed to collaterally 
  discover a swapoff lockup and an htree leak though).  It's probably an
  ext3/VM interaction.  Please keep an eye out for this.



Changes since 2.5.53-mm2:


-aic-bounce.patch
-ga2.patch
-reduce-random-context-switch-rate.patch
-file-nr-doc-fix.patch
-remove-memshared.patch
-bin2bcd.patch
-semtimedop-update.patch
-drain_local_pages.patch
-kmalloc_percpu.patch
-dont-aligns-vmas.patch
-remove-swappable.patch
-remove-hugetlb-syscalls.patch

 Merged

-slab-preallocation.patch
-slab-export-tuning.patch
-rat-preallocation.patch

 Dropped

+rat-preload.patch

 Do the preallocation as a custom radix-tree thing, not generically.

+i_shared_sem.patch

 Turn i_shared_lock into a semaphore.  Will be needed for scheduling latency
 reasons.  Is needed to avoid a shared pagetable deadlock.

+cond_resched_lock-rework.patch

 Tidy up a couple of low-latency things

+mempool_resize-fix.patch

 Fix a problem in mempool_resize()

+slab-redzone-cleanup.patch

 Clean up the slab redzoning debug code, add useful messages.

+shrink-kmap-space.patch

 Save some wasted kernel virtual address space

+setuid-exec-no-lock_kernel.patch

 Locking cleanup

+fix-ethernet-hash.patch

 Fix for the ethernet crc function

+route-cache-kmalloc-per-cpu.patch

 Use kmalloc_per_cpu for the route cache stats

-config_page_offset.patch
-config_hz.patch

 Dropped.   Not to Linus' taste.

+page-walk-api-2.5.53-mm2-update.patch

 New stuff from Ingo

-page-walk-api-update.patch
-gup-check-valid.patch

 Folded into other patches

+page-walk-scsi-2.5.53-mm2.patch

 More from Ingo




All 64 patches:


linus.patch
  cset-1.911.4.10-to-1.932.txt.gz

kgdb.patch

log_buf_size.patch
  move LOG_BUF_SIZE to header/config

rcf.patch
  run-child-first after fork

devfs-fix.patch

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

inlines-net.patch

rbtree-iosched.patch
  rbtree-based IO scheduler

deadsched-fix.patch
  deadline scheduler fix

quota-smp-locks.patch
  Subject: Quota SMP locks

copy_page_range-cleanup.patch
  copy_page_range: minor cleanup

pte_chain_alloc-fix.patch

page_add_rmap-rework.patch

rat-preload.patch

use-rat-preallocation.patch

i_shared_sem.patch
  turn i_shared_lock into a semaphore

cond_resched_lock-rework.patch
  simplify and generalise cond_resched_lock

shpte-ng.patch
  pagetable sharing for ia32

teeny-mem-limits.patch

smaller-head-arrays.patch

mempool_resize-fix.patch
  mempool_resize fix

slab-redzone-cleanup.patch
  slab: redzoning cleanup

shrink-kmap-space.patch
  shrink the amount of vmalloc space reserved for kmap

setuid-exec-no-lock_kernel.patch
  remove lock_kernel() from exec of setuid apps

fix-ethernet-hash.patch
  fix ethernet hash function

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
