Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267554AbTBNJVj>; Fri, 14 Feb 2003 04:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268248AbTBNJVj>; Fri, 14 Feb 2003 04:21:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:15823 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267554AbTBNJVe>;
	Fri, 14 Feb 2003 04:21:34 -0500
Date: Fri, 14 Feb 2003 01:31:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.60-mm2
Message-Id: <20030214013144.2d94a9c5.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2003 09:31:20.0541 (UTC) FILETIME=[D523B0D0:01C2D40B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.60/2.5.60-mm2/

. Robert has fixed up Ingo's scheduler update, so that's back in.

. Considerable poking at the NFS MAP_SHARED OOM lockup.  It is limping
  along now, but writeout bandwidth is poor and it is still struggling. 
  Needs work.

. There's a one-liner which removes an O(n^2) search in the NFS writeback
  path.  It increases writeout bandwidth by 4x and decreases CPU load from
  100% to 3%.  Needs work.

. A patch to permit direct-io reads of the partial block at EOF.  Seems to
  work, but needs more testing.

. There is another anticipatory scheduler patch over in experimental/.

  The main obective of the anticipatory scheduler is not really to improve
  interactivity.  It is to increase throughput.  Nick is showing some
  impressive benchmark results with this now.  Some benchmarking of the
  non-contest variety would be appreciated.

. Added Matthew Jacob's Qlogic ISP driver for a bit of testing.  It locks
  up mysteriously with my ISP12160 controller.  Testing results for other
  controllers would be appreciated.



Changes since 2.5.60-mm1:


 linus.patch

 Latest bk from Linus

-genhd-warnings.patch
-vmscan-warning.patch
-nfsd-warnings.patch
-partitions-warnings.patch
-nfs-warning-fix.patch
-reiserfs-hashes-warning-fix.patch
-st-warning-fix.patch
-adaptec-compile-fix.patch
-adaptec-debug-fix.patch
-oprofile-p4.patch
-oprofile_cpu-as-string.patch
-oprofile-braino.patch
-disassociate_tty-fix.patch
-epoll-update-2.5.60.patch
-misc.patch
-dcache_rcu-nfs-server-fix.patch
-cyclone-fixes.patch
-enable-timer_cyclone.patch
-hugetlbfs-i_size-fix.patch

+jfs-build-fix.patch

 JFS compile fix for gcc-2.95.3.

-mandlock-oops-fix.patch
+mandlock-fix.patch

 Updated flocking fix

+fault_in_pages-move.patch

 Move fault_in_pages_readable/writeable to a header file so reiserfs can
 reuse it.

 reiserfs_file_write.patch

 Updated

+ext3-eio-fix.patch

 Fix a BUG with fsx-linux

+smctr-fix.patch

 compile fix.

+sched-f3.patch
+rml-scheduler-bits.patch

 Updated scheduler update.

+nfs-speedup.patch
+nfs-more-oom-fix.patch

 NFS OOM work.

+nfs-sendfile.patch

 "fix" an O(n^2) problem in the NFS client.

+put_page-speedup.patch

 Speed up put_page() for CONFIG_HUGETLB_PAGE=y

+kernel_lock_bug2.patch
+ext2_ext3_listxattr-bug.patch
+xattr-flags.patch
+xattr-flags-policy.patch
+xattr-trusted.patch

 Extended attribute feature work.

+generic_write_checks.patch

 Break out the bounds checking from generic_file_write() so other
 filesystems can use them.

+balance_dirty_pages-lockup-fix.patch

 Fix a weird lockup in the writeback code.

+cciss-1.patch
+cciss-2.patch
+cciss-3.patch
+cciss-5.patch
+cciss-6.patch
+cciss-7.patch
+cciss-8.patch
+cciss-9.patch
+cciss-10.patch
+cciss-11.patch

 cciss array controller driver update

+direct-io-retval-fix.patch

 Return the correct thing on -EIO

+dio-eof-read.patch

 Allow direct-io reads of the non-aligned end of file.

+linux-isp.patch

 Latest qlogic driver from www.feral.com bitkeeper

+linux-isp-update.patch

 Port it to 2.5


In the experimental/ directory:

+handle-async-write-errors.patch

 Framework for recording and reporting data loss during the async writeout
 code.

+anticipatory_io_scheduling.patch
+ant-sched-9feb.patch
+ant-sched-12feb.patch

 Anticipatory scheduler updates.



All 66 patches

linus.patch

kgdb.patch

ppc64-reloc_hide.patch

ppc64-time-warning.patch
  kill ppc64 unused var warning

xfs-warning-fixes.patch

xfs-cli-fix.patch
  xfs interrupt flags fix

ppc64-smp_prepare_cpus-warning.patch
  ppc64: fix warning

report-lost-ticks.patch
  make lost-tick detection more informative

devfs-fix.patch

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

jfs-build-fix.patch
  JFS build fix with gcc-2.95.3

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

mandlock-fix.patch
  Subject: [PATCH] Fix mandatory locking

fault_in_pages-move.patch
  move fault_in_pages_readable/writeable to header

reiserfs_file_write.patch
  Subject: reiserfs file_write patch

ext3-eio-fix.patch
  fix ext3 BUG due to race with truncate

deadline-np-42.patch
  (undescribed patch)

deadline-np-43.patch
  (undescribed patch)

batch-tuning.patch
  I/O scheduler tuning

starvation-by-read-fix.patch
  fix starvation-by-readers in the IO scheduler

crc32-speedup.patch
  crc32 improvements for 2.5

smctr-fix.patch
  smctr.c build fixes

scheduler-tunables.patch
  scheduler tunables

sched-f3.patch
  scheduler F3-updated

rml-scheduler-bits.patch
  scheduler bits

lockd-lockup-fix.patch
  Subject: Re: Fw: Re: 2.4.20 NFS server lock-up (SMP)

rcu-stats.patch
  RCU statistics reporting

dcache_rcu-fast_walk-revert.patch
  dcache_rcu: revert fast_walk code

dcache_rcu-main.patch
  dcache_rcu

smalldevfs.patch
  smalldevfs

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

deadline-hash-fix.patch

nfs-speedup.patch

nfs-oom-fix.patch
  nfs oom fix

sk-allocation.patch
  Subject: Re: nfs oom

nfs-more-oom-fix.patch

nfs-sendfile.patch
  Implement sendfile() for NFS

rpciod-atomic-allocations.patch
  Make rcpiod use atomic allocations

put_page-speedup.patch
  hugetlb put_page speedup

kernel_lock_bug2.patch

ext2_ext3_listxattr-bug.patch
  xattr: listxattr fix

xattr-flags.patch
  xattr: infrastructure for permission overrides

xattr-flags-policy.patch
  xattr: allow kernel code to override EA permissions

xattr-trusted.patch
  xattr: trusted extended attributes

generic_write_checks.patch
  separate checks from generic_file_aio_write

balance_dirty_pages-lockup-fix.patch
  blk_congestion_wait tuning and lockup fix

cciss-1.patch
  make cciss driver compile

cciss-2.patch
  make cciss driver compile (2)

cciss-3.patch
  make cciss driver compile [3]

cciss-5.patch
  make cciss driver compile [5]

cciss-6.patch
  make cciss driver compile [6]

cciss-7.patch
  make cciss driver compile [7]

cciss-8.patch
  make cciss driver compile

cciss-9.patch
  make cciss driver compile

cciss-10.patch
  make cciss driver compile

cciss-11.patch
  make cciss driver compile

direct-io-retval-fix.patch
  direct-io return value fix

dio-eof-read.patch

linux-isp.patch

linux-isp-update.patch

handle-async-write-errors.patch
  Propagate async write errors to userspace

anticipatory_io_scheduling.patch
  Subject: [PATCH] 2.5.59-mm3 antic io sched

ant-sched-9feb.patch
  anticipatory scheduler fix

ant-sched-12feb.patch
  Anticipatory scheduler tuning



