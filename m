Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTEBIsj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 04:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTEBIsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 04:48:39 -0400
Received: from [12.47.58.20] ([12.47.58.20]:50243 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261974AbTEBIs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 04:48:29 -0400
Date: Fri, 2 May 2003 02:01:49 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.68-mm4
Message-Id: <20030502020149.1ec3e54f.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2003 09:00:46.0448 (UTC) FILETIME=[51BE0F00:01C31089]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.68/2.5.68-mm4/

. Much reworking of the disk IO scheduler patches due to the updated
  dynamic-disk-request-allocation patch.  No real functional changes here.

. Included the `kexec' patch - load Linux from Linux.  Various people want
  this for various reasons.  I like the idea of going from a login prompt to
  "Calibrating delay loop" in 0.5 seconds.

  I tried it on four machines and it worked with small glitches on three of
  them, and wedged up the fourth.  So if it is to proceed this code needs
  help with testing and careful bug reporting please.

  There's a femto-HOWTO in the patch itself, reproduced here:



- enable kexec in config, build, install.

- grab kexec-tools from

	http://www.osdl.org/archive/andyp/kexec/2.5.68/

  - edit ./kexec/kexec-syscall.c and make sure __NR_kexec_load is set
    to 269 (-mm kernels have an additional syscall)

  - run `make distclean' and `make'

- I use this script:

#!/bin/sh

usage()
{
	echo "Usage: do-kexec.sh /boot/bzImage [commandline options]"
	exit 1
}

if [ $# -lt 1 ]
then
	usage
fi

sync
IMAGE=$1
shift
./objdir/build/sbin/kexec -l $IMAGE --command-line="$(cat /proc/cmdline) $*"
./objdir/build/sbin/kexec -e


  invoked as

	cd /usr/src/kexec-tools
	./do-kexec.sh /boot/bzImage-2.5.68

  This is fairly crude - it's an instant reboot, no shutdown or anything. 
  Only do this if you're using journalled filesystems!




Changes since 2.5.68-mm3:


 linus.patch

 Latest BK drop

-irqreturn-i2c.patch
-irqreturn-sound-2.patch
-irqreturn-smcc.patch
-SLAB_NO_GROW-fix.patch
-irqreturn-bttv.patch
-apm-locking-fix.patch
-xd-warning-fix.patch
-DAC960-interface-fixes.patch
-alt_instr-__KERNEL__.patch
-modular-jbd.patch
-hdlc-module-update.patch
-proc_file_read-fix.patch
-disk_name-size-check.patch
-cleanups.patch
-mwave-cleanup.patch
-ext3-ro-mount-fix.patch
-nr_threads-docco-fix.patch
-lost-tick-HZ-fix.patch
-nr_inactive-race-fix.patch
-blockdev-aio-support.patch
-percpu-counters-fix.patch
-config-menu-aesthetics.patch
-oom-kill-locking.patch
-restore-modinfo-section.patch
-implement-__module_get.patch

 Merged

+compat-ioctl-fix.patch

 Fix 32-bit ioctl fallback

+generic-subarch-missing-bit.patch

 Some ofthe generic subarch patch got lost

+config-PAGE_OFFSET-025G.patch

 Allow really small amounts of lowmem.

+dont-set-kernel-pgd-on-PAE.patch

 little ia32 optimisation/cleanup

+shrink_slab-accounting.patch

 Teach page reclaim to notice success due to slab shrinkage

-dynamic-request-allocation.patch
-dynamic-request-allocation-fix.patch
+rq-dyn-works.patch

 latest dynamic disk request allocation patch

+as-iosched-dyn.patch

 Update as-iosched for dynamic request allocation

+cfq-iosched-dyn.patch

 Update cfq-iosched for dynamic request allocation

+security_d_instantiate-movement.patch
+ext3-security-xattr.patch
+ext2-security-xattr.patch

 Security stuff

+pcmcia-fix.patch

 Compile fix for the pcmcia fix.

+kexec.patch

 kexec.




All 99 patches

linus.patch

mm.patch
  add -mmN to EXTRAVERSION

compat-ioctl-fix.patch
  Fix NULL handler for compat_ioctl

generic-subarch.patch
  generic subarchitecture for ia32

generic-subarch-fix.patch
  generic subarch: SMP only

generic-subarch-missing-bit.patch
  generic subarch: missing chunk

ipmi-warning-fixes.patch

irqreturn-uml.patch
  UML updates for the new IRQ API

irqreturn-aic79xx.patch
  Fix aic79xx for new IRQ API

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-ga-ppc64-fix.patch

irqreturn-kgdb-ga.patch

irqreturn-drivers-net.patch

kgdb-ga-smp_num_cpus.patch

kgdb-ga-discontigmem-fixup.patch
  kgdb: discontigmem fixup

slab-magazine-layer.patch
  magazine layer for slab

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

ppc64-irqfixes.patch

ppc64-pci-bogons.patch

sym-do-160.patch
  make the SYM driver do 160 MB/sec

misc.patch
  misc fixes

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

config-PAGE_OFFSET-025G.patch
  3.75G config option

fat-speedup.patch
  fat cluster search speedup

buffer-debug.patch
  buffer.c debugging

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

VM_RESERVED-check.patch
  VM_RESERVED check

semop-race-fix.patch
  semtimedop(): Fix racy BUG check

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

dcache_lock-vs-tasklist_lock-take-2.patch
  Fix dcache_lock/tasklist_lock ranking bug

clone-retval-fix.patch
  copy_process return value fix

de_thread-fix.patch
  de_thread memory corruption fix

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

386-access_ok-race-fix.patch
  access_ok() race fix for 80386.

synaptics-mouse-support.patch
  Add Synaptics touchpad tweaking to psmouse driver

swapfile-hold-i_sem.patch
  hold i_sem on swapfiles

dont-set-kernel-pgd-on-PAE.patch
  remove unnecessary PAE pgd set

shrink_slab-accounting.patch
  account for slab reclaim in try_to_free_pages()

rq-dyn-works.patch
  rq-dyn, dynamic request allocation

kblockd.patch
  Create `kblockd' workqueue

cfq-infrastructure.patch

elevator-completion-api.patch
  elevator completion API

as-iosched.patch
  anticipatory I/O scheduler

as-use-completion.patch
  AS use completion notifier

as-remove-debug-checks.patch
  AS: remove debug checks

as-iosched-dyn.patch
  AS: update to dynamic request allocation API

unplug-use-kblockd.patch
  Use kblockd for running request queues

cfq-2.patch
  CFQ scheduler, #2

cfq-iosched-dyn.patch
  CFQ: update to rq-dyn API

unmap-page-debugging.patch
  unmap unused pages for debugging

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

sched-2.5.68-B2.patch
  HT scheduler, sched-2.5.68-B2

sched_idle-typo-fix.patch
  fix sched_idle typo

kgdb-ga-idle-fix.patch

sched-2.5.64-D3.patch
  sched-2.5.64-D3, more interactivity changes

show_task-free-stack-fix.patch
  show_task() fix and cleanup

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

i8042-share-irqs.patch
  allow i8042 interrupt sharing

select-speedup.patch
  Subject: Re: IA64 changes to fs/select.c

select-speedup-fix.patch
  select() sleedup fix

slab_store_user-large-objects.patch
  slab debug: perform redzoning against larger objects

htree-nfs-fix-2.patch
  htree nfs fix

htree-leak-fix.patch
  ext3: htree memory leak fix

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

security_d_instantiate-movement.patch
  Move security_d_instantiate hook calls

ext3-security-xattr.patch
  ext3 xattr handler for security modules

ext2-security-xattr.patch
  ext2 xattr handler for security modules

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

pcmcia-deadlock-fix-2.patch
  Fix PCMCIA deadlock (rev. 2)

pcmcia-fix.patch

kexec.patch
  kexec



