Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262438AbTCIGZ7>; Sun, 9 Mar 2003 01:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262439AbTCIGZ7>; Sun, 9 Mar 2003 01:25:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:22968 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262438AbTCIGZu>;
	Sun, 9 Mar 2003 01:25:50 -0500
Date: Sat, 8 Mar 2003 22:36:47 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.64-mm4
Message-Id: <20030308223647.5097f38d.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Mar 2003 06:36:22.0065 (UTC) FILETIME=[330FA210:01C2E606]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm4/


Please bear in mind that the bulk of a -mm patch is in fact the latest batch
of updates from Linus's tree.  So if you discover a problem, don't just tell
me about it!  Other people write bugs too, you know.


. More anticipatory scheduler work.  We're now starting to track
  per-process I/O patterns.

  This is all part of fixing up all the small (and not so small)
  regressions which are a natural consequence of leaving the disk head idle
  for 5-10 milliseconds.  We're getting there.

. There's a missing spin_unlock() in sysfs_remove_dir() which is fairly
  fatal for SMP and preemptible kernels.  Fix it with this:


--- 25/fs/sysfs/dir.c
+++ 25-akpm/fs/sysfs/dir.c
@@ -106,7 +106,7 @@ void sysfs_remove_dir(struct kobject * k
 		pr_debug(" done\n");
 		node = dentry->d_subdirs.next;
 	}
-
+	spin_unlock(&dcache_lock);
 	up(&dentry->d_inode->i_sem);
 	d_invalidate(dentry);
 	simple_rmdir(parent->d_inode,dentry);





Changes since 2.5.64-mm3:


 linus.patch

 Latest from Linus

-register_blkdev-cleanups.patch
-limit-write-latency.patch
-nfs-sendfile.patch
-readahead-shrink-to-zero.patch
-per-cpu-disk-stats.patch
-vm_area-use-after-free-fix.patch
-use-after-free-check.patch
-slab-caller-tracking.patch
-slab-caller-tracking-symbolic.patch
-copy_page_range-invalid-page-fix.patch
-CONFIG_SWAP-fix.patch
-bonding-zerodiv-fix.patch
-readdir-usercopy-check.patch
-hugetlb-unmap_vmas-fix.patch
-ext2-double-free-bug.patch
-load_elf_binary-memleak-fix.patch
-xattr-bug-fixes.patch
-noirqbalance-fix.patch
-show_interrupts-locking-fix.patch
-show_interrupts-fixes.patch
-eepro100-lockup-fix.patch
-remove-kernel_flag.patch
-kernel-flag-fix.patch
-larger-proc-interrupts-buffer.patch

 Merged

+sysfs_remove_dir-dcache_lock.patch

 Missing spin_unlock()

+nfs-del_timer-race-fix.patch

 Fix SMP race in NFS

+serial-warning-fix.patch

 Fix a warning

+resurrect-kernel_flag.patch

 Put kernel_flag back.  It is needed by

	!CONFIG_SMP && CONFIG_PREEMPT && CONFIG_DEBUG_SPINLOCK

+eepro100-warning-fix.patch

 Fix a warning

+as-thinktime.patch
+as-div-by-zero-fix.patch
+as-history-track-reads-only.patch

 Anticipatory scheduler work

+register-tty_devclass.patch

 tty/sysfs fix




All 67 patches

linus.patch
  Latest from Linus

sysfs_remove_dir-dcache_lock.patch
  missing spin_unlock() in sysfs_remove_dir()

nfs-del_timer-race-fix.patch
  rpc_delete_timer race fix

serial-warning-fix.patch
  Subject: [PATCH] remove compile warning from serial console initcall

resurrect-kernel_flag.patch
  revert the "remove kernel_flag" patch

eepro100-warning-fix.patch
  fix a warning in eepro100.c

mm.patch
  add -mmN to EXTRAVERSION

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-64-bit-exec-fix.patch
  Subject: 64bit exec

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

sym-do-160.patch
  make the SYM driver do 160 MB/sec

kgdb.patch

nfsd-disable-softirq.patch
  Fix race in svcsock.c in 2.5.61

report-lost-ticks.patch
  make lost-tick detection more informative

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

atm_dev_sem.patch
  convert atm_dev_lock from spinlock to semaphore

as-iosched.patch
  anticipatory I/O scheduler

as-random-fixes.patch
  Subject: [PATCH] important fixes

as-comment-fix.patch
  AS: comment fix

as-naming-comments-BUG.patch
  AS: fix up naming, comments, add more BUGs

as-unnecessary-test.patch

as-atomicity-fix.patch

as-state-tracking-and-debug.patch
  AS: state tracking fix and debug additions

as-state-tracking-fix.patch
  AS: state tracking fix

as-nr_dispatched-atomic-fix.patch

as-thinktime.patch
  AS: thinktime tracking

as-div-by-zero-fix.patch

as-history-track-reads-only.patch
  AS: only track reads in per-process history

cfq-2.patch
  CFQ scheduler, #2

smalldevfs.patch
  smalldevfs

objrmap-2.5.62-5.patch
  object-based rmap

objrmap-X-fix.patch
  objrmap fix for X

objrmap-nr_mapped-fix.patch
  objrmap: fix /proc/meminfo:Mapped

objrmap-mapped-mem-fix-2.patch
  fix objrmap mapped mem accounting again

objrmap-atomic_t-fix.patch
  Make objrmap mapcount non-atomic

scheduler-tunables.patch
  scheduler tunables

scheduler-tunables-fix.patch
  scheduler tunables fix

show_task-free-stack-fix.patch
  show_task() fix and cleanup

reiserfs-fix-memleaks.patch
  ReiserFS: fix memleaks on journal opening failures

yellowfin-set_bit-fix.patch
  yellowfin driver set_bit fix

remap-file-pages-2.5.63-a1.patch
  Subject: [patch] remap-file-pages-2.5.63-A1

pte_file-always.patch
  enable file-offset-in-pte's for all mappings

hugh-nonlinear-fixes.patch
  Fix nonlinear oddities

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

update_atime-ng.patch
  inode a/c/mtime modification speedup

one-sec-times.patch
  Implement a/c/time speedup in ext2 & ext3

gcc3-inline-fix.patch
  work around gcc-3.x inlining bugs

task_prio-fix.patch
  simple task_prio() fix

register-tty_devclass.patch
  Register tty_devclass before use



