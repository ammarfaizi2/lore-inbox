Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVAMWEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVAMWEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVAMWC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:02:28 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:46085 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261765AbVAMV6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:58:32 -0500
Subject: [patch 10/11] uml: add stack addresses to dumps
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it,
       bstroesser@fujitsu-siemens.com
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 22:01:11 +0100
Message-Id: <20050113210111.86DE01FEFB@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Add stack addresses to print of symbols from stack trace.
For stack analysis it's important to have this information.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

For UML, we should also copy the CONFIG_FRAME_POINTER stack walking from i386,
and move the result to sys-i386.

Another note: this should be done for i386 also, if ksymoops does not have
problems.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/sysrq.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN arch/um/kernel/sysrq.c~uml-add-stack-addresses-to-dumps arch/um/kernel/sysrq.c
--- linux-2.6.11/arch/um/kernel/sysrq.c~uml-add-stack-addresses-to-dumps	2005-01-13 21:54:57.450269544 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/sysrq.c	2005-01-13 21:56:09.250354272 +0100
@@ -25,12 +25,13 @@ void show_trace(unsigned long * stack)
 
         printk("Call Trace: \n");
         while (((long) stack & (THREAD_SIZE-1)) != 0) {
-                addr = *stack++;
+                addr = *stack;
 		if (__kernel_text_address(addr)) {
-			printk(" [<%08lx>]", addr);
+			printk("%08lx:  [<%08lx>]", (unsigned long) stack, addr);
 			print_symbol(" %s", addr);
 			printk("\n");
                 }
+                stack++;
         }
         printk("\n");
 }
_
