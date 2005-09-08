Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVIHIyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVIHIyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 04:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVIHIyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 04:54:35 -0400
Received: from odin2.bull.net ([192.90.70.84]:20683 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S932249AbVIHIyf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 04:54:35 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: george@mvista.com
Subject: Re: [patch] KGDB for Real-Time Preemption systems
Date: Thu, 8 Sep 2005 10:57:53 +0200
User-Agent: KMail/1.7.1
References: <20050811110051.GA20872@elte.hu> <200509071055.54016.Serge.Noiraud@bull.net> <431F58C8.70109@mvista.com>
In-Reply-To: <431F58C8.70109@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509081057.54005.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mercredi 7 Septembre 2005 23:16, George Anzinger wrote/a écrit :
> Serge Noiraud wrote:
...
> >
> > I'm trying this kgdb patch with 2.6.13 and I get the following errors.
> > Is there something I forgot ?
>
> This related to kgdb?  I.e. does it go away if you either turn off kgdb
> at configure time or just don't patch with kgdb?  (It sure seems
> unrelated, but...)
I don't get those errors with CONFIG_KGDB=n
bellow I put the diff between a working . config and a non working .config
>
> George
>
> > ...
> >   INSTALL sound/usb/snd-usb-audio.ko
> >   INSTALL sound/usb/snd-usb-lib.ko
> >   INSTALL sound/usb/usx2y/snd-usb-usx2y.ko
> > if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
> > System.map -b /var/tmp/kernel-2.6.13-rt4-root -r 2.6.13-rt4; fi
> > WARNING:
...
If I redo the make command only ( not make rpm ) I obtain the following :
# make
  CHK     include/linux/version.h
make[1]: « arch/i386/kernel/asm-offsets.s » est à jour.
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
Kernel: arch/i386/boot/bzImage is ready  (#1)
  Building modules, stage 2.
  MODPOST
*** Warning: "preempt_locks" [net/sunrpc/sunrpc.ko] undefined!
*** Warning: "preempt_locks" [net/appletalk/appletalk.ko] undefined!
*** Warning: "preempt_locks" [fs/reiserfs/reiserfs.ko] undefined!
*** Warning: "preempt_locks" [fs/ntfs/ntfs.ko] undefined!
*** Warning: "preempt_locks" [fs/nfs/nfs.ko] undefined!
*** Warning: "preempt_locks" [fs/minix/minix.ko] undefined!
*** Warning: "preempt_locks" [fs/jbd/jbd.ko] undefined!
*** Warning: "preempt_locks" [fs/ext3/ext3.ko] undefined!
*** Warning: "preempt_locks" [fs/cifs/cifs.ko] undefined!
*** Warning: "preempt_locks" [fs/affs/affs.ko] undefined!
*** Warning: "preempt_locks" [drivers/scsi/libata.ko] undefined!
*** Warning: "preempt_locks" [drivers/scsi/ide-scsi.ko] undefined!
*** Warning: "preempt_locks" [drivers/scsi/gdth.ko] undefined!
*** Warning: "preempt_locks" [drivers/md/raid6.ko] undefined!
*** Warning: "preempt_locks" [drivers/md/raid5.ko] undefined!
*** Warning: "preempt_locks" [drivers/ide/ide-floppy.ko] undefined!
*** Warning: "preempt_locks" [drivers/block/pktcdvd.ko] undefined!
*** Warning: "preempt_locks" [drivers/block/loop.ko] undefined!
#

If I apply the following patch to my .config, I get the errors :
I tried with and without LTT. I get the same problem.

--- .config.orig    2005-08-01 10:29:22.740759504 +0200
+++ .config_dbg 2005-08-01 10:40:30.534239464 +0200
@@ -35,15 +35,16 @@
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
 CONFIG_EMBEDDED=y
-# CONFIG_KALLSYMS is not set
-# CONFIG_KALLSYMS_ALL is not set
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_LTT=y
 CONFIG_SHMEM=y
 CONFIG_CC_ALIGN_FUNCTIONS=0
 CONFIG_CC_ALIGN_LABELS=0
@@ -283,7 +284,7 @@
 CONFIG_PCI_MSI=y
 CONFIG_PCI_LEGACY_PROC=y
 # CONFIG_PCI_NAMES is not set
-# CONFIG_PCI_DEBUG is not set
+CONFIG_PCI_DEBUG=y
 CONFIG_ISA_DMA_API=y
 CONFIG_ISA=y
 # CONFIG_EISA is not set
@@ -329,7 +330,7 @@
 # CONFIG_STANDALONE is not set
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=m
-# CONFIG_DEBUG_DRIVER is not set
+CONFIG_DEBUG_DRIVER=y
 CONFIG_NET=y

 #
@@ -2780,7 +2781,10 @@
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-# CONFIG_RELAYFS_FS is not set
+CONFIG_RELAYFS_FS=y
+CONFIG_KLOG_CHANNEL=y
+CONFIG_KLOG_CHANNEL_AUTOENABLE=y
+CONFIG_KLOG_CHANNEL_SHIFT=21
 CONFIG_SUPERMOUNT=m
 # CONFIG_SUPERMOUNT_DEBUG is not set

@@ -2930,36 +2931,38 @@
 #
 # Kernel hacking
 #
-# CONFIG_PRINTK_TIME is not set
-# CONFIG_PRINTK_IGNORE_LOGLEVEL is not set 
-# CONFIG_DEBUG_KERNEL is not set
+CONFIG_PRINTK_TIME=y
+CONFIG_PRINTK_IGNORE_LOGLEVEL=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOG_BUF_SHIFT=17
 CONFIG_DETECT_SOFTLOCKUP=y
-# CONFIG_SCHEDSTATS is not set
-# CONFIG_DEBUG_SLAB is not set
-CONFIG_DEBUG_PREEMPT=n
-CONFIG_DEBUG_IRQ_FLAGS=n
+CONFIG_SCHEDSTATS=y
+CONFIG_DEBUG_SLAB=y
+CONFIG_DEBUG_PREEMPT=y
+CONFIG_DEBUG_IRQ_FLAGS=y
 CONFIG_WAKEUP_TIMING=y
-CONFIG_WAKEUP_LATENCY_HIST=n
+CONFIG_WAKEUP_LATENCY_HIST=y
 CONFIG_PREEMPT_TRACE=y
-CONFIG_CRITICAL_PREEMPT_TIMING=n  
-CONFIG_CRITICAL_IRQSOFF_TIMING=n   
+CONFIG_CRITICAL_PREEMPT_TIMING=y   
+CONFIG_PREEMPT_OFF_HIST=y
+CONFIG_CRITICAL_IRQSOFF_TIMING=y   
+CONFIG_INTERRUPT_OFF_HIST=y
 CONFIG_CRITICAL_TIMING=y
 CONFIG_LATENCY_TIMING=y
-# CONFIG_LATENCY_TRACE is not set
-# CONFIG_RT_DEADLOCK_DETECT is not set
-# CONFIG_DEBUG_RT_LOCKING_MODE is not set
-# CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_HIGHMEM is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_DEBUG_INFO is not set
-# CONFIG_DEBUG_FS is not set
-# CONFIG_USE_FRAME_POINTER is not set
-# CONFIG_EARLY_PRINTK is not set
-# CONFIG_DEBUG_STACKOVERFLOW is not set
+CONFIG_LATENCY_TRACE=y
+CONFIG_RT_DEADLOCK_DETECT=y
+CONFIG_DEBUG_RT_LOCKING_MODE=y
+CONFIG_DEBUG_KOBJECT=y
+CONFIG_DEBUG_HIGHMEM=y
+CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_FS=y
+CONFIG_USE_FRAME_POINTER=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_KPROBES is not set
-# CONFIG_DEBUG_STACK_USAGE is not set
+CONFIG_DEBUG_STACK_USAGE=y

 #
 # Page alloc debug is incompatible with Software Suspend on i386
@@ -2967,7 +2968,27 @@
 # CONFIG_4KSTACKS is not set
 CONFIG_X86_FIND_SMP_CONFIG=y
 CONFIG_X86_MPPARSE=y
-# CONFIG_KGDB is not set
+CONFIG_KGDB=y
+CONFIG_KGDB_9600BAUD=y
+# CONFIG_KGDB_19200BAUD is not set
+# CONFIG_KGDB_38400BAUD is not set
+# CONFIG_KGDB_57600BAUD is not set
+# CONFIG_KGDB_115200BAUD is not set
+CONFIG_KGDB_PORT=0x3f8
+CONFIG_KGDB_IRQ=4
+CONFIG_KGDB_MORE=y
+CONFIG_KGDB_OPTIONS="-O1"
+CONFIG_NO_KGDB_CPUS=8
+CONFIG_KGDB_TS=y
+# CONFIG_KGDB_TS_64 is not set
+CONFIG_KGDB_TS_128=y
+# CONFIG_KGDB_TS_256 is not set
+# CONFIG_KGDB_TS_512 is not set
+# CONFIG_KGDB_TS_1024 is not set
+CONFIG_STACK_OVERFLOW_TEST=y
+CONFIG_TRAP_BAD_SYSCALL_EXITS=y
+CONFIG_KGDB_CONSOLE=y
+CONFIG_KGDB_SYSRQ=y

 #

