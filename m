Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbUAAUsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbUAAUCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:02:46 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:7213 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S264563AbUAAUBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:01:50 -0500
Date: Thu, 1 Jan 2004 21:01:48 +0100
Message-Id: <200401012001.i01K1mLo031697@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 342] M68k head comments
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Update some comments (from Roman Zippel)

--- linux-2.6.0/arch/m68k/kernel/head.S	13 Oct 2003 22:48:56 -0000	1.11
+++ linux-m68k-2.6.0/arch/m68k/kernel/head.S	13 Oct 2003 22:52:41 -0000
@@ -1250,9 +1250,9 @@
 	mmu_map		#VIDEOMEMBASE,%d0,#VIDEOMEMSIZE,%d3
 	/* The ROM starts at 4000 0000		    	*/
 	mmu_map_eq	#0x40000000,#0x02000000,%d3
-	/* IO devices                               	*/
+	/* IO devices (incl. serial port) from 5000 0000 to 5300 0000 */
 	mmu_map_eq	#0x50000000,#0x03000000,%d3
-	/* NuBus slot space				*/
+	/* Nubus slot space (video at 0xF0000000, rom at 0xF0F80000) */
 	mmu_map_tt	#1,#0xf8000000,#0x08000000,%d3
 
 	jbra	L(mmu_init_done)
@@ -1891,7 +1891,7 @@
 	movel	%a4,%d5
 	addil	#PAGESIZE<<13,%d5
 	movel	%a0@+,%d6
-	btst	#1,%d6			/* is it a ptr? */
+	btst	#1,%d6			/* is it a table ptr? */
 	jbne	31f			/* yes */
 	btst	#0,%d6			/* is it early terminating? */
 	jbeq	1f			/* no */
@@ -1908,9 +1908,9 @@
 	movel	%a4,%d5
 	addil	#PAGESIZE<<6,%d5
 	movel	%a1@+,%d6
-	btst	#1,%d6
-	jbne	33f
-	btst	#0,%d6
+	btst	#1,%d6			/* is it a table ptr? */
+	jbne	33f			/* yes */
+	btst	#0,%d6			/* is it a page descriptor? */
 	jbeq	1f			/* no */
 	jbsr	mmu_030_print_helper
 	jbra	37f
@@ -3154,7 +3154,7 @@
 	moveml	%sp@+,%d0-%d7/%a2-%a6
 	jbra	L(serial_putc_done)
 2:
-#endif CONFIG_MVME16x
+#endif /* CONFIG_MVME16x */
 
 #ifdef CONFIG_BVME6000
 	is_not_bvme6000(2f)
@@ -3369,10 +3369,10 @@
 
 	/*
 	 *	At this point we make a shift in register usage
-	 *	a1 = address of Lconsole_font pointer
+	 *	a1 = address of console_font pointer
 	 */
 	lea	%pc@(L(console_font)),%a1
-	movel	%a0,%a1@	/* store pointer to struct font_desc in Lconsole_font */
+	movel	%a0,%a1@	/* store pointer to struct fbcon_font_desc in console_font */
 	tstl	%a0
 	jeq	1f
 
@@ -3383,10 +3383,10 @@
 	 *	6 x 11 also supported
 	 */
 		/* ASSERT: a0 = contents of Lconsole_font */
-	movel	%d3,%d0			/* screen width in pixels */
-	divul	%a0@(FONT_DESC_WIDTH),%d0		/* d0 = max num chars per row */
+	movel	%d3,%d0				/* screen width in pixels */
+	divul	%a0@(FONT_DESC_WIDTH),%d0	/* d0 = max num chars per row */
 
-	movel	%d4,%d1			 /* screen height in pixels */
+	movel	%d4,%d1				 /* screen height in pixels */
 	divul	%a0@(FONT_DESC_HEIGHT),%d1	 /* d1 = max num rows */
 
 	movel	%d0,%a2@(Lconsole_struct_num_columns)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
