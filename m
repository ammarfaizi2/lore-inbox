Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268272AbTCCB7f>; Sun, 2 Mar 2003 20:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268276AbTCCB7f>; Sun, 2 Mar 2003 20:59:35 -0500
Received: from packet.digeo.com ([12.110.80.53]:29916 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268272AbTCCB71>;
	Sun, 2 Mar 2003 20:59:27 -0500
Date: Sun, 2 Mar 2003 18:09:59 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.63-mm2
Message-Id: <20030302180959.3c9c437a.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2003 02:09:46.0579 (UTC) FILETIME=[F687AA30:01C2E129]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.63/2.5.63-mm2/

Mainly bugfixes, and solidification of the anticipatory scheduler.

The anticipatory scheduler has become significantly better - I believe that
all of the little regressions which had previously been identified are fixed
up now, with the exception of the OLTP-style database workload which is still
10% slower.  Write-versus-write latency problems have been fixed, which is
important for ext3 behaviour during heavy writeback.

All the infrastructure for per-task IO pattern tracking is in now place so we
should be able to fix the OLTP slowdown without any requirement for manual
tuning.

We still have not located Ed Tomlinson's lost IO request.  It's odd.



If you see this come out:

Slab corruption: start=cde0414c, expend=cde0418b, problemat=cde04162
Data: **********************7B ****************************************A5 
Next: 71 F0 2C .A5 C2 0F 17 84 10 B3 CE 00 80 04 08 00 A0 05 08 8C 1C 90 CE 25 00 00 00 75 18 00 00 
slab error in check_poison_obj(): cache `vm_area_struct': object was modified after freeing
Call Trace:
 [<c013aabd>] __slab_error+0x21/0x28
 [<c013acac>] check_poison_obj+0x104/0x110
 [<c013c080>] kmem_cache_alloc+0x90/0x11c
 [<c01449c0>] split_vma+0x28/0xcc
 [<c0144b35>] do_munmap+0xd1/0x178
 [<c0144c21>] sys_munmap+0x45/0x64
 [<c0109143>] syscall_call+0x7/0xb

please do not report it.  We know.

If this message comes out for any cache apart from vm_area_struct then please
_do_ report it.




Changes since 2.5.63-mm1:


-devfs-fix.patch

 Dropped for now - conflicts with changes in Linus's tree

-nfs-unstable-pages.patch

 Dropped for a while - it could impact testing of limit-write-latency.patch

-as-comments-and-tweaks.patch
-as-hz-1000-fix.patch
-as-tidy-up-rename.patch
-anticipation_is_killing_me.patch
-as-update-1.patch
-as-break-anticipation-on-write.patch
-as-break-if-readahead.patch
-as-fix-hughs-problem.patch
-as-cleanup.patch
-as-start-stop-anticipation-helpers.patch
-as-cleanup-2.patch
-as-cleanup-3.patch
-as-cleanup-3-write-latency-fix.patch
-as-handle-exitted-tasks.patch
-as-handle-exitted-tasks-fix.patch
-as-no-plugging-and-cleanups.patch
-as-remove-debug.patch
-as-track-queued-reads.patch
-as-accounting-fix.patch
-as-nr_reads-fix.patch
-as-tuning.patch
-as-disable-nr_reads.patch

 Folded into anticipatory-scheduling.patch

+as-random-fixes.patch
+as-comment-fix.patch

 More anticipatory scheduling work

+objrmap-nr_mapped-fix.patch
+objrmap-mapped-mem-fix-2.patch

 Fix up the mapped page accounting

+sched-b3.patch

 Latest HT-aware CPU scheduler patch

+cciss-startup-problem-fix.patch
+cciss-retry-bus-reset.patch
+cciss-add-cmd-type.patch
+cciss-getluninfo-ioctl.patch
+cciss-passthrough-ioctl.patch

 cciss update

+show_task-free-stack-fix.patch

 Fix some nonsense in the sysrq-t output.  Probably we should just remove
 the non-functional "free stack" accounting.

+use-after-free-check.patch

 Full use-after-free checking in slab

+reiserfs-fix-memleaks.patch

 Reiserfs fixes

+copy_page_range-invalid-page-fix.patch

 Fix a crash when an app forks while holding a mmap of /dev/mem.  This is
 incomplete.




All 77 patches:

linus.patch
  Latest from Linus

separate.patch

mm.patch
  add -mmN to EXTRAVERSION

rpc_rmdir-fix.patch
  Fix nfs oops during mount

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-e100-fix.patch
  fix e100 for big-endian machines

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

deadline-dispatching-fix.patch
  deadline IO scheduler dispatching fix

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

aic-makefile-fix.patch
  aicasm Makefile fix

loop-hack.patch
  loop: Fix OOM and oops

atm_dev_sem.patch
  convert atm_dev_lock from spinlock to semaphore

flock-fix.patch
  flock fixes for 2.5.62

sysfs-dget-fix-2.patch

irq-sharing-fix.patch
  fix irq sharing and SA_INTERRUPT on x86

as-iosched.patch
  anticipatory I/O scheduler

as-random-fixes.patch
  Subject: [PATCH] important fixes

as-comment-fix.patch
  AS: comment fix

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

oprofile-up-fix.patch
  fix oprofile on UP (lockless sync)

update_atime-speedup.patch
  speed up update_atime()

ext2-update_atime_speedup.patch
  Use one_sec_update_atime in ext2

ext3-update_atime_speedup.patch
  Use one_sec_update_atime in ext2

UPDATE_ATIME-to-update_atime.patch
  Rename UPDATE_ATIME to update_atime

per-cpu-disk-stats.patch
  Make diskstats per-cpu using kmalloc_percpu

presto_get_sb-fix.patch
  fix presto_get_sb() return value and oops.

on_each_cpu.patch
  fix preempt-issues with smp_call_function()

on_each_cpu-ldt-cleanup.patch

notsc-panic.patch
  Don't panic if TSC is enabled and notsc is used

alloc_pages_cleanup.patch
  clean up redundant code for alloc_pages

ext2-handle-htree-flag.patch
  ext2: clear ext3 htree flag on directories

sched-b3.patch
  HT scheduler, sched-2.5.63-B3

mpparse-typo-fix.patch
  fix typo in arch/i386/kernel/mpparse.c in printk

i386-no-swap-fix.patch
  allow CONFIG_SWAP=n for i386

remove-hugetlb_key.patch
  remove dead hugetlb_key forward decl

hugetlbpage-doc-update.patch
  hugetlbpage documentation update

hugetlb-valid-page-ranges.patch
  hugetlb: fix MAP_FIXED handling

cciss-startup-problem-fix.patch
  cciss: fix unlikely startup problem

cciss-retry-bus-reset.patch
  cciss: retry bus resets

cciss-add-cmd-type.patch
  cciss: add cmd_type to sendcmd parameters

cciss-getluninfo-ioctl.patch
  cciss: add CCISS_GETLUNINFO ioctl

cciss-passthrough-ioctl.patch
  cciss: add passthrough ioctl

show_task-free-stack-fix.patch
  show_task() fix and cleanup

use-after-free-check.patch
  slab use-after-free detector

reiserfs-fix-memleaks.patch
  ReiserFS: fix memleaks on journal opening failures

copy_page_range-invalid-page-fix.patch
  Fix copy_page_range()'s handling of invalid pages



