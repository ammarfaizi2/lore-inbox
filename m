Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751856AbWF3S4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbWF3S4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWF3S4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:56:14 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:39383 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751414AbWF3Szx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:55:53 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] IRQ: warning message cleanup
Date: Fri, 30 Jun 2006 12:55:48 -0600
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301255.48552.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make warnings more consistent.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm7/kernel/irq/manage.c
===================================================================
--- work-mm7.orig/kernel/irq/manage.c	2006-06-30 11:59:13.000000000 -0600
+++ work-mm7/kernel/irq/manage.c	2006-06-30 12:17:42.000000000 -0600
@@ -115,7 +115,7 @@
 	spin_lock_irqsave(&desc->lock, flags);
 	switch (desc->depth) {
 	case 0:
-		printk(KERN_WARNING "Unablanced enable_irq(%d)\n", irq);
+		printk(KERN_WARNING "Unbalanced enable for IRQ %d\n", irq);
 		WARN_ON(1);
 		break;
 	case 1: {
@@ -268,9 +268,10 @@
 				 * SA_TRIGGER_* but the PIC does not support
 				 * multiple flow-types?
 				 */
-				printk(KERN_WARNING "setup_irq(%d) SA_TRIGGER"
-				       "set. No set_type function available\n",
-				       irq);
+				printk(KERN_WARNING "No SA_TRIGGER set_type "
+				       "function for IRQ %d (%s)\n", irq,
+				       desc->chip ? desc->chip->name :
+				       "unknown");
 		} else
 			compat_irq_chip_set_default_handler(desc);
 
@@ -300,7 +301,7 @@
 mismatch:
 	spin_unlock_irqrestore(&desc->lock, flags);
 	if (!(new->flags & SA_PROBEIRQ)) {
-		printk(KERN_ERR "%s: irq handler mismatch\n", __FUNCTION__);
+		printk(KERN_ERR "IRQ handler type mismatch for IRQ %d\n", irq);
 		dump_stack();
 	}
 	return -EBUSY;
@@ -374,7 +375,7 @@
 			kfree(action);
 			return;
 		}
-		printk(KERN_ERR "Trying to free free IRQ%d\n", irq);
+		printk(KERN_ERR "Trying to free already-free IRQ %d\n", irq);
 		spin_unlock_irqrestore(&desc->lock, flags);
 		return;
 	}
