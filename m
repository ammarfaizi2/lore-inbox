Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263514AbTHXM7o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTHXM6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:58:33 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:39187 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S263495AbTHXM6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:58:21 -0400
Date: Sun, 24 Aug 2003 14:58:51 +0200
Message-Id: <200308241258.h7OCwphp000985@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k switch_to
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Set last in switch_to(), fix asm constraints (from Andreas Schwab)

--- linux-2.6.0-test3/include/asm-m68k/system.h	Tue Mar 25 10:07:22 2003
+++ linux-m68k-2.6.0-test3/include/asm-m68k/system.h	Tue Aug 12 12:48:28 2003
@@ -36,9 +36,12 @@
 #define switch_to(prev,next,last) do { \
   register void *_prev __asm__ ("a0") = (prev); \
   register void *_next __asm__ ("a1") = (next); \
+  register void *_last __asm__ ("d1"); \
   __asm__ __volatile__("jbsr resume" \
-		       : : "a" (_prev), "a" (_next) \
-		       : "d0", "d1", "d2", "d3", "d4", "d5", "a0", "a1"); \
+		       : "=a" (_prev), "=a" (_next), "=d" (_last) \
+		       : "0" (_prev), "1" (_next) \
+		       : "d0", "d2", "d3", "d4", "d5"); \
+  (last) = _last; \
 } while (0)
 
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
