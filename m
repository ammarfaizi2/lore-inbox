Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUJBRCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUJBRCm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUJBRBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:01:15 -0400
Received: from nl-ams-slo-l4-01-pip-5.chellonetwork.com ([213.46.243.21]:18210
	"EHLO amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S267408AbUJBRA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:00:27 -0400
Date: Sat, 2 Oct 2004 19:00:24 +0200
Message-Id: <200410021700.i92H0OAu021188@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 494] NULL vs. 0 cleanups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few more NULL vs. 0 cleanups, as detected by sparse.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9-rc3/arch/m68k/kernel/setup.c	2004-08-04 12:13:35.000000000 +0200
+++ linux-m68k-2.6.9-rc3-sparse/arch/m68k/kernel/setup.c	2004-09-29 14:25:11.000000000 +0200
@@ -352,7 +343,7 @@
 #ifndef CONFIG_SUN3
 	startmem= m68k_memory[0].addr;
 	endmem = startmem + m68k_memory[0].size;
-	high_memory = PAGE_OFFSET;
+	high_memory = (void *)PAGE_OFFSET;
 	for (i = 0; i < m68k_num_memory; i++) {
 		m68k_memory[i].size &= MASK_256K;
 		if (m68k_memory[i].addr < startmem)
--- linux-2.6.9-rc3/arch/m68k/mm/memory.c	2004-08-14 15:35:36.000000000 +0200
+++ linux-m68k-2.6.9-rc3-sparse/arch/m68k/mm/memory.c	2004-09-29 14:22:34.000000000 +0200
@@ -77,7 +77,7 @@
 		ptable_desc *new;
 
 		if (!(page = (void *)get_zeroed_page(GFP_KERNEL)))
-			return 0;
+			return NULL;
 
 		flush_tlb_kernel_page(page);
 		nocache_page(page);
--- linux-2.6.9-rc3/include/asm-generic/dma-mapping-broken.h	2004-04-28 15:49:03.000000000 +0200
+++ linux-m68k-2.6.9-rc3-sparse/include/asm-generic/dma-mapping-broken.h	2004-09-30 17:53:55.000000000 +0200
@@ -9,7 +9,7 @@
 		   int flag)
 {
 	BUG();
-	return 0;
+	return NULL;
 }
 
 static inline void
--- linux-2.6.9-rc3/drivers/char/amiserial.c	2004-09-13 21:57:40.000000000 +0200
+++ linux-m68k-2.6.9-rc3-sparse/drivers/char/amiserial.c	2004-09-30 17:59:41.000000000 +0200
@@ -647,7 +651,7 @@
 	/*
 	 * and set the speed of the serial port
 	 */
-	change_speed(info, 0);
+	change_speed(info, NULL);
 
 	info->flags |= ASYNC_INITIALIZED;
 	local_irq_restore(flags);
@@ -693,7 +697,7 @@
 
 	if (info->xmit.buf) {
 		free_page((unsigned long) info->xmit.buf);
-		info->xmit.buf = 0;
+		info->xmit.buf = NULL;
 	}
 
 	info->IER = 0;
@@ -1209,7 +1215,7 @@
 				info->tty->alt_speed = 230400;
 			if ((state->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
 				info->tty->alt_speed = 460800;
-			change_speed(info, 0);
+			change_speed(info, NULL);
 		}
 	} else
 		retval = startup(info);
@@ -1564,7 +1570,7 @@
 		tty->ldisc.flush_buffer(tty);
 	tty->closing = 0;
 	info->event = 0;
-	info->tty = 0;
+	info->tty = NULL;
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
@@ -1657,7 +1663,7 @@
 	info->event = 0;
 	state->count = 0;
 	info->flags &= ~ASYNC_NORMAL_ACTIVE;
-	info->tty = 0;
+	info->tty = NULL;
 	wake_up_interruptible(&info->open_wait);
 }
 
@@ -1913,7 +1919,7 @@
 		info->magic = SERIAL_MAGIC;
 		info->flags = state->flags;
 		info->quot = 0;
-		info->tty = 0;
+		info->tty = NULL;
 	}
 	local_irq_save(flags);
 	status = ciab.pra;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
