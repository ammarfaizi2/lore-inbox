Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVAGWze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVAGWze (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVAGWw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:52:59 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.13]:33844 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S261676AbVAGWux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:50:53 -0500
Date: Fri, 7 Jan 2005 23:50:49 +0100
Message-Id: <200501072250.j07Monq3012305@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 539] M68k: Remove nowhere referenced files
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Remove nowhere referenced files

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10/arch/m68k/apollo/dn_debug.c	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.10/arch/m68k/apollo/dn_debug.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,22 +0,0 @@
-
-#define DN_DEBUG_BUFFER_BASE 0x82800000
-#define DN_DEBUG_BUFFER_SIZE 8*1024*1024
-
-static char *current_dbg_ptr=DN_DEBUG_BUFFER_BASE;
-
-int dn_deb_printf(const char *fmt, ...) {
-
-	va_list args;
-	int i;
-
-	if(current_dbg_ptr<(DN_DEBUG_BUFFER_BASE + DN_DEBUG_BUFFER_SIZE)) {
-		va_start(args,fmt);
-		i=vsprintf(current_dbg_ptr,fmt,args);
-		va_end(args);
-		current_dbg_ptr+=i;
-
-		return i;
-	}
-	else
-		return 0;
-}
--- linux-2.6.10/arch/m68k/sun3x/sun3x_ksyms.c	2004-04-27 16:25:45.000000000 +0200
+++ linux-m68k-2.6.10/arch/m68k/sun3x/sun3x_ksyms.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,13 +0,0 @@
-#include <linux/module.h>
-#include <linux/types.h>
-#include <asm/dvma.h>
-#include <asm/idprom.h>
-
-/*
- * Add things here when you find the need for it.
- */
-EXPORT_SYMBOL(dvma_map_align);
-EXPORT_SYMBOL(dvma_unmap);
-EXPORT_SYMBOL(dvma_malloc_align);
-EXPORT_SYMBOL(dvma_free);
-EXPORT_SYMBOL(idprom);
--- linux-2.6.10/include/asm-m68k/atari_SCCserial.h	2004-05-24 11:13:52.000000000 +0200
+++ linux-m68k-2.6.10/include/asm-m68k/atari_SCCserial.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,67 +0,0 @@
-#ifndef _ATARI_SCCSERIAL_H
-#define _ATARI_SCCSERIAL_H
-
-/* Special configuration ioctls for the Atari SCC5380 Serial
- * Communications Controller
- */
-
-/* ioctl command codes */
-
-#define TIOCGATSCC	0x54c0	/* get SCC configuration */
-#define TIOCSATSCC	0x54c1	/* set SCC configuration */
-#define TIOCDATSCC	0x54c2	/* reset configuration to defaults */
-
-/* Clock sources */
-
-#define CLK_RTxC	0
-#define CLK_TRxC	1
-#define CLK_PCLK	2
-
-/* baud_bases for the common clocks in the Atari. These are the real
- * frequencies divided by 16.
- */
-
-#define SCC_BAUD_BASE_TIMC	19200	/* 0.3072 MHz from TT-MFP, Timer C */
-#define SCC_BAUD_BASE_BCLK	153600	/* 2.4576 MHz */
-#define SCC_BAUD_BASE_PCLK4	229500	/* 3.6720 MHz */
-#define SCC_BAUD_BASE_PCLK	503374	/* 8.0539763 MHz */
-#define SCC_BAUD_BASE_NONE	0		/* for not connected or unused
-						 * clock sources */
-
-#define SCC_BAUD_BASE_M147_PCLK	312500	/* 5 MHz */
-#define SCC_BAUD_BASE_M147	312500	/* 5 MHz */
-#define SCC_BAUD_BASE_MVME_PCLK	781250	/* 12.5 MHz */
-#define SCC_BAUD_BASE_MVME	625000	/* 10.000 MHz */
-#define SCC_BAUD_BASE_BVME_PCLK	781250	/* 12.5 MHz */   /* XXX ??? */
-#define SCC_BAUD_BASE_BVME	460800	/* 7.3728 MHz */
-
-/* The SCC configuration structure */
-
-struct atari_SCCserial {
-	unsigned	RTxC_base;	/* base_baud of RTxC */
-	unsigned	TRxC_base;	/* base_baud of TRxC */
-	unsigned	PCLK_base;	/* base_baud of PCLK, for both channels! */
-	struct {
-		unsigned clksrc;	/* CLK_RTxC, CLK_TRxC or CLK_PCLK */
-		unsigned divisor;	/* divisor for base baud, valid values:
-					 * see below */
-	} baud_table[17];		/* For 50, 75, 110, 135, 150, 200, 300,
-					 * 600, 1200, 1800, 2400, 4800, 9600,
-					 * 19200, 38400, 57600 and 115200 bps. The
-					 * last two could be replaced by other
-					 * rates > 38400 if they're not possible.
-					 */
-};
-
-/* The following divisors are valid:
- *
- *   - CLK_RTxC: 1 or even (1, 2 and 4 are the direct modes, > 4 use
- *               the BRG)
- *
- *   - CLK_TRxC: 1, 2 or 4 (no BRG, only direct modes possible)
- *
- *   - CLK_PCLK: >= 4 and even (no direct modes, only BRG)
- *
- */
-
-#endif /* _ATARI_SCCSERIAL_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
