Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267703AbUIZOId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267703AbUIZOId (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 10:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269456AbUIZOIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 10:08:32 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:50398 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S267703AbUIZOIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 10:08:16 -0400
Date: Sun, 26 Sep 2004 23:08:03 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: akpm@osdl.org
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: added CPU type checking to interrupt control routines
Message-Id: <20040926230803.5485e331.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change had added CPU type checking to interrupt control routines.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff vr-orig/arch/mips/vr41xx/common/icu.c vr/arch/mips/vr41xx/common/icu.c
--- vr-orig/arch/mips/vr41xx/common/icu.c	Sun Sep 26 21:27:15 2004
+++ vr/arch/mips/vr41xx/common/icu.c	Sun Sep 26 21:27:36 2004
@@ -165,217 +165,267 @@
 {
 	irq_desc_t *desc = irq_desc + PIU_IRQ;
 	unsigned long flags;
-	uint16_t val;
 
-	spin_lock_irqsave(&desc->lock, flags);
-	val = read_icu1(MPIUINTREG);
-	val |= mask;
-	write_icu1(val, MPIUINTREG);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	if (current_cpu_data.cputype == CPU_VR4111 ||
+	    current_cpu_data.cputype == CPU_VR4121) {
+		spin_lock_irqsave(&desc->lock, flags);
+		set_icu1(MPIUINTREG, mask);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 }
 
+EXPORT_SYMBOL(vr41xx_enable_piuint);
+
 void vr41xx_disable_piuint(uint16_t mask)
 {
 	irq_desc_t *desc = irq_desc + PIU_IRQ;
 	unsigned long flags;
-	uint16_t val;
 
-	spin_lock_irqsave(&desc->lock, flags);
-	val = read_icu1(MPIUINTREG);
-	val &= ~mask;
-	write_icu1(val, MPIUINTREG);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	if (current_cpu_data.cputype == CPU_VR4111 ||
+	    current_cpu_data.cputype == CPU_VR4121) {
+		spin_lock_irqsave(&desc->lock, flags);
+		clear_icu1(MPIUINTREG, mask);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 }
 
+EXPORT_SYMBOL(vr41xx_disable_piuint);
+
 void vr41xx_enable_aiuint(uint16_t mask)
 {
 	irq_desc_t *desc = irq_desc + AIU_IRQ;
 	unsigned long flags;
-	uint16_t val;
 
-	spin_lock_irqsave(&desc->lock, flags);
-	val = read_icu1(MAIUINTREG);
-	val |= mask;
-	write_icu1(val, MAIUINTREG);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	if (current_cpu_data.cputype == CPU_VR4111 ||
+	    current_cpu_data.cputype == CPU_VR4121) {
+		spin_lock_irqsave(&desc->lock, flags);
+		set_icu1(MAIUINTREG, mask);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 }
 
+EXPORT_SYMBOL(vr41xx_enable_aiuint);
+
 void vr41xx_disable_aiuint(uint16_t mask)
 {
 	irq_desc_t *desc = irq_desc + AIU_IRQ;
 	unsigned long flags;
-	uint16_t val;
 
-	spin_lock_irqsave(&desc->lock, flags);
-	val = read_icu1(MAIUINTREG);
-	val &= ~mask;
-	write_icu1(val, MAIUINTREG);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	if (current_cpu_data.cputype == CPU_VR4111 ||
+	    current_cpu_data.cputype == CPU_VR4121) {
+		spin_lock_irqsave(&desc->lock, flags);
+		clear_icu1(MAIUINTREG, mask);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 }
 
+EXPORT_SYMBOL(vr41xx_disable_aiuint);
+
 void vr41xx_enable_kiuint(uint16_t mask)
 {
 	irq_desc_t *desc = irq_desc + KIU_IRQ;
 	unsigned long flags;
-	uint16_t val;
 
-	spin_lock_irqsave(&desc->lock, flags);
-	val = read_icu1(MKIUINTREG);
-	val |= mask;
-	write_icu1(val, MKIUINTREG);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	if (current_cpu_data.cputype == CPU_VR4111 ||
+	    current_cpu_data.cputype == CPU_VR4121) {
+		spin_lock_irqsave(&desc->lock, flags);
+		set_icu1(MKIUINTREG, mask);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 }
 
+EXPORT_SYMBOL(vr41xx_enable_kiuint);
+
 void vr41xx_disable_kiuint(uint16_t mask)
 {
 	irq_desc_t *desc = irq_desc + KIU_IRQ;
 	unsigned long flags;
-	uint16_t val;
 
-	spin_lock_irqsave(&desc->lock, flags);
-	val = read_icu1(MKIUINTREG);
-	val &= ~mask;
-	write_icu1(val, MKIUINTREG);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	if (current_cpu_data.cputype == CPU_VR4111 ||
+	    current_cpu_data.cputype == CPU_VR4121) {
+		spin_lock_irqsave(&desc->lock, flags);
+		clear_icu1(MKIUINTREG, mask);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 }
 
+EXPORT_SYMBOL(vr41xx_disable_kiuint);
+
 void vr41xx_enable_dsiuint(uint16_t mask)
 {
 	irq_desc_t *desc = irq_desc + DSIU_IRQ;
 	unsigned long flags;
-	uint16_t val;
 
 	spin_lock_irqsave(&desc->lock, flags);
-	val = read_icu1(MDSIUINTREG);
-	val |= mask;
-	write_icu1(val, MDSIUINTREG);
+	set_icu1(MDSIUINTREG, mask);
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
+EXPORT_SYMBOL(vr41xx_enable_dsiuint);
+
 void vr41xx_disable_dsiuint(uint16_t mask)
 {
 	irq_desc_t *desc = irq_desc + DSIU_IRQ;
 	unsigned long flags;
-	uint16_t val;
 
 	spin_lock_irqsave(&desc->lock, flags);
-	val = read_icu1(MDSIUINTREG);
-	val &= ~mask;
-	write_icu1(val, MDSIUINTREG);
+	clear_icu1(MDSIUINTREG, mask);
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
+EXPORT_SYMBOL(vr41xx_disable_dsiuint);
+
 void vr41xx_enable_firint(uint16_t mask)
 {
 	irq_desc_t *desc = irq_desc + FIR_IRQ;
 	unsigned long flags;
-	uint16_t val;
 
 	spin_lock_irqsave(&desc->lock, flags);
-	val = read_icu2(MFIRINTREG);
-	val |= mask;
-	write_icu2(val, MFIRINTREG);
+	set_icu2(MFIRINTREG, mask);
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
+EXPORT_SYMBOL(vr41xx_enable_firint);
+
 void vr41xx_disable_firint(uint16_t mask)
 {
 	irq_desc_t *desc = irq_desc + FIR_IRQ;
 	unsigned long flags;
-	uint16_t val;
 
 	spin_lock_irqsave(&desc->lock, flags);
-	val = read_icu2(MFIRINTREG);
-	val &= ~mask;
-	write_icu2(val, MFIRINTREG);
+	clear_icu2(MFIRINTREG, mask);
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
+EXPORT_SYMBOL(vr41xx_disable_firint);
+
 void vr41xx_enable_pciint(void)
 {
 	irq_desc_t *desc = irq_desc + PCI_IRQ;
 	unsigned long flags;
 
-	spin_lock_irqsave(&desc->lock, flags);
-	write_icu2(PCIINT0, MPCIINTREG);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	if (current_cpu_data.cputype == CPU_VR4122 ||
+	    current_cpu_data.cputype == CPU_VR4131 ||
+	    current_cpu_data.cputype == CPU_VR4133) {
+		spin_lock_irqsave(&desc->lock, flags);
+		write_icu2(PCIINT0, MPCIINTREG);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 }
 
+EXPORT_SYMBOL(vr41xx_enable_pciint);
+
 void vr41xx_disable_pciint(void)
 {
 	irq_desc_t *desc = irq_desc + PCI_IRQ;
 	unsigned long flags;
 
-	spin_lock_irqsave(&desc->lock, flags);
-	write_icu2(0, MPCIINTREG);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	if (current_cpu_data.cputype == CPU_VR4122 ||
+	    current_cpu_data.cputype == CPU_VR4131 ||
+	    current_cpu_data.cputype == CPU_VR4133) {
+		spin_lock_irqsave(&desc->lock, flags);
+		write_icu2(0, MPCIINTREG);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 }
 
+EXPORT_SYMBOL(vr41xx_disable_pciint);
+
 void vr41xx_enable_scuint(void)
 {
 	irq_desc_t *desc = irq_desc + SCU_IRQ;
 	unsigned long flags;
 
-	spin_lock_irqsave(&desc->lock, flags);
-	write_icu2(SCUINT0, MSCUINTREG);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	if (current_cpu_data.cputype == CPU_VR4122 ||
+	    current_cpu_data.cputype == CPU_VR4131 ||
+	    current_cpu_data.cputype == CPU_VR4133) {
+		spin_lock_irqsave(&desc->lock, flags);
+		write_icu2(SCUINT0, MSCUINTREG);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 }
 
+EXPORT_SYMBOL(vr41xx_enable_scuint);
+
 void vr41xx_disable_scuint(void)
 {
 	irq_desc_t *desc = irq_desc + SCU_IRQ;
 	unsigned long flags;
 
-	spin_lock_irqsave(&desc->lock, flags);
-	write_icu2(0, MSCUINTREG);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	if (current_cpu_data.cputype == CPU_VR4122 ||
+	    current_cpu_data.cputype == CPU_VR4131 ||
+	    current_cpu_data.cputype == CPU_VR4133) {
+		spin_lock_irqsave(&desc->lock, flags);
+		write_icu2(0, MSCUINTREG);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 }
 
+EXPORT_SYMBOL(vr41xx_disable_scuint);
+
 void vr41xx_enable_csiint(uint16_t mask)
 {
 	irq_desc_t *desc = irq_desc + CSI_IRQ;
 	unsigned long flags;
-	uint16_t val;
 
-	spin_lock_irqsave(&desc->lock, flags);
-	val = read_icu2(MCSIINTREG);
-	val |= mask;
-	write_icu2(val, MCSIINTREG);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	if (current_cpu_data.cputype == CPU_VR4122 ||
+	    current_cpu_data.cputype == CPU_VR4131 ||
+	    current_cpu_data.cputype == CPU_VR4133) {
+		spin_lock_irqsave(&desc->lock, flags);
+		set_icu2(MCSIINTREG, mask);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 }
 
+EXPORT_SYMBOL(vr41xx_enable_csiint);
+
 void vr41xx_disable_csiint(uint16_t mask)
 {
 	irq_desc_t *desc = irq_desc + CSI_IRQ;
 	unsigned long flags;
-	uint16_t val;
 
-	spin_lock_irqsave(&desc->lock, flags);
-	val = read_icu2(MCSIINTREG);
-	val &= ~mask;
-	write_icu2(val, MCSIINTREG);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	if (current_cpu_data.cputype == CPU_VR4122 ||
+	    current_cpu_data.cputype == CPU_VR4131 ||
+	    current_cpu_data.cputype == CPU_VR4133) {
+		spin_lock_irqsave(&desc->lock, flags);
+		clear_icu2(MCSIINTREG, mask);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 }
 
+EXPORT_SYMBOL(vr41xx_disable_csiint);
+
 void vr41xx_enable_bcuint(void)
 {
 	irq_desc_t *desc = irq_desc + BCU_IRQ;
 	unsigned long flags;
 
-	spin_lock_irqsave(&desc->lock, flags);
-	write_icu2(BCUINTR, MBCUINTREG);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	if (current_cpu_data.cputype == CPU_VR4122 ||
+	    current_cpu_data.cputype == CPU_VR4131 ||
+	    current_cpu_data.cputype == CPU_VR4133) {
+		spin_lock_irqsave(&desc->lock, flags);
+		write_icu2(BCUINTR, MBCUINTREG);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 }
 
+EXPORT_SYMBOL(vr41xx_enable_bcuint);
+
 void vr41xx_disable_bcuint(void)
 {
 	irq_desc_t *desc = irq_desc + BCU_IRQ;
 	unsigned long flags;
 
-	spin_lock_irqsave(&desc->lock, flags);
-	write_icu2(0, MBCUINTREG);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	if (current_cpu_data.cputype == CPU_VR4122 ||
+	    current_cpu_data.cputype == CPU_VR4131 ||
+	    current_cpu_data.cputype == CPU_VR4133) {
+		spin_lock_irqsave(&desc->lock, flags);
+		write_icu2(0, MBCUINTREG);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 }
+
+EXPORT_SYMBOL(vr41xx_disable_bcuint);
 
 /*=======================================================================*/
 

