Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265806AbUFTRky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265806AbUFTRky (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUFTR3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:29:08 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.20]:23578 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S265806AbUFTRZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:25:56 -0400
Date: Sun, 20 Jun 2004 19:25:56 +0200
Message-Id: <200406201725.i5KHPuur001494@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 453] M68k set_page_count()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: From 2.6.7-rc1 on, it's no longer allowed to access page->count directly 

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.7/arch/m68k/mm/memory.c	2004-05-03 11:01:24.000000000 +0200
+++ linux-m68k-2.6.7/arch/m68k/mm/memory.c	2004-05-24 15:55:41.000000000 +0200
@@ -54,7 +54,7 @@ void __init init_pointer_table(unsigned 
 
 	/* unreserve the page so it's possible to free that page */
 	PD_PAGE(dp)->flags &= ~(1 << PG_reserved);
-	atomic_set(&PD_PAGE(dp)->count, 1);
+	set_page_count(PD_PAGE(dp), 1);
 
 	return;
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
