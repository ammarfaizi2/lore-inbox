Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319144AbSH2IUx>; Thu, 29 Aug 2002 04:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319145AbSH2IUw>; Thu, 29 Aug 2002 04:20:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40709 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319144AbSH2IUu>;
	Thu, 29 Aug 2002 04:20:50 -0400
Message-ID: <3D6DDD1E.14510CFC@zip.com.au>
Date: Thu, 29 Aug 2002 01:36:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.32-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.32/2.5.32-mm2/

- Linus has merged per-zone-lru and per-zone-lock, so the NUMA guys should
  be less than totally grumpy for several milliseconds.

- Linus has merged tlb-speedup.  There are new stats in /proc/meminfo
  which boast about how many global tlb invalidations have been saved.
  These will disappear soon.

- The hashed rmap spinlocking patch has been shown to slow down the big
  NUMA machines, and was of marginal benefit for SMP, and it added complexity.
  It has been shuffled to apply after rmap-speedup and the highpte patch.
  So it has basically been dropped.  Daniel is cooking up something else.

+ A BUG_ON(page_count(page)) has been added to put_page_testzero()
  (per Daniel's suggestion).  Should catch the possible double-free
  of LRU pages.

+ pagevec_lru_del() is removed

+ a change to the refill_inactive logic suggested by Ed Tomlinson

+ Janet Morgan's patch which speeds up readv&writev for O_DIRECT is
  included.  It needs some interface changes yet - generic_file_read
  and generic_file_write should be changed to take an iovec, which will
  allow lots of code to be removed.

+ Ed Tomlinson's slablru patch is now included.  This puts slab pages
  onto the LRU in an attempt to balance the various caches against
  other demands on the page allocator.   Seems to work nicely from a
  quick test.  It is early days for this code.

  I added a field to /proc/meminfo which displays the total amount of
  slab memory.

+ pte_highmem is still included, but it has mysteriously broken itself.
  Don't enable this in config.

  pte_highmem touches all architectures in possibly injurious ways.  It
  would be helpful if it received some non-x86 testing, please.  Just the
  "does it compile and boot" test.


2.5.32-mm2 hasn't had a ton of stability testing....



linus.patch
  Incremental BK patch from Linus' tree

scsi_hack.patch
  Fix block-highmem for scsi

misc.patch
  misc stuff

ext3-htree.patch
  Indexed directories for ext3

put_page-test.patch
  Check for zero-ref pages in put_page_testzero()

pagevec_lru_del.patch
  Remove pagevec_lru_del()

put_page_cleanup.patch
  Clean up put_page() and page_cache_release().

anon-batch-free.patch
  Batched freeing and de-LRUing of anonymous pages

writeback-sync.patch
  Writeback fixes and tuneups

ext3-inode-allocation.patch
  Fix an ext3 deadlock

ext3-o_direct.patch
  O_DIRECT support for ext3.

discontig-paddr_to_pfn.patch
  Convert page pointers into pfns for i386 NUMA

discontig-setup_arch.patch
  Rework setup_arch() for i386 NUMA

discontig-mem_init.patch
  Restructure mem_init for i386 NUMA

discontig-i386-numa.patch
  discontigmem support for i386 NUMA

cleanup-mem_map-1.patch
  Clean up lots of open-coded uese of mem_map[].  For ia32 NUMA

zone-pages-reporting.patch
  Fix the boot-time reporting of each zone's available pages

enospc-recovery-fix.patch
  Fix the __block_write_full_page() error path.

fix-faults.patch
  Back out the initial work for atomic copy_*_user()

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

refill-rate.patch
  refill the inactive list more quickly

copy_user_atomic.patch

kmap_atomic_reads.patch
  Use kmap_atomic() for generic_file_read()

kmap_atomic_writes.patch
  Use kmap_atomic() for generic_file_write()

throttling-fix.patch
  Fix throttling of heavy write()rs.

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

slablru.patch
  age slab pages on the LRU
