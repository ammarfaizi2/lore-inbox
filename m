Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbUDMI7X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbUDMI5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:57:24 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:34344 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S263372AbUDMIqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:46:54 -0400
Date: Tue, 13 Apr 2004 10:38:09 +0200
Message-Id: <200404130838.i3D8c9CH018455@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 429] Sun-3 duplicates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3: Kill duplicate definitions:
  - FC_CONTROL is defined in <asm/sun3-head.h>
  - vectors[] is declared in <asm/traps.h>

--- linux-2.6.5-rc2/arch/m68k/sun3/leds.c	1999-09-04 22:06:41.000000000 +0200
+++ linux-m68k-2.6.5-rc2/arch/m68k/sun3/leds.c	2004-03-21 20:42:05.000000000 +0100
@@ -1,9 +1,6 @@
 #include <asm/contregs.h>
 #include <asm/sun3mmu.h>
 #include <asm/io.h>
-#include <asm/movs.h>
-
-#define FC_CONTROL 3    /* This should go somewhere else... */
 
 void sun3_leds(unsigned char byte)
 {
--- linux-2.6.5-rc2/arch/m68k/sun3x/prom.c	2003-05-05 10:30:22.000000000 +0200
+++ linux-m68k-2.6.5-rc2/arch/m68k/sun3x/prom.c	2004-03-28 12:01:44.000000000 +0200
@@ -31,8 +31,6 @@
 /* prom vector table */
 e_vector *sun3x_prom_vbr;
 
-extern e_vector vectors[256];  /* arch/m68k/kernel/traps.c */
-
 /* Handle returning to the prom */
 void sun3x_halt(void)
 {
--- linux-2.6.5-rc2/include/asm-m68k/sun3mmu.h	2003-12-23 11:31:10.000000000 +0100
+++ linux-m68k-2.6.5-rc2/include/asm-m68k/sun3mmu.h	2004-03-21 20:12:20.000000000 +0100
@@ -1,12 +1,11 @@
 /*
  * Definitions for Sun3 custom MMU.
  */
-#include <asm/movs.h>
-
 #ifndef __SUN3_MMU_H__
 #define __SUN3_MMU_H__
 
-#define FC_CONTROL 3
+#include <asm/movs.h>
+#include <asm/sun3-head.h>
 
 /* MMU characteristics. */
 #define SUN3_SEGMAPS_PER_CONTEXT	2048

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
