Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265471AbUAAUsC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUAAUD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:03:57 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.14]:16457 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S264574AbUAAUBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:01:52 -0500
Date: Thu, 1 Jan 2004 21:01:50 +0100
Message-Id: <200401012001.i01K1oBM031715@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 345] M68k cache mode
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Use a constant m68k_supervisor_cachemode only if we know it's safe,
otherwise use the value from head.S (from Roman Zippel)

--- linux-2.6.0/include/asm-m68k/motorola_pgtable.h	11 Jul 2003 15:18:46 -0000	1.8
+++ linux-m68k-2.6.0/include/asm-m68k/motorola_pgtable.h	16 Oct 2003 20:56:07 -0000
@@ -41,10 +41,14 @@
  * processors >= '040. It is used in pte_mkcache(), and the variable is
  * defined and initialized in head.S */
 
-#if defined(CONFIG_060_WRITETHROUGH)
-extern int m68k_supervisor_cachemode;
-#else
+#if defined(CPU_M68060_ONLY) && defined(CONFIG_060_WRITETHROUGH)
+#define m68k_supervisor_cachemode _PAGE_CACHE040W
+#elif defined(CPU_M68040_OR_M68060_ONLY)
 #define m68k_supervisor_cachemode _PAGE_CACHE040
+#elif defined(CPU_M68020_OR_M68030_ONLY)
+#define m68k_supervisor_cachemode 0
+#else
+extern int m68k_supervisor_cachemode;
 #endif
 
 #if defined(CPU_M68040_OR_M68060_ONLY)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
