Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbTLGUzp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbTLGUx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:53:57 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:5207 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S264520AbTLGUxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:53:50 -0500
Date: Sun, 7 Dec 2003 21:49:36 +0100
Message-Id: <200312072049.hB7Knag8000672@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 124] M68k cache mode
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Use a constant m68k_supervisor_cachemode only if we know it's safe,
otherwise use the value from head.S (from Roman Zippel)

--- linux-2.4.23/include/asm-m68k/motorola_pgtable.h	26 Mar 2003 23:05:38 -0000	1.1.1.1.2.2
+++ linux-m68k-2.4.23/include/asm-m68k/motorola_pgtable.h	16 Oct 2003 20:56:45 -0000
@@ -40,10 +40,14 @@
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
