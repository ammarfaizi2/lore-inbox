Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317852AbSHaSLL>; Sat, 31 Aug 2002 14:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317855AbSHaSLL>; Sat, 31 Aug 2002 14:11:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31244 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317852AbSHaSLJ>;
	Sat, 31 Aug 2002 14:11:09 -0400
Message-ID: <3D710A93.729F3026@zip.com.au>
Date: Sat, 31 Aug 2002 11:27:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.32-mm4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.32/2.5.32-mm4/

Since -mm2:

- Linus has merged a bunch of things.  Of which O_DIRECT support for ext3
  is the only interesting part.

- mm3 was a temp syncup with wli.  mm4 has survived an overnight deathtest
  and looks pretty good.

+ the block-highmem scsi fix has been changed: we now allow block-highmem
  for all scsi devices, not just disks.

+ added a patch to move the rmap locking functions into their own
  header file.

+ highpte is now working.

  There is no evidence that non-ia32 people have tried to compile this
  code yet.

+ a race in slablru has been fixed.  slablru seems to keep the slabs
  under control quite nicely.

+ added rml's low-latency-zap_page_range patch

+ reinstated buffermem acounting in /proc/meminfo.  This is useful,
  but the implementation's walk across the inode_unused list will
  probably be very costly in some situations.  May need to change it so
  that the inode walk only works correctly for blockdevs, or make
  the inode_unused list (and inode_lock!) per-superblock.

+ The configurable kernel/userspace split patch is back.

+ Added Rohit's ia32 huge tlb page patch.  We don't have any tools
  to test this with at present, which is a bit of a problem.

+ Added Jani Monoses' EXT3_SB cleanup.



linus.patch
  cset-1.508.1.15-to-1.567.txt.gz

scsi_hack.patch
  Fix block-highmem for scsi

ext3-htree.patch
  Indexed directories for ext3

rmap-locking-move.patch
  move rmap locking inlines into their own header file.

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

llzpr.patch
  Reduce scheduling latency across zap_page_range

buffermem.patch
  Resurrect buffermem accounting

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

lpp.patch
  ia32 huge tlb pages

ext3-sb.patch
  u.ext3_sb -> generic_sbp
