Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319849AbSINDqE>; Fri, 13 Sep 2002 23:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319850AbSINDqE>; Fri, 13 Sep 2002 23:46:04 -0400
Received: from packet.digeo.com ([12.110.80.53]:23280 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319849AbSINDqB>;
	Fri, 13 Sep 2002 23:46:01 -0400
Message-ID: <3D82B5C3.229C6B1A@digeo.com>
Date: Fri, 13 Sep 2002 21:06:27 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>
Subject: 2.5.34-mm4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2002 03:50:47.0720 (UTC) FILETIME=[E906E280:01C25BA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.34/2.5.34-mm4/

Some additional work has been performed on the new, faster
sleep/wakeup facilities.

I have converted TCP/IPV4 over to use the faster wakeups.  It would
be appreciated if the people who are interested in (and set up for
testing) high performance networking could test this out.  Note
however that there is no benefit to select()/poll().  That's quite
a large change.

So please bear in mind that this code will only help if applications
are generally sleeping in accept(), connect(), etc.  At this stage
I'd like to know whether this work is generally something which should be
pursued further - let's be careful that the measurements are not
swamped by select()/poll() wakeups.

The individual patches are:

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.34/2.5.34-mm4/broken-out/wake-speedup.patch
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.34/2.5.34-mm4/broken-out/tcp-wakeups.patch

These apply against 2.5.26 and possibly earlier, and testing against
earlier kernels would be valid.  Thanks.



Changes have been made to /proc/stat which break top(1) and vmstat(1).
New versions are available at
http://www.zip.com.au/~akpm/linux/patches/procps-2.5.34-mm4.tar.gz
and newer versions will appear at
http://surriel.com/procps/

+aio-sync-iocb.patch

 Ben's AIO patch conflicted with the readv/writev patch.  This is
 Ben's patch reworked to fit on top of readv-writev.patch

+pagevec_lru_add.patch

 Fix a bogon which broke reiserfs4

+taka-writev.patch

 Hirokazu Takahashi's writev() speedup.

+vm-wakeups.patch

 Use the auto waitqueues in the VM and block layers.  Broken out of
 the wake-speedup patch.

+per-node-kswapd.patch

 David Hansen's per-NUMA-node kswapd patch.

+topology-api.patch

 Matthew Dobson's topology API.

+kswapd-reclaim-stats.patch

 Add `kswapd_steal' and `pgrefill' to /proc/vmstat.  The former indicates
 that, on a quick test, 99% of page reclaim is being performed by kswapd.

+iowait.patch

 Instrumentation to show how much time is spent in disk wait.  (Doesn't
 appear to come out in the new top(1) though?)

+tcp-wakeups.patch

 Use auto-waitqueues in TCP/IPV4




linus.patch
  cset-1.568.19.4-to-1.661.txt.gz

scsi_hack.patch
  Fix block-highmem for scsi

ext3-htree.patch
  Indexed directories for ext3

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

readv-writev.patch
  O_DIRECT support for readv/writev

aio-sync-iocb.patch
  Use a sync iocb for generic_file_read

llzpr.patch
  Reduce scheduling latency across zap_page_range

buffermem.patch
  Resurrect buffermem accounting

lpp.patch
  ia32 huge tlb pages

lpp-update.patch
  hugetlbpage fixes

reversemaps-leak.patch
  Fix reverse map accounting leak

sharedmem.patch
  Add /proc/meminfo:Mapped - tha amount of memory which is mapped into pagetables

ext3-sb.patch
  u.ext3_sb -> generic_sbp

pagevec_lru_add.patch
  Run readpage before dropping the page refcount

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

taka-writev.patch
  Speed up writev

pf_nowarn.patch
  Fix up the handling of PF_NOWARN

jeremy.patch
  Spel Jermy's naim wright

queue-congestion.patch
  Infrastructure for communicating request queue congestion to the VM

nonblocking-ext2-preread.patch
  avoid ext2 inode prereads if the queue is congested

nonblocking-pdflush.patch
  non-blocking writeback infrastructure, use it for pdflush

nonblocking-vm.patch
  Non-blocking page reclaim

wake-speedup.patch
  Faster wakeup code

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
