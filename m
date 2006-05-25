Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWEYB0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWEYB0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWEYB0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:26:43 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:28814 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964813AbWEYB0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:26:42 -0400
Message-Id: <20060525003421.479787000@linux-m68k.org>
References: <20060525002742.723577000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Thu, 25 May 2006 02:27:48 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] print correct stack trace
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pass unmodified stack argument to show_trace().

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/kernel/traps.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6-mm/arch/m68k/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/m68k/kernel/traps.c
+++ linux-2.6-mm/arch/m68k/kernel/traps.c
@@ -992,6 +992,7 @@ void show_registers(struct pt_regs *regs
 
 void show_stack(struct task_struct *task, unsigned long *stack)
 {
+	unsigned long *p;
 	unsigned long *endstack;
 	int i;
 
@@ -1004,12 +1005,13 @@ void show_stack(struct task_struct *task
 	endstack = (unsigned long *)(((unsigned long)stack + THREAD_SIZE - 1) & -THREAD_SIZE);
 
 	printk("Stack from %08lx:", (unsigned long)stack);
+	p = stack;
 	for (i = 0; i < kstack_depth_to_print; i++) {
-		if (stack + 1 > endstack)
+		if (p + 1 > endstack)
 			break;
 		if (i % 8 == 0)
 			printk("\n       ");
-		printk(" %08lx", *stack++);
+		printk(" %08lx", *p++);
 	}
 	printk("\n");
 	show_trace(stack);

--

