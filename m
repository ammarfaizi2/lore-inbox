Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268450AbUHYTuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268450AbUHYTuL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268448AbUHYTtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:49:19 -0400
Received: from holomorphy.com ([207.189.100.168]:6543 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268409AbUHYTpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:45:34 -0400
Date: Wed, 25 Aug 2004 12:45:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [4/4] move signal_struct to signal.h
Message-ID: <20040825194527.GH2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040819143907.GA4236@redhat.com> <20040819150632.GP11200@holomorphy.com> <20040825180138.GA2793@holomorphy.com> <20040825180342.GB2793@holomorphy.com> <20040825193921.GC2793@holomorphy.com> <20040825194207.GE2793@holomorphy.com> <20040825194304.GF2793@holomorphy.com> <20040825194413.GG2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825194413.GG2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 12:43:04PM -0700, William Lee Irwin III wrote:
>> Move sigpending -related bits to include/linux/sched.h

On Wed, Aug 25, 2004 at 12:44:13PM -0700, William Lee Irwin III wrote:
> Move sighand_struct -related bits over to include/linux/signal.h

Move signal_struct -related bits over to include/linux/signal.h

Index: mm4-2.6.8.1/arch/i386/mach-voyager/voyager_thread.c
===================================================================
--- mm4-2.6.8.1.orig/arch/i386/mach-voyager/voyager_thread.c	2004-08-25 12:14:44.620183496 -0700
+++ mm4-2.6.8.1/arch/i386/mach-voyager/voyager_thread.c	2004-08-25 12:16:48.767310264 -0700
@@ -25,6 +25,7 @@
 #include <linux/kmod.h>
 #include <linux/completion.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <asm/desc.h>
 #include <asm/voyager.h>
 #include <asm/vic.h>
Index: mm4-2.6.8.1/arch/ia64/kernel/unaligned.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ia64/kernel/unaligned.c	2004-08-25 12:14:44.620183496 -0700
+++ mm4-2.6.8.1/arch/ia64/kernel/unaligned.c	2004-08-25 12:16:48.767310264 -0700
@@ -15,6 +15,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/smp_lock.h>
 #include <linux/tty.h>
 
Index: mm4-2.6.8.1/arch/sparc64/solaris/misc.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sparc64/solaris/misc.c	2004-08-25 12:14:44.621183344 -0700
+++ mm4-2.6.8.1/arch/sparc64/solaris/misc.c	2004-08-25 12:16:48.768310112 -0700
@@ -17,6 +17,7 @@
 #include <linux/timex.h>
 #include <linux/major.h>
 #include <linux/compat.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/string.h>
Index: mm4-2.6.8.1/drivers/char/vt.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/char/vt.c	2004-08-25 12:14:44.621183344 -0700
+++ mm4-2.6.8.1/drivers/char/vt.c	2004-08-25 12:16:48.769309960 -0700
@@ -101,6 +101,7 @@
 #include <linux/bootmem.h>
 #include <linux/pm.h>
 #include <linux/font.h>
+#include <linux/signal.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/drivers/char/vt_ioctl.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/char/vt_ioctl.c	2004-08-25 11:06:48.178896768 -0700
+++ mm4-2.6.8.1/drivers/char/vt_ioctl.c	2004-08-25 12:21:41.379826400 -0700
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/tty.h>
 #include <linux/timer.h>
 #include <linux/kernel.h>
Index: mm4-2.6.8.1/drivers/net/slip.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/net/slip.c	2004-08-25 12:14:44.621183344 -0700
+++ mm4-2.6.8.1/drivers/net/slip.c	2004-08-25 12:16:48.769309960 -0700
@@ -66,6 +66,7 @@
 #include <linux/interrupt.h>
 #include <linux/in.h>
 #include <linux/tty.h>
+#include <linux/signal.h>
 #include <linux/errno.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
Index: mm4-2.6.8.1/drivers/s390/char/keyboard.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/s390/char/keyboard.c	2004-08-25 12:14:44.621183344 -0700
+++ mm4-2.6.8.1/drivers/s390/char/keyboard.c	2004-08-25 12:16:48.769309960 -0700
@@ -10,6 +10,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/sysrq.h>
 
 #include <linux/kbd_kern.h>
Index: mm4-2.6.8.1/fs/autofs/autofs_i.h
===================================================================
--- mm4-2.6.8.1.orig/fs/autofs/autofs_i.h	2004-08-25 12:14:44.621183344 -0700
+++ mm4-2.6.8.1/fs/autofs/autofs_i.h	2004-08-25 12:16:48.770309808 -0700
@@ -27,6 +27,7 @@
 #include <linux/namei.h>
 #include <linux/mount.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 
 #include <asm/current.h>
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/fs/autofs4/autofs_i.h
===================================================================
--- mm4-2.6.8.1.orig/fs/autofs4/autofs_i.h	2004-08-25 12:14:44.622183192 -0700
+++ mm4-2.6.8.1/fs/autofs4/autofs_i.h	2004-08-25 12:16:48.770309808 -0700
@@ -25,6 +25,7 @@
 #include <linux/string.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <asm/current.h>
Index: mm4-2.6.8.1/fs/devfs/base.c
===================================================================
--- mm4-2.6.8.1.orig/fs/devfs/base.c	2004-08-25 11:06:48.173897528 -0700
+++ mm4-2.6.8.1/fs/devfs/base.c	2004-08-25 12:17:17.358963672 -0700
@@ -676,6 +676,7 @@
 #include <linux/smp.h>
 #include <linux/rwsem.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/namei.h>
 
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/include/linux/sched.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/sched.h	2004-08-25 12:14:57.696195640 -0700
+++ mm4-2.6.8.1/include/linux/sched.h	2004-08-25 12:16:48.770309808 -0700
@@ -255,6 +255,7 @@
 extern int mmlist_nr;
 
 struct sighand_struct;
+struct signal_struct;
 
 struct sigpending {
 	struct list_head list;
@@ -262,61 +263,6 @@
 };
 
 /*
- * NOTE! "signal_struct" does not have it's own
- * locking, because a shared signal_struct always
- * implies a shared sighand_struct, so locking
- * sighand_struct is always a proper superset of
- * the locking of signal_struct.
- */
-struct signal_struct {
-	atomic_t		count;
-
-	/* current thread group signal load-balancing target: */
-	task_t			*curr_target;
-
-	/* shared signal handling: */
-	struct sigpending	shared_pending;
-
-	/* thread group exit support */
-	int			group_exit;
-	int			group_exit_code;
-	/* overloaded:
-	 * - notify group_exit_task when ->count is equal to notify_count
-	 * - everyone except group_exit_task is stopped during signal delivery
-	 *   of fatal signals, group_exit_task processes the signal.
-	 */
-	struct task_struct	*group_exit_task;
-	int			notify_count;
-
-	/* thread group stop support, overloads group_exit_code too */
-	int			group_stop_count;
-	/* 1 if group stopped since last SIGCONT, -1 if SIGCONT since report */
-  	int			stop_state;
-
-	/* POSIX.1b Interval Timers */
-	struct list_head posix_timers;
-
-	/* job control IDs */
-	pid_t pgrp;
-	pid_t tty_old_pgrp;
-	pid_t session;
-	/* boolean value for session group leader */
-	int leader;
-
-	struct tty_struct *tty; /* NULL if no tty */
-
-	/*
-	 * Cumulative resource counters for dead threads in the group,
-	 * and for reaped dead child processes forked by this group.
-	 * Live threads maintain their own counters and add to these
-	 * in __exit_signal, except for the group leader.
-	 */
-	unsigned long utime, stime, cutime, cstime;
-	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw;
-	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
-};
-
-/*
  * Priority of a process goes from 0..MAX_PRIO-1, valid RT
  * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL tasks are
  * in the range MAX_RT_PRIO..MAX_PRIO-1. Priority values
@@ -583,11 +529,6 @@
 	int private_pages_count;
 };
 
-static inline pid_t process_group(struct task_struct *tsk)
-{
-	return tsk->signal->pgrp;
-}
-
 extern void free_task(struct task_struct *tsk);
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
@@ -786,7 +727,6 @@
 extern void __exit_signal(struct task_struct *);
 extern void exit_sighand(struct task_struct *);
 extern void __exit_sighand(struct task_struct *);
-extern void exit_itimers(struct signal_struct *);
 
 extern NORET_TYPE void do_group_exit(int);
 
Index: mm4-2.6.8.1/include/linux/signal.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/signal.h	2004-08-25 12:15:39.695810728 -0700
+++ mm4-2.6.8.1/include/linux/signal.h	2004-08-25 12:16:48.771309656 -0700
@@ -29,6 +29,61 @@
 	spinlock_t		siglock;
 };
 
+/*
+ * NOTE! "signal_struct" does not have it's own
+ * locking, because a shared signal_struct always
+ * implies a shared sighand_struct, so locking
+ * sighand_struct is always a proper superset of
+ * the locking of signal_struct.
+ */
+struct signal_struct {
+	atomic_t		count;
+
+	/* current thread group signal load-balancing target: */
+	task_t			*curr_target;
+
+	/* shared signal handling: */
+	struct sigpending	shared_pending;
+
+	/* thread group exit support */
+	int			group_exit;
+	int			group_exit_code;
+	/* overloaded:
+	 * - notify group_exit_task when ->count is equal to notify_count
+	 * - everyone except group_exit_task is stopped during signal delivery
+	 *   of fatal signals, group_exit_task processes the signal.
+	 */
+	task_t			*group_exit_task;
+	int			notify_count;
+
+	/* thread group stop support, overloads group_exit_code too */
+	int			group_stop_count;
+	/* 1 if group stopped since last SIGCONT, -1 if SIGCONT since report */
+  	int			stop_state;
+
+	/* POSIX.1b Interval Timers */
+	struct list_head posix_timers;
+
+	/* job control IDs */
+	pid_t pgrp;
+	pid_t tty_old_pgrp;
+	pid_t session;
+	/* boolean value for session group leader */
+	int leader;
+
+	struct tty_struct *tty; /* NULL if no tty */
+
+	/*
+	 * Cumulative resource counters for dead threads in the group,
+	 * and for reaped dead child processes forked by this group.
+	 * Live threads maintain their own counters and add to these
+	 * in __exit_signal, except for the group leader.
+	 */
+	unsigned long utime, stime, cutime, cstime;
+	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw;
+	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
+};
+
 /* flags values. */
 #define SIGQUEUE_PREALLOC	1
 
@@ -223,6 +278,11 @@
 	spin_unlock_irqrestore(&task->sighand->siglock, flags);
 	return ret;
 }
+ 
+static inline pid_t process_group(task_t *task)
+{
+	return task->signal->pgrp;
+}
 
 extern int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p);
 extern long do_sigpending(void __user *, unsigned long);
@@ -231,6 +291,7 @@
 void sigqueue_free(struct sigqueue *);
 int send_sigqueue(int, struct sigqueue *, struct task_struct *);
 int send_group_sigqueue(int, struct sigqueue *, struct task_struct *);
+void exit_itimers(struct signal_struct *);
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 struct pt_regs;
Index: mm4-2.6.8.1/kernel/pid.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/pid.c	2004-08-25 11:06:48.176897072 -0700
+++ mm4-2.6.8.1/kernel/pid.c	2004-08-25 12:17:53.753430872 -0700
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/hash.h>
+#include <linux/signal.h>
 
 #define pid_hashfn(nr) hash_long((unsigned long)nr, pidhash_shift)
 static struct hlist_head *pid_hash[PIDTYPE_MAX];
Index: mm4-2.6.8.1/net/bridge/netfilter/ebtables.c
===================================================================
--- mm4-2.6.8.1.orig/net/bridge/netfilter/ebtables.c	2004-08-14 03:55:10.000000000 -0700
+++ mm4-2.6.8.1/net/bridge/netfilter/ebtables.c	2004-08-25 12:18:21.632192656 -0700
@@ -17,6 +17,7 @@
 
 /* used for print_string */
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/tty.h>
 
 #include <linux/kmod.h>
Index: mm4-2.6.8.1/net/ipv4/netfilter/ipt_owner.c
===================================================================
--- mm4-2.6.8.1.orig/net/ipv4/netfilter/ipt_owner.c	2004-08-14 03:56:22.000000000 -0700
+++ mm4-2.6.8.1/net/ipv4/netfilter/ipt_owner.c	2004-08-25 12:18:44.863660936 -0700
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/file.h>
+#include <linux/signal.h>
 #include <net/sock.h>
 
 #include <linux/netfilter_ipv4/ipt_owner.h>
Index: mm4-2.6.8.1/net/ipv6/netfilter/ip6t_owner.c
===================================================================
--- mm4-2.6.8.1.orig/net/ipv6/netfilter/ip6t_owner.c	2004-08-14 03:55:59.000000000 -0700
+++ mm4-2.6.8.1/net/ipv6/netfilter/ip6t_owner.c	2004-08-25 12:19:03.440836776 -0700
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/file.h>
+#include <linux/signal.h>
 #include <net/sock.h>
 
 #include <linux/netfilter_ipv6/ip6t_owner.h>
