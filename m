Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVCCVyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVCCVyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbVCCVwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:52:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8970 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262616AbVCCVto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:49:44 -0500
Date: Thu, 3 Mar 2005 22:49:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/irq/spurious.c: make a function static
Message-ID: <20050303214937.GQ4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/irq.h   |    1 -
 kernel/irq/spurious.c |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.11-rc5-mm1-full/include/linux/irq.h.old	2005-03-03 16:32:01.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/include/linux/irq.h	2005-03-03 16:32:09.000000000 +0100
@@ -85,7 +85,6 @@
 				       struct irqaction *action);
 extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
 extern void note_interrupt(unsigned int irq, irq_desc_t *desc, int action_ret, struct pt_regs *regs);
-extern void report_bad_irq(unsigned int irq, irq_desc_t *desc, int action_ret);
 extern int can_request_irq(unsigned int irq, unsigned long irqflags);
 
 extern void init_irq_proc(void);
--- linux-2.6.11-rc5-mm1-full/kernel/irq/spurious.c.old	2005-03-03 16:32:27.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/irq/spurious.c	2005-03-03 16:32:33.000000000 +0100
@@ -116,7 +116,7 @@
 	}
 }
 
-void report_bad_irq(unsigned int irq, irq_desc_t *desc, irqreturn_t action_ret)
+static void report_bad_irq(unsigned int irq, irq_desc_t *desc, irqreturn_t action_ret)
 {
 	static int count = 100;
 

