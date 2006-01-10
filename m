Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWAJSXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWAJSXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWAJSXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:23:47 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:32239 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S932464AbWAJSXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:23:46 -0500
Date: Tue, 10 Jan 2006 10:23:41 -0800
Message-Id: <200601101823.k0AINfMt032199@dhcp153.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Split schedule() {raw_}irq warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I changed this error message so it's clear what triggered it.
If it's a raw_ type it says it's raw.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.15/kernel/sched.c
===================================================================
--- linux-2.6.15.orig/kernel/sched.c
+++ linux-2.6.15/kernel/sched.c
@@ -3568,9 +3568,10 @@ asmlinkage void __sched schedule(void)
 	 */
 	if (unlikely(irqs_disabled() || raw_irqs_disabled())) {
 		stop_trace();
-		printk(KERN_ERR "BUG: scheduling with irqs disabled: "
+		printk(KERN_ERR "BUG: scheduling with %sirqs disabled: "
 			"%s/0x%08x/%d\n",
-				current->comm, preempt_count(), current->pid);
+				(irqs_disabled())?"":"raw ", current->comm, 
+				preempt_count(), current->pid);
 		print_symbol("caller is %s\n",
 			(long)__builtin_return_address(0));
 		dump_stack();
