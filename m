Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbTEYLMk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 07:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTEYLMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 07:12:40 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:54552 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261858AbTEYLLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 07:11:30 -0400
Date: Sun, 25 May 2003 04:27:59 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.69-mm9
Message-Id: <20030525042759.6edacd62.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 May 2003 11:24:38.0661 (UTC) FILETIME=[3A717B50:01C322B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm9/


. 2.5.69-mm9 is not for the timid.  It includes extensive changes to the
  ext3 filesystem and the JBD layer.  It withstood an hour of testing on my
  4-way, but it probably has a couple of holes still.

  The locking has been finegrained and sleeping locks have been removed -
  there are now no instances of lock_kernel(), lock_journal() or sleep_on()
  in JBD or ext3.  ext3 is much quicker on SMP machines.

. The AIO patches have gone through another cycle.  Mainly the addition of
  extensive commentary to quieten my perpetual whining.

. Several patches have been quietly upgraded (this often happens in -mm,
  but I don't changelog them).

. /proc/sys/vm/min_free_kbytes is here.  It is like the old free_pages,
  only better.

. /sys/block/hda/queue/nr_requests is here.  It allows the disk request
  queue depth to be set on-the-fly.

. Various fixes.



Changes since 2.5.68-mm8:


-sched-numa-warning-fix.patch
-acpi-irq-ret-fix.patch
-vt8237.patch

 Merged

+DEFINE_PERCPU-in-modules.patch

 Allow DEFINE_PER_CPU to be used in modules.  AFAIK, nothing uses this yet.

-slab-magazine-tuning.patch

 Folded into slab-magazine-layer.patch

+mpparse-warning-fix.patch

 Nail a warning

-ext3-truncate-ordered-pages.patch

 Dropped.  It was lame.

+irq_balance-fix-2.patch

 For noirqbalance commandline handling logic, perhaps.

+as-dont-clear-last_merge.patch
+cfq-dont-clear-last_merge.patch

 Sync these IO schedulers up with core API changes.

+per-queue-nr_requests.patch

 Allow the size of each disk queue to be set at runtime.  Via
 /sys/block/hda/queue/nr_requests

+CONFIG_DEBUG_PAGEALLOC-extras.patch

 More work against the patch which unmaps freed pages from the kernel
 address space.

+jbd-010-b_committed_data-race-fix.patch
+jbd-020-locking-schema.patch
+jbd-030-remove-splice_lock.patch
+jbd-040-journal_add_journal_head-locking.patch
+jbd-045-rename-journal_unlock_journal_head.patch
+jbd-050-b_frozen_data-locking.patch
+jbd-060-b_committed_data-locking.patch
+jbd-070-b_transaction-locking.patch
+jbd-080-b_next_transaction-locking.patch
+jbd-090-b_tnext-locking.patch
+jbd-100-remove-journal_datalist_lock.patch
+jbd-110-t_nr_buffers-locking.patch
+jbd-120-t_updates-locking.patch
+jbd-130-t_outstanding_credits-locking.patch
+jbd-140-t_jcb-locking.patch
+jbd-150-j_barrier_count-locking.patch
+jbd-160-j_running_transaction-locking.patch
+jbd-170-j_committing_transaction-locking.patch
+jbd-180-j_checkpoint_transactions.patch
+jbd-190-j_head-locking.patch
+jbd-200-j_tail-locking.patch
+jbd-210-j_free-locking.patch
+jbd-220-j_commit_sequence-locking.patch
+jbd-230-j_commit_request-locking.patch
+jbd-240-dual-revoke-tables.patch
+jbd-250-remove-sleep_on.patch
+jbd-300-remove-lock_kernel-journal_c.patch
+jbd-310-remove-lock_kernel-transaction_c.patch
+jbd-400-remove-lock_journal-checkpoint_c.patch
+jbd-410-remove-lock_journal-commit_c.patch
+jbd-420-remove-lock_journal-journal_c.patch
+jbd-430-remove-lock_journal-transaction_c.patch
+jbd-440-remove-lock_journal.patch

 JBD locking rework.

-aio-01-retry-cleanup.patch

 Folded into aio-01-retry.patch

+rd-separate-queues.patch

 ramdisk fix

+proc-kcore-rework.patch

 /proc/kcore fixes

+mystery-subarch-fix.patch

 cleanup

+ewrk3-memleak-fix.patch
+initrd-memleak-fix.patch
+pnp-memory-leaks.patch

 Fix memleaks

+per-cpu-mmu_gathers.patch

 cleanup

+syncppp-locking-fix.patch

 Might fix a syncppp problem.

+s390-dirty-bit-cleaning.patch

 A hook for an s390 MMU strangeness.

+min_free_kbytes.patch

 /proc/sys/vm/min_free_kbytes

 This is a resurrection of the old free_pages tunable.  It allows the
 sysadmin to increase the amount of free memory which the VM will maintain. 
 It is mainly for specialised networking applications.

 But it can also be used for stresstesting the kernel: reduce it to
 something very small and check for OOM deadlocks, etc.

+srat-warning-fix.patch

 Warning fix

+ACPI-constant-overflow-fixes.patch

 Some ACPI fix

+tulip-warning-fix.patch

 Warning fix

+install_page-flushing.patch

 TLB optimisation

+netdev-deadlock-fix.patch

 hotplug/sysfs/networking deadlock fix




All 178 patches


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kmalloc_percpu-interface-change.patch
  kmalloc_percpu: interface change.

kmalloc_percpu-interface-change-warning-fix.patch
  nail a warning

DEFINE_PERCPU-in-modules.patch
  per-cpu support inside modules (minimal)

irqreturn-drivers-net.patch

slab-magazine-layer.patch
  magazine layer for slab

slabinfo-rework.patch
  new statistics for slab

aio-random-cleanups.patch

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-ioctl-pci-update.patch
  From: Anton Blanchard <anton@samba.org>
  Subject: ppc64 stuff

ppc64-reloc_hide.patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

ppc64-xics-irq-fix.patch
  PPC64 irq return fix

ppc64-addnote-warning-fix.patch
  Squash warning in ppc64 addnote tool

ppc64-fp-warning-fix.patch
  Squash implicit declaration warning in ppc64 align.c

ppc64-do_signal32-fix.patch
  ppc64 do_signal32 warning fix

ppc64-xics-warning-fix.patch
  Squash warning in ppc64 xics.c

ppc64-prom-warning-fix.patch
  Unused variables in ppc64 prom.c

ppc64-compat-build-fix.patch
  ppc64 build fix

ppc64-ioctl32-warning-fix-2.patch
  ppc64 ioctl32 warning fix

ppc64-setup-warning-fix.patch
  nail warnings in arch/ppc64/kernel/setup.c

ppc64-traps-warning-fixes.patch
  arch/ppc64/kernel/traps.c warning fixes

ppc64-lpar-warning-fixes.patch
  ppc64: more warning fixes

tty_io-warning-fix.patch
  tty_io warning fix

siocdevprivate_ioctl-warning-fix.patch
  siocdevprivate_ioctl warning fix

aic-errno-removal.patch
  aic7xxx build fix

aic-non-i386-build-fix.patch
  aic7xxx non-i386 build fix

aic7xxx-fixes.patch

sym-do-160.patch
  make the SYM driver do 160 MB/sec

mpparse-warning-fix.patch
  arch/i386/kernel/mpparse.c warning fixes

irqreturn-snd-via-fix.patch
  via sound irqreturn fix

irq_cpustat-cleanup.patch
  irq_cpustat cleanup

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

irq-check-rate-limit.patch
  IRQs: handle bad return values from handlers

irq_desc-others.patch
  Fix up irq_desc initialisation for non-ia32

dcache_lock-vs-tasklist_lock-take-3.patch
  Fix dcache_lock/tasklist_lock ranking bug

apm-set_cpus_allowed-fix.patch
  APM does unsafe conditional set_cpus_allowed

buffer-debug.patch
  buffer.c debugging

irq_balance-fix-2.patch
  irq balance logic fix

VM_RESERVED-check.patch
  VM_RESERVED check

reiserfs-inode-attribute-support.patch
  reiserfs: inode attributes support.

rcu-stats.patch
  RCU statistics reporting

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

make-KOBJ_NAME-match-BUS_ID_SIZE.patch
  Make KOBJ_NAME_LEN match BUS_ID_SIZE

xirc2ps_cs-irqreturn-fix.patch
  xirc2ps_cs irq return fix

ide_setting_sem-fix.patch

readdir-return-value-fix.patch
  Fix readdir error return value

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

linux-isp.patch

isp-update-1.patch

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

synaptics-mouse-support.patch
  Add Synaptics touchpad tweaking to psmouse driver

inode-unhashing-fix-2.patch
  Don't remove inode from hash until filesystem has deleted it

resurrect-batch_requests.patch
  bring back the batch_requests function

kblockd.patch
  Create `kblockd' workqueue

cfq-infrastructure.patch

elevator-completion-api.patch
  elevator completion API

as-iosched.patch
  anticipatory I/O scheduler

as-dont-clear-last_merge.patch

as-proc-read-write.patch
  AS: pgbench improvement

as-discrete-read-fifo-batches.patch
  AS: discrete read fifo batches

as-sync-async.patch
  AS sync/async batches

unplug-use-kblockd.patch
  Use kblockd for running request queues

cfq-2.patch
  CFQ scheduler, #2

cfq-dont-clear-last_merge.patch

cfq-iosched-dyn.patch
  CFQ: update to rq-dyn API

per-queue-nr_requests.patch
  per queue nr_requests

unmap-page-debugging.patch
  unmap unused pages for debugging

CONFIG_DEBUG_PAGEALLOC-extras.patch
  From: Manfred Spraul <manfred@colorfullife.com>
  Subject: DEBUG_PAGEALLOC

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

sound-irq-hack.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

put_task_struct-debug.patch

ia32-mknod64.patch
  mknod64 for ia32

ext2-64-bit-special-inodes.patch
  ext2: support for 64-bit device nodes

ext3-64-bit-special-inodes.patch
  ext3: support for 64-bit device nodes

64-bit-dev_t-kdev_t.patch
  64-bit dev_t and kdev_t

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

slab-reclaimable-accounting.patch
  slab: account for reclaimable caches

slab-reclaimable-accounting-fs.patch
  mark shrinkable slabs as being reclaimable

security-process-attribute-api.patch
  Process Attribute API for Security Modules

proc-pid-attr-fix.patch
  Process Attribute API for Security Modules (fixlet)

proc-pid-security-labels.patch
  /proc/pid inode security labels

time-interpolation-infrastructure.patch
  improved core support for time-interpolation

time-interpolation-infrastructure-fix.patch
  make timer interpolation patch compile

thread-info-in-task_struct.patch
  allow thread_info to be allocated as part of task_struct

reinstate-task-freeing-hack-for-ia64.patch
  reinstate lame task_struct (non)-refcounting hack/fix

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

jbd-010-b_committed_data-race-fix.patch
  Subject: Re: [Ext2-devel] [RFC] probably bug in current ext3/jbd

jbd-020-locking-schema.patch
  plan JBD locking schema

jbd-030-remove-splice_lock.patch
  remove jh_splice_lock

jbd-040-journal_add_journal_head-locking.patch
  fine-grain journal_add_journal_head locking

jbd-045-rename-journal_unlock_journal_head.patch
  rename journal_unlock_journal_head to journal_put_journal_head

jbd-050-b_frozen_data-locking.patch
  Finish protection of journal_head.b_frozen_data

jbd-060-b_committed_data-locking.patch

jbd-070-b_transaction-locking.patch
  implement b_transaction locking rules

jbd-080-b_next_transaction-locking.patch
  Implement b_next_transaction locking rules

jbd-090-b_tnext-locking.patch
  b_tnext locking

jbd-100-remove-journal_datalist_lock.patch
  remove journal_datalist_lock

jbd-110-t_nr_buffers-locking.patch
  t_nr_buffers locking

jbd-120-t_updates-locking.patch
  t_updates locking

jbd-130-t_outstanding_credits-locking.patch
  implement t_outstanding_credits locking

jbd-140-t_jcb-locking.patch
  implement t_jcb locking

jbd-150-j_barrier_count-locking.patch
  implement j_barrier_count locking

jbd-160-j_running_transaction-locking.patch
  implement j_running_transaction locking

jbd-170-j_committing_transaction-locking.patch
  implement j_committing_transaction locking

jbd-180-j_checkpoint_transactions.patch
  implement j_checkpoint_transactions locking

jbd-190-j_head-locking.patch
  implement journal->j_head locking

jbd-200-j_tail-locking.patch
  implement journal->j_tail locking

jbd-210-j_free-locking.patch
  implement journal->j_free locking

jbd-220-j_commit_sequence-locking.patch
  implement journal->j_commit_sequence locking

jbd-230-j_commit_request-locking.patch
  implement j_commit_request locking

jbd-240-dual-revoke-tables.patch
  implement dual revoke tables.

jbd-250-remove-sleep_on.patch
  remove remaining sleep_on()s

jbd-300-remove-lock_kernel-journal_c.patch
  remove lock_kernel() calls from journal.c

jbd-310-remove-lock_kernel-transaction_c.patch
  remove lock_kernel calls from transaction.c

jbd-400-remove-lock_journal-checkpoint_c.patch
  remove lock_journal calls from checkpoint.c

jbd-410-remove-lock_journal-commit_c.patch
  remove lock_journal() from commit.c

jbd-420-remove-lock_journal-journal_c.patch
  remove lock_journal() calls from journal.c

jbd-430-remove-lock_journal-transaction_c.patch
  remove lock_journal() calls from transaction.c

jbd-440-remove-lock_journal.patch
  remove lock_journal()

reboot_on_bsp.patch

kexec-revert-NORET_TYPE.patch

apic_shutdown.patch

i8259-shutdown.patch

hwfixes-x86kexec.patch

kexec-warning-fixes-2.patch

CONFIG_FUTEX.patch
  FUTEX support should be optional

CONFIG_EPOLL.patch
  eventpollfs configuration option

invalidate_mmap_range.patch
  Interface to invalidate regions of mmaps

devpts-xattr-handler.patch
  devpts xattr handler for security labels 2.5.69-bk

unregister_netdev-cleanup.patch

aio-01-retry.patch
  AIO: Core retry infrastructure

aio-02-lockpage_wq.patch
  AIO: Async page wait

aio-03-fs_read.patch
  AIO: Filesystem aio read

aio-04-buffer_wq.patch
  AIO: Async buffer wait

aio-05-fs_write.patch
  AIO: Filesystem aio write

aio-06-bread_wq.patch
  AIO: Async block read

aio-06-bread_wq-fix.patch

aio-07-ext2getblk_wq.patch
  AIO: Async get block for ext2

aio-poll.patch
  aio_poll

aio-poll-cleanup.patch
  aio-poll: don't put extern decls in .c!

overcommit-root-margin.patch
  overcommit root margin

rpc-ifdef-fix.patch
  net/sunrpc/sunrpc_syms.c typo fix

notify_count-for-de_thread.patch
  add notify_count for de_thread

extend-check_valid_hugepage_range.patch
  rename check_valid_hugepage_range()

misc2.patch
  misc fixes

io_stats-documentation.patch
  Documentation for disk iostats

voyager-do_fork-fix.patch
  do_fork fixes for voyager x86 subarch

cpia-fp-removal.patch
  Remove floating point use in cpia.c

vfsmount_lock.patch
  From: Maneesh Soni <maneesh@in.ibm.com>
  Subject: [patch 1/2] vfsmount_lock

lockfree-lookup_mnt.patch
  lockfree lookup_mnt

rd-separate-queues.patch
  rd.c: separate queue per disk

proc-kcore-rework.patch
  /proc/kcore fixes

mystery-subarch-fix.patch
  Better fix for ia32 subarch circular dependencies

ewrk3-memleak-fix.patch
  fix drivers/net/ewrk.c memory leak

initrd-memleak-fix.patch
  fix init/do_mounts_rd.c memory leak

pnp-memory-leaks.patch
  two PNP memory leaks

per-cpu-mmu_gathers.patch
  Change mmu_gathers into per-cpu data

syncppp-locking-fix.patch
  syncppp locking fix

s390-dirty-bit-cleaning.patch
  dirty bit clearing on s390.

min_free_kbytes.patch
  /proc/sys/vm/min_free_kbytes

srat-warning-fix.patch
  arch/i386/kernel/srat.c cast warning fix

ACPI-constant-overflow-fixes.patch
  ACPI constant overflow fixes

tulip-warning-fix.patch
  tulip warning fix

install_page-flushing.patch

netdev-deadlock-fix.patch



