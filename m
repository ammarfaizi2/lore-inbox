Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319571AbSIHG2U>; Sun, 8 Sep 2002 02:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319572AbSIHG2U>; Sun, 8 Sep 2002 02:28:20 -0400
Received: from packet.digeo.com ([12.110.80.53]:63384 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319571AbSIHG2R>;
	Sun, 8 Sep 2002 02:28:17 -0400
Message-ID: <3D7AF270.BE4AFBEB@digeo.com>
Date: Sat, 07 Sep 2002 23:47:12 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.33-mm5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2002 06:32:52.0596 (UTC) FILETIME=[8F06B340:01C25701]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


URL: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.33/2.5.33-mm5/

+refill-rate-fix.patch

 Fix a problem in refill_inactive_zone() which could soak a lot of CPU.

+sleeping-release_page.patch

 Allow mapped->releasepage() to sleep again.  My passing in non-zero
 gfp_mask.

+filemap-integration-fixes.patch

 Some fixes to the readv/writev rework.

Plus a lot of stabilisation, tuning and testing of the new VM latency
control code.  Including fixing one rarely-occurring infinite loop
which might explain Steve Cole's reported failure.

Some testing with no swap has been performed as well.  Works OK,
and some speedups were made in this area (if there's no swap online,
don't bring anon pages onto the inactive list).

It's looking pretty good now - the system is quite responsive under
all heavy writeout workloads.  It's still very latent under heavy
swapout load; that is deliberate.  It is latent when overloaded by
dirty MAP_SHARED data.  We can fix that.

A side-effect of the VM rework is an improvement in many-spindle
pagecache writeout. This is the first kernel which can keep four
queues saturated.  I tested six disks - the LEDs never went out.

I'd appreciate it if people could grab this one, be nasty to it
and send a report.

You will probably see increased CPU utilisation by kswapd.  I believe
that this is not an efficiency problem - it's due to kswapd doing more
work that it used to, rather than sleeping on request queues all the time.

Also, pdflush appears to be taking more CPU, but profiling shows that it
is not - this may be due to synchronisation with the CPU load accounting.


linus.patch
  cset-1.575-to-1.600.txt.gz

scsi_hack.patch
  Fix block-highmem for scsi

ext3-htree.patch
  Indexed directories for ext3

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

refill-rate-fix.patch
  Don't call shrink_zone with a negative nr_pages

copy_user_atomic.patch

kmap_atomic_reads.patch
  Use kmap_atomic() for generic_file_read()

kmap_atomic_writes.patch
  Use kmap_atomic() for generic_file_write()

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

filemap-integration.patch
  Clean up readv/writev

filemap-integration-fixes.patch
  More readv/writev fixes

slablru.patch
  age slab pages on the LRU

slablru-speedup.patch
  slablru optimisations

llzpr.patch
  Reduce scheduling latency across zap_page_range

buffermem.patch
  Resurrect buffermem accounting

lpp.patch
  ia32 huge tlb pages

lpp2.patch
  hugetlbpage fixes

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

writeback-control.patch
  Cleanup and extension of the writeback paths

queue-congestion.patch
  Infrastructure for communicating request queue congestion to the VM

nonblocking-ext2-preread.patch
  avoid ext2 inode prereads if the queue is congested

nonblocking-pdflush.patch
  non-blocking writeback infrastructure, use it for pdflush

nonblocking-vm.patch
  Non-blocking page reclaim
