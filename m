Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbTBDHWY>; Tue, 4 Feb 2003 02:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbTBDHWY>; Tue, 4 Feb 2003 02:22:24 -0500
Received: from packet.digeo.com ([12.110.80.53]:41166 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267135AbTBDHWT>;
	Tue, 4 Feb 2003 02:22:19 -0500
Date: Mon, 3 Feb 2003 23:31:56 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.59-mm8
Message-Id: <20030203233156.39be7770.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Feb 2003 07:31:45.0254 (UTC) FILETIME=[78344860:01C2CC1F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm8/

. Various tweaks and fixes, and some hugetlbpage work.

. There is an updated anticipatory scheduler patch from Nick over in
  experimental/ which addresses the large-read-starves-everything problem.

. The reworked ia32 balancing patch from Nitin Kamble is stable, and is
  consistently showing benefit for heavy networking loads on large SMP
  machines.  Even though everyone seems to agree that a userspace solution to
  this is smarter, that's no reason to hold back on improving the
  kernel-based solution so I shall be submitting that patch.

. Ingo's latest scheduler changes are here.  I held off on that because it
  appeared that there was some interaction with the I/O scheduler.  Whatever
  that was has gone away without any CPU scheduler changes, so...

. frlocks have been renamed to seqlocks, and that code is now converging
  onto something stable.



Changes since 2.5.59-mm7:


+linus.patch

 Latest drop from Linus

-sync-fix.patch
-direct-io-ENOSPC-fix.patch
-inode-accounting-race-fix.patch
-vmlinux-fix.patch
-maestro-fix.patch
-setuid-exec-no-lock_kernel.patch
-ext3-scheduling-storm.patch
-quota-lockfix.patch
-quota-offsem.patch
-slab-poisoning-fix.patch
-preempt-locking.patch
-stack-overflow-fix.patch
-ext2-allocation-failure-fix.patch
-ext2_new_block-fixes.patch
-slab-irq-fix.patch
-Richard_Henderson_for_President.patch
-parenthesise-pgd_index.patch
-kernel-commandline-fix.patch
-macro-double-eval-fix.patch
-blkdev-fixes.patch
-modversions.patch
-pcmcia_timer_init.patch
-buffer-io-accounting.patch
-aic79xx-linux-2.5.59-20030122.patch
-discarded-section-fix.patch
-atyfb-compile-fix.patch
-floppy-locking-fix.patch
-sound-firmware-load-fix.patch
-generic_file_readonly_mmap-fix.patch
-exit_mmap-fix-47.patch
-show_task-fix.patch

 Merged

+mark_inode_dirty-race.patch

 SMP barriers in __mark_inode_dirty()

+pin_page-pmd.patch

 Optimisation for follow_page() for some architectures.  For futexes in huge
 pages.

+seqlock.patch

 Rename frlocks, fixes.

+default_idle-speedup.patch

 Speed up the idle task!

+hugetlbfs-get_unmapped_area.patch
+hugetlbfs-truncate-fix.patch
+hugetlbfs-i_size-fix.patch
+hugetlbfs-cleanup.patch
+hugetlbfs-nopage-cleanup.patch
+hugetlbfs-fault-fix.patch
+hugetlbpage-cleanup.patch
+hugetlb_vmtruncate-fixes.patch
+hugetlb-mremap-fix.patch

 hugetlb fixes/cleanups

+mremap-cleanup.patch

 Random edits

+up-spinlock-debugging.patch

 spinlock debugging for uniprocessor builds

+scheduler-update.patch

 Ingo's latest.

+rml-scheduler-update.patch

 scheduler tweaks from Robert




All 80 patches:

linus.patch
  cset-1.879.1.145-to-1.950.txt.gz

kgdb.patch

devfs-fix.patch

deadline-np-42.patch
  (undescribed patch)

deadline-np-43.patch
  (undescribed patch)

batch-tuning.patch
  I/O scheduler tuning

starvation-by-read-fix.patch
  fix starvation-by-readers in the IO scheduler

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

reiserfs-readpages.patch
  reiserfs v3 readpages support

fadvise.patch
  implement posix_fadvise64()

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

scheduler-tunables.patch
  scheduler tunables

htlb-2.patch
  hugetlb: fix MAP_FIXED handling

kirq.patch
  ia32 IRQ distribution rework

kirq-up-fix.patch
  Subject: Re: 2.5.59-mm1

agp-warning-fix.patch
  fix agp compile warning

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

prune-icache-stats.patch
  add stats for page reclaim via inode freeing

vma-file-merge.patch
  file-backed vma merging mergnig

mmap-whitespace.patch

read_cache_pages-cleanup.patch
  cleanup in read_cache_pages()

remove-GFP_HIGHIO.patch
  remove __GFP_HIGHIO

oprofile-p4.patch

oprofile_cpu-as-string.patch
  oprofile cpu-as-string

wli-11_pgd_ctor.patch
  Use a slab cache for pgd and pmd pages

wli-11_pgd_ctor-update.patch
  pgd_ctor update

smaller-slab-batches.patch
  Avoid losing timer ticks when slab debug is enabled.

printk-locking.patch
  remove unneeded locking in do_syslog()

hangcheck-timer.patch
  hangcheck-timer

jbd-documentation.patch
  JBD Documentation

sendfile-security-hooks.patch
  Subject: [RFC][PATCH] Restore LSM hook calls to sendfile

mmzone-parens.patch
  asm-i386/mmzone.h macro paren/eval fixes

no_space_in_slabnames.patch
  remove spaces from slab names

remove-will_become_orphaned_pgrp.patch
  remove will_become_orphaned_pgrp()

MAX_IO_APICS-ifdef.patch
  MAX_IO_APICS #ifdef'd wrongly

dac960-error-retry.patch
  Subject: [PATCH] linux2.5.56 patch to DAC960 driver for error retry

epoll-update.patch
  epoll timeout and syscall return types ...

topology-remove-underbars.patch
  Remove __ from topology macros

mandlock-oops-fix.patch
  ftruncate/truncate oopses with mandatory locking

put_user-warning-fix.patch
  Subject: Re: Linux 2.5.59

hash-warnings.patch
  fix #warning's

mark_inode_dirty-race.patch
  Fix SMP race betwen __sync_single_inode and __mark_inode_dirty

reiserfs_file_write.patch
  Subject: reiserfs file_write patch

lost-tick.patch
  Lost tick compensation

seq_file-page-defn.patch
  Include <asm/page.h> in fs/seq_file.c, as it uses PAGE_SIZE

user-process-count-leak.patch
  fix current->user->processes leak

scsi-iothread.patch
  scsi_eh_* needs to run even during suspend

numaq-ioapic-fix2.patch
  NUMAQ io_apic programming fix

misc.patch
  misc fixes

writeback-sync-cleanup.patch
  Remove unneeded code in fs/fs-writeback.c

dont-wait-on-inode.patch
  Fix latencies during writeback

unlink-latency-fix.patch
  fix i_sem contention in sys_unlink()

pin_page-fix.patch
  Fix futexes in huge pages

pin_page-pmd.patch
  Optimise follow_page() for page-table-based hugepages

frlock-xtime.patch
  fast reader locks for gettimeofday() and friends

frlock-xtime-i386.patch

frlock-xtime-ia64.patch

frlock-xtime-other.patch

seqlock.patch
  Change frlock to seqlock

do_gettimeofday-speedup.patch
  do_gettimeofday() optimisations

default_idle-speedup.patch
  default_idle micro-optimisation

pte_chain_alloc-fixes.patch

hugetlbfs-set_page_dirty.patch
  give hugetlbfs a set_page_dirty a_op

compound-pages.patch
  Infrastructure for correct hugepage refcounting

compound-pages-hugetlb.patch
  convert hugetlb code to use compound pages

hugetlbfs-get_unmapped_area.patch
  get_unmapped_area for hugetlbfs

hugetlbfs-truncate-fix.patch
  hugetlbfs: fix truncate

hugetlbfs-i_size-fix.patch
  hugetlbfs i_size fixes

hugetlbfs-cleanup.patch
  hugetlbfs cleanups

hugetlbfs-nopage-cleanup.patch
  Give all architectures a hugetlb_nopage().

hugetlbfs-fault-fix.patch
  Fix hugetlbfs faults

hugetlbpage-cleanup.patch
  ia32 hugetlb cleanup

hugetlb_vmtruncate-fixes.patch
  Fix hugetlb_vmtruncate_list()

hugetlb-mremap-fix.patch
  hugetlb mremap fix

mremap-cleanup.patch
  mm/mremap.c whitespace cleanup

up-spinlock-debugging.patch
  spinlock debugging on uniprocessors

scheduler-update.patch
  ingo's scheduler changes for 2.5.59-mm7

rml-scheduler-update.patch
  rml scheduler bits, 2.5.59-mm7



