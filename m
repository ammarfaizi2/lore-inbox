Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUBTNMn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbUBTMw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:52:28 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:1101 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261197AbUBTMsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:48:36 -0500
Date: Fri, 20 Feb 2004 13:48:21 +0100
Message-Id: <200402201248.i1KCmLI4004293@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 409] M68k call trace output
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Improve formatting of call trace output (from Matthias Urlichs)

--- linux-2.6.3/arch/m68k/kernel/traps.c	2004-01-21 22:03:12.000000000 +0100
+++ linux-m68k-2.6.3/arch/m68k/kernel/traps.c	2003-11-23 20:59:33.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/ptrace.h>
+#include <linux/kallsyms.h>
 
 #include <asm/setup.h>
 #include <asm/fpu.h>
@@ -825,9 +826,12 @@
 		 * out the call path that was taken.
 		 */
 		if (kernel_text_address(addr)) {
-			if (i % 4 == 0)
+#ifndef CONFIG_KALLSYMS
+			if (i % 5 == 0)
 				printk("\n       ");
+#endif
 			printk(" [<%08lx>]", addr);
+			print_symbol(" %s\n", addr);
 			i++;
 		}
 	}
@@ -1098,8 +1102,10 @@
 
 	console_verbose();
 	printk("%s: %08x\n",str,nr);
-	printk("PC: [<%08lx>]\nSR: %04x  SP: %p  a2: %08lx\n",
-	       fp->pc, fp->sr, fp, fp->a2);
+	printk("PC: [<%08lx>]",fp->pc);
+	print_symbol(" %s\n", fp->pc);
+	printk("\nSR: %04x  SP: %p  a2: %08lx\n",
+	       fp->sr, fp, fp->a2);
 	printk("d0: %08lx    d1: %08lx    d2: %08lx    d3: %08lx\n",
 	       fp->d0, fp->d1, fp->d2, fp->d3);
 	printk("d4: %08lx    d5: %08lx    a0: %08lx    a1: %08lx\n",

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
