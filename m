Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268480AbUHYTrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268480AbUHYTrD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268465AbUHYTqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:46:39 -0400
Received: from holomorphy.com ([207.189.100.168]:3727 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268429AbUHYToZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:44:25 -0400
Date: Wed, 25 Aug 2004 12:44:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [3/4] move sighand to signal.h
Message-ID: <20040825194413.GG2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040819143907.GA4236@redhat.com> <20040819150632.GP11200@holomorphy.com> <20040825180138.GA2793@holomorphy.com> <20040825180342.GB2793@holomorphy.com> <20040825193921.GC2793@holomorphy.com> <20040825194207.GE2793@holomorphy.com> <20040825194304.GF2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825194304.GF2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 12:42:07PM -0700, William Lee Irwin III wrote:
>> Sorry, this is the real 1/4.
>> Move sigqueue-related bits to include/linux/signal.h

On Wed, Aug 25, 2004 at 12:43:04PM -0700, William Lee Irwin III wrote:
> Move sigpending -related bits to include/linux/sched.h

Move sighand_struct -related bits over to include/linux/signal.h

Index: mm4-2.6.8.1/arch/ia64/kernel/asm-offsets.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ia64/kernel/asm-offsets.c	2004-08-25 12:14:52.068051248 -0700
+++ mm4-2.6.8.1/arch/ia64/kernel/asm-offsets.c	2004-08-25 12:14:57.689196704 -0700
@@ -7,6 +7,7 @@
 #include <linux/config.h>
 
 #include <linux/sched.h>
+#include <linux/signal.h>
 
 #include <asm-ia64/processor.h>
 #include <asm-ia64/ptrace.h>
Index: mm4-2.6.8.1/arch/mips/kernel/irixsig.c
===================================================================
--- mm4-2.6.8.1.orig/arch/mips/kernel/irixsig.c	2004-08-25 12:14:52.068051248 -0700
+++ mm4-2.6.8.1/arch/mips/kernel/irixsig.c	2004-08-25 12:14:57.689196704 -0700
@@ -7,6 +7,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/mm.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
Index: mm4-2.6.8.1/arch/sparc64/solaris/signal.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sparc64/solaris/signal.c	2004-08-25 12:14:52.069051096 -0700
+++ mm4-2.6.8.1/arch/sparc64/solaris/signal.c	2004-08-25 12:14:57.690196552 -0700
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/svr4.h>
Index: mm4-2.6.8.1/arch/um/kernel/signal_kern.c
===================================================================
--- mm4-2.6.8.1.orig/arch/um/kernel/signal_kern.c	2004-08-25 12:14:52.069051096 -0700
+++ mm4-2.6.8.1/arch/um/kernel/signal_kern.c	2004-08-25 12:14:57.690196552 -0700
@@ -15,6 +15,7 @@
 #include "linux/tty.h"
 #include "linux/binfmts.h"
 #include "linux/ptrace.h"
+#include "linux/sighand.h"
 #include "asm/signal.h"
 #include "asm/uaccess.h"
 #include "asm/unistd.h"
Index: mm4-2.6.8.1/drivers/block/nbd.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/block/nbd.c	2004-08-25 12:14:52.069051096 -0700
+++ mm4-2.6.8.1/drivers/block/nbd.c	2004-08-25 12:14:57.690196552 -0700
@@ -54,6 +54,7 @@
 #include <linux/errno.h>
 #include <linux/file.h>
 #include <linux/ioctl.h>
+#include <linux/signal.h>
 #include <net/sock.h>
 
 #include <linux/devfs_fs_kernel.h>
Index: mm4-2.6.8.1/drivers/char/ftape/lowlevel/fdc-io.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/char/ftape/lowlevel/fdc-io.c	2004-08-25 12:14:52.069051096 -0700
+++ mm4-2.6.8.1/drivers/char/ftape/lowlevel/fdc-io.c	2004-08-25 12:14:57.691196400 -0700
@@ -32,6 +32,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/signal.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/dma.h>
Index: mm4-2.6.8.1/drivers/media/video/saa5249.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/media/video/saa5249.c	2004-08-25 12:14:52.069051096 -0700
+++ mm4-2.6.8.1/drivers/media/video/saa5249.c	2004-08-25 12:14:57.691196400 -0700
@@ -53,6 +53,7 @@
 #include <linux/i2c.h>
 #include <linux/videotext.h>
 #include <linux/videodev.h>
+#include <linux/signal.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/drivers/mmc/mmc_queue.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/mmc/mmc_queue.c	2004-08-25 12:14:52.070050944 -0700
+++ mm4-2.6.8.1/drivers/mmc/mmc_queue.c	2004-08-25 12:14:57.691196400 -0700
@@ -10,6 +10,7 @@
  */
 #include <linux/module.h>
 #include <linux/blkdev.h>
+#include <linux/signal.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
Index: mm4-2.6.8.1/drivers/mtd/mtd_blkdevs.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/mtd/mtd_blkdevs.c	2004-08-25 12:14:52.070050944 -0700
+++ mm4-2.6.8.1/drivers/mtd/mtd_blkdevs.c	2004-08-25 12:14:57.692196248 -0700
@@ -19,6 +19,7 @@
 #include <linux/spinlock.h>
 #include <linux/hdreg.h>
 #include <linux/init.h>
+#include <linux/sighand.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 #include <linux/devfs_fs_kernel.h>
Index: mm4-2.6.8.1/fs/afs/internal.h
===================================================================
--- mm4-2.6.8.1.orig/fs/afs/internal.h	2004-08-25 12:14:52.070050944 -0700
+++ mm4-2.6.8.1/fs/afs/internal.h	2004-08-25 12:14:57.692196248 -0700
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/signal.h>
 
 /*
  * debug tracing
Index: mm4-2.6.8.1/fs/exec.c
===================================================================
--- mm4-2.6.8.1.orig/fs/exec.c	2004-08-25 12:14:52.070050944 -0700
+++ mm4-2.6.8.1/fs/exec.c	2004-08-25 12:14:57.692196248 -0700
@@ -47,6 +47,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
Index: mm4-2.6.8.1/fs/jffs/intrep.c
===================================================================
--- mm4-2.6.8.1.orig/fs/jffs/intrep.c	2004-08-25 12:14:52.070050944 -0700
+++ mm4-2.6.8.1/fs/jffs/intrep.c	2004-08-25 12:14:57.693196096 -0700
@@ -67,6 +67,7 @@
 #include <linux/smp_lock.h>
 #include <linux/time.h>
 #include <linux/ctype.h>
+#include <linux/signal.h>
 
 #include "intrep.h"
 #include "jffs_fm.h"
Index: mm4-2.6.8.1/fs/jffs2/background.c
===================================================================
--- mm4-2.6.8.1.orig/fs/jffs2/background.c	2004-08-25 12:14:52.071050792 -0700
+++ mm4-2.6.8.1/fs/jffs2/background.c	2004-08-25 12:14:57.694195944 -0700
@@ -16,6 +16,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/completion.h>
 #include <linux/suspend.h>
+#include <linux/signal.h>
 #include "nodelist.h"
 
 
Index: mm4-2.6.8.1/fs/lockd/clntproc.c
===================================================================
--- mm4-2.6.8.1.orig/fs/lockd/clntproc.c	2004-08-25 12:14:52.071050792 -0700
+++ mm4-2.6.8.1/fs/lockd/clntproc.c	2004-08-25 12:14:57.694195944 -0700
@@ -13,6 +13,7 @@
 #include <linux/nfs_fs.h>
 #include <linux/utsname.h>
 #include <linux/smp_lock.h>
+#include <linux/signal.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/lockd/lockd.h>
Index: mm4-2.6.8.1/fs/lockd/svc.c
===================================================================
--- mm4-2.6.8.1.orig/fs/lockd/svc.c	2004-08-25 12:14:52.071050792 -0700
+++ mm4-2.6.8.1/fs/lockd/svc.c	2004-08-25 12:14:57.694195944 -0700
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
+#include <linux/signal.h>
 
 #include <linux/sunrpc/types.h>
 #include <linux/sunrpc/stats.h>
Index: mm4-2.6.8.1/fs/proc/task_nommu.c
===================================================================
--- mm4-2.6.8.1.orig/fs/proc/task_nommu.c	2004-08-25 12:14:52.071050792 -0700
+++ mm4-2.6.8.1/fs/proc/task_nommu.c	2004-08-25 12:14:57.694195944 -0700
@@ -2,6 +2,7 @@
 #include <linux/mm.h>
 #include <linux/file.h>
 #include <linux/seq_file.h>
+#include <linux/signal.h>
 
 /*
  * Logic: we've got two memory sums for each process, "shared", and
Index: mm4-2.6.8.1/fs/reiser4/entd.c
===================================================================
--- mm4-2.6.8.1.orig/fs/reiser4/entd.c	2004-08-25 12:14:52.071050792 -0700
+++ mm4-2.6.8.1/fs/reiser4/entd.c	2004-08-25 12:14:57.695195792 -0700
@@ -20,6 +20,7 @@
 #include <linux/writeback.h>
 #include <linux/time.h>         /* INITIAL_JIFFIES */
 #include <linux/backing-dev.h>  /* bdi_write_congested */
+#include <linux/signal.h>
 
 TYPE_SAFE_LIST_DEFINE(wbq, struct wbq, link);
 
Index: mm4-2.6.8.1/fs/reiser4/ktxnmgrd.c
===================================================================
--- mm4-2.6.8.1.orig/fs/reiser4/ktxnmgrd.c	2004-08-25 12:14:52.071050792 -0700
+++ mm4-2.6.8.1/fs/reiser4/ktxnmgrd.c	2004-08-25 12:14:57.695195792 -0700
@@ -34,6 +34,7 @@
 #include <linux/suspend.h>
 #include <linux/kernel.h>
 #include <linux/writeback.h>
+#include <linux/signal.h>
 
 static int scan_mgr(txn_mgr * mgr);
 
Index: mm4-2.6.8.1/fs/reiser4/repacker.c
===================================================================
--- mm4-2.6.8.1.orig/fs/reiser4/repacker.c	2004-08-25 12:14:52.071050792 -0700
+++ mm4-2.6.8.1/fs/reiser4/repacker.c	2004-08-25 12:14:57.695195792 -0700
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/writeback.h>
 #include <linux/suspend.h>
+#include <linux/signal.h>
 
 #include <asm/atomic.h>
 
Index: mm4-2.6.8.1/include/linux/init_task.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/init_task.h	2004-08-25 12:14:52.072050640 -0700
+++ mm4-2.6.8.1/include/linux/init_task.h	2004-08-25 12:14:57.695195792 -0700
@@ -3,6 +3,7 @@
 
 #include <linux/file.h>
 #include <linux/user.h>
+#include <linux/signal.h>
 #include <asm/resource.h>
 
 #define INIT_FILES \
Index: mm4-2.6.8.1/include/linux/sched.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/sched.h	2004-08-25 12:14:52.072050640 -0700
+++ mm4-2.6.8.1/include/linux/sched.h	2004-08-25 12:14:57.696195640 -0700
@@ -20,10 +20,11 @@
 #include <asm/page.h>
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
+#include <asm/signal.h>
+#include <asm/siginfo.h>
 
 #include <linux/smp.h>
 #include <linux/sem.h>
-#include <linux/signal.h>
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
@@ -253,11 +254,7 @@
 
 extern int mmlist_nr;
 
-struct sighand_struct {
-	atomic_t		count;
-	struct k_sigaction	action[_NSIG];
-	spinlock_t		siglock;
-};
+struct sighand_struct;
 
 struct sigpending {
 	struct list_head list;
@@ -704,18 +701,6 @@
 extern void flush_signal_handlers(struct task_struct *, int force_default);
 extern int dequeue_signal(struct task_struct *tsk, sigset_t *mask, siginfo_t *info);
 
-static inline int dequeue_signal_lock(struct task_struct *tsk, sigset_t *mask, siginfo_t *info)
-{
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&tsk->sighand->siglock, flags);
-	ret = dequeue_signal(tsk, mask, info);
-	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
-
-	return ret;
-}	
-
 extern void block_all_signals(int (*notifier)(void *priv), void *priv,
 			      sigset_t *mask);
 extern void unblock_all_signals(void);
Index: mm4-2.6.8.1/include/linux/signal.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/signal.h	2004-08-25 12:14:52.072050640 -0700
+++ mm4-2.6.8.1/include/linux/signal.h	2004-08-25 12:15:39.695810728 -0700
@@ -3,6 +3,7 @@
 
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/sched.h>
 #include <asm/signal.h>
 #include <asm/siginfo.h>
 
@@ -22,6 +23,12 @@
 	struct user_struct *user;
 };
 
+struct sighand_struct {
+	atomic_t		count;
+	struct k_sigaction	action[_NSIG];
+	spinlock_t		siglock;
+};
+
 /* flags values. */
 #define SIGQUEUE_PREALLOC	1
 
@@ -206,6 +213,17 @@
 	INIT_LIST_HEAD(&sig->list);
 }
 
+static inline int dequeue_signal_lock(task_t *task, sigset_t *mask, siginfo_t *info)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&task->sighand->siglock, flags);
+	ret = dequeue_signal(task, mask, info);
+	spin_unlock_irqrestore(&task->sighand->siglock, flags);
+	return ret;
+}
+
 extern int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p);
 extern long do_sigpending(void __user *, unsigned long);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
Index: mm4-2.6.8.1/kernel/exit.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/exit.c	2004-08-25 12:14:52.072050640 -0700
+++ mm4-2.6.8.1/kernel/exit.c	2004-08-25 12:14:57.697195488 -0700
@@ -28,6 +28,7 @@
 #include <linux/perfctr.h>
 #include <linux/cpu.h>
 #include <linux/user.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
Index: mm4-2.6.8.1/kernel/kmod.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/kmod.c	2004-08-25 12:14:52.072050640 -0700
+++ mm4-2.6.8.1/kernel/kmod.c	2004-08-25 12:14:57.697195488 -0700
@@ -36,6 +36,7 @@
 #include <linux/mount.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/signal.h>
 #include <asm/uaccess.h>
 
 extern int max_threads;
Index: mm4-2.6.8.1/kernel/kthread.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/kthread.c	2004-08-25 12:14:52.072050640 -0700
+++ mm4-2.6.8.1/kernel/kthread.c	2004-08-25 12:14:57.697195488 -0700
@@ -6,6 +6,7 @@
  * etc.).
  */
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/kthread.h>
 #include <linux/completion.h>
 #include <linux/err.h>
Index: mm4-2.6.8.1/kernel/power/process.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/power/process.c	2004-08-25 12:14:52.073050488 -0700
+++ mm4-2.6.8.1/kernel/power/process.c	2004-08-25 12:14:57.697195488 -0700
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
+#include <linux/signal.h>
 
 /* 
  * Timeout for stopping processes
Index: mm4-2.6.8.1/kernel/sys.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/sys.c	2004-08-25 12:14:52.073050488 -0700
+++ mm4-2.6.8.1/kernel/sys.c	2004-08-25 12:14:57.698195336 -0700
@@ -27,6 +27,7 @@
 #include <linux/suspend.h>
 #include <linux/key.h>
 #include <linux/user.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
Index: mm4-2.6.8.1/net/ipv4/ipvs/ip_vs_sync.c
===================================================================
--- mm4-2.6.8.1.orig/net/ipv4/ipvs/ip_vs_sync.c	2004-08-25 12:14:52.073050488 -0700
+++ mm4-2.6.8.1/net/ipv4/ipvs/ip_vs_sync.c	2004-08-25 12:14:57.698195336 -0700
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/net.h>
 #include <linux/completion.h>
+#include <linux/signal.h>
 
 #include <linux/skbuff.h>
 #include <linux/in.h>
Index: mm4-2.6.8.1/net/rxrpc/internal.h
===================================================================
--- mm4-2.6.8.1.orig/net/rxrpc/internal.h	2004-08-25 12:14:52.073050488 -0700
+++ mm4-2.6.8.1/net/rxrpc/internal.h	2004-08-25 12:14:57.698195336 -0700
@@ -8,6 +8,7 @@
 
 #include <linux/compiler.h>
 #include <linux/kernel.h>
+#include <linux/signal.h>
 
 /*
  * debug accounting
Index: mm4-2.6.8.1/net/sunrpc/clnt.c
===================================================================
--- mm4-2.6.8.1.orig/net/sunrpc/clnt.c	2004-08-25 12:14:52.073050488 -0700
+++ mm4-2.6.8.1/net/sunrpc/clnt.c	2004-08-25 12:14:57.699195184 -0700
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/in.h>
 #include <linux/utsname.h>
+#include <linux/signal.h>
 
 #include <linux/sunrpc/clnt.h>
 #include <linux/workqueue.h>
Index: mm4-2.6.8.1/net/sunrpc/sched.c
===================================================================
--- mm4-2.6.8.1.orig/net/sunrpc/sched.c	2004-08-25 12:14:52.074050336 -0700
+++ mm4-2.6.8.1/net/sunrpc/sched.c	2004-08-25 12:14:57.699195184 -0700
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/suspend.h>
+#include <linux/signal.h>
 
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/xprt.h>
Index: mm4-2.6.8.1/net/sunrpc/svc.c
===================================================================
--- mm4-2.6.8.1.orig/net/sunrpc/svc.c	2004-08-25 12:14:52.074050336 -0700
+++ mm4-2.6.8.1/net/sunrpc/svc.c	2004-08-25 12:14:57.699195184 -0700
@@ -12,6 +12,7 @@
 #include <linux/net.h>
 #include <linux/in.h>
 #include <linux/mm.h>
+#include <linux/signal.h>
 
 #include <linux/sunrpc/types.h>
 #include <linux/sunrpc/xdr.h>
Index: mm4-2.6.8.1/security/selinux/hooks.c
===================================================================
--- mm4-2.6.8.1.orig/security/selinux/hooks.c	2004-08-25 12:14:52.074050336 -0700
+++ mm4-2.6.8.1/security/selinux/hooks.c	2004-08-25 12:14:57.701194880 -0700
@@ -64,6 +64,7 @@
 #include <net/ipv6.h>
 #include <linux/hugetlb.h>
 #include <linux/personality.h>
+#include <linux/signal.h>
 
 #include "avc.h"
 #include "objsec.h"
