Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271171AbUJVC4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271171AbUJVC4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 22:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271187AbUJVCvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:51:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:57777 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S271169AbUJVCot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:44:49 -0400
Subject: [PATCH] ppc: Fix build of irq.c with CONFIG_TAU_INT
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098413033.19462.53.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 12:43:54 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes build of arch/ppc/kernel/irc.c when CONFIG_TAU_INT
is set.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/kernel/irq.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/irq.c	2004-10-21 11:47:00.000000000 +1000
+++ linux-work/arch/ppc/kernel/irq.c	2004-10-22 12:41:22.683883440 +1000
@@ -71,6 +71,11 @@
 unsigned long ppc_lost_interrupts[NR_MASK_WORDS];
 atomic_t ppc_n_lost_interrupts;
 
+#ifdef CONFIG_TAU_INT
+extern int tau_initialized;
+extern int tau_interrupts(int);
+#endif
+
 int show_interrupts(struct seq_file *p, void *v)
 {
 	int i = *(loff_t *) v, j;


