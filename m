Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbTDMM5g (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 08:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbTDMM5g (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 08:57:36 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:50995 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S263503AbTDMM4P (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 08:56:15 -0400
Date: Sun, 13 Apr 2003 15:05:14 +0200
Message-Id: <200304131305.h3DD5EQi001293@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k ndelay()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: add ndelay() implementation (needed for IDE)

--- linux-2.4.21-pre7/include/asm-m68k/delay.h	Thu Jan  4 22:00:55 2001
+++ linux-m68k-2.4.21-pre7/include/asm-m68k/delay.h	Sun Mar 30 22:22:40 2003
@@ -16,6 +16,7 @@
 }
 
 extern void __bad_udelay(void);
+extern void __bad_ndelay(void);
 
 /*
  * Use only for very small delays ( < 1 msec).  Should probably use a
@@ -39,9 +40,18 @@
 	__const_udelay(usecs * 4295);	/* 2**32 / 1000000 */
 }
 
+static inline void __ndelay(unsigned long nsecs)
+{
+	__const_udelay(nsecs * 5);	/* 2**32 / 1000000000 */
+}
+
 #define udelay(n) (__builtin_constant_p(n) ? \
 	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 4295)) : \
 	__udelay(n))
+
+#define ndelay(n) (__builtin_constant_p(n) ? \
+	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5)) : \
+	__ndelay(n))
 
 extern __inline__ unsigned long muldiv(unsigned long a, unsigned long b, unsigned long c)
 {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
