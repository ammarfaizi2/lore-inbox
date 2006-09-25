Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWIYSft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWIYSft (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWIYSft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:35:49 -0400
Received: from [198.99.130.12] ([198.99.130.12]:49812 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751322AbWIYSfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:35:48 -0400
Message-Id: <200609251834.k8PIYang005041@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH 5/8] UML - Use correct SIGBUS handler
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Sep 2006 14:34:36 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BB noticed that we had the wrong bus error handler.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/kernel/trap.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/trap.c	2006-09-22 09:19:50.000000000 -0400
+++ linux-2.6.18-mm/arch/um/kernel/trap.c	2006-09-22 09:24:03.000000000 -0400
@@ -139,14 +139,6 @@ void segv_handler(int sig, union uml_pt_
 	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
 }
 
-const struct kern_handlers handlinfo_kern = {
-	.relay_signal = relay_signal,
-	.winch = winch,
-	.bus_handler = relay_signal,
-	.page_fault = segv_handler,
-	.sigio_handler = sigio_handler,
-	.timer_handler = timer_handler
-};
 /*
  * We give a *copy* of the faultinfo in the regs to segv.
  * This must be done, since nesting SEGVs could overwrite
@@ -252,6 +244,15 @@ void winch(int sig, union uml_pt_regs *r
 	do_IRQ(WINCH_IRQ, regs);
 }
 
+const struct kern_handlers handlinfo_kern = {
+	.relay_signal = relay_signal,
+	.winch = winch,
+	.bus_handler = bus_handler,
+	.page_fault = segv_handler,
+	.sigio_handler = sigio_handler,
+	.timer_handler = timer_handler
+};
+
 void trap_init(void)
 {
 }

