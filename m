Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbWJBQU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWJBQU6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWJBQU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:20:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16566 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965069AbWJBQUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:20:55 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/3] IRQ: Typedef the IRQ handler function type
Date: Mon, 02 Oct 2006 17:20:51 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Message-Id: <20061002162051.17763.72448.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Typedef the IRQ handler function type.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/interrupt.h |    7 ++++---
 kernel/irq/manage.c       |    4 +---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 1f97e3d..1978235 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -64,8 +64,10 @@ #define SA_TRIGGER_FALLING	IRQF_TRIGGER_
 #define SA_TRIGGER_RISING	IRQF_TRIGGER_RISING
 #define SA_TRIGGER_MASK		IRQF_TRIGGER_MASK
 
+typedef irqreturn_t (*irq_handler_t)(int, void *, struct pt_regs *);
+
 struct irqaction {
-	irqreturn_t (*handler)(int, void *, struct pt_regs *);
+	irq_handler_t handler;
 	unsigned long flags;
 	cpumask_t mask;
 	const char *name;
@@ -76,8 +78,7 @@ struct irqaction {
 };
 
 extern irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs);
-extern int request_irq(unsigned int,
-		       irqreturn_t (*handler)(int, void *, struct pt_regs *),
+extern int request_irq(unsigned int, irq_handler_t handler,
 		       unsigned long, const char *, void *);
 extern void free_irq(unsigned int, void *);
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 92be519..6879202 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -427,8 +427,7 @@ EXPORT_SYMBOL(free_irq);
  *	IRQF_SAMPLE_RANDOM	The interrupt can be used for entropy
  *
  */
-int request_irq(unsigned int irq,
-		irqreturn_t (*handler)(int, void *, struct pt_regs *),
+int request_irq(unsigned int irq, irq_handler_t handler,
 		unsigned long irqflags, const char *devname, void *dev_id)
 {
 	struct irqaction *action;
@@ -475,4 +474,3 @@ #endif
 	return retval;
 }
 EXPORT_SYMBOL(request_irq);
-
