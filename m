Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbSLXIrS>; Tue, 24 Dec 2002 03:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267072AbSLXIrS>; Tue, 24 Dec 2002 03:47:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:22412 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267070AbSLXIrN>;
	Tue, 24 Dec 2002 03:47:13 -0500
Message-ID: <3E0820F5.7DB71BF5@digeo.com>
Date: Tue, 24 Dec 2002 00:55:17 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.53-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Dec 2002 08:55:17.0837 (UTC) FILETIME=[2E963FD0:01C2AB2A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.53/2.5.53-mm1/

. Collapsed all the shared pagetable patches into a single patch, so
  it is readable now.  Also made it selectable in config again.

  It is unlikely that the shared pagetable code will be merged.

. A patch which fixes the run-child-first-after-fork logic.  This 
  supposedly will provide benefits when the child quickly exec's a
  new program, but I'm not able to measure much difference at all.  It
  would be interesting if anyone can find a workload which likes this.

  Last time we tried this, /bin/bash broke...

  This patch is much more intrusive than it needs to be - it ended up
  being a great chase against various scheduler startup bogons.  Not
  sure that it improves things much, actually.

  It will break non-ia32 kernels in its present form.


Changes since 2.5.52-mm2:

-sync_fs-deadlock-fix.patch
-shrink_list-dirty-page-race.patch
-slab-poisoning.patch
-nommu-generic_file_readonly_mmap.patch
-misc.patch
-remove-PF_NOWARN.patch
-blocking-kswapd.patch
-block-allocator-doc.patch
-spread-find_group_other.patch
-ext3-alloc-spread.patch
-ext2-alloc-spread.patch
-ext2-rename-vars.patch
-ext3-use-after-free.patch
-ext3-bh-dirty-race.patch
-unalign-radix-tree-nodes.patch
-htlb-0.patch
-htlb-1.patch
-htlb-3.patch
-wli-04_cap_set_pg.patch

 Merged

+rcf.patch

 Run child first after fork

+ga2.patch

 Fix a bootup ordering problem on SMP

-shpte-nonlinear.patch
-shpte-reorg.patch
-shpte-reorg-fixes.patch

 Folded into shpte-ng.patch

-shpte-always-on.patch

 Dropped - make shared pagetables a config option again

+lockless-current_kernel_time.patch

 Back again

+drain_local_pages.patch

 Page allocator helper for software suspend.

-kmalloc_percpu-rtcache.patch
-kmalloc_percpu-mibs-1.patch
-kmalloc_percpu-mibs-2.patch
-kmalloc_percpu-mibs-3.patch

 These work OK.

+config_page_offset.patch

 Make the user/kernel split configurable on ia32

+config_hz.patch

 Make HZ=100/HZ=1000 selectable

+dont-aligns-vmas.patch

 Don't cacheline align vm_area_struct

+remove-swappable.patch

 Remove unused task_struct.swappable




All 57 patches:


kgdb.patch

rcf.patch
  run-child-first after fork

ga2.patch
  don't call console drivers on non-online CPUs

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

reduce-random-context-switch-rate.patch
  Reduce context switch rate due to the random driver

inlines-net.patch

rbtree-iosched.patch
  rbtree-based IO scheduler

deadsched-fix.patch
  deadline scheduler fix

quota-smp-locks.patch
  Subject: [PATCH] Quota SMP locks

shpte-ng.patch
  pagetable sharing for ia32

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

file-nr-doc-fix.patch
  Docs: fix explanation of file-nr

set_page_dirty_lock.patch
  fix set_page_dirty vs truncate&free races

remove-memshared.patch
  Remove /proc/meminfo:MemShared

bin2bcd.patch
  BIN_TO_BCD consolidation

log_buf_size.patch
  move LOG_BUF_SIZE to header/config

semtimedop-update.patch
  Enable semtimedop for ia64 32-bit emulation.

drain_local_pages.patch
  add drain_local_pages() for CONFIG_SOFTWARE_SUSPEND

htlb-2.patch
  hugetlb: fix MAP_FIXED handling

kmalloc_percpu.patch
  kmalloc_percpu -- stripped down version

config_page_offset.patch
  Configurable kenrel/user memory split

config_hz.patch
  CONFIGurable HZ

dont-aligns-vmas.patch
  Don't cacheline-align vm_area_struct

remove-swappable.patch
  remove task_struct.swappable

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
  (undescribed patch)

wli-13_rmap_nrpte.patch
  (undescribed patch)

dcache_rcu-2.patch
  dcache_rcu-2-2.5.51.patch

dcache_rcu-3.patch
  dcache_rcu-3-2.5.51.patch

page-walk-api.patch

page-walk-scsi.patch

page-walk-api-update.patch
  pagewalk API update

gup-check-valid.patch
  valid page test in get_user_pages()
