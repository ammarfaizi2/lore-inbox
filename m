Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVGJVvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVGJVvi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVGJVtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 17:49:42 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:4035
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262118AbVGJVrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 17:47:21 -0400
Message-ID: <20050710235022.1.patchmail@tglx.tec.linutronix.de>
References: <1121031634.26713.243.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: trini@kernel.crashing.org
Cc: linuxppc-embedded@ozlabs.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC:  [PATCH resend] C99 initializers for hw_interrupt_type structures
Date: Sun, 10 Jul 2005 23:47:18 +0200 (CEST)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the initializers of hw_interrupt_type structures to C99 initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 platforms/adir_pic.c |   12 ++++--------
 syslib/cpc700_pic.c  |   12 ++++--------
 syslib/i8259.c       |   13 +++++--------
 syslib/open_pic2.c   |   12 +++++-------
 syslib/ppc403_pic.c  |   11 ++++-------
 syslib/xilinx_pic.c  |   13 +++++--------
 6 files changed, 27 insertions(+), 46 deletions(-)
---
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/ppc/platforms/adir_pic.c linux-2.6.13-rc2-armirq/arch/ppc/platforms/adir_pic.c
--- linux-2.6.13-rc2/arch/ppc/platforms/adir_pic.c	2005-07-09 13:04:31.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/ppc/platforms/adir_pic.c	2005-07-09 13:10:41.000000000 +0200
@@ -73,14 +73,10 @@
 }
 
 static struct hw_interrupt_type adir_onboard_pic = {
-	" ADIR PIC ",
-	NULL,
-	NULL,
-	adir_onboard_pic_enable,		/* unmask */
-	adir_onboard_pic_disable,		/* mask */
-	adir_onboard_pic_disable,		/* mask and ack */
-	NULL,
-	NULL
+	.typename = " ADIR PIC ",
+	.enable = adir_onboard_pic_enable,	/* unmask */
+	.disable = adir_onboard_pic_disable,	/* mask */
+	.ack = adir_onboard_pic_disable,	/* mask and ack */
 };
 
 static struct irqaction noop_action = {
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/ppc/syslib/cpc700_pic.c linux-2.6.13-rc2-armirq/arch/ppc/syslib/cpc700_pic.c
--- linux-2.6.13-rc2/arch/ppc/syslib/cpc700_pic.c	2005-07-09 13:04:31.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/ppc/syslib/cpc700_pic.c	2005-07-09 13:10:41.000000000 +0200
@@ -90,14 +90,10 @@
 }
 
 static struct hw_interrupt_type cpc700_pic = {
-	"CPC700 PIC",
-	NULL,
-	NULL,
-	cpc700_unmask_irq,
-	cpc700_mask_irq,
-	cpc700_mask_and_ack_irq,
-	NULL,
-	NULL
+	.typename = "CPC700 PIC",
+	.enable = cpc700_unmask_irq,
+	.disable = cpc700_mask_irq,
+	.ack = cpc700_mask_and_ack_irq,
 };
 
 __init static void
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/ppc/syslib/i8259.c linux-2.6.13-rc2-armirq/arch/ppc/syslib/i8259.c
--- linux-2.6.13-rc2/arch/ppc/syslib/i8259.c	2005-07-09 13:04:31.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/ppc/syslib/i8259.c	2005-07-09 13:10:41.000000000 +0200
@@ -129,14 +129,11 @@
 }
 
 struct hw_interrupt_type i8259_pic = {
-	" i8259    ",
-	NULL,
-	NULL,
-	i8259_unmask_irq,
-	i8259_mask_irq,
-	i8259_mask_and_ack_irq,
-	i8259_end_irq,
-	NULL
+	.typename = " i8259    ",
+	.enable = i8259_unmask_irq,
+	.disable = i8259_mask_irq,
+	.ack = i8259_mask_and_ack_irq,
+	.end = i8259_end_irq,
 };
 
 static struct resource pic1_iores = {
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/ppc/syslib/open_pic2.c linux-2.6.13-rc2-armirq/arch/ppc/syslib/open_pic2.c
--- linux-2.6.13-rc2/arch/ppc/syslib/open_pic2.c	2005-07-09 13:08:08.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/ppc/syslib/open_pic2.c	2005-07-09 13:10:41.000000000 +0200
@@ -82,13 +82,11 @@
 static void openpic2_ack_irq(unsigned int irq_nr);
 
 struct hw_interrupt_type open_pic2 = {
-	" OpenPIC2 ",
-	NULL,
-	NULL,
-	openpic2_enable_irq,
-	openpic2_disable_irq,
-	openpic2_ack_irq,
-	openpic2_end_irq,
+	.typename = " OpenPIC2 ",
+	.enable = openpic2_enable_irq,
+	.disable = openpic2_disable_irq,
+	.ack = openpic2_ack_irq,
+	.end = openpic2_end_irq,
 };
 
 /*
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/ppc/syslib/ppc403_pic.c linux-2.6.13-rc2-armirq/arch/ppc/syslib/ppc403_pic.c
--- linux-2.6.13-rc2/arch/ppc/syslib/ppc403_pic.c	2005-07-09 13:04:31.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/ppc/syslib/ppc403_pic.c	2005-07-09 13:10:41.000000000 +0200
@@ -34,13 +34,10 @@
 static void ppc403_aic_disable_and_ack(unsigned int irq);
 
 static struct hw_interrupt_type ppc403_aic = {
-	"403GC AIC",
-	NULL,
-	NULL,
-	ppc403_aic_enable,
-	ppc403_aic_disable,
-	ppc403_aic_disable_and_ack,
-	0
+	.typename = "403GC AIC",
+	.enable = ppc403_aic_enable,
+	.disable = ppc403_aic_disable,
+	.ack = ppc403_aic_disable_and_ack,
 };
 
 int
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/ppc/syslib/xilinx_pic.c linux-2.6.13-rc2-armirq/arch/ppc/syslib/xilinx_pic.c
--- linux-2.6.13-rc2/arch/ppc/syslib/xilinx_pic.c	2005-07-09 13:04:31.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/ppc/syslib/xilinx_pic.c	2005-07-09 13:10:41.000000000 +0200
@@ -79,14 +79,11 @@
 }
 
 static struct hw_interrupt_type xilinx_intc = {
-	"Xilinx Interrupt Controller",
-	NULL,
-	NULL,
-	xilinx_intc_enable,
-	xilinx_intc_disable,
-	xilinx_intc_disable_and_ack,
-	xilinx_intc_end,
-	0
+	.typename = "Xilinx Interrupt Controller",
+	.enable = xilinx_intc_enable,
+	.disable = xilinx_intc_disable,
+	.ack = xilinx_intc_disable_and_ack,
+	.end = xilinx_intc_end,
 };
 
 int
