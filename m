Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263074AbTCLHJt>; Wed, 12 Mar 2003 02:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263075AbTCLHJs>; Wed, 12 Mar 2003 02:09:48 -0500
Received: from packet.digeo.com ([12.110.80.53]:42140 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263074AbTCLHJl>;
	Wed, 12 Mar 2003 02:09:41 -0500
Date: Tue, 11 Mar 2003 23:21:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.64-mm5
Message-Id: <20030311232117.28eb3734.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Mar 2003 07:20:19.0046 (UTC) FILETIME=[D6104060:01C2E867]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm5/

. Various fixes and debug things.

. Included the brlock-removal patches for a bit of testing.

. The global files_lock spinlock is now one of the most expensive locks in
  the kernel.  There are a few patches here which pretty much exterminate it.

  These were written by Manfred and myself.  We somehow blundered through
  this despite our never having seen any UNIX(tm) source code.  Beginner's
  luck.

. No significant anticipatory scheduler changes this time.  We're still
  hunting Ed's bug.  Testing results would be interesting.




Changes since 2.5.64-mm4

 linus.patch

 Latest from Linus

-sysfs_remove_dir-dcache_lock.patch
-nfs-del_timer-race-fix.patch
-serial-warning-fix.patch
-resurrect-kernel_flag.patch
-eepro100-warning-fix.patch
-atm_dev_sem.patch
-gcc3-inline-fix.patch

 Merged

+noirqbalance-fix.patch

 Fix the i386 noirqbalance boot option

+config_spinline.patch

 Config option to allow the out-of-line spinlock spinning code to be placed
 inline.  So kernel profiling shows the spin cost in the caller, not in
 .text.lock.foo.

+config-PAGE_OFFSET.patch

 Configurable user/kernel split (so I can pretend I have 16G)

-as-random-fixes.patch
-as-comment-fix.patch
-as-naming-comments-BUG.patch
-as-unnecessary-test.patch
-as-atomicity-fix.patch
-as-state-tracking-and-debug.patch
-as-state-tracking-fix.patch
-as-nr_dispatched-atomic-fix.patch
-as-thinktime.patch
-as-div-by-zero-fix.patch
-as-history-track-reads-only.patch

 Folded into as-iosched.patch

+as-debug-BUG-fix.patch

 64-bit fix for anticipatory scheduler debug code.

-objrmap-X-fix.patch
-objrmap-nr_mapped-fix.patch
-objrmap-mapped-mem-fix-2.patch
-objrmap-atomic_t-fix.patch

 Folded into objrmap-2.5.62-5.patch

-scheduler-tunables-fix.patch

 Folded into scheduler-tunables.patch

-pte_file-always.patch

 This didn't work.

+file-offset-in-pte-x86_64.patch

 x86_64 support for file-offsets-in-ptes

+set_current_state-fs.patch
+set_current_state-mm.patch

 Cleanups

+copy_thread-leak-fix.patch

 Memory leak fix

+slab_store_user-large-objects.patch

 Allow larger slab objects to get full use-after-free debug treatment

+file_list_lock-contention-fix.patch
+tty_files-fixes.patch
+file_list_cleanup.patch
+file_list-remove-free_list.patch
+file-list-less-locking.patch

 file_list_lock speedups and cleanups

+vt_ioctl-stack-use.patch

 Stack reduction

+fix-mem-equals.patch

 Fix the "mem=" boot option.

+no-mmu-stubs.patch
+nommu-slab.patch

 !CONFIG_MMU fixes

+nfsd-memleak-fix.patch
+nfs-memleak-fix.patch
+ufs-memleak-fix.patch

 Memory leak fixes

+hugetlb-unmap_vmas-fix.patch

 Fix the fix for unmapping hugetlb areas

+brlock-1.patch
+brlock-2.patch
+brlock-3.patch
+brlock-4.patch
+brlock-5.patch
+brlock-6.patch
+brlock-7.patch
+brlock-8.patch

 brlock removal



All 72 patches

linus.patch
  Latest from Linus

mm.patch
  add -mmN to EXTRAVERSION

kgdb.patch

noirqbalance-fix.patch
  Fix noirqbalance

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-64-bit-exec-fix.patch
  Pass the load address into ELF_PLAT_INIT()

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

sym-do-160.patch
  make the SYM driver do 160 MB/sec

nfsd-disable-softirq.patch
  Fix race in svcsock.c in 2.5.61

report-lost-ticks.patch
  make lost-tick detection more informative

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

ptrace-flush.patch
  cache flushing in the ptrace code

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

reiserfs_file_write-5.patch

tcp-wakeups.patch
  Use fast wakeups in TCP/IPV4

lockd-lockup-fix-2.patch
  Subject: Re: Fw: Re: 2.4.20 NFS server lock-up (SMP)

rcu-stats.patch
  RCU statistics reporting

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

nfs-speedup.patch

nfs-oom-fix.patch
  nfs oom fix

sk-allocation.patch
  Subject: Re: nfs oom

nfs-more-oom-fix.patch

rpciod-atomic-allocations.patch
  Make rcpiod use atomic allocations

linux-isp.patch

isp-update-1.patch

remove-unused-congestion-stuff.patch
  Subject: [PATCH] remove unused congestion stuff

as-iosched.patch
  anticipatory I/O scheduler

as-debug-BUG-fix.patch

cfq-2.patch
  CFQ scheduler, #2

smalldevfs.patch
  smalldevfs

objrmap-2.5.62-5.patch
  object-based rmap

scheduler-tunables.patch
  scheduler tunables

show_task-free-stack-fix.patch
  show_task() fix and cleanup

reiserfs-fix-memleaks.patch
  ReiserFS: fix memleaks on journal opening failures

yellowfin-set_bit-fix.patch
  yellowfin driver set_bit fix

remap-file-pages-2.5.63-a1.patch
  Subject: [patch] remap-file-pages-2.5.63-A1

hugh-nonlinear-fixes.patch
  Fix nonlinear oddities

file-offset-in-pte-x86_64.patch
  x86_64: support for file offsets in pte's

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

update_atime-ng.patch
  inode a/c/mtime modification speedup

one-sec-times.patch
  Implement a/c/time speedup in ext2 & ext3

task_prio-fix.patch
  simple task_prio() fix

register-tty_devclass.patch
  Register tty_devclass before use

set_current_state-fs.patch
  use set_current_state in fs

set_current_state-mm.patch
  use set_current_state in mm

copy_thread-leak-fix.patch
  Fix memory leak in copy_thread

slab_store_user-large-objects.patch
  slab debug: perform redzoning against larger objects

file_list_lock-contention-fix.patch
  file_list_lock contention fixes

tty_files-fixes.patch
  file->f_list locking in tty_io.c

file_list_cleanup.patch
  file_list cleanup

file_list-remove-free_list.patch
  file_table: remove the private freelist

file-list-less-locking.patch
  file_list: less locking

vt_ioctl-stack-use.patch
  stack reduction in drivers/char/vt_ioctl.c

fix-mem-equals.patch
  Fix mem= options

no-mmu-stubs.patch
  a few missing stubs for !CONFIG_MMU

nommu-slab.patch
  slab changes for !CONFIG_MMU

nfsd-memleak-fix.patch
  nfsd/export.c memleak.

nfs-memleak-fix.patch
  memleak in fs/nfs/inode.c::nfs_get_sb()

ufs-memleak-fix.patch
  Memleak in fs/ufs/util.c

hugetlb-unmap_vmas-fix.patch
  fix the fix for unmap_vmas & hugepages

brlock-1.patch
  Eliminate brlock in psnap

brlock-2.patch
  Eliminate brlock for packet_type

brlock-3.patch
  Eliminate brlock from vlan

brlock-4.patch
  Eliminate brlock in net/bridge

brlock-5.patch
  Eliminate brlock from netfilter

brlock-6.patch
  Eliminate brlock from ipv4

brlock-7.patch
  Eliminate brlock from IPV6

brlock-8.patch
  Kill brlock



