Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVB0AAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVB0AAi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVB0AAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:00:37 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:62887
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261301AbVB0AAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:00:07 -0500
Message-ID: <20050227005956.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: trini@kernel.crashing.org
Cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/10] PPC:  C99 initializers for hw_interrupt_type structures
Date: Sun, 27 Feb 2005 00:56:16 +0100 (CET)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the initializers of hw_interrupt_type structures to C99 initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 platforms/adir_pic.c |   12 ++++--------
 syslib/cpc700_pic.c  |   12 ++++--------
 syslib/cpm2_pic.c    |   13 +++++--------
 syslib/i8259.c       |   13 +++++--------
 syslib/mpc52xx_pic.c |   13 +++++--------
 syslib/open_pic2.c   |   12 +++++-------
 syslib/ppc403_pic.c  |   11 ++++-------
 syslib/xilinx_pic.c  |   13 +++++--------
 8 files changed, 37 insertions(+), 62 deletions(-)
---
diff -urN 2.6.11-rc5.orig/arch/ppc/platforms/adir_pic.c 2.6.11-rc5/arch/ppc/platforms/adir_pic.c
--- 2.6.11-rc5.orig/arch/ppc/platforms/adir_pic.c	2004-12-24 22:33:52.000000000 +0100
+++ 2.6.11-rc5/arch/ppc/platforms/adir_pic.c	2005-02-26 20:54:19.000000000 +0100
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
diff -urN 2.6.11-rc5.orig/arch/ppc/syslib/cpc700_pic.c 2.6.11-rc5/arch/ppc/syslib/cpc700_pic.c
--- 2.6.11-rc5.orig/arch/ppc/syslib/cpc700_pic.c	2004-12-24 22:34:26.000000000 +0100
+++ 2.6.11-rc5/arch/ppc/syslib/cpc700_pic.c	2005-02-26 20:54:19.000000000 +0100
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
diff -urN 2.6.11-rc5.orig/arch/ppc/syslib/cpm2_pic.c 2.6.11-rc5/arch/ppc/syslib/cpm2_pic.c
--- 2.6.11-rc5.orig/arch/ppc/syslib/cpm2_pic.c	2004-12-24 22:34:57.000000000 +0100
+++ 2.6.11-rc5/arch/ppc/syslib/cpm2_pic.c	2005-02-26 20:54:19.000000000 +0100
@@ -102,14 +102,11 @@
 }
 
 struct hw_interrupt_type cpm2_pic = {
-	" CPM2 SIU  ",
-	NULL,
-	NULL,
-	cpm2_unmask_irq,
-	cpm2_mask_irq,
-	cpm2_mask_and_ack,
-	cpm2_end_irq,
-	0
+	.typename = " CPM2 SIU  ",
+	.enable = cpm2_unmask_irq,
+	.disable = cpm2_mask_irq,
+	.ack = cpm2_mask_and_ack,
+	.end = cpm2_end_irq,
 };
 
 
diff -urN 2.6.11-rc5.orig/arch/ppc/syslib/i8259.c 2.6.11-rc5/arch/ppc/syslib/i8259.c
--- 2.6.11-rc5.orig/arch/ppc/syslib/i8259.c	2005-02-26 20:38:12.000000000 +0100
+++ 2.6.11-rc5/arch/ppc/syslib/i8259.c	2005-02-26 20:54:19.000000000 +0100
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
diff -urN 2.6.11-rc5.orig/arch/ppc/syslib/mpc52xx_pic.c 2.6.11-rc5/arch/ppc/syslib/mpc52xx_pic.c
--- 2.6.11-rc5.orig/arch/ppc/syslib/mpc52xx_pic.c	2004-12-24 22:35:59.000000000 +0100
+++ 2.6.11-rc5/arch/ppc/syslib/mpc52xx_pic.c	2005-02-26 20:54:19.000000000 +0100
@@ -166,14 +166,11 @@
 }
 
 static struct hw_interrupt_type mpc52xx_ic = {
-	"MPC52xx",
-	NULL,				/* startup(irq) */
-	NULL,				/* shutdown(irq) */
-	mpc52xx_ic_enable,		/* enable(irq) */
-	mpc52xx_ic_disable,		/* disable(irq) */
-	mpc52xx_ic_disable_and_ack,	/* disable_and_ack(irq) */
-	mpc52xx_ic_end,			/* end(irq) */
-	0				/* set_affinity(irq, cpumask) SMP. */
+	.typename = "MPC52xx",
+	.enable = mpc52xx_ic_enable,		/* enable(irq) */
+	.disable = mpc52xx_ic_disable,		/* disable(irq) */
+	.ack = mpc52xx_ic_disable_and_ack,	/* disable_and_ack(irq) */
+	.end = mpc52xx_ic_end,			/* end(irq) */
 };
 
 void __init
diff -urN 2.6.11-rc5.orig/arch/ppc/syslib/open_pic2.c 2.6.11-rc5/arch/ppc/syslib/open_pic2.c
--- 2.6.11-rc5.orig/arch/ppc/syslib/open_pic2.c	2005-01-24 12:25:36.000000000 +0100
+++ 2.6.11-rc5/arch/ppc/syslib/open_pic2.c	2005-02-26 20:54:19.000000000 +0100
@@ -83,13 +83,11 @@
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
diff -urN 2.6.11-rc5.orig/arch/ppc/syslib/ppc403_pic.c 2.6.11-rc5/arch/ppc/syslib/ppc403_pic.c
--- 2.6.11-rc5.orig/arch/ppc/syslib/ppc403_pic.c	2005-01-24 12:25:36.000000000 +0100
+++ 2.6.11-rc5/arch/ppc/syslib/ppc403_pic.c	2005-02-26 20:54:19.000000000 +0100
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
diff -urN 2.6.11-rc5.orig/arch/ppc/syslib/xilinx_pic.c 2.6.11-rc5/arch/ppc/syslib/xilinx_pic.c
--- 2.6.11-rc5.orig/arch/ppc/syslib/xilinx_pic.c	2005-01-24 12:25:36.000000000 +0100
+++ 2.6.11-rc5/arch/ppc/syslib/xilinx_pic.c	2005-02-26 20:54:19.000000000 +0100
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
