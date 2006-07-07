Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWGGAeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWGGAeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWGGAdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:33:46 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:46531 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751108AbWGGAdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:33:42 -0400
Message-Id: <200607070033.k670XgKO008702@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 9/19] UML - mark forward_interrupts as being mode-specific
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:42 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark forward_interrupts as being tt-mode only.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/include/irq_user.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/irq_user.h	2006-07-05 23:53:28.000000000 -0400
+++ linux-2.6.17/arch/um/include/irq_user.h	2006-07-06 11:50:06.000000000 -0400
@@ -6,6 +6,8 @@
 #ifndef __IRQ_USER_H__
 #define __IRQ_USER_H__
 
+#include "uml-config.h"
+
 struct irq_fd {
 	struct irq_fd *next;
 	void *id;
@@ -26,9 +28,12 @@ extern void free_irq_by_fd(int fd);
 extern void reactivate_fd(int fd, int irqnum);
 extern void deactivate_fd(int fd, int irqnum);
 extern int deactivate_all_fds(void);
-extern void forward_interrupts(int pid);
 extern int activate_ipi(int fd, int pid);
 extern unsigned long irq_lock(void);
 extern void irq_unlock(unsigned long flags);
 
+#ifdef CONFIG_MODE_TT
+extern void forward_interrupts(int pid);
+#endif
+
 #endif
Index: linux-2.6.17/arch/um/kernel/irq.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/irq.c	2006-07-06 11:50:06.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/irq.c	2006-07-06 11:50:38.000000000 -0400
@@ -350,6 +350,7 @@ int deactivate_all_fds(void)
 	return 0;
 }
 
+#ifdef CONFIG_MODE_TT
 void forward_interrupts(int pid)
 {
 	struct irq_fd *irq;
@@ -371,6 +372,7 @@ void forward_interrupts(int pid)
 	}
 	irq_unlock(flags);
 }
+#endif
 
 /*
  * do_IRQ handles all normal device IRQ's (the special

