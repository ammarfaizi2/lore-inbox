Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVAQAiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVAQAiW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 19:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVAQAho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 19:37:44 -0500
Received: from mail.dif.dk ([193.138.115.101]:47341 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262620AbVAQAhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 19:37:32 -0500
Date: Mon, 17 Jan 2005 01:40:19 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Dave Jones <davej@redhat.com>
Subject: [PATCH] Line up CPU caps messages once more
Message-ID: <Pine.LNX.4.61.0501170127260.2730@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A while back I submitted a patch that made the "CPU: After * identify, 
caps:" messages produced by printk's in arch/i386/kernel/cpu/common.c line 
up nicely (http://www.ussg.iu.edu/hypermail/linux/kernel/0406.3/0222.html).
The patch was accepted back then, but recently a new patch  
http://linux.bkbits.net:8080/linux-2.6/diffs/arch/i386/kernel/cpu/common.c@1.35?nav=index.html|src/|src/arch|src/arch/i386|src/arch/i386/kernel|src/arch/i386/kernel/cpu|hist/arch/i386/kernel/cpu/common.c 
 broke that nice lineup of the messages again, so here's a patch to 
restore the visually pleasing printing of those messages (it also adds 
two comments this time to indicate that the extra spaces are there for a 
reason).
Hopefully this will make it back in, it looks so much nicer when stuff 
lines up like this:
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps:  0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
CPU: After all inits, caps:        0183f9ff c1c7f9ff 00000000 00000020 00000000 00000000 00000000


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-rc1-bk4-orig/arch/i386/kernel/cpu/common.c linux-2.6.11-rc1-bk4/arch/i386/kernel/cpu/common.c
--- linux-2.6.11-rc1-bk4-orig/arch/i386/kernel/cpu/common.c	2005-01-12 23:26:01.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/i386/kernel/cpu/common.c	2005-01-17 01:16:29.000000000 +0100
@@ -350,7 +350,8 @@ void __init identify_cpu(struct cpuinfo_
 	if (this_cpu->c_identify) {
 		this_cpu->c_identify(c);
 
-		printk(KERN_DEBUG "CPU: After vendor identify, caps:");
+		/* extra spacing at the end on purpose to line up message with above printk */
+		printk(KERN_DEBUG "CPU: After vendor identify, caps: ");
 		for (i = 0; i < NCAPINTS; i++)
 			printk(" %08lx", c->x86_capability[i]);
 		printk("\n");
@@ -404,7 +405,8 @@ void __init identify_cpu(struct cpuinfo_
 
 	/* Now the feature flags better reflect actual CPU features! */
 
-	printk(KERN_DEBUG "CPU: After all inits, caps:");
+	/* extra spacing at the end on purpose to line up message with above printk */
+	printk(KERN_DEBUG "CPU: After all inits, caps:       ");
 	for (i = 0; i < NCAPINTS; i++)
 		printk(" %08lx", c->x86_capability[i]);
 	printk("\n");



