Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbSLSFpc>; Thu, 19 Dec 2002 00:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267360AbSLSFpc>; Thu, 19 Dec 2002 00:45:32 -0500
Received: from packet.digeo.com ([12.110.80.53]:57300 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267339AbSLSFp1>;
	Thu, 19 Dec 2002 00:45:27 -0500
Message-ID: <3E015ECE.9E3BD19@digeo.com>
Date: Wed, 18 Dec 2002 21:53:18 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.52-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Dec 2002 05:53:21.0889 (UTC) FILETIME=[F01C0510:01C2A722]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.52/2.5.52-mm2/

. Big reorganisation of shared pagetable code.  It is a cleanup, and
  there should be no functional changes.  The diff is considerably
  easier to read now.

  In this patchset, shared pagetables are configurable again, and the
  default is "off".  This is because the intent is that pagetable sharing
  always be enabled (on ia32 at least).  But we want it to work when it
  is disabled too.  So in this -mm, pagetable sahring is disabled. 
  Henceforth it will be enabled.  Make sense?

. Added Bill Irwin's patches, get them some additional testing.

. The per-cpu kmalloc infrastructure.

. Another update of the patch management scripts is at

	http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.9/

  no great changes here.  Various fixes and tweaks.



Changes since 2.5.52-mm1:

+shpte-reorg.patch

 The shared pagetable patch reorganisation.

+shpte-reorg-fixes.patch

 Make it work with CONFIG_SHAREPTE=n

-lockless-current_kernel_time.patch

 Dropped for now, because it is ia32-only and it is time to get some
 non-ia32 testing done.

+block-allocator-doc.patch

 Some commentary.

+ext2-rename-vars.patch

 Make ext2_new_block() understandable

+remove-memshared.patch

 Remvoe /proc/meminfo:MemShared

+bin2bcd.patch

 Code consolidation/cleanup

+log_buf_size.patch

 Configurable printk buffer size.

+semtimedop-update.patch

 Wire up semtimedop() for 32-bit ia32 apps on ia64.

+nfs-kmap_atomic.patch

 Use kmap_atomic in NFS

+ext3-bh-dirty-race.patch

 Fix a rare BUG in ext3

+unalign-radix-tree-nodes.patch

 Space saving for radix_tree_nodes

+htlb-0.patch
+htlb-1.patch
+htlb-2.patch
+htlb-3.patch

 hugetlbpage updates

+kmalloc_percpu.patch

 per-cpu kmalloc infrastructure

+kmalloc_percpu-rtcache.patch
+kmalloc_percpu-mibs-1.patch
+kmalloc_percpu-mibs-2.patch
+kmalloc_percpu-mibs-3.patch

 Applications thereof

+wli-01_numaq_io.patch
+wli-02_do_sak.patch
+wli-03_proc_super.patch
+wli-04_cap_set_pg.patch
+wli-06_uml_get_task.patch
+wli-07_numaq_mem_map.patch
+wli-08_numaq_pgdat.patch
+wli-09_has_stopped_jobs.patch
+wli-10_inode_wait.patch
+wli-11_pgd_ctor.patch
+wli-12_pidhash_size.patch
+wli-13_rmap_nrpte.patch

 Bill's stuff.



All 78 patches:


linus.patch
  cset-1.883.3.60-to-1.900.txt.gz

kgdb.patch

sync_fs-deadlock-fix.patch
  sync_fs deadlock fix

shrink_list-dirty-page-race.patch
  fix a page dirtying race in vmscan.c

slab-poisoning.patch
  more informative slab poisoning

nommu-generic_file_readonly_mmap.patch
  Add generic_file_readonly_mmap() for nommu

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

shpte-nonlinear.patch
  shpte: support nonlinear mappings and clean up clear_share_range()

shpte-reorg.patch

shpte-reorg-fixes.patch
  shared pagetable reorg fixes

shpte-always-on.patch
  Force CONFIG_SHAREPTE=y for ia32

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

misc.patch
  misc fixes

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

remove-PF_NOWARN.patch
  Remove PF_NOWARN

scheduler-tunables.patch
  scheduler tunables

blocking-kswapd.patch
  Give kswapd writeback higher priority than pdflush

block-allocator-doc.patch
  ext2/3 commentary and cleanup

spread-find_group_other.patch
  ext2/3: better starting group for S_ISREG files

ext3-alloc-spread.patch
  ext3: smarter block allocation startup

ext2-alloc-spread.patch
  ext2: smarter block allocation startup

ext2-rename-vars.patch
  rename locals in ext2_new_block()

ext3-use-after-free.patch
  ext3 use-after-free bugfix

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

nfs-kmap_atomic.patch
  use kmap_atomic instaed of kmap in NFS client

ext3-bh-dirty-race.patch
  ext3: fix buffer dirtying

unalign-radix-tree-nodes.patch
  don't cacheline-align radix_tree_nodes

htlb-0.patch
  hugetlb bugfixes

htlb-1.patch
  hugetlb: report shared memory attachment counts

htlb-2.patch
  hugetlb: fix MAP_FIXED handling

htlb-3.patch
  hugetlbfs: set inode->i_size

kmalloc_percpu.patch
  kmalloc_percpu -- stripped down version

kmalloc_percpu-rtcache.patch
  Make rt_cache_stat use kmalloc_percpu

kmalloc_percpu-mibs-1.patch
  Change Networking mibs to use kmalloc_percpu -- 1/3

kmalloc_percpu-mibs-2.patch
  Change Networking mibs to use kmalloc_percpu -- 2/3

kmalloc_percpu-mibs-3.patch
  Change Networking mibs to use kmalloc_percpu -- 3/3

wli-01_numaq_io.patch
  (undescribed patch)

wli-02_do_sak.patch
  (undescribed patch)

wli-03_proc_super.patch
  (undescribed patch)

wli-04_cap_set_pg.patch
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
