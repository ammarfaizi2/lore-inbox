Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269538AbUIZO1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269538AbUIZO1y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 10:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269540AbUIZO1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 10:27:53 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:25589 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S269538AbUIZO1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 10:27:42 -0400
Date: Sun, 26 Sep 2004 23:27:29 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: akpm@osdl.org
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: added interrupt control routines for vrc4173
Message-Id: <20040926232729.0c02fcd3.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change had added interrupt control routines for vrc4173.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff vr-orig/arch/mips/vr41xx/common/vrc4173.c vr/arch/mips/vr41xx/common/vrc4173.c
--- vr-orig/arch/mips/vr41xx/common/vrc4173.c	Sun Sep 26 21:33:37 2004
+++ vr/arch/mips/vr41xx/common/vrc4173.c	Sun Sep 26 23:09:25 2004
@@ -316,6 +316,96 @@
 	spin_lock_init(&vrc4173_giu_lock);
 }
 
+void vrc4173_enable_piuint(uint16_t mask)
+{
+	irq_desc_t *desc = irq_desc + VRC4173_PIU_IRQ;
+	unsigned long flags;
+	uint16_t val;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	val = vrc4173_inw(VRC4173_MPIUINTREG);
+	val |= mask;
+	vrc4173_outw(val, VRC4173_MPIUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+EXPORT_SYMBOL(vrc4173_eanble_piuint);
+
+void vrc4173_disable_piuint(uint16_t mask)
+{
+	irq_desc_t *desc = irq_desc + VRC4173_PIU_IRQ;
+	unsigned long flags;
+	uint16_t val;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	val = vrc4173_inw(VRC4173_MPIUINTREG);
+	val &= ~mask;
+	vrc4173_outw(val, VRC4173_MPIUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+EXPORT_SYMBOL(vrc4173_disable_piuint);
+
+void vrc4173_enable_aiuint(uint16_t mask)
+{
+	irq_desc_t *desc = irq_desc + VRC4173_AIU_IRQ;
+	unsigned long flags;
+	uint16_t val;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	val = vrc4173_inw(VRC4173_MAIUINTREG);
+	val |= mask;
+	vrc4173_outw(val, VRC4173_MAIUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+EXPORT_SYMBOL(vrc4173_enable_aiuint);
+
+void vrc4173_disable_aiuint(uint16_t mask)
+{
+	irq_desc_t *desc = irq_desc + VRC4173_AIU_IRQ;
+	unsigned long flags;
+	uint16_t val;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	val = vrc4173_inw(VRC4173_MAIUINTREG);
+	val &= ~mask;
+	vrc4173_outw(val, VRC4173_MAIUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+EXPORT_SYMBOL(vrc4173_disable_aiuint);
+
+void vrc4173_enable_kiuint(uint16_t mask)
+{
+	irq_desc_t *desc = irq_desc + VRC4173_KIU_IRQ;
+	unsigned long flags;
+	uint16_t val;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	val = vrc4173_inw(VRC4173_MKIUINTREG);
+	val |= mask;
+	vrc4173_outw(val, VRC4173_MKIUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+EXPORT_SYMBOL(vrc4173_enable_kiuint);
+
+void vrc4173_disable_kiuint(uint16_t mask)
+{
+	irq_desc_t *desc = irq_desc + VRC4173_KIU_IRQ;
+	unsigned long flags;
+	uint16_t val;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	val = vrc4173_inw(VRC4173_MKIUINTREG);
+	val &= ~mask;
+	vrc4173_outw(val, VRC4173_MKIUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+EXPORT_SYMBOL(vrc4173_disable_kiuint);
+
 static void enable_vrc4173_irq(unsigned int irq)
 {
 	uint16_t val;
diff -urN -X dontdiff vr-orig/include/asm-mips/vr41xx/vrc4173.h vr/include/asm-mips/vr41xx/vrc4173.h
--- vr-orig/include/asm-mips/vr41xx/vrc4173.h	Sun Sep 26 21:35:34 2004
+++ vr/include/asm-mips/vr41xx/vrc4173.h	Sun Sep 26 23:09:25 2004
@@ -48,6 +48,8 @@
 /*
  * PCI I/O accesses
  */
+#ifdef CONFIG_VRC4173
+
 extern unsigned long vrc4173_io_offset;
 
 #define set_vrc4173_io_offset(offset)	do { vrc4173_io_offset = (offset); } while (0)
@@ -74,6 +76,34 @@
 #define vrc4173_insw(port,addr,count)	insw(vrc4173_io_offset+(port),(addr),(count))
 #define vrc4173_insl(port,addr,count)	insl(vrc4173_io_offset+(port),(addr),(count))
 
+#else
+
+#define set_vrc4173_io_offset(offset)	do {} while (0)
+
+#define vrc4173_outb(val,port)		do {} while (0)
+#define vrc4173_outw(val,port)		do {} while (0)
+#define vrc4173_outl(val,port)		do {} while (0)
+#define vrc4173_outb_p(val,port)	do {} while (0)
+#define vrc4173_outw_p(val,port)	do {} while (0)
+#define vrc4173_outl_p(val,port)	do {} while (0)
+
+#define vrc4173_inb(port)		0
+#define vrc4173_inw(port)		0
+#define vrc4173_inl(port)		0
+#define vrc4173_inb_p(port)		0
+#define vrc4173_inw_p(port)		0
+#define vrc4173_inl_p(port)		0
+
+#define vrc4173_outsb(port,addr,count)	do {} while (0)
+#define vrc4173_outsw(port,addr,count)	do {} while (0)
+#define vrc4173_outsl(port,addr,count)	do {} while (0)
+
+#define vrc4173_insb(port,addr,count)	do {} while (0)
+#define vrc4173_insw(port,addr,count)	do {} while (0)
+#define vrc4173_insl(port,addr,count)	do {} while (0)
+
+#endif
+
 /*
  * Clock Mask Unit
  */
@@ -92,9 +122,77 @@
 	VRC4173_48MHz_CLOCK,
 } vrc4173_clock_t;
 
+#ifdef CONFIG_VRC4173
+
 extern void vrc4173_supply_clock(vrc4173_clock_t clock);
 extern void vrc4173_mask_clock(vrc4173_clock_t clock);
 
+#else
+
+static inline void vrc4173_supply_clock(vrc4173_clock_t clock) {}
+static inline void vrc4173_mask_clock(vrc4173_clock_t clock) {}
+
+#endif
+
+/*
+ * Interupt Control Unit
+ */
+
+#define VRC4173_PIUINT_COMMAND		0x0040
+#define VRC4173_PIUINT_DATA		0x0020
+#define VRC4173_PIUINT_PAGE1		0x0010
+#define VRC4173_PIUINT_PAGE0		0x0008
+#define VRC4173_PIUINT_DATALOST		0x0004
+#define VRC4173_PIUINT_STATUSCHANGE	0x0001
+
+#ifdef CONFIG_VRC4173
+
+extern void vrc4173_enable_piuint(uint16_t mask);
+extern void vrc4173_disable_piuint(uint16_t mask);
+
+#else
+
+static inline void vrc4173_enable_piuint(uint16_t mask) {}
+static inline void vrc4173_disable_piuint(uint16_t mask) {}
+
+#endif
+
+#define VRC4173_AIUINT_INPUT_DMAEND	0x0800
+#define VRC4173_AIUINT_INPUT_DMAHALT	0x0400
+#define VRC4173_AIUINT_INPUT_DATALOST	0x0200
+#define VRC4173_AIUINT_INPUT_DATA	0x0100
+#define VRC4173_AIUINT_OUTPUT_DMAEND	0x0008
+#define VRC4173_AIUINT_OUTPUT_DMAHALT	0x0004
+#define VRC4173_AIUINT_OUTPUT_NODATA	0x0002
+
+#ifdef CONFIG_VRC4173
+
+extern void vrc4173_enable_aiuint(uint16_t mask);
+extern void vrc4173_disable_aiuint(uint16_t mask);
+
+#else
+
+static inline void vrc4173_enable_aiuint(uint16_t mask) {}
+static inline void vrc4173_disable_aiuint(uint16_t mask) {}
+
+#endif
+
+#define VRC4173_KIUINT_DATALOST		0x0004
+#define VRC4173_KIUINT_DATAREADY	0x0002
+#define VRC4173_KIUINT_SCAN		0x0001
+
+#ifdef CONFIG_VRC4173
+
+extern void vrc4173_enable_kiuint(uint16_t mask);
+extern void vrc4173_disable_kiuint(uint16_t mask);
+
+#else
+
+static inline void vrc4173_enable_kiuint(uint16_t mask) {}
+static inline void vrc4173_disable_kiuint(uint16_t mask) {}
+
+#endif
+
 /*
  * General-Purpose I/O Unit
  */
@@ -109,6 +207,14 @@
 	GPIO_16_20PINS,
 } vrc4173_function_t;
 
+#ifdef CONFIG_VRC4173
+
 extern void vrc4173_select_function(vrc4173_function_t function);
+
+#else
+
+static inline void vrc4173_select_function(vrc4173_function_t function) {}
+
+#endif
 
 #endif /* __NEC_VRC4173_H */

