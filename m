Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUBTMtd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbUBTMrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:47:33 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:18708 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261183AbUBTMqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:46:54 -0500
Date: Fri, 20 Feb 2004 13:46:39 +0100
Message-Id: <200402201246.i1KCkdvx004199@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 395] Sun-3 missing sbus_readl()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3 sbus: Add missing definition of sbus_readl() (from Sam Creasey)

--- linux-2.6.3/include/asm-m68k/sbus.h	2003-11-30 20:07:03.000000000 +0100
+++ linux-m68k-2.6.3/include/asm-m68k/sbus.h	2004-01-15 13:59:33.000000000 +0100
@@ -36,8 +36,15 @@
 
 }
 
+extern inline unsigned long _sbus_readl(unsigned long addr)
+{
+	return *(volatile unsigned long *)addr;
+}
+
+
 #define sbus_readb(a) _sbus_readb((unsigned long)a)
 #define sbus_writeb(v, a) _sbus_writeb(v, (unsigned long)a)
+#define sbus_readl(a) _sbus_readl((unsigned long)a)
 #define sbus_writel(v, a) _sbus_writel(v, (unsigned long)a)
 
 #endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
