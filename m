Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVJWSzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVJWSzl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 14:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVJWSzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 14:55:40 -0400
Received: from xenotime.net ([66.160.160.81]:57056 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750798AbVJWSzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 14:55:40 -0400
Date: Sun, 23 Oct 2005 11:55:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] more kernel-doc cleanups, additions
Message-Id: <20051023115538.3e119535.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Various core kernel-doc cleanups:
- add missing function parameters in ipc, irq/manage, kernel/sys,
  kernel/sysctl, and mm/slab;
- move description to just above function for kernel_restart()

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 ipc/util.c          |    9 +++++----
 kernel/irq/manage.c |    1 +
 kernel/sys.c        |   15 +++++++++------
 kernel/sysctl.c     |    1 +
 mm/slab.c           |    1 +
 5 files changed, 17 insertions(+), 10 deletions(-)

diff -Naurp linux-2614-rc4/ipc/util.c~kerneldoc2 linux-2614-rc4/ipc/util.c
--- linux-2614-rc4/ipc/util.c~kerneldoc2	2005-10-16 20:12:24.000000000 -0700
+++ linux-2614-rc4/ipc/util.c	2005-10-16 20:20:24.000000000 -0700
@@ -410,7 +410,8 @@ void ipc_rcu_getref(void *ptr)
 }
 
 /**
- *	ipc_schedule_free	- free ipc + rcu space
+ * ipc_schedule_free - free ipc + rcu space
+ * @head: RCU callback structure for queued work
  * 
  * Since RCU callback function is called in bh,
  * we need to defer the vfree to schedule_work
@@ -427,10 +428,10 @@ static void ipc_schedule_free(struct rcu
 }
 
 /**
- *	ipc_immediate_free	- free ipc + rcu space
- *
- *	Free from the RCU callback context
+ * ipc_immediate_free - free ipc + rcu space
+ * @head: RCU callback structure that contains pointer to be freed
  *
+ * Free from the RCU callback context
  */
 static void ipc_immediate_free(struct rcu_head *head)
 {
diff -Naurp linux-2614-rc4/kernel/irq/manage.c~kerneldoc2 linux-2614-rc4/kernel/irq/manage.c
--- linux-2614-rc4/kernel/irq/manage.c~kerneldoc2	2005-10-14 17:31:30.000000000 -0700
+++ linux-2614-rc4/kernel/irq/manage.c	2005-10-16 21:18:06.000000000 -0700
@@ -24,6 +24,7 @@ cpumask_t __cacheline_aligned pending_ir
 
 /**
  *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
+ *	@irq: interrupt number to wait for
  *
  *	This function waits for any pending IRQ handlers for this interrupt
  *	to complete before returning. If you use this function while
diff -Naurp linux-2614-rc4/kernel/sys.c~kerneldoc2 linux-2614-rc4/kernel/sys.c
--- linux-2614-rc4/kernel/sys.c~kerneldoc2	2005-10-14 17:31:30.000000000 -0700
+++ linux-2614-rc4/kernel/sys.c	2005-10-16 10:19:07.000000000 -0700
@@ -375,18 +375,21 @@ void emergency_restart(void)
 }
 EXPORT_SYMBOL_GPL(emergency_restart);
 
-/**
- *	kernel_restart - reboot the system
- *
- *	Shutdown everything and perform a clean reboot.
- *	This is not safe to call in interrupt context.
- */
 void kernel_restart_prepare(char *cmd)
 {
 	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state = SYSTEM_RESTART;
 	device_shutdown();
 }
+
+/**
+ *	kernel_restart - reboot the system
+ *	@cmd: pointer to buffer containing command to execute for restart
+ *		or NULL
+ *
+ *	Shutdown everything and perform a clean reboot.
+ *	This is not safe to call in interrupt context.
+ */
 void kernel_restart(char *cmd)
 {
 	kernel_restart_prepare(cmd);
diff -Naurp linux-2614-rc4/kernel/sysctl.c~kerneldoc2 linux-2614-rc4/kernel/sysctl.c
--- linux-2614-rc4/kernel/sysctl.c~kerneldoc2	2005-10-14 17:31:30.000000000 -0700
+++ linux-2614-rc4/kernel/sysctl.c	2005-10-16 20:22:01.000000000 -0700
@@ -1997,6 +1997,7 @@ int proc_dointvec_jiffies(ctl_table *tab
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: pointer to the file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string. 
diff -Naurp linux-2614-rc4/mm/slab.c~kerneldoc2 linux-2614-rc4/mm/slab.c
--- linux-2614-rc4/mm/slab.c~kerneldoc2	2005-10-16 20:10:58.000000000 -0700
+++ linux-2614-rc4/mm/slab.c	2005-10-16 20:11:10.000000000 -0700
@@ -3259,6 +3259,7 @@ static void drain_array_locked(kmem_cach
 
 /**
  * cache_reap - Reclaim memory from caches.
+ * @unused: unused parameter
  *
  * Called from workqueue/eventd every few seconds.
  * Purpose:


---
