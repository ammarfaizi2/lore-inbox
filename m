Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263140AbTCWSF7>; Sun, 23 Mar 2003 13:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263142AbTCWSF7>; Sun, 23 Mar 2003 13:05:59 -0500
Received: from franka.aracnet.com ([216.99.193.44]:57005 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263140AbTCWSFp>; Sun, 23 Mar 2003 13:05:45 -0500
Date: Sun, 23 Mar 2003 10:16:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.65-mm4
Message-ID: <394580000.1048443396@[10.10.2.4]>
In-Reply-To: <20030323020646.0dfcc17b.akpm@digeo.com>
References: <20030323020646.0dfcc17b.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems to hang SDET ... I use ext2 for root & benchmarking, but ext3
for my home dir, so there's a *tiny* bit of ext3 going on I guess.

the sdet script seems to be hung ...

larry:~# strace -p 5342
wait4(31314, 

larry:~# ps -ef | grep 31314
root     31314  5342  0 08:45 pts/0    00:00:00 sync

strace -p 31314 yields nothing.

That's probably not very helpful, is it ...
Let me know what else I can grab ...

M.


--On Sunday, March 23, 2003 02:06:46 -0800 Andrew Morton <akpm@digeo.com> wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.65/2.5.65-mm4/
> 
> . Anyone who was having problems with knfsd exports should find them fixed
>   here.  It was a 32-bit dev_t problem.
> 
> . Several ext3 speedups here.  They reduce the overhead of a write() to
>   ext3 by about 45%.
> 
> . Large locking changes to ext3.  lock_kernel() has been completely
>   removed from ext3 and pushed down into the JBD layer, around those bits
>   which actually need it.
> 
>   Lock contention is greatly reduced, but this change means that the
>   front-line locking for ext3 is now two semaphores.  The context switch rate
>   under load has gone through the roof.  So there is more work to be done
>   here yet.
> 
> . Managed to reduce the number of patches from 127 down to 74 by various
>   means.  The major outstanding things here at present are the anticipatory
>   scheduler, object-based-rmap and ext3 locking work.
> 
> 
> 
> 
> Changes since 2.5.65-mm3:
> 
>  linus.patch
> 
>  Latest from -bk.
> 
> -posix-timers-fixes.patch
> -tcp-wakeups.patch
> -remap-file-pages-2.5.63-a1.patch
> -hugh-remap-fix.patch
> -fremap-limit-offsets.patch
> -filemap_populate-speedup.patch
> -file-offset-in-pte-x86_64.patch
> -file-offset-in-pte-ppc64.patch
> -update_atime-ng.patch
> -one-sec-times.patch
> -lseek-ext2_readdir.patch
> -inode_setattr-lock_kernel-removal.patch
> -ide_probe-init_irq-fix.patch
> -raid1-fix.patch
> -nmi-watchdog-fix.patch
> -vm_enough_memory-speedup.patch
> -nanosleep-accuracy-fix-2.patch
> -dev_t-1-kill-cdev.patch
> -dev_t-2-remove-MAX_CHRDEV.patch
> -dev_t-3-major_h-cleanup.patch
> -cpufreq-xtime-locking.patch
> -cs46xx-fixes.patch
> -tty-put_user-checks.patch
> -fail-setup_irq-for-unconfigured-IRQs.patch
> -raw-fix-address_space-rewriting.patch
> -raw-cleanups-and-fixlets.patch
> -timer-simplification.patch
> -timer-lockup-fix-simplification.patch
> -slab-large-obj-tuning.patch
> -floppy-oops-fix.patch
> -ext3_writepage-use-after-free-fix.patch
> -list-barriers-on-smp-only.patch
> -sync_filesystems-docco-lock.patch
> -awe_wave-linkage-error-fix.patch
> -syscalls-return-long.patch
> -syscalls-return-long-2.patch
> 
>  Merged
> 
> -kgdb-cleanup.patch
> 
>  Folded into kgdb.patch
> 
> -proc-sys-debug.patch
> 
>  Lost interest in this.
>  
> -as-debug-BUG-fix.patch
> -as-eject-BUG-fix.patch
> -as-jumbo-fix.patch
> -as-request_fn-in-timer.patch
> -as-remove-request-fix.patch
> -as-np-1.patch
> -as-use-kblockd.patch
> -as-cleanup-2.patch
> -as-as_remove_request-simplification.patch
> -as-dont-go-BUG-again.patch
> -as-handle-non-block-requests.patch
> 
>  Folded into as-iosched.patch
> 
> -cfq-fix.patch
> 
>  Folded into cfq-2.patch
> 
> -objrmap-nonlinear-fixes.patch
> 
>  Folded into objrmap-2.5.62-5.patch
> 
> -anobjrmap-1-rmap_h.patch
> -anobjrmap-2-mapping.patch
> -anobjrmap-3-unchained.patch
> -anobjrmap-4-anonmm.patch
> -anobjrmap-5-rechained.patch
> -anobjrmap-6-arches.patch
> -anobjrmap-ttfb-no-BUG.patch
> 
>  Dropped.  Is currently a bit marginal and overlaps other patches.
> 
> -brlock-1b.patch
> -brlock-removal-2.patch
> -brlock-removal-3.patch
> -brlock-removal-4.patch
> -brlock-removal-5.patch
> 
>  Dropped.  A bit too invasive on the networking layer for this stage in the
>  development cycle.
> 
> -dev_t-remove-B_FREE.patch
> 
>  The files it patches got moved around.  I need to fix this up.
> 
> -smalldevfs.patch
> 
>  This kept on getting broken by devfs changes and is outdated anyway.
> 
> -notsclock-option.patch
> 
>  Obsoleted by x86-clock-override-option.patch
> 
> +sg-dev_t-fix.patch
> +nfsd-32-bit-dev_t-fixes.patch
> 
>  Fixes for 32-bit dev_t.
> 
> +x86-clock-override-option.patch
> 
>  Boot-time setting of the gettimeofday() source for ia32.
> 
> +VM_DONTEXPAND-fix.patch
> 
>  Fix VM_DONTEXPAND for drivers/media/video/video-buf.c
> 
> +i2c-fix.patch
> 
>  Fix an i2c oops
> 
> +ext3_mark_inode_dirty-speedup.patch
> +ext3_mark_inode_dirty-less-calls.patch
> +ext3-handle-cache.patch
> 
>  ext3 speedups
> 
> +ext3-no-bkl.patch
> 
>  Push lock_kernel() down from ext3 into JBD.
> 
> +journal_dirty_metadata-speedup.patch
> +journal_get_write_access-speedup.patch
> 
>  JBD speedups
> 
> +cdevname-irq-safety-fix.patch
> +register_chrdev_region-leak-fix.patch
> 
>  fs/char_dev.c fixes.
> 
> 
> 
> 
> All 74 patches:
> 
> linus.patch
>   Latest from Linus
> 
> mm.patch
>   add -mmN to EXTRAVERSION
> 
> kgdb.patch
> 
> config_spinline.patch
>   uninline spinlocks for profiling accuracy.
> 
> ppc64-reloc_hide.patch
> 
> ppc64-pci-patch.patch
>   Subject: pci patch
> 
> ppc64-aio-32bit-emulation.patch
>   32/64bit emulation for aio
> 
> ppc64-scruffiness.patch
>   Fix some PPC64 compile warnings
> 
> sym-do-160.patch
>   make the SYM driver do 160 MB/sec
> 
> config-PAGE_OFFSET.patch
>   Configurable kenrel/user memory split
> 
> ptrace-flush.patch
>   cache flushing in the ptrace code
> 
> buffer-debug.patch
>   buffer.c debugging
> 
> warn-null-wakeup.patch
> 
> ext3-truncate-ordered-pages.patch
>   ext3: explicitly free truncated pages
> 
> reiserfs_file_write-5.patch
> 
> rcu-stats.patch
>   RCU statistics reporting
> 
> ext3-journalled-data-assertion-fix.patch
>   Remove incorrect assertion from ext3
> 
> nfs-speedup.patch
> 
> nfs-oom-fix.patch
>   nfs oom fix
> 
> sk-allocation.patch
>   Subject: Re: nfs oom
> 
> nfs-more-oom-fix.patch
> 
> rpciod-atomic-allocations.patch
>   Make rcpiod use atomic allocations
> 
> linux-isp.patch
> 
> isp-update-1.patch
> 
> kblockd.patch
>   Create `kblockd' workqueue
> 
> as-iosched.patch
>   anticipatory I/O scheduler
> 
> as-np-reads-1.patch
>   AS: read-vs-read fixes
> 
> as-np-reads-2.patch
>   AS: more read-vs-read fixes
> 
> as-predict-data-direction.patch
>   as: predict direction of next IO
> 
> as-remove-frontmerge.patch
>   AS: remove frontmerge tunable
> 
> as-misc-cleanups.patch
>   AS: misc cleanups
> 
> cfq-2.patch
>   CFQ scheduler, #2
> 
> unplug-use-kblockd.patch
>   Use kblockd for running request queues
> 
> fremap-all-mappings.patch
>   Make all executable mappings be nonlinear
> 
> objrmap-2.5.62-5.patch
>   object-based rmap
> 
> sched-2.5.64-D3.patch
>   sched-2.5.64-D3, more interactivity changes
> 
> scheduler-tunables.patch
>   scheduler tunables
> 
> show_task-free-stack-fix.patch
>   show_task() fix and cleanup
> 
> yellowfin-set_bit-fix.patch
>   yellowfin driver set_bit fix
> 
> htree-nfs-fix.patch
>   Fix ext3 htree / NFS compatibility problems
> 
> task_prio-fix.patch
>   simple task_prio() fix
> 
> slab_store_user-large-objects.patch
>   slab debug: perform redzoning against larger objects
> 
> pcmcia-2.patch
> 
> pcmcia-3b.patch
> 
> pcmcia-3.patch
> 
> pcmcia-4.patch
> 
> pcmcia-5.patch
> 
> pcmcia-6.patch
> 
> pcmcia-7b.patch
> 
> pcmcia-7.patch
> 
> pcmcia-8.patch
> 
> pcmcia-9.patch
> 
> pcmcia-10.patch
> 
> htree-nfs-fix-2.patch
>   htree nfs fix
> 
> ext2-no-lock_super.patch
>   concurrent block allocation for ext2
> 
> ext2-ialloc-no-lock_super.patch
>   concurrent inode allocation for ext2
> 
> linear-oops-fix-1.patch
>   md/linear oops fix
> 
> dev_t-32-bit.patch
>   [for playing only] change type of dev_t
> 
> dev_t-drm-warnings.patch
>   dev_t: fix drm printk warnings
> 
> sg-dev_t-fix.patch
>   32-bit dev_t fix for sg
> 
> nfsd-32-bit-dev_t-fixes.patch
>   nfsd fixes for 32-bit dev_t
> 
> oops-dump-preceding-code.patch
>   i386 oops output: dump preceding code
> 
> x86-clock-override-option.patch
>   x86 clock override boot option
> 
> conntrack-use-after-free-fix.patch
>   fix use-after-free in ip_conntrack
> 
> VM_DONTEXPAND-fix.patch
>   honour VM_DONTEXPAND in vma merging
> 
> i2c-fix.patch
>   Subject: [PATCH] Fix kobject_get oopses triggered by i2c in 2.5.65-bk
> 
> ext3_mark_inode_dirty-speedup.patch
>   ext3_mark_inode_dirty() speedup
> 
> ext3_mark_inode_dirty-less-calls.patch
>   ext3_commit_write speedup
> 
> ext3-handle-cache.patch
>   ext3: create a slab cache for transaction handles
> 
> ext3-no-bkl.patch
> 
> journal_dirty_metadata-speedup.patch
> 
> journal_get_write_access-speedup.patch
> 
> cdevname-irq-safety-fix.patch
>   make cdevname() callable from interrupts
> 
> register_chrdev_region-leak-fix.patch
>   register_chrdev_region() leak and race fix
> 
> 
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
> 
> 


