Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269518AbUIROiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269518AbUIROiy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 10:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUIROix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 10:38:53 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:57228 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S269532AbUIROfQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 10:35:16 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] add missing linux/syscalls.h includes
Date: Sat, 18 Sep 2004 16:34:31 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409181634.43422.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found that the prototypes for sys_waitid and sys_fcntl in
<linux/syscalls.h> don't match the implementation. In order
to keep all prototypes in sync in the future, now include the
header from each file implementing any syscall.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

--- 1.4/drivers/pci/syscall.c	Sat May 29 11:12:56 2004
+++ edited/drivers/pci/syscall.c	Sat Sep 18 16:17:30 2004
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/pci.h>
 #include <linux/smp_lock.h>
+#include <linux/syscalls.h>
 #include <asm/uaccess.h>
 
 
===== fs/aio.c 1.58 vs edited =====
--- 1.58/fs/aio.c	Wed Aug 25 19:38:30 2004
+++ edited/fs/aio.c	Sat Sep 18 15:40:11 2004
@@ -14,6 +14,7 @@
 #include <linux/time.h>
 #include <linux/aio_abi.h>
 #include <linux/module.h>
+#include <linux/syscalls.h>
 
 #define DEBUG 0
 
===== fs/buffer.c 1.257 vs edited =====
--- 1.257/fs/buffer.c	Thu Sep  9 12:53:17 2004
+++ edited/fs/buffer.c	Sat Sep 18 15:40:43 2004
@@ -20,6 +20,7 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
+#include <linux/syscalls.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/percpu.h>
===== fs/dcache.c 1.91 vs edited =====
--- 1.91/fs/dcache.c	Fri Aug 27 08:31:38 2004
+++ edited/fs/dcache.c	Sat Sep 18 15:40:48 2004
@@ -15,6 +15,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/syscalls.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
===== fs/dcookies.c 1.7 vs edited =====
--- 1.7/fs/dcookies.c	Wed Jun 30 17:39:43 2004
+++ edited/fs/dcookies.c	Sat Sep 18 15:40:51 2004
@@ -13,6 +13,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/syscalls.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/list.h>
===== fs/fcntl.c 1.40 vs edited =====
--- 1.40/fs/fcntl.c	Thu Sep  2 11:48:03 2004
+++ edited/fs/fcntl.c	Sat Sep 18 15:50:51 2004
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/syscalls.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
@@ -362,7 +363,7 @@
 	return err;
 }
 
-asmlinkage long sys_fcntl(int fd, unsigned int cmd, unsigned long arg)
+asmlinkage long sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {	
 	struct file *filp;
 	long err = -EBADF;
===== fs/filesystems.c 1.18 vs edited =====
--- 1.18/fs/filesystems.c	Wed Oct  8 03:52:02 2003
+++ edited/fs/filesystems.c	Sat Sep 18 15:41:04 2004
@@ -6,6 +6,7 @@
  *  table of configured filesystems
  */
 
+#include <linux/syscalls.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
===== fs/ioctl.c 1.13 vs edited =====
--- 1.13/fs/ioctl.c	Mon Jun 21 03:23:42 2004
+++ edited/fs/ioctl.c	Sat Sep 18 15:41:13 2004
@@ -5,6 +5,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/syscalls.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/file.h>
===== fs/locks.c 1.61 vs edited =====
--- 1.61/fs/locks.c	Wed Sep  8 08:33:00 2004
+++ edited/fs/locks.c	Sat Sep 18 15:41:23 2004
@@ -122,6 +122,7 @@
 #include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
+#include <linux/syscalls.h>
 #include <linux/time.h>
 
 #include <asm/semaphore.h>
===== fs/namei.c 1.107 vs edited =====
--- 1.107/fs/namei.c	Wed Sep  1 01:00:48 2004
+++ edited/fs/namei.c	Sat Sep 18 15:41:47 2004
@@ -25,6 +25,7 @@
 #include <linux/smp_lock.h>
 #include <linux/personality.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 #include <linux/mount.h>
 #include <linux/audit.h>
 #include <asm/namei.h>
===== fs/namespace.c 1.65 vs edited =====
--- 1.65/fs/namespace.c	Fri Aug 27 08:42:56 2004
+++ edited/fs/namespace.c	Sat Sep 18 15:41:55 2004
@@ -9,6 +9,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/syscalls.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
===== fs/nfsctl.c 1.9 vs edited =====
--- 1.9/fs/nfsctl.c	Mon Jun 28 23:25:04 2004
+++ edited/fs/nfsctl.c	Sat Sep 18 15:41:59 2004
@@ -13,6 +13,7 @@
 #include <linux/linkage.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
+#include <linux/syscalls.h>
 #include <asm/uaccess.h>
 
 /*
===== fs/open.c 1.68 vs edited =====
--- 1.68/fs/open.c	Sun Aug  8 03:54:13 2004
+++ edited/fs/open.c	Sat Sep 18 15:42:04 2004
@@ -22,6 +22,7 @@
 #include <asm/uaccess.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/syscalls.h>
 
 #include <asm/unistd.h>
 
===== fs/quota.c 1.18 vs edited =====
--- 1.18/fs/quota.c	Thu Jun 24 10:56:07 2004
+++ edited/fs/quota.c	Sat Sep 18 15:42:08 2004
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 
 /* Check validity of quotactl */
 static int check_quotactl_valid(struct super_block *sb, int type, int cmd, qid_t id)
===== fs/read_write.c 1.44 vs edited =====
--- 1.44/fs/read_write.c	Tue Aug 10 02:28:36 2004
+++ edited/fs/read_write.c	Sat Sep 18 15:42:12 2004
@@ -13,6 +13,7 @@
 #include <linux/dnotify.h>
 #include <linux/security.h>
 #include <linux/module.h>
+#include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
===== fs/readdir.c 1.29 vs edited =====
--- 1.29/fs/readdir.c	Sat May 29 20:22:23 2004
+++ edited/fs/readdir.c	Sat Sep 18 15:42:16 2004
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/dirent.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 #include <linux/unistd.h>
 
 #include <asm/uaccess.h>
===== fs/select.c 1.23 vs edited =====
--- 1.23/fs/select.c	Fri Aug 27 09:02:39 2004
+++ edited/fs/select.c	Sat Sep 18 15:42:20 2004
@@ -14,6 +14,7 @@
  *     of fds to overcome nfds < 16390 descriptors limit (Tigran Aivazian).
  */
 
+#include <linux/syscalls.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
===== fs/stat.c 1.34 vs edited =====
--- 1.34/fs/stat.c	Tue Jun 15 02:40:21 2004
+++ edited/fs/stat.c	Sat Sep 18 15:42:27 2004
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
===== fs/super.c 1.122 vs edited =====
--- 1.122/fs/super.c	Sun Jul 11 11:23:26 2004
+++ edited/fs/super.c	Sat Sep 18 15:42:33 2004
@@ -32,6 +32,7 @@
 #include <linux/buffer_head.h>		/* for fsync_super() */
 #include <linux/mount.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 #include <linux/vfs.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <linux/idr.h>
===== fs/xattr.c 1.18 vs edited =====
--- 1.18/fs/xattr.c	Mon Feb  9 16:09:06 2004
+++ edited/fs/xattr.c	Sat Sep 18 15:42:37 2004
@@ -13,6 +13,7 @@
 #include <linux/xattr.h>
 #include <linux/namei.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 #include <asm/uaccess.h>
 
 /*
===== include/linux/syscalls.h 1.11 vs edited =====
--- 1.11/include/linux/syscalls.h	Tue Aug 31 10:00:22 2004
+++ edited/include/linux/syscalls.h	Sat Sep 18 10:43:36 2004
@@ -163,7 +163,8 @@
 asmlinkage long sys_wait4(pid_t pid, unsigned int __user *stat_addr,
 				int options, struct rusage __user *ru);
 asmlinkage long sys_waitid(int which, pid_t pid,
-			   	struct siginfo __user *infop, int options);
+				struct siginfo __user *infop, int options,
+				struct rusage __user *ru);
 asmlinkage long sys_waitpid(pid_t pid, unsigned int __user *stat_addr, int options);
 asmlinkage long sys_set_tid_address(int __user *tidptr);
 asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
===== init/do_mounts_devfs.c 1.6 vs edited =====
--- 1.6/init/do_mounts_devfs.c	Sun Mar 14 02:57:41 2004
+++ edited/init/do_mounts_devfs.c	Sat Sep 18 15:46:44 2004
@@ -2,7 +2,6 @@
 #include <linux/kernel.h>
 #include <linux/dirent.h>
 #include <linux/string.h>
-#include <linux/syscalls.h>
 
 #include "do_mounts.h"
 
===== ipc/mqueue.c 1.17 vs edited =====
--- 1.17/ipc/mqueue.c	Mon Aug 23 10:15:23 2004
+++ edited/ipc/mqueue.c	Sat Sep 18 15:43:34 2004
@@ -22,6 +22,7 @@
 #include <linux/msg.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <linux/syscalls.h>
 #include <net/sock.h>
 #include "util.h"
 
===== ipc/msg.c 1.22 vs edited =====
--- 1.22/ipc/msg.c	Mon Aug 23 10:14:51 2004
+++ edited/ipc/msg.c	Sat Sep 18 15:43:38 2004
@@ -24,6 +24,7 @@
 #include <linux/list.h>
 #include <linux/security.h>
 #include <linux/sched.h>
+#include <linux/syscalls.h>
 #include <asm/current.h>
 #include <asm/uaccess.h>
 #include "util.h"
===== ipc/sem.c 1.33 vs edited =====
--- 1.33/ipc/sem.c	Mon Aug 23 10:14:50 2004
+++ edited/ipc/sem.c	Sat Sep 18 15:43:42 2004
@@ -71,6 +71,7 @@
 #include <linux/time.h>
 #include <linux/smp_lock.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 #include <asm/uaccess.h>
 #include "util.h"
 
===== ipc/shm.c 1.41 vs edited =====
--- 1.41/ipc/shm.c	Tue Aug 24 11:08:44 2004
+++ edited/ipc/shm.c	Sat Sep 18 15:43:45 2004
@@ -26,6 +26,7 @@
 #include <linux/proc_fs.h>
 #include <linux/shmem_fs.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 #include <asm/uaccess.h>
 
 #include "util.h"
===== kernel/acct.c 1.34 vs edited =====
--- 1.34/kernel/acct.c	Mon Aug  2 10:00:40 2004
+++ edited/kernel/acct.c	Sat Sep 18 15:43:50 2004
@@ -53,6 +53,7 @@
 #include <linux/vfs.h>
 #include <linux/jiffies.h>
 #include <linux/times.h>
+#include <linux/syscalls.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <linux/blkdev.h> /* sector_div */
===== kernel/capability.c 1.12 vs edited =====
--- 1.12/kernel/capability.c	Thu Sep  2 11:48:04 2004
+++ edited/kernel/capability.c	Sat Sep 18 15:44:05 2004
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 #include <asm/uaccess.h>
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
===== kernel/exec_domain.c 1.17 vs edited =====
--- 1.17/kernel/exec_domain.c	Wed Sep  8 08:33:01 2004
+++ edited/kernel/exec_domain.c	Sat Sep 18 15:44:14 2004
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/personality.h>
 #include <linux/sched.h>
+#include <linux/syscalls.h>
 #include <linux/sysctl.h>
 #include <linux/types.h>
 
===== kernel/exit.c 1.154 vs edited =====
--- 1.154/kernel/exit.c	Wed Sep 15 10:25:50 2004
+++ edited/kernel/exit.c	Sat Sep 18 15:44:22 2004
@@ -24,6 +24,7 @@
 #include <linux/mount.h>
 #include <linux/proc_fs.h>
 #include <linux/mempolicy.h>
+#include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
===== kernel/itimer.c 1.6 vs edited =====
--- 1.6/kernel/itimer.c	Tue Jun 29 23:35:35 2004
+++ edited/kernel/itimer.c	Sat Sep 18 15:44:32 2004
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
+#include <linux/syscalls.h>
 #include <linux/time.h>
 
 #include <asm/uaccess.h>
===== kernel/panic.c 1.16 vs edited =====
--- 1.16/kernel/panic.c	Mon Aug 23 10:14:57 2004
+++ edited/kernel/panic.c	Sat Sep 18 15:53:07 2004
@@ -16,7 +16,6 @@
 #include <linux/notifier.h>
 #include <linux/init.h>
 #include <linux/sysrq.h>
-#include <linux/syscalls.h>
 #include <linux/interrupt.h>
 #include <linux/nmi.h>
 
===== kernel/posix-timers.c 1.35 vs edited =====
--- 1.35/kernel/posix-timers.c	Fri Sep 10 22:29:24 2004
+++ edited/kernel/posix-timers.c	Sat Sep 18 15:44:42 2004
@@ -43,6 +43,7 @@
 #include <linux/compiler.h>
 #include <linux/idr.h>
 #include <linux/posix-timers.h>
+#include <linux/syscalls.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
===== kernel/printk.c 1.41 vs edited =====
--- 1.41/kernel/printk.c	Mon Aug 23 10:15:11 2004
+++ edited/kernel/printk.c	Sat Sep 18 15:44:46 2004
@@ -30,6 +30,7 @@
 #include <linux/smp.h>
 #include <linux/security.h>
 #include <linux/bootmem.h>
+#include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
 
===== kernel/sched.c 1.350 vs edited =====
--- 1.350/kernel/sched.c	Tue Sep 14 02:23:11 2004
+++ edited/kernel/sched.c	Sat Sep 18 15:44:57 2004
@@ -42,6 +42,7 @@
 #include <linux/percpu.h>
 #include <linux/kthread.h>
 #include <linux/seq_file.h>
+#include <linux/syscalls.h>
 #include <linux/times.h>
 #include <asm/tlb.h>
 
===== kernel/signal.c 1.134 vs edited =====
--- 1.134/kernel/signal.c	Wed Sep 15 10:26:18 2004
+++ edited/kernel/signal.c	Sat Sep 18 15:45:02 2004
@@ -20,6 +20,7 @@
 #include <linux/tty.h>
 #include <linux/binfmts.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 #include <linux/ptrace.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
===== kernel/sys.c 1.93 vs edited =====
--- 1.93/kernel/sys.c	Tue Sep 14 02:23:21 2004
+++ edited/kernel/sys.c	Sat Sep 18 15:45:06 2004
@@ -23,6 +23,7 @@
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
+#include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
===== kernel/sysctl.c 1.86 vs edited =====
--- 1.86/kernel/sysctl.c	Tue Aug 24 21:40:55 2004
+++ edited/kernel/sysctl.c	Sat Sep 18 15:45:09 2004
@@ -40,6 +40,7 @@
 #include <linux/times.h>
 #include <linux/limits.h>
 #include <linux/dcache.h>
+#include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
===== kernel/time.c 1.23 vs edited =====
--- 1.23/kernel/time.c	Wed Sep  8 08:32:53 2004
+++ edited/kernel/time.c	Sat Sep 18 15:45:12 2004
@@ -31,6 +31,7 @@
 #include <linux/timex.h>
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
+#include <linux/syscalls.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
===== kernel/timer.c 1.93 vs edited =====
--- 1.93/kernel/timer.c	Fri Sep 17 09:07:06 2004
+++ edited/kernel/timer.c	Sat Sep 18 15:45:16 2004
@@ -31,6 +31,7 @@
 #include <linux/time.h>
 #include <linux/jiffies.h>
 #include <linux/cpu.h>
+#include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
===== mm/fadvise.c 1.14 vs edited =====
--- 1.14/mm/fadvise.c	Sat May 22 10:23:18 2004
+++ edited/mm/fadvise.c	Sat Sep 18 15:45:19 2004
@@ -15,6 +15,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 #include <linux/fadvise.h>
+#include <linux/syscalls.h>
 
 #include <asm/unistd.h>
 
===== mm/filemap.c 1.274 vs edited =====
--- 1.274/mm/filemap.c	Sat Sep 11 17:50:30 2004
+++ edited/mm/filemap.c	Sat Sep 18 15:45:22 2004
@@ -27,6 +27,7 @@
 #include <linux/pagevec.h>
 #include <linux/blkdev.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 /*
  * This is needed for the following functions:
  *  - try_to_release_page
===== mm/fremap.c 1.28 vs edited =====
--- 1.28/mm/fremap.c	Mon Aug 23 10:15:12 2004
+++ edited/mm/fremap.c	Sat Sep 18 15:45:25 2004
@@ -14,6 +14,7 @@
 #include <linux/swapops.h>
 #include <linux/rmap.h>
 #include <linux/module.h>
+#include <linux/syscalls.h>
 
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
===== mm/madvise.c 1.13 vs edited =====
--- 1.13/mm/madvise.c	Sat May 22 23:56:29 2004
+++ edited/mm/madvise.c	Sat Sep 18 15:45:28 2004
@@ -7,6 +7,7 @@
 
 #include <linux/mman.h>
 #include <linux/pagemap.h>
+#include <linux/syscalls.h>
 
 
 /*
===== mm/mincore.c 1.7 vs edited =====
--- 1.7/mm/mincore.c	Fri Jun 18 08:41:09 2004
+++ edited/mm/mincore.c	Sat Sep 18 15:45:32 2004
@@ -11,6 +11,7 @@
 #include <linux/pagemap.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
===== mm/mlock.c 1.9 vs edited =====
--- 1.9/mm/mlock.c	Mon Aug 23 10:15:25 2004
+++ edited/mm/mlock.c	Sat Sep 18 15:45:35 2004
@@ -7,6 +7,7 @@
 
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/syscalls.h>
 
 
 static int mlock_fixup(struct vm_area_struct * vma, 
===== mm/mprotect.c 1.37 vs edited =====
--- 1.37/mm/mprotect.c	Fri Aug 27 09:02:34 2004
+++ edited/mm/mprotect.c	Sat Sep 18 15:45:43 2004
@@ -18,6 +18,7 @@
 #include <linux/security.h>
 #include <linux/mempolicy.h>
 #include <linux/personality.h>
+#include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
===== mm/mremap.c 1.57 vs edited =====
--- 1.57/mm/mremap.c	Fri Aug 27 09:02:34 2004
+++ edited/mm/mremap.c	Sat Sep 18 15:45:46 2004
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
===== mm/msync.c 1.18 vs edited =====
--- 1.18/mm/msync.c	Fri Jun 18 08:41:09 2004
+++ edited/mm/msync.c	Sat Sep 18 15:45:49 2004
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/hugetlb.h>
+#include <linux/syscalls.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
===== mm/nommu.c 1.15 vs edited =====
--- 1.15/mm/nommu.c	Sun Jul  4 20:33:15 2004
+++ edited/mm/nommu.c	Sat Sep 18 15:45:52 2004
@@ -19,6 +19,7 @@
 #include <linux/vmalloc.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
+#include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
 #include <asm/tlb.h>
===== mm/swapfile.c 1.117 vs edited =====
--- 1.117/mm/swapfile.c	Tue Aug 24 11:08:39 2004
+++ edited/mm/swapfile.c	Sat Sep 18 15:45:58 2004
@@ -25,6 +25,7 @@
 #include <linux/rmap.h>
 #include <linux/security.h>
 #include <linux/backing-dev.h>
+#include <linux/syscalls.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
