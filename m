Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319047AbSIJGWG>; Tue, 10 Sep 2002 02:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319049AbSIJGWG>; Tue, 10 Sep 2002 02:22:06 -0400
Received: from packet.digeo.com ([12.110.80.53]:59617 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319047AbSIJGWA>;
	Tue, 10 Sep 2002 02:22:00 -0400
Message-ID: <3D7D942A.C1D4C5F6@digeo.com>
Date: Mon, 09 Sep 2002 23:41:46 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.34-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Sep 2002 06:26:38.0598 (UTC) FILETIME=[04EEA260:01C25893]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.34/2.5.34-mm1/

A fair amount of new stuff here.  The testing status is "light".

Since 2.5.33-mm5:

-zone-pages-reporting.patch
-enospc-recovery-fix.patch
-fix-faults.patch
-refill-rate.patch
-refill-rate-fix.patch
-copy_user_atomic.patch
-kmap_atomic_reads.patch
-kmap_atomic_writes.patch

  Merged.

-filemap-integration.patch
-filemap-integration-fixes.patch

 Folded into readv-writev.patch

-slablru.patch
-slablru-speedup.patch

 We decided that there wasn't a lot of point in putting slab pages on the
 LRU.  They're not really being aged on the LRU.  Their presence on the
 LRU was merely telling us

   (page reclaim pressure) * (proportion of slab pages)

 and we can calculate that directly, without using the LRU for it.

+sharedmem.patch

  Display in /proc/meminfo the amount of memory which is mapped into
  process address space.

+slab-stats.patch

  Display total slab memory in /proc/meminfo

+free_area_init-cleanup.patch
+alloc_pages-cleanup.patch

  discontigmem code cleanups

+statm_pgd_range-sucks.patch

  He's right.  It does.  Did.

+remove-sync_thresh.patch

  Remove /proc/sys/vm/dirty_sync_ratio.

+sync-helper.patch

  Speed up /bin/sync against multiple spindles

+slabasap.patch

  A patch from Ed Tomlinson which improves the way in which the kernel
  reclaims slab objects.

  The theory is: a cached object's usefulness is measured in terms of the
  number of disk seeks which is saves.  Furthermore, we assume that one
  dentry or inode saves as many seeks as one pagecache page.

  So we reap one slab object for each reaped pagecache page (actually, we
  _scan_ one slab object for each scanned pagecache page).

  Furthermore we assume that one swapout costs twice as many seeks as one
  pagecache page, and twice as many seeks as one slab object.  So we
  double the pressure on slab when anonymous pages are being considered
  for eviction.

  The code works nicely, and smoothly.  Possibly it does not shrink slab
  hard enough, but that is now very easy to tune up and down.  It is just:

        ratio *= 3;

  in shrink_caches().

+write-deadlock.patch

  Fix the write()-into-mmapped-page-which-got-evicted-at-the-wrong-time
  deadlock.

+segq.patch

  Patch from Rik which makes the VM prefer to reclaim pagecache rather
  than pages which are mapped into process memory.

  It makes the VM significantly less inclined to swap out and evict
  program text in the presence of heavy disk I/O, and is very nice.

  Still needs a few things doing to it, but I'm running it on my
  desktop and it has caused a very noticeable decrease in suckiness.


Also, the `Buffers:' accounting in /proc/meminfo has been redone to not
walk inode_unused.  count_list() won't appear on profiles any more.



linus.patch
  cset-1.575-to-1.600.txt.gz

scsi_hack.patch
  Fix block-highmem for scsi

ext3-htree.patch
  Indexed directories for ext3

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

throttling-fix.patch
  Fix throttling of heavy write()rs.

sleeping-release_page.patch
  Allow a_ops->releasepage() to sleep again

dirty-state-accounting.patch
  Make the global dirty memory accounting more accurate

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

discontig-cleanup-1.patch
  i386 discontigmem coding cleanups

discontig-cleanup-2.patch
  i386 discontigmem cleanups

writeback-thresholds.patch
  Downward adjustments to the default dirtymemory thresholds

buffer-strip.patch
  Limit the consumption of ZONE_NORMAL by buffer_heads

rmap-speedup.patch
  rmap pte_chain space and CPU reductions

wli-highpte.patch
  Resurrect CONFIG_HIGHPTE - ia32 pagetables in highmem

readv-writev.patch
  O_DIRECT support for readv/writev

llzpr.patch
  Reduce scheduling latency across zap_page_range

buffermem.patch
  Resurrect buffermem accounting

lpp.patch
  ia32 huge tlb pages

lpp2.patch
  hugetlbpage fixes

sharedmem.patch
  Add /proc/meminfo:Mapped - tha amount of memory which is mapped into pagetables

ext3-sb.patch
  u.ext3_sb -> generic_sbp

oom-fix.patch
  Fix an OOM condition on big highmem machines

tlb-cleanup.patch
  Clean up the tlb gather code

dump-stack.patch
  arch-neutral dump_stack() function

wli-cleanup.patch
  random cleanups

madvise-move.patch
  move mdavise implementation into mm/madvise.c

split-vma.patch
  VMA splitting patch

mmap-fixes.patch
  mmap.c cleanup and lock ranking fixes

buffer-ops-move.patch
  Move submit_bh() and ll_rw_block() into fs/buffer.c

slab-stats.patch
  Display total slab memory in /proc/meminfo

writeback-control.patch
  Cleanup and extension of the writeback paths

free_area_init-cleanup.patch
  free_area_init() code cleanup

alloc_pages-cleanup.patch
  alloc_pages cleanup and optimisation

statm_pgd_range-sucks.patch
  Remove the pagetable walk from /proc/stat

remove-sync_thresh.patch
  Remove /proc/sys/vm/dirty_sync_thresh

queue-congestion.patch
  Infrastructure for communicating request queue congestion to the VM

nonblocking-ext2-preread.patch
  avoid ext2 inode prereads if the queue is congested

nonblocking-pdflush.patch
  non-blocking writeback infrastructure, use it for pdflush

nonblocking-vm.patch
  Non-blocking page reclaim

sync-helper.patch
  Speed up sys_sync()

slabasap.patch
  Early and smarter shrinking of slabs

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

segq.patch
  Modified segmented queue algorithm for page aging
