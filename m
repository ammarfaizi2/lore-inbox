Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVB0AKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVB0AKc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVB0AJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:09:52 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:2216
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261310AbVB0AA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:00:26 -0500
Message-ID: <20050227010023.7.patchmail@tglx>
References: <20050227005956.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/10] I386:  C99 initializers for hw_interrupt_type structures
Date: Sun, 27 Feb 2005 00:56:37 +0100 (CET)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the initializers of hw_interrupt_type structures to C99 initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/i8259.c             |   15 +++++++--------
 mach-voyager/voyager_smp.c |   16 ++++++++--------
 2 files changed, 15 insertions(+), 16 deletions(-)
---
diff -urN 2.6.11-rc5.orig/arch/i386/kernel/i8259.c 2.6.11-rc5/arch/i386/kernel/i8259.c
--- 2.6.11-rc5.orig/arch/i386/kernel/i8259.c	2005-01-24 12:25:33.000000000 +0100
+++ 2.6.11-rc5/arch/i386/kernel/i8259.c	2005-02-26 21:51:58.000000000 +0100
@@ -58,14 +58,13 @@
 }
 
 static struct hw_interrupt_type i8259A_irq_type = {
-	"XT-PIC",
-	startup_8259A_irq,
-	shutdown_8259A_irq,
-	enable_8259A_irq,
-	disable_8259A_irq,
-	mask_and_ack_8259A,
-	end_8259A_irq,
-	NULL
+	.typename = "XT-PIC",
+	.startup = startup_8259A_irq,
+	.shutdown = shutdown_8259A_irq,
+	.enable = enable_8259A_irq,
+	.disable = disable_8259A_irq,
+	.ack = mask_and_ack_8259A,
+	.end = end_8259A_irq,
 };
 
 /*
diff -urN 2.6.11-rc5.orig/arch/i386/mach-voyager/voyager_smp.c 2.6.11-rc5/arch/i386/mach-voyager/voyager_smp.c
--- 2.6.11-rc5.orig/arch/i386/mach-voyager/voyager_smp.c	2005-02-14 11:01:03.000000000 +0100
+++ 2.6.11-rc5/arch/i386/mach-voyager/voyager_smp.c	2005-02-26 20:54:19.000000000 +0100
@@ -210,14 +210,14 @@
  * 8259 IRQs except that masks and things must be kept per processor
  */
 static struct hw_interrupt_type vic_irq_type = {
-	"VIC-level",
-	startup_vic_irq,	/* startup */
-	disable_vic_irq,	/* shutdown */
-	enable_vic_irq,		/* enable */
-	disable_vic_irq,	/* disable */
-	before_handle_vic_irq,	/* ack */
-	after_handle_vic_irq,	/* end */
-	set_vic_irq_affinity,	/* affinity */
+	.typename = "VIC-level",
+	.startup = startup_vic_irq,
+	.shutdown = disable_vic_irq,
+	.enable = enable_vic_irq,
+	.disable = disable_vic_irq,
+	.ack = before_handle_vic_irq,
+	.end = after_handle_vic_irq,
+	.set_affinity = set_vic_irq_affinity,
 };
 
 /* used to count up as CPUs are brought on line (starts at 0) */
