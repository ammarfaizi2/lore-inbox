Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbTDRIdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 04:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbTDRIdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 04:33:21 -0400
Received: from [12.47.58.203] ([12.47.58.203]:39456 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262961AbTDRIdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 04:33:03 -0400
Date: Fri, 18 Apr 2003 01:45:36 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.67-mm4
Message-Id: <20030418014536.79d16076.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Apr 2003 08:44:52.0893 (UTC) FILETIME=[C7989CD0:01C30586]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm4/

. A bunch of anticipatory scheduler patches.

  For the first time ever, AS is working well with both IDE and SCSI
  under all the usual tests.

  It works just fine on SCSI with zero TCQ tags, and with four TCQ tags. 
  At eight tags, read-vs-write performace is starting to measurably drop off.
  At 32 tags it is about 2000x slower than at zero or four tags.

  My recommendation, as always, is to disable SCSI TCQ completely.  If you
  really must, set it to four tags.

. Now using 64-bit dev_t with a 32:32 split.  There's a new `mknod64()'
  syscall for creating these device nodes, and support for this in ext2 and
  ext3.  There is no corresponding userspace mknod(1) as far as I know.

. There is a fancy memory debugging patch from Manfred here.  On ia32 it
  will unmap pages from kernel virtual address space when they are freed.  It
  will also unmap slab objects which are >= 4 kilobytes in size.  This is to
  force an oops if anyone touches freed-up memory.

  This might be buggy on SMP, due to missing TLB invalidations (put them
  in, and they will deadlock).  Or it might not be buggy, due to the
  behaviour of the special vmalloc pagefault handler.

  Anyway, it's cool, and should work OK on uniprocessor at least.

. Lots of new random fixes.   This is a 13 megabyte diff...




Changes since 2.5.67-mm3:


 linus.patch

 Latest BK snapshot

-devclass-oops-workaround.patch
-ipip_err-compile-fix.patch
-p4-oprofile-fix.patch
-flush_workqueue-hang-fix.patch
-tty-shutdown-race-fix.patch
-genrtc-jiffies-fix.patch
-export-kernel_fpu_begin.patch
-posix-timer-hang-fix-2.patch
-vsyscall-unwinding.patch
-mce-workqueue-startup-fix.patch
-1394-compile-fix.patch
-nfs-resource-management.patch
-usb-disconnect-crash-fix.patch
-fbdev.patch

 Merged

-kgdb-ga-warning-fix.patch
-kgdb-ga-up-warning-fix.patch

 Folded into kgdb-ga.patch

+kobj_lock-fix.patch

 Fix kobject locking bug.

+mach_countup-fix.patch

 Fix cpu_khx measurement.

+dentry_stat-accounting-fix.patch

 Fix dentry accounting

+DCACHE_REFERENCED-fixes.patch

 Fix DCACHE_REFERENCED handling

+posix_timers-CLOCK_MONOTONIC-fix.patch

 Timekeeping accuracy fix

+jiffies_to_timespec-fix.patch

 Timekeeping accuracy fix.

+misc.patch

 Fixlets

+SAK-raw-mode-fix.patch

 Make SAK work when the keyboard is in raw mode

-as-disable-thinktime.patch

 This was a workaround for a now-fixed performance problem.

+cfq-infrastructure.patch

 Non-CFQ related infrastructure split out of the CFQ I/O scheduler patch.

+elevator-completion-api.patch

 elevator callback from request completion.

+as-use-completion.patch

 Use the above in the anticipatory scheduler.

+cfq-2.patch

 Just CFQ.

+unmap-page-debugging.patch
+unmap-page-debugging-fixes.patch
+global_flush_tlb-irqs-check.patch
+unmap-page-debugging-fixes-2.patch

 Debug code to unmap freed pages from kernel virtual address space.

+pcmcia-deadlock-fix.patch

 Fix the PCMCIA startup problem.

+move-__set_page_dirty-buffers.patch
+buffers-cleanup.patch

 Cleanups.

+follow_hugetlb_page-fix.patch
+hugetlb-overflow-fix.patch

 Hugetlb fixes.

+mach64-build-fix.patch

 fbdev build fix.

+sync-all-quotas.patch

 Global quota sync operation.

+do_timer_overflow-locking-fix.patch

 ia32 timer fixes.

+lost-tick-fix.patch

 More ia32 timer fixes.

+aio-mmap-fix.patch

 AIO fix.

+generic-bitops-update.patch

 Bring the skeleton bitop functions up to date.

+overcommit-stop-swapoff.patch
+interruptible-swapoff.patch
+oomkill-swapoff.patch

 sys_swapoff() fixes.

+dac960-bounce-avoidance.patch

 Avoid memory copies in dac960.

+NOMMU-merge-fixes.patch

 !CONFIG_MMU build fixes

+vmap-extensions.patch

 Generalise vmap() a bit, for ia64.

+select-speedup.patch

 Speed up sys_select()

+dont-shrink-slab-for-highmem.patch

 Don't shrink the slab caches in response to ZONE_HIGHMEM shortages.

+htree-leak-fix.patch

 Fix ext3/htree memory leak.

-dev_t-32-bit.patch

 Dropped - now doing 64-bit dev_t.

-dev_t-remove-B_FREE.patch
-sg-dev_t-fix.patch
-xfs-dev_t-warning-fix.patch

 Merged into 64-bit-dev_t-kdev_t.patch

+ia32-mknod64.patch

 sys_mknod64() for ia32.

+dm-larger-dev_t-fix.patch
+ext2-64-bit-special-inodes.patch
+ext3-64-bit-special-inodes.patch
+rdev-for-samba.patch

 Larger dev_t preparatory fixes.

+64-bit-dev_t-kdev_t.patch

 64-bit dev_t.

-lockmeter-fixes.patch

 Folded into lockmeter.patch

+ext3-orlov-approx-counter-fix.patch

 ext3 directory allocator fix for the ext3 scalability patches which are in
 -mm.




All 114 patches


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kobj_lock-fix.patch

mach_countup-fix.patch

ppa-null-pointer-fix.patch

dmfe-kfree_skb-fix.patch
  dmfe: don't free skb with local interrupts disabled

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

ppc64-update.patch
  ppc64 update

ppc64-update-fixes.patch

sym-do-160.patch
  make the SYM driver do 160 MB/sec

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

buffer-debug.patch
  buffer.c debugging

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

reiserfs_file_write-5.patch

sched_idle-typo-fix.patch
  fix sched_idle typo

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

dentry_stat-accounting-fix.patch
  dentry_stat accounting fix

DCACHE_REFERENCED-fixes.patch
  Fix and clean up DCACHE_REFERENCED usage

posix_timers-CLOCK_MONOTONIC-fix.patch
  Fix POSIX timers to give CLOCK_MONOTONIC full resolution and tie it to xtime instead of jiffies

jiffies_to_timespec-fix.patch
  Fix jiffies_to_time[spec | val] and converse to use actual jiffies increment rather than 1/HZ

tasklist_lock-dcache_lock-inversion-fix.patch
  Fix deadlock between tasklist_lock and dcache_lock

misc.patch
  misc fixes

setserial-fix.patch
  Subject: [PATCH 2.5] Minor fix for driver/serial/core.c

SAK-raw-mode-fix.patch
  keyboard.c Fix SAK in raw mode

kblockd.patch
  Create `kblockd' workqueue

as-iosched.patch
  anticipatory I/O scheduler

as-np-reads-1.patch
  AS: read-vs-read fixes

as-np-reads-2.patch
  AS: more read-vs-read fixes

as-predict-data-direction.patch
  as: predict direction of next IO

as-remove-frontmerge.patch
  AS: remove frontmerge tunable

as-misc-cleanups.patch
  AS: misc cleanups

as-minor-tweaks.patch
  AS: tuning and tweaks

as-remove-stats.patch
  AS: remove statistics

as-locking-fix.patch
  AS: Fix minor race

as-use-queue_empty.patch
  AS: Use the queue_empty API

cfq-infrastructure.patch

elevator-completion-api.patch
  elevator completion API

as-use-completion.patch
  AS use completion notifier

unplug-use-kblockd.patch
  Use kblockd for running request queues

cfq-2.patch
  CFQ scheduler, #2

unmap-page-debugging.patch
  unmap unused pages for debugging

unmap-page-debugging-fixes.patch

global_flush_tlb-irqs-check.patch

unmap-page-debugging-fixes-2.patch

pcmcia-deadlock-fix.patch

move-__set_page_dirty-buffers.patch
  Move __set_page_dirty_buffers to fs/buffer.c

buffers-cleanup.patch
  Clean up various buffer-head dependencies

follow_hugetlb_page-fix.patch
  follow_hugetlb_page fix

hugetlb-overflow-fix.patch
  hugetlb math overflow fix

mach64-build-fix.patch
  ATI Mach64 build fix

sync-all-quotas.patch
  quotactl(): sync all quotas

do_timer_overflow-locking-fix.patch
  Locking fix in do_timer_overflow()

lost-tick-fix.patch
  detect_lost_tick locking fixes

aio-mmap-fix.patch
  AIO mmap fix

objrmap.patch
  object-based rmap

objrmap-sort-vma-list.patch
  objrmap: optimise per-mapping vma searches

objrmap-vma-sorting-fix.patch
  fix obj vma sorting

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

sched-2.5.64-D3.patch
  sched-2.5.64-D3, more interactivity changes

scheduler-tunables.patch
  scheduler tunables

show_task-free-stack-fix.patch
  show_task() fix and cleanup

yellowfin-set_bit-fix.patch
  yellowfin driver set_bit fix

generic-bitops-update.patch
  include/asm-generic/bitops.h {set,clear}_bit return  void

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

task_prio-fix.patch
  simple task_prio() fix

i8042-share-irqs.patch
  allow i8042 interrupt sharing

gfp_repeat.patch
  implement __GFP_REPEAT

alloc_buffer_head-take-gfp.patch
  make alloc_buffer_head take gfp_flags

pte_alloc_one-use-gfp_repeat.patch
  use __GFP_REPEAT in pte_alloc_one()

pmd_alloc_one-use-gfp_repeat.patch
  use __GFP_REPEAT in pmd_alloc_one()

overcommit-stop-swapoff.patch
  Disallow swapoff if there is insufficient memory

interruptible-swapoff.patch
  Permit interruption of swapoff

oomkill-swapoff.patch
  oom-kill: preferentially kill swapoff

dac960-bounce-avoidance.patch
  DAC960: add call to blk_queue_bounce_limit

dynamic-hd_struct-allocation.patch
  Allocate hd_structs dynamically

dynamic-hd_struct-devfs-fix.patch
  Fix dynamic hd_struct allocation for devfs

NOMMU-merge-fixes.patch
  fix CONFIG_NOMMU mismerges

vmap-extensions.patch
  Extend map_vm_area()/get_vm_area()

select-speedup.patch
  Subject: Re: IA64 changes to fs/select.c

slab_store_user-large-objects.patch
  slab debug: perform redzoning against larger objects

dont-shrink-slab-for-highmem.patch
  don't shrink slab for highmem allocations

htree-nfs-fix-2.patch
  htree nfs fix

htree-leak-fix.patch
  ext3: htree memory leak fix

put_task_struct-debug.patch

ia32-mknod64.patch
  mknod64 for ia32

dm-larger-dev_t-fix.patch
  Subject: Re: 2.5.67-mm2

ext2-64-bit-special-inodes.patch
  ext2: support for 64-bit device nodes

ext3-64-bit-special-inodes.patch
  ext3: support for 64-bit device nodes

rdev-for-samba.patch
  From: Andries.Brouwer@cwi.nl
  Subject: [PATCH] rdev for samba

32bit-dev_t-nfs-export-fix.patch
  Fix nfsd exports with big dev_t

64-bit-dev_t-kdev_t.patch
  64-bit dev_t and kdev_t

aggregated-disk-stats.patch
  Aggregated disk statistics

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

ext3-no-bkl.patch

journal_dirty_metadata-speedup.patch

journal_get_write_access-speedup.patch

ext3-concurrent-block-inode-allocation.patch
  Subject: [PATCH] concurrent block/inode allocation for EXT3

ext3-orlov-approx-counter-fix.patch
  Fix orlov allocator boundary case

ext3-concurrent-block-allocation-fix-1.patch

ext3-concurrent-block-allocation-hashed.patch
  Subject: Re: [PATCH] concurrent block/inode allocation for EXT3



