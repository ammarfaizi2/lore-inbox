Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVB0AKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVB0AKd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVB0AJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:09:35 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:1448
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261308AbVB0AAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:00:24 -0500
Message-ID: <20050227010020.6.patchmail@tglx>
References: <20050227005956.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: uclinux-v850@lsi.nec.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/10] V850:  C99 initializers for hw_interrupt_type structures
Date: Sun, 27 Feb 2005 00:56:34 +0100 (CET)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the initializers of hw_interrupt_type structures to C99 initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 irq.c   |   14 +++++++-------
 setup.c |   14 +++++++-------
 sim.c   |   14 +++++++-------
 3 files changed, 21 insertions(+), 21 deletions(-)
---
diff -urN 2.6.11-rc5.orig/arch/v850/kernel/irq.c 2.6.11-rc5/arch/v850/kernel/irq.c
--- 2.6.11-rc5.orig/arch/v850/kernel/irq.c	2004-12-24 22:35:24.000000000 +0100
+++ 2.6.11-rc5/arch/v850/kernel/irq.c	2005-02-26 20:54:19.000000000 +0100
@@ -67,13 +67,13 @@
 #define end_none	enable_none
 
 struct hw_interrupt_type no_irq_type = {
-	"none",
-	startup_none,
-	shutdown_none,
-	enable_none,
-	disable_none,
-	ack_none,
-	end_none
+	.typename = "none",
+	.startup = startup_none,
+	.shutdown = shutdown_none,
+	.enable = enable_none,
+	.disable = disable_none,
+	.ack = ack_none,
+	.end = end_none
 };
 
 volatile unsigned long irq_err_count, spurious_count;
diff -urN 2.6.11-rc5.orig/arch/v850/kernel/setup.c 2.6.11-rc5/arch/v850/kernel/setup.c
--- 2.6.11-rc5.orig/arch/v850/kernel/setup.c	2004-12-24 22:34:32.000000000 +0100
+++ 2.6.11-rc5/arch/v850/kernel/setup.c	2005-02-26 20:54:19.000000000 +0100
@@ -128,13 +128,13 @@
 }
 
 static struct hw_interrupt_type nmi_irq_type = {
-	"NMI",
-	irq_zero,		/* startup */
-	irq_nop,		/* shutdown */
-	irq_nop,		/* enable */
-	irq_nop,		/* disable */
-	irq_nop,		/* ack */
-	nmi_end,		/* end */
+	.typename = "NMI",
+	.startup = irq_zero,		/* startup */
+	.shutdown = irq_nop,		/* shutdown */
+	.enable = irq_nop,		/* enable */
+	.disable = irq_nop,		/* disable */
+	.ack = irq_nop,		/* ack */
+	.end = nmi_end,		/* end */
 };
 
 void __init init_IRQ (void)
diff -urN 2.6.11-rc5.orig/arch/v850/kernel/sim.c 2.6.11-rc5/arch/v850/kernel/sim.c
--- 2.6.11-rc5.orig/arch/v850/kernel/sim.c	2004-12-24 22:35:24.000000000 +0100
+++ 2.6.11-rc5/arch/v850/kernel/sim.c	2005-02-26 20:54:19.000000000 +0100
@@ -73,13 +73,13 @@
 static unsigned irq_zero (unsigned irq) { return 0; }
 
 static struct hw_interrupt_type sim_irq_type = {
-	"IRQ",
-	irq_zero,		/* startup */
-	irq_nop,		/* shutdown */
-	irq_nop,		/* enable */
-	irq_nop,		/* disable */
-	irq_nop,		/* ack */
-	irq_nop,		/* end */
+	.typename = "IRQ",
+	.startup = irq_zero,		/* startup */
+	.shutdown = irq_nop,		/* shutdown */
+	.enable = irq_nop,		/* enable */
+	.disable = irq_nop,		/* disable */
+	.ack = irq_nop,		/* ack */
+	.end = irq_nop,		/* end */
 };
 
 void __init mach_init_irqs (void)
