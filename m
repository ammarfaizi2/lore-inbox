Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751925AbWFWSrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbWFWSrN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWFWSmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:31 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:17615 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751918AbWFWSl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:41:58 -0400
Message-Id: <20060623183912.619448000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:06 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/21] cleanup generic irq names
Content-Disposition: inline; filename=0016-M68K-cleanup-generic-irq-names.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename IRQ1..IRQ7 to IRQ_AUTO_1..IRQ_AUTO_7 and remove the duplicate
defintions.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/kernel/ints.c      |    4 ++--
 arch/m68k/q40/q40ints.c      |    4 ++--
 drivers/net/sun3lance.c      |    2 +-
 include/asm-m68k/atariints.h |   11 -----------
 include/asm-m68k/irq.h       |   22 ++++++++++------------
 include/asm-m68k/macints.h   |   11 -----------
 6 files changed, 15 insertions(+), 39 deletions(-)

757f09a7cc7fb3e1c6d993fe92a62d3b7c28850f
diff --git a/arch/m68k/kernel/ints.c b/arch/m68k/kernel/ints.c
index 895a56d..3ce7c61 100644
--- a/arch/m68k/kernel/ints.c
+++ b/arch/m68k/kernel/ints.c
@@ -153,7 +153,7 @@ int cpu_request_irq(unsigned int irq,
                     irqreturn_t (*handler)(int, void *, struct pt_regs *),
                     unsigned long flags, const char *devname, void *dev_id)
 {
-	if (irq < IRQ1 || irq > IRQ7) {
+	if (irq < IRQ_AUTO_1 || irq > IRQ_AUTO_7) {
 		printk("%s: Incorrect IRQ %d from %s\n",
 		       __FUNCTION__, irq, devname);
 		return -ENXIO;
@@ -183,7 +183,7 @@ #endif
 
 void cpu_free_irq(unsigned int irq, void *dev_id)
 {
-	if (irq < IRQ1 || irq > IRQ7) {
+	if (irq < IRQ_AUTO_1 || irq > IRQ_AUTO_7) {
 		printk("%s: Incorrect IRQ %d\n", __FUNCTION__, irq);
 		return;
 	}
diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index f8ecc26..b106839 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -93,8 +93,8 @@ void q40_init_IRQ (void)
 	}
 
 	/* setup handler for ISA ints */
-	cpu_request_irq(IRQ2, q40_irq2_handler, 0, "q40 ISA and master chip",
-			NULL);
+	cpu_request_irq(IRQ_AUTO_2, q40_irq2_handler, 0,
+			"q40 ISA and master chip", NULL);
 
 	/* now enable some ints.. */
 	master_outb(1,EXT_ENABLE_REG);  /* ISA IRQ 5-15 */
diff --git a/drivers/net/sun3lance.c b/drivers/net/sun3lance.c
index d4c0002..a2fad50 100644
--- a/drivers/net/sun3lance.c
+++ b/drivers/net/sun3lance.c
@@ -55,7 +55,7 @@ #endif
 /* sun3/60 addr/irq for the lance chip.  If your sun is different,
    change this. */
 #define LANCE_OBIO 0x120000
-#define LANCE_IRQ IRQ3
+#define LANCE_IRQ IRQ_AUTO_3
 
 /* Debug level:
  *  0 = silent, print only serious errors
diff --git a/include/asm-m68k/atariints.h b/include/asm-m68k/atariints.h
index 42952c8..0ed454f 100644
--- a/include/asm-m68k/atariints.h
+++ b/include/asm-m68k/atariints.h
@@ -45,17 +45,6 @@ #define IRQ_TYPE_SLOW     0
 #define IRQ_TYPE_FAST     1
 #define IRQ_TYPE_PRIO     2
 
-#define	IRQ_SPURIOUS      (0)
-
-/* auto-vector interrupts */
-#define IRQ_AUTO_1        (1)
-#define IRQ_AUTO_2        (2)
-#define IRQ_AUTO_3        (3)
-#define IRQ_AUTO_4        (4)
-#define IRQ_AUTO_5        (5)
-#define IRQ_AUTO_6        (6)
-#define IRQ_AUTO_7        (7)
-
 /* ST-MFP interrupts */
 #define IRQ_MFP_BUSY      (8)
 #define IRQ_MFP_DCD       (9)
diff --git a/include/asm-m68k/irq.h b/include/asm-m68k/irq.h
index 9727ca9..320a084 100644
--- a/include/asm-m68k/irq.h
+++ b/include/asm-m68k/irq.h
@@ -4,7 +4,7 @@ #define _M68K_IRQ_H_
 #include <linux/interrupt.h>
 
 /*
- * # of m68k interrupts
+ * # of m68k auto vector interrupts
  */
 
 #define SYS_IRQS 8
@@ -40,19 +40,17 @@ #endif
  * that routine requires service.
  */
 
-#define IRQ1		(1)	/* level 1 interrupt */
-#define IRQ2		(2)	/* level 2 interrupt */
-#define IRQ3		(3)	/* level 3 interrupt */
-#define IRQ4		(4)	/* level 4 interrupt */
-#define IRQ5		(5)	/* level 5 interrupt */
-#define IRQ6		(6)	/* level 6 interrupt */
-#define IRQ7		(7)	/* level 7 interrupt (non-maskable) */
+#define IRQ_SPURIOUS	0
 
-/*
- * "Generic" interrupt sources
- */
+#define IRQ_AUTO_1	1	/* level 1 interrupt */
+#define IRQ_AUTO_2	2	/* level 2 interrupt */
+#define IRQ_AUTO_3	3	/* level 3 interrupt */
+#define IRQ_AUTO_4	4	/* level 4 interrupt */
+#define IRQ_AUTO_5	5	/* level 5 interrupt */
+#define IRQ_AUTO_6	6	/* level 6 interrupt */
+#define IRQ_AUTO_7	7	/* level 7 interrupt (non-maskable) */
 
-#define IRQ_SCHED_TIMER	(8)    /* interrupt source for scheduling timer */
+#define IRQ_USER	8
 
 static __inline__ int irq_canonicalize(int irq)
 {
diff --git a/include/asm-m68k/macints.h b/include/asm-m68k/macints.h
index fd8c3a9..c9604f8 100644
--- a/include/asm-m68k/macints.h
+++ b/include/asm-m68k/macints.h
@@ -59,17 +59,6 @@ #define NUM_MAC_SOURCES		72
 #define IRQ_SRC(irq)	(irq >> 3)
 #define	IRQ_IDX(irq)	(irq & 7)
 
-#define	IRQ_SPURIOUS      (0)
-
-/* auto-vector interrupts */
-#define IRQ_AUTO_1        (1)
-#define IRQ_AUTO_2        (2)
-#define IRQ_AUTO_3        (3)
-#define IRQ_AUTO_4        (4)
-#define IRQ_AUTO_5        (5)
-#define IRQ_AUTO_6        (6)
-#define IRQ_AUTO_7        (7)
-
 /* VIA1 interrupts */
 #define IRQ_VIA1_0	  (8)		/* one second int. */
 #define IRQ_VIA1_1        (9)		/* VBlank int. */
-- 
1.3.3

--

