Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262134AbTDAHuH>; Tue, 1 Apr 2003 02:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262174AbTDAHuG>; Tue, 1 Apr 2003 02:50:06 -0500
Received: from [12.47.58.55] ([12.47.58.55]:24573 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S262134AbTDAHtx>;
	Tue, 1 Apr 2003 02:49:53 -0500
Date: Tue, 1 Apr 2003 00:01:27 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.66-mm2
Message-Id: <20030401000127.5acba4bc.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Apr 2003 08:01:11.0104 (UTC) FILETIME=[DBDD9C00:01C2F824]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.66/2.5.66-mm2/


. Just lots of little fixes, cleanups, late-but-promised minor features,
  etc.

. There is a small patch from Ingo here against the CPU scheduler which we
  hope will fix the new starvation problems which people have been reporting.
  I this is you, please test and report.

. It turns out that a recent change to the anticipatory scheduler
  accidentally made it quite ineffective on SCSI (performance is similar to
  deadline).  The patch which did that has been disabled, but we expect that
  the seeky OLTP loads will suffer until this is fixed up for real.



Changes since 2.5.66-mm1:


 linus.patch

 Latest from Linus

-initcall-debug.patch
-posix-timers-64-bit-fix.patch
-slab-off-by-one-fix.patch
-install_page-flush_cache_page.patch
-ext3-fsync-speedup.patch
-pcmcia-2.patch
-pcmcia-3b.patch
-pcmcia-3.patch
-pcmcia-4.patch
-pcmcia-5.patch
-pcmcia-6.patch
-pcmcia-7b.patch
-pcmcia-7.patch
-pcmcia-8.patch
-pcmcia-9.patch
-pcmcia-10.patch
-posix-timer-double-expiration-fix.patch
-hugh-01-no-SWAP_ERROR.patch
-hugh-02-try_to_unmap-CONFIG_SWAP.patch
-hugh-03-add_to_swap_cache.patch
-hugh-09-tmpfs-truncation.patch
-hugh-10-tmpfs-atomics.patch
-hugh-12-vm_enough_memory-double-counts.patch
-ext3-max-file-size-fix.patch
-linear-oops-fix-1.patch
-dev_t-drm-warnings.patch
-x86-clock-override-option.patch
-tty_io-cleanup.patch
-page_to_pfn-in-blk_queue_bounce.patch
-init_inode_once-bloat-fix.patch
-VM_DONTEXPAND-fix.patch
-compound-page-warning-fix.patch
-cdevname-irq-safety-fix.patch
-register_chrdev_region-leak-fix.patch
-slab-cache-sizes-cleanup.patch
-sync_blockdev-on-final-close.patch

 Merged

+as-queue_notready-cleanup.patch

 Anticipatory scheduler cleanups.

+as-disable-thinktime.patch

 Anticipatory scheduler simply doesn't work on scsi.  Disable the thinktime
 heuristic to make it go again (this will cause slowdowns for OLTP loads).

+cdrom-stack-usage.patch

 Reduced stack usage

+sched-interactivity-backboost-revert.patch

 Revert the CPU scheduler backboost heuristic.

+tmpfs-blk_congestion_wait-fix.patch

 tmpfs fixlet.

+page_convert_anon-locking-fix.patch

 Fix locking for objrmap.

+monotonic-clock-hangcheck.patch

 get_cycles() clock source, used in the hangcheck timer.

+module_load_notification.patch

 Provide notification of module load/unload to other places in the kernel.

+put_task_struct-debug.patch

 Try to find out who is doing put_task_struct() on a freed task_struct.

+remove-kdev_name.patch

 Remove kdevname()

+percpu_counter.patch
+blockgroup_lock.patch

 Broken out from the ext2 speedup patches.

+kill-TIOCTTYGSTRUCT.patch

 Remove the TIOCTTYGSTRUCT ioctl.

+misc.patch

 Misc fixes

+sony-apm-fix.patch

 Fix APM for Sony notebooks.

+init-sections-in-kallsyms.patch

 Make kallsyms aware of __init symbols.

+3c59x-980-support.patch

 Extra PCI IDs for 3c59x

+fadvise-flush-data.patch

 Teach fadvise(FADV_DONTNEED) to gently flush out dirty pages.

+console-scrollback.patch

 Another TIOCLINUX command for scrolling the console down.

+usb-disconnect-crash-fix.patch

 Fix some USB crash (this isn't right)

+devfs-rescan_partitions-fix.patch

 Fix a devfs problem

+umsdos-fixes.patch

 Fixes

+exp_parent-locking-fix.patch

 Fix nfsd locking

+real_lookup-race-fix.patch

 Fix a fixed race differently

+remove-dparent_lock.patch

 Remove the global dparent_lock

+PCI-aliases-fix.patch

 Stuff from Rusty.

+jbd_expect.patch
+jbd-assert-io-failure-fix.patch

 Forward-port from Stephen's recent batch of ext3 patches.

+jbd-handle-journal-io-errors.patch
+jbd-handle-journal-io-errors-fix.patch

 Propagate IO errors against the ext3 journal back to user syscalls, mainly
 fsync().

+ext3-concurrent-block-allocation-hashed.patch

 Change the ext3 BKL-removal code to use the hashed locking and
 percpu_counters from ext2.



All 99 patches:

linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

ppa-null-pointer-fix.patch

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

as-queue_notready-cleanup.patch
  don't dispatch request on elv_queue_empty

as-disable-thinktime.patch

cfq-2.patch
  CFQ scheduler, #2

unplug-use-kblockd.patch
  Use kblockd for running request queues

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

cdrom-stack-usage.patch
  reduce stack in cdrom/optcd.c

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

htree-nfs-fix-2.patch
  htree nfs fix

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

hugh-11-fix-unuse_pmd-fixme.patch
  swap 11/13 fix unuse_pmd fixme

tmpfs-blk_congestion_wait-fix.patch
  tmpfs blk_congestion_wait fix

page_convert_anon-locking-fix.patch
  page_convert_anon locking fix

monotonic-clock-hangcheck.patch
  monotonic clock source for hangcheck timer

module_load_notification.patch
  module load notification

put_task_struct-debug.patch

remove-kdev_name.patch
  remove kdevname() before someone starts using it again

percpu_counter.patch
  percpu_counters: approximate but scalabel counters

blockgroup_lock.patch
  blockgroup_lock: hashed spinlocks for ext2 and ext3 blockgroup locking

ext2-no-lock_super-ng.patch

ext2-ialloc-no-lock_super-ng.patch

stat_t-larger-dev_t.patch
  struct stat - support larger dev_t

kill-TIOCTTYGSTRUCT.patch
  kill TIOCTTYGSTRUCT

dev_t-32-bit.patch
  [for playing only] change type of dev_t

dev_t-remove-B_FREE.patch
  dev_t: eliminate B_FREE

sg-dev_t-fix.patch
  32-bit dev_t fix for sg

misc.patch
  misc fixes

sony-apm-fix.patch
  fix ec_read using wrong #define's in sonypi driver.

init-sections-in-kallsyms.patch
  Put all functions in kallsyms

3c59x-980-support.patch
  Additional 3c980 device support

fadvise-flush-data.patch

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

console-scrollback.patch
  add vt console scrollback ioctl

usb-disconnect-crash-fix.patch
  Subject: Re: [linux-usb-devel] timer hang with current 2.5 BK

devfs-rescan_partitions-fix.patch
  Fix devfs' partition handling

umsdos-fixes.patch
  umsdos fixes

exp_parent-locking-fix.patch
  exp_parent locking fixes

real_lookup-race-fix.patch
  real_lookup race fix

remove-dparent_lock.patch
  remove dparent_lock

conntrack-use-after-free-fix.patch
  fix use-after-free in ip_conntrack

PCI-aliases-fix.patch
  Fix PCI aliases.

jbd_expect.patch
  Add less-severe assert-failure form for ext3.

jbd-assert-io-failure-fix.patch
  Fix jbd assert failure on IO error.

acpi-build-fix.patch
  ACPI build fix

ext3_mark_inode_dirty-speedup.patch
  ext3_mark_inode_dirty() speedup

ext3_mark_inode_dirty-less-calls.patch
  ext3_commit_write speedup

ext3-handle-cache.patch
  ext3: create a slab cache for transaction handles

jbd-handle-journal-io-errors.patch
  ext3 journal commit I/O error fix

jbd-handle-journal-io-errors-fix.patch

ext3-no-bkl.patch

journal_dirty_metadata-speedup.patch

journal_get_write_access-speedup.patch

ext3-concurrent-block-inode-allocation.patch
  Subject: [PATCH] concurrent block/inode allocation for EXT3

ext3-concurrent-block-allocation-fix-1.patch

ext3-concurrent-block-allocation-hashed.patch
  Subject: Re: [PATCH] concurrent block/inode allocation for EXT3



