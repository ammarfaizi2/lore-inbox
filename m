Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267421AbUJBRME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267421AbUJBRME (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267438AbUJBRJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:09:12 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.20]:9821 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S267421AbUJBRF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:05:27 -0400
Date: Sat, 2 Oct 2004 19:05:23 +0200
Message-Id: <200410021705.i92H5Nc8021785@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 160] m68k MM off-by-one
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Fix off-by-one error in zone size calculation (from Didier Mequignon and
Petr Stehlik)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.4.28-pre3/arch/m68k/mm/motorola.c.old	2003-08-30 08:01:28.000000000 +0200
+++ linux-m68k-2.4.28-pre3/arch/m68k/mm/motorola.c	2004-05-07 09:01:10.000000000 +0200
@@ -264,7 +264,7 @@
 	printk ("before free_area_init\n");
 #endif
 	zones_size[0] = (mach_max_dma_address < (unsigned long)high_memory ?
-			 mach_max_dma_address : (unsigned long)high_memory);
+			 (mach_max_dma_address+1) : (unsigned long)high_memory);
 	zones_size[1] = (unsigned long)high_memory - zones_size[0];
 
 	zones_size[0] = (zones_size[0] - PAGE_OFFSET) >> PAGE_SHIFT;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
