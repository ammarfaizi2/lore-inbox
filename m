Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262008AbTCHCkl>; Fri, 7 Mar 2003 21:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262009AbTCHCkl>; Fri, 7 Mar 2003 21:40:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:39076 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262008AbTCHCke>;
	Fri, 7 Mar 2003 21:40:34 -0500
Date: Fri, 7 Mar 2003 18:51:16 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.64-mm2
Message-Id: <20030307185116.0c53e442.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Mar 2003 02:51:03.0744 (UTC) FILETIME=[8F19CC00:01C2E51D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm2/

Just lots of little stuff here.  Mainly a resync with various people.

Note: there is a change to the console handling code in Linus's tree which
means that if you have both VT console and serial console enabled in kernel
config, the serial console now wins.  Nothing comes out on the screen during
bootup.  It used to be the case that the VT console was initialised first.

If this happens you will need to specify the console device on the boot
command line.

We appear to have at least three use-after-free bugs.  One is fixed here, and
there are extra debugging goodies which may help us find the others.  Please
enable memory debugging and keep an eye open.



Changes since 2.5.64-mm1:


 linus.patch

 Latest -bk

-balance_irq-cleanup.patch
-balance_irq-fix.patch
-rpc_rmdir-fix.patch
-aic-makefile-fix.patch
-flock-fix.patch
-rtc-locking-fix.patch
-sk98-build-fix.patch
-cciss-pci-hotplug-fix.patch
-export-pfn_to_nid.patch
-move-CONFIG_SWAP.patch
-random-stack-use.patch
-inode-pruning-fix.patch
-remove-__pgd_offset.patch
-remove-__pmd_offset.patch
-remove-__pte_offset.patch
-htree-lock_kernel-fix.patch
-pci-1.patch
-pci-2.patch
-pci-3.patch
-pci-4.patch
-pci-5.patch
-elf_core_dump-stack-size-reduction.patch
-uninline-binfmt_elf.patch

 Merged

+register_blkdev-cleanups.patch

 Toward 32-bit dev-t.

-shared-irq-warning.patch

 Dropped.  Need to do something different here.

+as-state-tracking-and-debug.patch
+as-state-tracking-fix.patch
+as-nr_dispatched-atomic-fix.patch

 Anticipatory scheduler work.

-sched-b3.patch

 Sort-of merged.

+vm_area-use-after-free-fix.patch

 Fix the use-after-free in the vma slab cache.

+slab-caller-tracking.patch

 Record the calling function inside slab objects, and report that on
 use-after-free erfors.

+slab-caller-tracking-symbolic.patch

 Teach the above about kallsyms.

+CONFIG_SWAP-fix.patch

 Fix up CONFIG_SWAP menus

+hugh-nonlinear-fixes.patch

 Try to make nonlinear VMAs and objrmap play better together.

+readdir-usercopy-check.patch

 Add some missing copy_to_user() checks.

+gcc3-inline-fix.patch

 Apply a club to gcc-3.x's head.

+pirq_enable_irq-warning-fix.patch

 Fix a compiler warning

+hugetlb-unmap_vmas-fix.patch

 Fix an oops with hugetlb pages, CONFIG_SMP && CONFIG_PREEMPT

+ext2-double-free-bug.patch

 Fix an error-path double-free.

+load_elf_binary-memleak-fix.patch

 Fix an error-path memory leak

+xattr-bug-fixes.patch

 Extended Attribute fixes

+noirqbalance-fix.patch

 Make the noirqalance boot option work

+show_interrupts-locking-fix.patch

 Put some locking into the /proc/interrupts handler code.

+eepro100-lockup-fix.patch

 Fix an eepro100 deadlock

+task_prio-fix.patch

 Scheduler fix for SCHED_RR tasks

+remove-kernel_flag.patch

 Eliminate lock_kernel()



All 79 patches:

linus.patch
  Latest from Linus

register_blkdev-cleanups.patch
  register_blkdev cleanups

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

limit-write-latency.patch
  fix possible latency in balance_dirty_pages()

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

nfs-sendfile.patch
  Implement sendfile() for NFS

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

readahead-shrink-to-zero.patch
  Allow VFS readahead to fall to zero

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

per-cpu-disk-stats.patch
  Make diskstats per-cpu using kmalloc_percpu

scheduler-tunables.patch
  scheduler tunables

show_task-free-stack-fix.patch
  show_task() fix and cleanup

vm_area-use-after-free-fix.patch
  Fix vm_area_struct slab corruption

use-after-free-check.patch
  slab use-after-free detector

slab-caller-tracking.patch
  slab debug: track caller program counter

slab-caller-tracking-symbolic.patch
  slab debug: symbolic output in caller tracking

reiserfs-fix-memleaks.patch
  ReiserFS: fix memleaks on journal opening failures

copy_page_range-invalid-page-fix.patch
  Fix copy_page_range()'s handling of invalid pages

yellowfin-set_bit-fix.patch
  yellowfin driver set_bit fix

CONFIG_SWAP-fix.patch
  move CONFIG_SWAP around

remap-file-pages-2.5.63-a1.patch
  Subject: [patch] remap-file-pages-2.5.63-A1

pte_file-always.patch
  enable file-offset-in-pte's for all mappings

hugh-nonlinear-fixes.patch
  Fix nonlinear oddities

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

bonding-zerodiv-fix.patch
  Subject: [PATCH][bonding] division by zero bug

update_atime-ng.patch
  inode a/c/mtime modification speedup

one-sec-times.patch
  Implement a/c/time speedup in ext2 & ext3

readdir-usercopy-check.patch
  usercopy checks in old_readdir()

gcc3-inline-fix.patch
  work around gcc-3.x inlining bugs

pirq_enable_irq-warning-fix.patch
  fix return value in arch/i386/pci/irq.c

hugetlb-unmap_vmas-fix.patch
  hugetlb unmap_vmas() SMP && PREEMPT fix

ext2-double-free-bug.patch
  ext2: fix error-path double-free

load_elf_binary-memleak-fix.patch
  fix memory leak in load_elf_binary()

xattr-bug-fixes.patch
  Extended attribute sharing and debug macro typo fixes

noirqbalance-fix.patch
  Fix noirqbalance

show_interrupts-locking-fix.patch
  protect 'action' in show_interrupts

eepro100-lockup-fix.patch
  fix SMP lockup in eepro100 with ethtool on unused interface

task_prio-fix.patch
  simple task_prio() fix

remove-kernel_flag.patch
  no need for kernel_flag on UP



