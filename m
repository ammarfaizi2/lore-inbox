Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSIPHKs>; Mon, 16 Sep 2002 03:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSIPHKr>; Mon, 16 Sep 2002 03:10:47 -0400
Received: from packet.digeo.com ([12.110.80.53]:39580 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S315942AbSIPHKn>;
	Mon, 16 Sep 2002 03:10:43 -0400
Message-ID: <3D858515.ED128C76@digeo.com>
Date: Mon, 16 Sep 2002 00:15:33 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>
Subject: 2.5.35-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Sep 2002 07:15:33.0411 (UTC) FILETIME=[D8B20F30:01C25D50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.35/2.5.35-mm1/

Significant rework of the new sleep/wakeup code - make it look totally
different from the current APIs to avoid confusion, and to make it
simpler to use.

Also increase the number of places where this API is used in networking;
Alexey says that some of these may be negative improvements, but
performance testing will nevertheless be interesting.  The relevant
patches are:

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.35/2.5.35-mm1/broken-out/prepare_to_wait.patch
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.35/2.5.35-mm1/broken-out/tcp-wakeups.patch

A 4x performance regression in heavy dbench testing has been fixed. The
VM was accidentally being fair to the dbench instances in page reclaim.
It's better to be unfair so just a few instances can get ahead and submit
more contiguous IO.  It's a silly thing, but it's what I meant to do anyway.

Since 2.5.34-mm4:

-readv-writev.patch
-aio-sync-iocb.patch
-llzpr.patch
-buffermem.patch
-lpp.patch
-lpp-update.patch
-reversemaps-leak.patch
-sharedmem.patch
-ext3-sb.patch
-pagevec_lru_add.patch
-oom-fix.patch
-tlb-cleanup.patch
-dump-stack.patch
-wli-cleanup.patch

 Merged

+release_pages-speedup.patch

 Avoid a couple of lock-takings.

-wake-speedup.patch
+prepare_to_wait.patch

 Renamed, reworked

+swapoff-deadlock.patch
+dirty-and-uptodate.patch
+shmem_rename.patch
+dirent-size.patch
+tmpfs-trivia.patch

 Various fixes and cleanups from Hugh Dickins


linus.patch
  cset-1.552-to-1.564.txt.gz

scsi_hack.patch
  Fix block-highmem for scsi

ext3-htree.patch
  Indexed directories for ext3

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

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

taka-writev.patch
  Speed up writev

pf_nowarn.patch
  Fix up the handling of PF_NOWARN

jeremy.patch
  Spel Jermy's naim wright

release_pages-speedup.patch
  Reduced locking in release_pages()

queue-congestion.patch
  Infrastructure for communicating request queue congestion to the VM

nonblocking-ext2-preread.patch
  avoid ext2 inode prereads if the queue is congested

nonblocking-pdflush.patch
  non-blocking writeback infrastructure, use it for pdflush

nonblocking-vm.patch
  Non-blocking page reclaim

prepare_to_wait.patch
  New sleep/wakeup API

vm-wakeups.patch
  Use the faster wakeups in the VM and block layers

sync-helper.patch
  Speed up sys_sync() against multiple spindles

slabasap.patch
  Early and smarter shrinking of slabs

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

buddyinfo.patch
  Add /proc/buddyinfo - stats on the free pages pool

free_area.patch
  Remove struct free_area_struct and free_area_t, use `struct free_area'

per-node-kswapd.patch
  Per-node kswapd instance

topology-api.patch
  NUMA topology API

radix_tree_gang_lookup.patch
  radix tree gang lookup

truncate_inode_pages.patch
  truncate/invalidate_inode_pages rewrite

proc_vmstat.patch
  Move the vm accounting out of /proc/stat

kswapd-reclaim-stats.patch
  Add kswapd_steal to /proc/vmstat

iowait.patch
  I/O wait statistics

tcp-wakeups.patch
  Use fast wakeups in TCP/IPV4

swapoff-deadlock.patch
  Fix a tmpfs swapoff deadlock

dirty-and-uptodate.patch
  page state cleanup

shmem_rename.patch
  shmem_rename() directory link count fix

dirent-size.patch
  tmpfs: show a non-zero size for directories

tmpfs-trivia.patch
  tmpfs: small fixlets
