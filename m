Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbTCZJ1E>; Wed, 26 Mar 2003 04:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261525AbTCZJ1E>; Wed, 26 Mar 2003 04:27:04 -0500
Received: from [12.47.58.51] ([12.47.58.51]:49372 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S261520AbTCZJ05>;
	Wed, 26 Mar 2003 04:26:57 -0500
Date: Wed, 26 Mar 2003 01:38:39 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.66-mm1
Message-Id: <20030326013839.0c470ebb.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Mar 2003 09:38:01.0243 (UTC) FILETIME=[647FF6B0:01C2F37B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.66/2.5.66-mm1/


. The anticipatory scheduler is in wrapup mode now.  It is pretty much in
  its final form.

. The ext2 locking changes have been significantly redone.

  The per-blockgroup data structures had to go.  For a 4TB filesystem we
  cannot even kmalloc that many pointers, let alone data structures.

  So the per-blockgroup spinlocking has been replaced with hashed
  spinlocking and the per-blockgroup accounting has been removed.  A "per-cpu
  counter" thing has been invented to amortise the locking cost of the
  filesystem-wide counters.

. ext3 is now using spinlocking in its block allocator rather than a
  filesystem-wide semaphore.

  It is stability-tested but I have not yet performance tested this
  closely.  It does appear to have improved the context switch problem (and
  the file fragmentation problem which the context switch problem causes). 
  But there's a way to go here.




Changes since 2.5.65-mm4:


 linus.patch

 Latest -bk

-nfsd-32-bit-dev_t-fixes.patch
-i2c-fix.patch

 Merged

+kgdb-ga.patch

 George Anzinger's gdb stub

+ppa-null-pointer-fix.patch

 Might fix the parport scsi driver

+initcall-debug.patch

 Debugging support for misbehaving initcalls

+posix-timers-64-bit-fix.patch

 Timer fix for 64-bit machines

+slab-off-by-one-fix.patch

 Slab was using too much memory.

+install_page-flush_cache_page.patch

 Cache coherency bug in remap_file_pages()

+as-minor-tweaks.patch
+as-remove-stats.patch

 Anticipaory scheduler tuning and clanups.

+posix-timer-double-expiration-fix.patch

 Posix timers were sending timer expiry info twice.

+hugh-01-no-SWAP_ERROR.patch
+hugh-02-try_to_unmap-CONFIG_SWAP.patch
+hugh-03-add_to_swap_cache.patch
+hugh-04-page_convert_anon-ENOMEM.patch
+hugh-05-page_convert_anon-unlocking.patch
+hugh-06-wrap-below-vm_start.patch
+hugh-07-objrmap-page_table_lock.patch
+hugh-08-rmap-comments.patch
+hugh-09-tmpfs-truncation.patch
+hugh-10-tmpfs-atomics.patch
+hugh-11-fix-unuse_pmd-fixme.patch
+hugh-12-vm_enough_memory-double-counts.patch

 Various vm/mm fixes and cleanups

+ext3-max-file-size-fix.patch

 Allow ext3 to create files larger than 32GB (should be nearly 2TB)

-ext2-no-lock_super.patch
-ext2-ialloc-no-lock_super.patch
+ext2-no-lock_super-ng.patch
+ext2-ialloc-no-lock_super-ng.patch

 Rework the ext2 block and inode allocator locking changes.

+dev_t-remove-B_FREE.patch

 Remove B_FREE.

+tty_io-cleanup.patch
+page_to_pfn-in-blk_queue_bounce.patch
+init_inode_once-bloat-fix.patch

 Cleanups and fixlets

+compound-page-warning-fix.patch

 Fix a warning

+slab-cache-sizes-cleanup.patch

 Unduplicate some tables in slab.

+stat_t-larger-dev_t.patch

 Large dev_t fix.

+acpi-build-fix.patch

 make acpi compile.

+sync_blockdev-on-final-close.patch

 Only write out blockdev mappings on the final close.

+ext3-concurrent-block-inode-allocation.patch
+ext3-concurrent-block-allocation-fix-1.patch

 Use spinlocking in the ext3 block allocator, not as fs-wide semaphore.



All 104 patches:

linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

ppa-null-pointer-fix.patch

initcall-debug.patch
  initcall debugging support

posix-timers-64-bit-fix.patch
  POSIX timers interface long/int cleanup

slab-off-by-one-fix.patch
  slab: fix off-by-one in size calculation

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

sym-do-160.patch
  make the SYM driver do 160 MB/sec

install_page-flush_cache_page.patch
  add flush_cache_page() to install_page()

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

cfq-2.patch
  CFQ scheduler, #2

unplug-use-kblockd.patch
  Use kblockd for running request queues

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

objrmap-2.5.62-5.patch
  object-based rmap

sched-2.5.64-D3.patch
  sched-2.5.64-D3, more interactivity changes

scheduler-tunables.patch
  scheduler tunables

show_task-free-stack-fix.patch
  show_task() fix and cleanup

yellowfin-set_bit-fix.patch
  yellowfin driver set_bit fix

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

task_prio-fix.patch
  simple task_prio() fix

slab_store_user-large-objects.patch
  slab debug: perform redzoning against larger objects

pcmcia-2.patch

pcmcia-3b.patch

pcmcia-3.patch

pcmcia-4.patch

pcmcia-5.patch

pcmcia-6.patch

pcmcia-7b.patch

pcmcia-7.patch

pcmcia-8.patch

pcmcia-9.patch

pcmcia-10.patch

htree-nfs-fix-2.patch
  htree nfs fix

posix-timer-double-expiration-fix.patch
  posix timers: fix double-reporting of timer expiration

hugh-01-no-SWAP_ERROR.patch
  swap 01/13 no SWAP_ERROR

hugh-02-try_to_unmap-CONFIG_SWAP.patch
  Subject: [PATCH] swap 02/13 !CONFIG_SWAP try_to_unmap

hugh-03-add_to_swap_cache.patch
  swap 03/13 add_to_swap_cache

hugh-04-page_convert_anon-ENOMEM.patch
  swap 04/13 page_convert_anon -ENOMEM

hugh-05-page_convert_anon-unlocking.patch
  swap 05/13 page_convert_anon unlocking

hugh-06-wrap-below-vm_start.patch
  swap 06/13 wrap below vm_start

hugh-07-objrmap-page_table_lock.patch
  swap 07/13 objrmap page_table_lock

hugh-08-rmap-comments.patch
  swap 08/13 rmap comments

hugh-09-tmpfs-truncation.patch
  swap 09/13 tmpfs truncation

hugh-10-tmpfs-atomics.patch
  swap 10/13 tmpfs atomics

hugh-11-fix-unuse_pmd-fixme.patch
  swap 11/13 fix unuse_pmd fixme

hugh-12-vm_enough_memory-double-counts.patch
  swap 12/13 vm_enough_memory double counts

ext3-max-file-size-fix.patch
  ext3: fix max file size

ext2-no-lock_super-ng.patch

ext2-ialloc-no-lock_super-ng.patch

linear-oops-fix-1.patch
  md/linear oops fix

dev_t-32-bit.patch
  [for playing only] change type of dev_t

dev_t-remove-B_FREE.patch
  dev_t: eliminate B_FREE

dev_t-drm-warnings.patch
  dev_t: fix drm printk warnings

sg-dev_t-fix.patch
  32-bit dev_t fix for sg

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

x86-clock-override-option.patch
  x86 clock override boot option

tty_io-cleanup.patch
  tty_io cleanup

page_to_pfn-in-blk_queue_bounce.patch
  Subject: use page_to_pfn() in __blk_queue_bounce()

init_inode_once-bloat-fix.patch
  Subject: init_inode_once() wants sizeof(struct hlist_head)

conntrack-use-after-free-fix.patch
  fix use-after-free in ip_conntrack

VM_DONTEXPAND-fix.patch
  honour VM_DONTEXPAND in vma merging

compound-page-warning-fix.patch
  Fix 64bit warnings in mm/page_alloc.c

cdevname-irq-safety-fix.patch
  make cdevname() callable from interrupts

register_chrdev_region-leak-fix.patch
  register_chrdev_region() leak and race fix

slab-cache-sizes-cleanup.patch
  slab: cache sizes cleanup

stat_t-larger-dev_t.patch
  struct stat - support larger dev_t

acpi-build-fix.patch
  ACPI build fix

sync_blockdev-on-final-close.patch
  sync blockdevs on the final close only

ext3_mark_inode_dirty-speedup.patch
  ext3_mark_inode_dirty() speedup

ext3_mark_inode_dirty-less-calls.patch
  ext3_commit_write speedup

ext3-handle-cache.patch
  ext3: create a slab cache for transaction handles

ext3-no-bkl.patch

journal_dirty_metadata-speedup.patch

journal_get_write_access-speedup.patch

ext3-concurrent-block-inode-allocation.patch
  Subject: [PATCH] concurrent block/inode allocation for EXT3

ext3-concurrent-block-allocation-fix-1.patch



