Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282784AbRLLFbx>; Wed, 12 Dec 2001 00:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282781AbRLLFbo>; Wed, 12 Dec 2001 00:31:44 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:22024 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S282784AbRLLFbf>; Wed, 12 Dec 2001 00:31:35 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Subject: [PATCH] 2.5.1-pre10 #ifdef CONFIG_KMOD Cleanup Part I.
Date: Wed, 12 Dec 2001 16:32:30 +1100
Message-Id: <E16E20M-0003bz-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

As everyone knows, you don't need #ifdef CONFIG_KMOD around #include
<linux/kmod.h>.  (In fact, #ifdefs around #includes irritate me).  So
here is the cleanup patch...

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/arch/s390x/kernel/exec32.c tmp/arch/s390x/kernel/exec32.c
--- linux-2.4.13-ac8/arch/s390x/kernel/exec32.c	Thu Apr 12 12:02:29 2001
+++ tmp/arch/s390x/kernel/exec32.c	Thu Nov 22 13:59:16 2001
@@ -22,14 +22,11 @@
 #include <linux/spinlock.h>
 #define __NO_VERSION__
 #include <linux/module.h>
+#include <linux/kmod.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
-
-#ifdef CONFIG_KMOD
-#include <linux/kmod.h>
-#endif
 
 
 extern void put_dirty_page(struct task_struct * tsk, struct page *page, unsigned long address);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/arch/sparc64/kernel/traps.c tmp/arch/sparc64/kernel/traps.c
--- linux-2.4.13-ac8/arch/sparc64/kernel/traps.c	Tue Oct  2 02:19:56 2001
+++ tmp/arch/sparc64/kernel/traps.c	Thu Nov 22 13:59:16 2001
@@ -32,9 +32,7 @@
 #include <asm/chafsr.h>
 #include <asm/psrcompat.h>
 #include <asm/processor.h>
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#endif
 
 void bad_trap (struct pt_regs *regs, long lvl)
 {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/drivers/char/ftape/zftape/zftape-init.c tmp/drivers/char/ftape/zftape/zftape-init.c
--- linux-2.4.13-ac8/drivers/char/ftape/zftape/zftape-init.c	Fri Sep 14 08:21:32 2001
+++ tmp/drivers/char/ftape/zftape/zftape-init.c	Thu Nov 22 13:59:16 2001
@@ -30,9 +30,7 @@
 #include <linux/signal.h>
 #include <linux/major.h>
 #include <linux/slab.h>
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#endif
 #include <linux/fcntl.h>
 #include <linux/wrapper.h>
 #include <linux/smp_lock.h>
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/drivers/ide/ide.c tmp/drivers/ide/ide.c
--- linux-2.4.13-ac8/drivers/ide/ide.c	Thu Nov 15 21:47:23 2001
+++ tmp/drivers/ide/ide.c	Thu Nov 22 14:00:03 2001
@@ -159,9 +159,7 @@
 
 #include "ide_modes.h"
 
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#endif /* CONFIG_KMOD */
 
 #ifdef CONFIG_IDE_TASKFILE_IO
 #  define __TASKFILE__IO
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/drivers/md/md.c tmp/drivers/md/md.c
--- linux-2.4.13-ac8/drivers/md/md.c	Thu Nov 15 21:47:23 2001
+++ tmp/drivers/md/md.c	Thu Nov 22 13:59:16 2001
@@ -36,10 +36,7 @@
 #include <linux/devfs_fs_kernel.h>
 
 #include <linux/init.h>
-
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#endif
 
 #define __KERNEL_SYSCALLS__
 #include <linux/unistd.h>
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/drivers/media/video/cpia.c tmp/drivers/media/video/cpia.c
--- linux-2.4.13-ac8/drivers/media/video/cpia.c	Thu Nov 15 21:47:23 2001
+++ tmp/drivers/media/video/cpia.c	Thu Nov 22 13:59:16 2001
@@ -38,10 +38,7 @@
 #include <asm/io.h>
 #include <asm/semaphore.h>
 #include <linux/wrapper.h>
-
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#endif
 
 #include "cpia.h"
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/drivers/mtd/nftlcore.c tmp/drivers/mtd/nftlcore.c
--- linux-2.4.13-ac8/drivers/mtd/nftlcore.c	Tue Oct 16 06:27:52 2001
+++ tmp/drivers/mtd/nftlcore.c	Thu Nov 22 13:59:16 2001
@@ -24,10 +24,8 @@
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/blkpg.h>
-
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#endif
+
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nftl.h>
 #include <linux/mtd/compatmac.h>
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/drivers/net/wan/comx.c tmp/drivers/net/wan/comx.c
--- linux-2.4.13-ac8/drivers/net/wan/comx.c	Fri Sep 14 09:04:43 2001
+++ tmp/drivers/net/wan/comx.c	Thu Nov 22 13:59:16 2001
@@ -64,10 +64,7 @@
 #include <asm/uaccess.h>
 #include <linux/ctype.h>
 #include <linux/init.h>
-
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#endif
 
 #ifndef CONFIG_PROC_FS
 #error For now, COMX really needs the /proc filesystem
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/drivers/scsi/fcal.c tmp/drivers/scsi/fcal.c
--- linux-2.4.13-ac8/drivers/scsi/fcal.c	Sat Feb 10 06:30:23 2001
+++ tmp/drivers/scsi/fcal.c	Thu Nov 22 13:59:16 2001
@@ -14,9 +14,7 @@
 #include <linux/stat.h>
 #include <linux/init.h>
 #include <linux/config.h>
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#endif
 
 #include <asm/irq.h>
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/drivers/scsi/pluto.c tmp/drivers/scsi/pluto.c
--- linux-2.4.13-ac8/drivers/scsi/pluto.c	Sat Feb 10 06:30:23 2001
+++ tmp/drivers/scsi/pluto.c	Thu Nov 22 13:59:16 2001
@@ -14,9 +14,7 @@
 #include <linux/stat.h>
 #include <linux/init.h>
 #include <linux/config.h>
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#endif
 
 #include <asm/irq.h>
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/drivers/scsi/scsi.c tmp/drivers/scsi/scsi.c
--- linux-2.4.13-ac8/drivers/scsi/scsi.c	Thu Nov 15 21:47:28 2001
+++ tmp/drivers/scsi/scsi.c	Thu Nov 22 13:59:16 2001
@@ -55,6 +55,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
+#include <linux/kmod.h>
 
 #define __KERNEL_SYSCALLS__
 
@@ -70,9 +71,6 @@
 #include "hosts.h"
 #include "constants.h"
 
-#ifdef CONFIG_KMOD
-#include <linux/kmod.h>
-#endif
 
 #undef USE_STATIC_SCSI_MEMORY
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/drivers/scsi/scsi_dma.c tmp/drivers/scsi/scsi_dma.c
--- linux-2.4.13-ac8/drivers/scsi/scsi_dma.c	Wed Sep  6 08:08:55 2000
+++ tmp/drivers/scsi/scsi_dma.c	Thu Nov 22 13:59:16 2001
@@ -9,15 +9,11 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/blk.h>
-
+#include <linux/kmod.h>
 
 #include "scsi.h"
 #include "hosts.h"
 #include "constants.h"
-
-#ifdef CONFIG_KMOD
-#include <linux/kmod.h>
-#endif
 
 /*
  * PAGE_SIZE must be a multiple of the sector size (512).  True
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/drivers/scsi/scsi_scan.c tmp/drivers/scsi/scsi_scan.c
--- linux-2.4.13-ac8/drivers/scsi/scsi_scan.c	Fri Oct 12 02:43:30 2001
+++ tmp/drivers/scsi/scsi_scan.c	Thu Nov 22 13:59:16 2001
@@ -12,6 +12,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/kmod.h>
 
 #include <linux/blk.h>
 
@@ -19,9 +20,6 @@
 #include "hosts.h"
 #include "constants.h"
 
-#ifdef CONFIG_KMOD
-#include <linux/kmod.h>
-#endif
 
 /* The following devices are known not to tolerate a lun != 0 scan for
  * one reason or another.  Some will respond to all luns, others will
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/drivers/video/fbmem.c tmp/drivers/video/fbmem.c
--- linux-2.4.13-ac8/drivers/video/fbmem.c	Thu Nov 15 21:47:31 2001
+++ tmp/drivers/video/fbmem.c	Thu Nov 22 13:59:16 2001
@@ -26,9 +26,7 @@
 #include <linux/console.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#endif
 #include <linux/devfs_fs_kernel.h>
 
 #if defined(__mc68000__) || defined(CONFIG_APUS)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/fs/exec.c tmp/fs/exec.c
--- linux-2.4.13-ac8/fs/exec.c	Thu Nov 15 21:47:33 2001
+++ tmp/fs/exec.c	Thu Nov 22 13:59:17 2001
@@ -37,14 +37,12 @@
 #include <linux/personality.h>
 #define __NO_VERSION__
 #include <linux/module.h>
+#include <linux/kmod.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 
-#ifdef CONFIG_KMOD
-#include <linux/kmod.h>
-#endif
 
 int core_uses_pid;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/fs/fat/cvf.c tmp/fs/fat/cvf.c
--- linux-2.4.13-ac8/fs/fat/cvf.c	Wed Jul 25 07:23:53 2001
+++ tmp/fs/fat/cvf.c	Thu Nov 22 13:59:17 2001
@@ -15,9 +15,7 @@
 #include<linux/string.h>
 #include<linux/fat_cvf.h>
 #include<linux/config.h>
-#ifdef CONFIG_KMOD
 #include<linux/kmod.h>
-#endif
 
 #define MAX_CVF_FORMATS 3
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/fs/nls/nls_base.c tmp/fs/nls/nls_base.c
--- linux-2.4.13-ac8/fs/nls/nls_base.c	Sat Feb 10 06:29:44 2001
+++ tmp/fs/nls/nls_base.c	Thu Nov 22 13:59:17 2001
@@ -15,9 +15,7 @@
 #include <linux/nls.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#endif
 #include <linux/spinlock.h>
 
 static struct nls_table *tables;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/kernel/ksyms.c tmp/kernel/ksyms.c
--- linux-2.4.13-ac8/kernel/ksyms.c	Thu Nov 15 21:47:41 2001
+++ tmp/kernel/ksyms.c	Thu Nov 22 13:59:17 2001
@@ -53,9 +53,7 @@
 #if defined(CONFIG_PROC_FS)
 #include <linux/proc_fs.h>
 #endif
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#endif
 
 extern void set_device_ro(kdev_t dev,int flag);
 extern void *sys_call_table;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/net/bluetooth/af_bluetooth.c tmp/net/bluetooth/af_bluetooth.c
--- linux-2.4.13-ac8/net/bluetooth/af_bluetooth.c	Sat Sep  8 02:28:38 2001
+++ tmp/net/bluetooth/af_bluetooth.c	Thu Nov 22 13:59:17 2001
@@ -41,11 +41,8 @@
 #include <linux/skbuff.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
-#include <net/sock.h>
-
-#if defined(CONFIG_KMOD)
 #include <linux/kmod.h>
-#endif
+#include <net/sock.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/bluez.h>
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/net/ipv4/af_inet.c tmp/net/ipv4/af_inet.c
--- linux-2.4.13-ac8/net/ipv4/af_inet.c	Wed Aug  8 01:30:50 2001
+++ tmp/net/ipv4/af_inet.c	Thu Nov 22 13:59:17 2001
@@ -107,9 +107,7 @@
 #include <linux/mroute.h>
 #endif
 #include <linux/if_bridge.h>
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#endif
 #ifdef CONFIG_NET_DIVERT
 #include <linux/divert.h>
 #endif /* CONFIG_NET_DIVERT */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-ac8/net/socket.c tmp/net/socket.c
--- linux-2.4.13-ac8/net/socket.c	Thu Oct 18 07:38:28 2001
+++ tmp/net/socket.c	Thu Nov 22 13:59:17 2001
@@ -72,10 +72,7 @@
 #include <linux/cache.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
-
-#if defined(CONFIG_KMOD) && defined(CONFIG_NET)
 #include <linux/kmod.h>
-#endif
 
 #include <asm/uaccess.h>
 
