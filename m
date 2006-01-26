Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWAZQdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWAZQdD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWAZQdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:33:02 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:26241 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964777AbWAZQdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:33:00 -0500
Date: Thu, 26 Jan 2006 17:33:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] warn if free_irq() is called from IRQ context
Message-ID: <20060126163339.GA5911@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

warn if free_irq() is called in IRQ context - free_irq() can execute
/proc VFS work, which must not be done in IRQ context.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/irq/manage.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux/kernel/irq/manage.c
===================================================================
--- linux.orig/kernel/irq/manage.c
+++ linux/kernel/irq/manage.c
@@ -263,6 +263,7 @@ void free_irq(unsigned int irq, void *de
 	unsigned long flags;
 	irqreturn_t (*handler)(int, void *, struct pt_regs *) = NULL;
 
+	WARN_ON(in_interrupt());
 	if (irq >= NR_IRQS)
 		return;
 
