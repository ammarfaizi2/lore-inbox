Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTFDGEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 02:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbTFDGEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 02:04:52 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:29673 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262934AbTFDGEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 02:04:33 -0400
Date: Tue, 3 Jun 2003 23:18:27 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.70-mm4
Message-Id: <20030603231827.0e635332.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jun 2003 06:18:01.0766 (UTC) FILETIME=[0D2B9460:01C32A61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm4/

. There are no substantial ext3 changes from 2.5.70-mm3.  A couple of
  performance tweaks have been added, and some debug code to help track down
  one report of an assertion failure in journal_dirty_metadata().

. A patch which adds the statfs64() syscall.  This involved some mangling
  of the BSD accountig code.  If anyone knows how to test BSD accounting,
  please do so, or let me know.

. There have been one or two reports of -mm3 getting stuck in
  get_request_wait() against CDROMs.  If anyone sees that, or was seeing it
  in -mm3 and does not see it in -mm4, please let us know.





Changes since 2.5.70-mm3:


 linus.patch

 Latest from Linus

-slab-magazine-layer.patch
-mtd-build-fix.patch
-time-interpolation-infrastructure.patch
-proc-kcore-rework.patch
-sysv-sem-16-bit-pif-fix.patch
-remove-LINUX_2_2.patch

 Merged

+kgdb-use-ggdb.patch

 Use `-ggdb' when compiling for kgdb.  Creates a huge vmlinux, but fixes the
 problem wherein gdb doesn't know the types of things when it should.

+ppc64-fixup.patch

 PPC64 fixes

+ppc64-semaphore-reimplementation.patch

 Replace the ppc64 semaphore implementation with the ia32 one.  (This hasn't
 been tested afaik).

+time-interpolator-cleanup.patch

 timer.c cleanups

+cadetradio-badcopy.patch
+cmpci-userptr.patch
+zr36120-userptr.patch
+bw-qcam-fix.patch

 copy_*_user fixes

+eat-keys-on-panic.patch

 Work around odd KVM switches

+truncate-vs-msync-fix.patch

 Avoid a feasible BUG in the pagecache code

+pnpbios-oops-leak-fix.patch

 pnpbios fixlets

+force_successful_syscall_return.patch

 ia64: sometimes overloading a negative syscall return code to indicate
 "error" doesn't work out.

+proc-stat-btime-fix.patch

 Stop /proc/stat:btime from wobbling

+eventpoll-use-after-free-fix.patch

 eventpoll fixes

+devfs_remove-fix.patch

 defvs diagnostics for broken callers

+console-blanking-fix.patch

 fix up console blanking

+console-privacy.patch

 Add an ioctl to prevent keystrokes from unblanking the console (for braille
 users)

+fix-tty-driver-mess.patch

 tty/devfs cleanups

+misc3.patch

 misc fixes

+generic_file_write-fix-2.patch

 fix the fix to the fix to the fix to the writev() code.

+cs423x-fixes.patch

 driver fixes

+statfs64.patch
+statfs64-fix.patch
+statfs-overflow-fix.patch
+statfs64-leftovers.patch

 Implement the statfs64() syscall.  We need this because statfs() will
 overflow with huge disks.

+sched_best_cpu-fix-01.patch
+sched_best_cpu-fix-02.patch
+sched_best_cpu-fix-03.patch

 Teach the CPU scheduler to not schedule tasks on nodes which don't have any
 CPUs

+cfq-list_del-fix.patch

 CFQ IO scheduler BUGfix

-unmap-page-debugging.patch
-CONFIG_DEBUG_PAGEALLOC-extras.patch
+unmap-page-debugging-2.patch
+unmap-page-debugging-2-fix.patch

 New version of this debug patch from Manfred.

+blk-fair-batches.patch

 block request batching changes

+blk-as-hint.patch

 Fix anticipatory scheduler for the above.

+get_request_wait-oom-fix.patch

 Plug a get_request_wait() hole

+slab-poisoning-fix.patch

 Correctly poison freshly allocated objects with 0x5a5a5a5a, to distinguish
 them from freed objects, which are poisoned with 0x6b6b6b6b.

-fremap-all-mappings.patch
+mmap-prefault.patch

 Implement the prefaulting of executable mmaps more simply.

+bio-debug-trap.patch

 Try to track down a free-of-freed-BIO bug.

+event-log-put_task_struct.patch

 Debugging to try to track down the put_task_struct(free task_struct) bug.

+journal_create-deadlock-fix.patch

 Fix ancient deadlock in journal_create()

+jbd-590-do_get_write_access-speedup.patch

 ext3 tweak

+ext3-080-remove-block-inode-count-message.patch

 Kill a printk which shouldn't be coming out.

+jbd-600-journal_dirty_metadata-speedup.patch

 ext3 tweak

+jbd-610-journal_dirty_metadata-diags.patch

 Try to trap a possible bug in journal_dirty_metadata()





All 177 patches


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-use-ggdb.patch

kmalloc_percpu-interface-change.patch
  kmalloc_percpu: interface change.

kmalloc_percpu-interface-change-warning-fix.patch
  nail a warning

DEFINE_PERCPU-in-modules.patch
  per-cpu support inside modules (minimal)

aio-random-cleanups.patch

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-fixup.patch
  ppc64 fixup

ppc64-ioctl-pci-update.patch
  From: Anton Blanchard <anton@samba.org>
  Subject: ppc64 stuff

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

sym-do-160.patch
  make the SYM driver do 160 MB/sec

irqreturn-snd-via-fix.patch
  via sound irqreturn fix

irq_cpustat-cleanup.patch
  irq_cpustat cleanup

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

time-interpolator-cleanup.patch
  clean up timer interpolation code

cadetradio-badcopy.patch
  radio-cadet.c: remove unnecessary copy_to_user()

cmpci-userptr.patch
  cmpci: fix improper access to userspace

zr36120-userptr.patch
  zr36120: fix improper access to userspace

irq-check-rate-limit.patch
  IRQs: handle bad return values from handlers

irq_desc-others.patch
  Fix up irq_desc initialisation for non-ia32

common-ioctl32.patch
  From: Pavel Machek <pavel@suse.cz>
  Subject: Re: must-fix list, v5

ioctl32-cleanup-sparc64.patch
  ioctl32 cleanup: sparc64

ioctl32-cleanup-x86_64.patch
  ioctl32 cleanup: sparc64

lru_cache_add-check.patch
  lru_cache_add debug check

eat-keys-on-panic.patch
  Eat keys on panic

truncate-vs-msync-fix.patch
  remove unsafe BUG_ON()

pnpbios-oops-leak-fix.patch
  pnpbios dereferencing user pointer

force_successful_syscall_return.patch
  force_successful_syscall_return

proc-stat-btime-fix.patch
  fix wobbly /proc/stat:btime

eventpoll-use-after-free-fix.patch
  eventpoll: fix possible use-after-free

bw-qcam-fix.patch
  fix bw-qcam.c bad copy_to_user

devfs_remove-fix.patch
  Graceful failure in devfs_remove()

console-blanking-fix.patch
  Console blanking fix

console-privacy.patch
  Console privacy for braille users

fix-tty-driver-mess.patch
  Fix tty devfs mess

misc3.patch
  misc fixes

generic_file_write-fix-2.patch
  Fix generic_file_write() again.

fb-image-depth-fix.patch
  fbdev image depth fix

reiserfs-parser-fix-remount.patch
  reiserfs option parser fix and ability to pass options to remount

reiserfs-small-blocksize.patch
  reiserfs support for blocksizes other than 4096 bytes

raid-fixes.patch
  gix RAID things

neilb-raid1-double-free-fix.patch
  raid1 double-free fix

buffer-debug.patch
  buffer.c debugging

cs423x-fixes.patch
  cs423x fixes

hugetlbfs-mount-options.patch
  hugetlbfs: mount options and permissions

statfs64.patch
  Add system calls statfs64 and fstatfs64

statfs64-fix.patch

statfs-overflow-fix.patch
  statfs64: handle overflows

statfs64-leftovers.patch
  statfs64: remaining filesystems

sched_best_cpu-fix-01.patch
  Fix Bug 619: Processes Scheduled on CPU-less nodes (1/3)

sched_best_cpu-fix-02.patch
  Processes Scheduled on CPU-less nodes (2/3)

sched_best_cpu-fix-03.patch
  Fix Bug 619: Processes Scheduled on CPU-less nodes (3/3)

VM_RESERVED-check.patch
  VM_RESERVED check

rcu-stats.patch
  RCU statistics reporting

ide_setting_sem-fix.patch

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

raid5-use-right-dev-fix.patch
  raid5 fix

linux-isp.patch

isp-update-1.patch

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

synaptics-mouse-support.patch
  Add Synaptics touchpad tweaking to psmouse driver

deadline-hash-removal-fix.patch
  DEADLINE: hash removal fix

resurrect-batch_requests.patch
  bring back the batch_requests function

kblockd.patch
  Create `kblockd' workqueue

cfq-infrastructure.patch

elevator-completion-api.patch
  elevator completion API

as-iosched.patch
  anticipatory I/O scheduler

as-proc-read-write.patch
  AS: pgbench improvement

as-discrete-read-fifo-batches.patch
  AS: discrete read fifo batches

as-sync-async.patch
  AS sync/async batches

as-hash-removal-fix.patch
  AS: hash removal fix

as-jumbo-patch-for-scsi.patch
  AS jumbo patch (for SCSI and TCQ)

unplug-use-kblockd.patch
  Use kblockd for running request queues

cfq-2.patch
  CFQ scheduler, #2
  CFQ: update to rq-dyn API

cfq-hash-removal-fix.patch
  CFQ: hash removal fix

cfq-list_del-fix.patch
  CFQ: empty the queuelist

per-queue-nr_requests.patch
  per queue nr_requests

blk-invert-watermarks.patch
  blk_congestion_wait threshold cleanup

blk-fair-batches.patch
  blk-fair-batches

blk-as-hint.patch
  blk-as-hint

get_request_wait-oom-fix.patch
  handle OOM in get_request_wait().

unmap-page-debugging-2.patch
  debug patch: unmap unused kernel pages

unmap-page-debugging-2-fix.patch

slab-poisoning-fix.patch
  slab poisoning fix

print-build-options-on-oops.patch
  print a few config options on oops

mmap-prefault.patch
  prefault of executable mmaps

bio-debug-trap.patch
  BIO debugging patch

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

thread-info-in-task_struct.patch
  allow thread_info to be allocated as part of task_struct

reinstate-task-freeing-hack-for-ia64.patch
  reinstate lame task_struct (non)-refcounting hack/fix

event-log-put_task_struct.patch
  event logging to find the late put_task_struct() bug

journal_create-deadlock-fix.patch
  ext3: fix dadlock in journal_create()

ext3-no-bkl.patch

journal_get_write_access-speedup.patch

ext3-concurrent-block-inode-allocation.patch
  Subject: [PATCH] concurrent block/inode allocation for EXT3

ext3-orlov-approx-counter-fix.patch
  Fix orlov allocator boundary case

ext3-concurrent-block-allocation-fix-1.patch

ext3-concurrent-block-allocation-hashed.patch
  Subject: Re: [PATCH] concurrent block/inode allocation for EXT3

ext3-concurrent-block-inode-allocation-fix.patch
  fix ext3 inode allocator race

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
  transaction leak and race fix

jbd-440-remove-lock_journal.patch
  remove lock_journal()

jbd-510-h_credits-fix.patch
  journal_release_buffer: handle credits fix

jbd-520-journal_unmap_buffer-race.patch
  journal_unmap_buffer race fix

jbd-530-walk_page_buffers-race-fix.patch
  ext3_writepage race fix

jbd-540-journal_try_to_free_buffers-race-fix.patch
  buffer freeing non-race comment

jbd-550-locking-checks.patch
  add some locking assertions

jbd-570-transaction-state-locking.patch
  additional transaction shutdown locking

jbd-580-log_start_commit-race-fix.patch
  fix log_start_commit race

jbd-590-do_get_write_access-speedup.patch
  JBD: do_get_write_access() speedup

ext3-010-fix-journalled-data.patch
  Remove incorrect assertion from ext3

ext3-035-journal_try_to_free_buffers-race-fix.patch

ext3-040-recursive-ext3_write_inode-check.patch
  ext3: add a dump_stack()

ext3-050-ioctl-transaction-leak.patch
  ext3: fix error-path handle leak

ext3-070-xattr-clone-leak-fix.patch
  Fix leak in ext3_acl_chmod()

ext3-080-remove-block-inode-count-message.patch
  ext3: remove mount-time diagnostic messages

jbd-600-journal_dirty_metadata-speedup.patch

jbd-610-journal_dirty_metadata-diags.patch
  JBD: journal_dirty_metadata diagnostics

invalidate_mmap_range.patch
  Interface to invalidate regions of mmaps

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

aio-05-fs_write-fix.patch

aio-06-bread_wq.patch
  AIO: Async block read

aio-06-bread_wq-fix.patch

aio-07-ext2getblk_wq.patch
  AIO: Async get block for ext2

aio-poll.patch
  aio_poll
  aio-poll: don't put extern decls in .c!

vfsmount_lock.patch
  From: Maneesh Soni <maneesh@in.ibm.com>
  Subject: [patch 1/2] vfsmount_lock

syncppp-locking-fix.patch
  syncppp locking fix

s390-dirty-bit-cleaning.patch
  dirty bit clearing on s390.

min_free_kbytes.patch
  /proc/sys/vm/min_free_kbytes

sched-hot-balancing-fix.patch
  fix for CPU scheduler load distribution

O_SYNC-speedup-2.patch
  speed up O_SYNC writes



