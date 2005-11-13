Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVKMHlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVKMHlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 02:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVKMHlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 02:41:44 -0500
Received: from verein.lst.de ([213.95.11.210]:62387 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S964785AbVKMHlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 02:41:44 -0500
Date: Sun, 13 Nov 2005 08:41:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: gerg@uclinux.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] m68knommu: enable_irq/disable_irq
Message-ID: <20051113074136.GA816@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mach_enable_irq/mach_disable_irq are never actually set, so let's remove
them.

Btw, is it really intentionally that enable_irq/disable_irq are no-ops on
m68knommu?


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/m68knommu/kernel/m68k_ksyms.c
===================================================================
--- linux-2.6.orig/arch/m68knommu/kernel/m68k_ksyms.c	2005-10-31 12:23:08.000000000 +0100
+++ linux-2.6/arch/m68knommu/kernel/m68k_ksyms.c	2005-11-12 09:22:34.000000000 +0100
@@ -38,8 +38,6 @@
 
 EXPORT_SYMBOL(ip_fast_csum);
 
-EXPORT_SYMBOL(mach_enable_irq);
-EXPORT_SYMBOL(mach_disable_irq);
 EXPORT_SYMBOL(kernel_thread);
 
 /* Networking helper routines. */
Index: linux-2.6/arch/m68knommu/kernel/setup.c
===================================================================
--- linux-2.6.orig/arch/m68knommu/kernel/setup.c	2005-11-07 21:30:08.000000000 +0100
+++ linux-2.6/arch/m68knommu/kernel/setup.c	2005-11-12 09:22:26.000000000 +0100
@@ -65,8 +65,6 @@
 /* machine dependent irq functions */
 void (*mach_init_IRQ) (void) = NULL;
 irqreturn_t (*(*mach_default_handler)[]) (int, void *, struct pt_regs *) = NULL;
-void (*mach_enable_irq) (unsigned int) = NULL;
-void (*mach_disable_irq) (unsigned int) = NULL;
 int (*mach_get_irq_list) (struct seq_file *, void *) = NULL;
 void (*mach_process_int) (int irq, struct pt_regs *fp) = NULL;
 void (*mach_trap_init) (void);
Index: linux-2.6/include/asm-m68knommu/irq.h
===================================================================
--- linux-2.6.orig/include/asm-m68knommu/irq.h	2005-11-07 21:30:09.000000000 +0100
+++ linux-2.6/include/asm-m68knommu/irq.h	2005-11-12 09:22:05.000000000 +0100
@@ -84,8 +84,8 @@
 /*
  * Some drivers want these entry points
  */
-#define enable_irq(x)	(mach_enable_irq  ? (*mach_enable_irq)(x)  : 0)
-#define disable_irq(x)	(mach_disable_irq ? (*mach_disable_irq)(x) : 0)
+#define enable_irq(x)	0
+#define disable_irq(x)	do { } while (0)
 
 #define enable_irq_nosync(x)	enable_irq(x)
 #define disable_irq_nosync(x)	disable_irq(x)
