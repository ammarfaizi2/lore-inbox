Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbTH2O6C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTH2O5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:57:50 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:31067 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261314AbTH2OwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:52:13 -0400
Date: Fri, 29 Aug 2003 16:51:15 +0200
Message-Id: <200308291451.h7TEpF6k005938@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k switch_to
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Fix asm constraints in switch_to() (from Andreas Schwab)

--- linux-2.4.23-pre1/include/asm-m68k/system.h	Fri May 23 09:53:45 2003
+++ linux-m68k-2.4.23-pre1/include/asm-m68k/system.h	Tue Aug 12 12:40:32 2003
@@ -42,8 +42,9 @@
   register void *_next __asm__ ("a1") = (next); \
   register void *_last __asm__ ("d1"); \
   __asm__ __volatile__("jbsr " SYMBOL_NAME_STR(resume) \
-		       : "=d" (_last) : "a" (_prev), "a" (_next) \
-		       : "d0", /* "d1", */ "d2", "d3", "d4", "d5", "a0", "a1"); \
+		       : "=a" (_prev), "=a" (_next), "=d" (_last) \
+		       : "0" (_prev), "1" (_next)		  \
+		       : "d0", "d2", "d3", "d4", "d5"); \
   (last) = _last; \
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
