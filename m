Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269152AbUINGYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269152AbUINGYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269164AbUINGYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:24:14 -0400
Received: from [12.177.129.25] ([12.177.129.25]:28355 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S269152AbUINGXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:23:43 -0400
Message-Id: <200409140727.i8E7RIL7005638@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - update handle_IRQ_event
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Sep 2004 03:27:18 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small update to make UML's handle_IRQ_event look like the i386 version.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/kernel/irq.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/irq.c	2004-09-14 02:03:52.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/irq.c	2004-09-14 02:03:58.000000000 -0400
@@ -147,7 +147,7 @@
 		     struct irqaction * action)
 {
 	int status = 1;	/* Force the "do bottom halves" bit */
-	int ret;
+	int ret, retval = 0;
 
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();
@@ -156,6 +156,7 @@
 		ret = action->handler(irq, action->dev_id, regs);
 		if (ret == IRQ_HANDLED)
 			status |= action->flags;
+		retval |= ret;
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
@@ -163,7 +164,7 @@
 
 	local_irq_disable();
 
-	return status;
+	return retval;
 }
 
 /*

