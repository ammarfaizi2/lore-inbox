Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268541AbTBOHDk>; Sat, 15 Feb 2003 02:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268542AbTBOHDk>; Sat, 15 Feb 2003 02:03:40 -0500
Received: from packet.digeo.com ([12.110.80.53]:41362 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268541AbTBOHDf>;
	Sat, 15 Feb 2003 02:03:35 -0500
Date: Fri, 14 Feb 2003 23:13:56 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.61-mm1
Message-Id: <20030214231356.59e2ef51.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2003 07:13:22.0922 (UTC) FILETIME=[B9B504A0:01C2D4C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.61/2.5.61-mm1/

. Jens has fixed the request queue aliasing problem and we are no longer
  able to break the IO scheduler.  This was preventing the OSDL team from
  running dbt2 against recent kernels, so hopefully that is all fixed up now.

. The anticipatory scheduler is performing well.  I've included that now.

. Also included the CFQ I/O scheduler.  The kernel defaults to using the
  deadline/anticipatory scheduler.  Select CFQ by adding "elevator=cfq" to
  the kernel command line.  Do "dmesg|grep elevator" to see which one you
  are using.

. There is an updated version of the reiserfs_file_write patch here.  This
  patch addresses CPU efficiency when performing appending writes (ie: the
  usual sort).

  To do this, it requires that userspace pass "large" amounts of data into
  the write() system call.  So the filesystem returns a value of 128k in the
  stat.st_blksize field from the stat(2) system call.  In the hope that some
  applications are using that kernel-provided hint.

  Turns out that some parts of KDE (kmail, at least) were indeed using this
  hint, and it triggers a nasty bug in (at least) kmail: it is reading the
  same 128k of the file again and again and again.  It runs like a dog.
  Ed Tomlinson upgraded his KDE/kmail version and this problem went away.

  So that is something for reiserfs users to keep an eye on.



Changes since 2.5.60-mm2:


-smctr-fix.patch

 Merged

+deadline-alias-3.patch

 Fix an elevator aliasing bug (was causing direct-io lockups and oopses)

+linear-gcc-workaround.patch

 Work around a gcc-2.95.3 ICE in drivers/md/linear.c

+flush_tlb_all-preempt-safety.patch

 Make flush_tlb_all preempt+SMP-safe

-reiserfs_file_write.patch
+reiserfs_file_write-3.patch

 Updated

+tcp-wakeups.patch

 Resurrect this patch which uses faster wakeups in ipv4.  Worth 2% in a
 famous web serving benchmark on an 8-way.

-deadline-hash-fix.patch

 Obsoleted.

-cciss-2.patch
-cciss-3.patch
-cciss-5.patch
-cciss-6.patch
-cciss-7.patch
-cciss-8.patch
-cciss-9.patch
-cciss-10.patch
-cciss-11.patch

 Merged into ciss-1.patch

+cciss-overrun-fix.patch

 Fix a cciss_scsi bug

+ext3_debug-fix.patch

 Fix ext3 build when EXT3_DEBUG is defined

+visws-1.patch
+visws-2.patch
+visws-3.patch
+visws-4.patch
+visws-5.patch
+visws-6.patch
+visws-7.patch
+visws-8.patch
+visws-9.patch
+visws-10.patch
+visws-11.patch
+visws-12.patch
+visws-13.patch

 Resurrect visws support

+profiling-cleanup.patch

 Consolidate kernel profiling code

+remove-unused-congestion-stuff.patch

 Hugh keeps deleting all my lovely code.

+fix-Wundef.patch

 Clean up the build with -Wundef

+scsi-fix-NCR53C9x.patch

 Build fix

+radix_tree_maxindex-cleanup.patch

 radix-tree simplification and cleanup

+tty-module-refcounting.patch

 New module refcounting for the tty layer

+anticipatory_io_scheduling.patch
-ant-sched-9feb.patch
-ant-sched-12feb.patch

 Rolled-up anticipatory scheduler diff

+cfq-2.patch

 Complete Fair Queueing for the disk scheduler

+elevator-selection.patch

 Allow CFQ to be selected with "elevator=cfq" on the kernel boot
 commandline.



All 78 patches:

kgdb.patch

deadline-alias-3.patch

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

linear-gcc-workaround.patch
  work around gcc-2.95.3 internal compler error in linear.c

flush_tlb_all-preempt-safety.patch
  Subject: [PATCH][2.5] flush_tlb_all is not preempt safe.

mandlock-fix.patch
  Fix mandatory locking

fault_in_pages-move.patch
  move fault_in_pages_readable/writeable to header

generic_write_checks.patch
  separate checks from generic_file_aio_write

reiserfs_file_write-3.patch

ext3-eio-fix.patch
  fix ext3 BUG due to race with truncate

tcp-wakeups.patch
  Use fast wakeups in TCP/IPV4

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

balance_dirty_pages-lockup-fix.patch
  blk_congestion_wait tuning and lockup fix

cciss-1.patch
  make cciss driver compile

cciss-overrun-fix.patch
  Subject: [PATCH] 2.5.60, cciss, fix array bounds overrun

direct-io-retval-fix.patch
  direct-io return value fix

dio-eof-read.patch
  direct-io: allow reading of the part-filled EOF block

linux-isp.patch

linux-isp-update.patch

ext3_debug-fix.patch
  Fix ext3 build when EXT#_DEBUG is defined

visws-1.patch
  visws: allow SMP kernel build without io_apic.c (1/13)

visws-2.patch
  visws: export some functions from i8259.c (2/13)

visws-3.patch
  visws: make startup_32 kernel entry point (3/13)

visws-4.patch
  visws: export boottime gdt descriptor (4/13)

visws-5.patch
  visws: boot changes (5/13)

visws-6.patch
  Subject: [PATCH] visws: move header file into asm/arch-visws (6/13)

visws-7.patch
  visws: add missing mach_apic.h file (7/13)

visws-8.patch
  visws: pci support (8/13)

visws-9.patch
  visws: core (9/13)

visws-10.patch
  visws: framebuffer driver update (10/13)

visws-11.patch
  visws: sound update (11/13)

visws-12.patch
  visws: MAINTAINERS file update (12/13)

visws-13.patch
  visws: i386/KConfig update (13/13)

profiling-cleanup.patch
  Subject: [PATCH]: consolidate and cleanup profiling code.

remove-unused-congestion-stuff.patch
  Subject: [PATCH] remove unused congestion stuff

fix-Wundef.patch
  Make the world safe for -Wundef

scsi-fix-NCR53C9x.patch
  fix compile breakage on drivers/scsi/NCR53C9x.c

radix_tree_maxindex-cleanup.patch
  Use table lookup for radix_tree_maxindex()

tty-module-refcounting.patch
  TYT module refcounting fix

anticipatory_io_scheduling.patch
  Subject: [PATCH] 2.5.59-mm3 antic io sched

cfq-2.patch
  CFQ scheduler, #2

elevator-selection.patch
  boot-time selection of disk elevator type


