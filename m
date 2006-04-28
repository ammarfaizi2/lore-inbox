Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbWD1PDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWD1PDE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 11:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWD1PDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 11:03:04 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:15973
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030429AbWD1PDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 11:03:03 -0400
Message-Id: <44524AF3.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 28 Apr 2006 17:03:47 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] adjust handle_IRR_event() return type
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the return type of handle_IRQ_event() (inconsistency noticed
during Xen development), and remove redundant declarations. The return
type adjustment required breaking out the definition of irqreturn_t
into a separate header, in order to satisfy current include order
dependencies.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-alpha/irq.h
2.6.17-rc3-handle_IRQ_event/include/asm-alpha/irq.h
--- /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-alpha/irq.h	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.17-rc3-handle_IRQ_event/include/asm-alpha/irq.h	2006-04-28 12:20:29.000000000 +0200
@@ -93,8 +93,4 @@ extern void enable_irq(unsigned int);
 struct pt_regs;
 extern void (*perf_irq)(unsigned long, struct pt_regs *);
 
-struct irqaction;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
-
 #endif /* _ALPHA_IRQ_H */
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-arm/irq.h 2.6.17-rc3-handle_IRQ_event/include/asm-arm/irq.h
--- /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-arm/irq.h	2006-04-27 17:49:48.000000000 +0200
+++ 2.6.17-rc3-handle_IRQ_event/include/asm-arm/irq.h	2006-04-28 12:20:45.000000000 +0200
@@ -47,10 +47,6 @@ void disable_irq_wake(unsigned int irq);
 void enable_irq_wake(unsigned int irq);
 int setup_irq(unsigned int, struct irqaction *);
 
-struct irqaction;
-struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
 extern void migrate_irqs(void);
 #endif
 
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-arm26/irq.h
2.6.17-rc3-handle_IRQ_event/include/asm-arm26/irq.h
--- /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-arm26/irq.h	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.17-rc3-handle_IRQ_event/include/asm-arm26/irq.h	2006-04-28 12:20:55.000000000 +0200
@@ -44,9 +44,5 @@ extern void enable_irq(unsigned int);
 
 int set_irq_type(unsigned int irq, unsigned int type);
 
-int setup_irq(unsigned int, struct irqaction *);
-struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
 #endif
 
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-h8300/irq.h
2.6.17-rc3-handle_IRQ_event/include/asm-h8300/irq.h
--- /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-h8300/irq.h	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.17-rc3-handle_IRQ_event/include/asm-h8300/irq.h	2006-04-28 12:21:15.000000000 +0200
@@ -63,8 +63,4 @@ extern void enable_irq(unsigned int);
 extern void disable_irq(unsigned int);
 #define disable_irq_nosync(x)	disable_irq(x)
 
-struct irqaction;
-struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
 #endif /* _H8300_IRQ_H_ */
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-m68k/irq.h
2.6.17-rc3-handle_IRQ_event/include/asm-m68k/irq.h
--- /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-m68k/irq.h	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.17-rc3-handle_IRQ_event/include/asm-m68k/irq.h	2006-04-28 12:21:39.000000000 +0200
@@ -131,8 +131,4 @@ extern volatile unsigned int num_spuriou
  */
 extern irq_node_t *new_irq_node(void);
 
-struct irqaction;
-struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
 #endif /* _M68K_IRQ_H_ */
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-m68knommu/irq.h
2.6.17-rc3-handle_IRQ_event/include/asm-m68knommu/irq.h
--- /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-m68knommu/irq.h	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.17-rc3-handle_IRQ_event/include/asm-m68knommu/irq.h	2006-04-28 12:20:02.000000000 +0200
@@ -88,8 +88,4 @@ extern void (*mach_disable_irq)(unsigned
 #define disable_irq(x)	do { } while (0)
 #define disable_irq_nosync(x)	disable_irq(x)
 
-struct irqaction;
-struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
 #endif /* _M68K_IRQ_H_ */
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-s390/irq.h
2.6.17-rc3-handle_IRQ_event/include/asm-s390/irq.h
--- /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-s390/irq.h	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.17-rc3-handle_IRQ_event/include/asm-s390/irq.h	2006-04-28 12:22:36.000000000 +0200
@@ -21,10 +21,6 @@ enum interruption_class {
 
 #define touch_nmi_watchdog() do { } while(0)
 
-struct irqaction;
-struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
 #endif /* __KERNEL__ */
 #endif
 
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-sparc/irq.h
2.6.17-rc3-handle_IRQ_event/include/asm-sparc/irq.h
--- /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-sparc/irq.h	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.17-rc3-handle_IRQ_event/include/asm-sparc/irq.h	2006-04-28 12:21:57.000000000 +0200
@@ -184,8 +184,4 @@ extern struct sun4m_intregs *sun4m_inter
 #define SUN4M_INT_SBUS(x)	(1 << (x+7))
 #define SUN4M_INT_VME(x)	(1 << (x))
 
-struct irqaction;
-struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
 #endif
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-sparc64/irq.h
2.6.17-rc3-handle_IRQ_event/include/asm-sparc64/irq.h
--- /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-sparc64/irq.h	2006-04-27 17:49:48.000000000 +0200
+++ 2.6.17-rc3-handle_IRQ_event/include/asm-sparc64/irq.h	2006-04-28 12:22:07.000000000 +0200
@@ -140,8 +140,4 @@ static __inline__ unsigned long get_soft
 	return retval;
 }
 
-struct irqaction;
-struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
 #endif
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-v850/irq.h
2.6.17-rc3-handle_IRQ_event/include/asm-v850/irq.h
--- /home/jbeulich/tmp/linux-2.6.17-rc3/include/asm-v850/irq.h	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.17-rc3-handle_IRQ_event/include/asm-v850/irq.h	2006-04-28 12:22:22.000000000 +0200
@@ -62,8 +62,6 @@ extern void disable_irq (unsigned int ir
 /* Disable an irq without waiting. */
 extern void disable_irq_nosync (unsigned int irq);
 
-extern int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __V850_IRQ_H__ */
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/include/linux/interrupt.h
2.6.17-rc3-handle_IRQ_event/include/linux/interrupt.h
--- /home/jbeulich/tmp/linux-2.6.17-rc3/include/linux/interrupt.h	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.17-rc3-handle_IRQ_event/include/linux/interrupt.h	2006-04-28 12:17:08.000000000 +0200
@@ -8,32 +8,13 @@
 #include <linux/bitops.h>
 #include <linux/preempt.h>
 #include <linux/cpumask.h>
+#include <linux/irqreturn.h>
 #include <linux/hardirq.h>
 #include <linux/sched.h>
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 
-/*
- * For 2.4.x compatibility, 2.4.x can use
- *
- *	typedef void irqreturn_t;
- *	#define IRQ_NONE
- *	#define IRQ_HANDLED
- *	#define IRQ_RETVAL(x)
- *
- * To mix old-style and new-style irq handler returns.
- *
- * IRQ_NONE means we didn't handle it.
- * IRQ_HANDLED means that we did have a valid interrupt and handled it.
- * IRQ_RETVAL(x) selects on the two depending on x being non-zero (for handled)
- */
-typedef int irqreturn_t;
-
-#define IRQ_NONE	(0)
-#define IRQ_HANDLED	(1)
-#define IRQ_RETVAL(x)	((x) != 0)
-
 struct irqaction {
 	irqreturn_t (*handler)(int, void *, struct pt_regs *);
 	unsigned long flags;
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/include/linux/irq.h 2.6.17-rc3-handle_IRQ_event/include/linux/irq.h
--- /home/jbeulich/tmp/linux-2.6.17-rc3/include/linux/irq.h	2006-04-27 17:49:48.000000000 +0200
+++ 2.6.17-rc3-handle_IRQ_event/include/linux/irq.h	2006-04-28 12:18:19.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/cache.h>
 #include <linux/spinlock.h>
 #include <linux/cpumask.h>
+#include <linux/irqreturn.h>
 
 #include <asm/irq.h>
 #include <asm/ptrace.h>
@@ -168,7 +169,7 @@ static inline void set_irq_info(int irq,
 extern int no_irq_affinity;
 extern int noirqdebug_setup(char *str);
 
-extern fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
+extern fastcall irqreturn_t handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
 					struct irqaction *action);
 extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
 extern void note_interrupt(unsigned int irq, irq_desc_t *desc,
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/include/linux/irqreturn.h
2.6.17-rc3-handle_IRQ_event/include/linux/irqreturn.h
--- /home/jbeulich/tmp/linux-2.6.17-rc3/include/linux/irqreturn.h	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.17-rc3-handle_IRQ_event/include/linux/irqreturn.h	2006-04-28 12:16:00.000000000 +0200
@@ -0,0 +1,25 @@
+/* irqreturn.h */
+#ifndef _LINUX_IRQRETURN_H
+#define _LINUX_IRQRETURN_H
+
+/*
+ * For 2.4.x compatibility, 2.4.x can use
+ *
+ *	typedef void irqreturn_t;
+ *	#define IRQ_NONE
+ *	#define IRQ_HANDLED
+ *	#define IRQ_RETVAL(x)
+ *
+ * To mix old-style and new-style irq handler returns.
+ *
+ * IRQ_NONE means we didn't handle it.
+ * IRQ_HANDLED means that we did have a valid interrupt and handled it.
+ * IRQ_RETVAL(x) selects on the two depending on x being non-zero (for handled)
+ */
+typedef int irqreturn_t;
+
+#define IRQ_NONE	(0)
+#define IRQ_HANDLED	(1)
+#define IRQ_RETVAL(x)	((x) != 0)
+
+#endif
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/kernel/irq/handle.c 2.6.17-rc3-handle_IRQ_event/kernel/irq/handle.c
--- /home/jbeulich/tmp/linux-2.6.17-rc3/kernel/irq/handle.c	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.17-rc3-handle_IRQ_event/kernel/irq/handle.c	2006-04-27 10:16:35.000000000 +0200
@@ -76,10 +76,11 @@ irqreturn_t no_action(int cpl, void *dev
 /*
  * Have got an event to handle:
  */
-fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
+fastcall irqreturn_t handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
 				struct irqaction *action)
 {
-	int ret, retval = 0, status = 0;
+	irqreturn_t ret, retval = IRQ_NONE;
+	unsigned int status = 0;
 
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();


