Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272550AbTGZPSn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 11:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272549AbTGZOlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:41:42 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:6745 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S272536AbTGZOcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:54 -0400
Date: Sat, 26 Jul 2003 16:52:03 +0200
Message-Id: <200307261452.h6QEq3rL002508@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k irqs_disabled()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Allow ALLOWINT to be used with other types than short (fixes a problem
with irqs_disabled(), from Roman Zippel)

--- linux-2.6.x/include/asm-m68k/entry.h	Thu Jul 25 12:54:07 2002
+++ linux-m68k-2.6.x/include/asm-m68k/entry.h	Wed Jul 23 22:16:16 2003
@@ -34,11 +34,11 @@
 /* the following macro is used when enabling interrupts */
 #if defined(MACH_ATARI_ONLY) && !defined(CONFIG_HADES)
 	/* block out HSYNC on the atari */
-#define ALLOWINT 0xfbff
+#define ALLOWINT	(~0x400)
 #define	MAX_NOINT_IPL	3
 #else
 	/* portable version */
-#define ALLOWINT 0xf8ff
+#define ALLOWINT	(~0x700)
 #define	MAX_NOINT_IPL	0
 #endif /* machine compilation types */ 
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
