Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTFXPkS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 11:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTFXPbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 11:31:23 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:60045 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262148AbTFXPa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 11:30:56 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 24 Jun 2003 17:49:52 +0200
From: Gerd Knorr <kraxel@suse.de>
To: Kernel List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: [x86_64 PATCH 1/2] build fix -- show_stack
Message-ID: <20030624154951.GA30885@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 79C4 EE94 CC44 6DD4 58C6  3088 DBB7 EC73 8750 D2C4  [1024D/8750D2C4]
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Trivial fix for show_stack() to make 2.5.73 build.

  Gerd

--- o-linux-2.5.73/arch/x86_64/kernel/traps.c.stack	2003-06-24 12:04:20.000000000 +0200
+++ o-linux-2.5.73/arch/x86_64/kernel/traps.c	2003-06-24 12:16:06.000000000 +0200
@@ -206,7 +206,7 @@
 	show_trace((unsigned long *)rsp);
 }
 
-void show_stack(unsigned long * rsp)
+void show_stack(struct task_struct *task, unsigned long *rsp)
 {
 	unsigned long *stack;
 	int i;
@@ -269,7 +269,7 @@
 	if (in_kernel) {
 
 		printk("Stack: ");
-		show_stack((unsigned long*)rsp);
+		show_stack(current, (unsigned long*)rsp);
 
 		printk("\nCode: ");
 		if(regs->rip < PAGE_OFFSET)
--- o-linux-2.5.73/include/asm-x86_64/proto.h.stack	2003-06-24 12:03:24.000000000 +0200
+++ o-linux-2.5.73/include/asm-x86_64/proto.h	2003-06-24 12:16:30.000000000 +0200
@@ -52,7 +52,10 @@
 
 extern unsigned long cpu_initialized;
 
+#if 0
+// prototype moved to linux/sched.h ...
 extern void show_stack(unsigned long * rsp);
+#endif
 extern void show_trace(unsigned long * rsp);
 extern void show_registers(struct pt_regs *regs);
 
