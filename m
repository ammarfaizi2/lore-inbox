Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267408AbUJBRCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUJBRCl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUJBRBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:01:32 -0400
Received: from nl-ams-slo-l4-01-pip-6.chellonetwork.com ([213.46.243.23]:62752
	"EHLO amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S267415AbUJBRAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:00:30 -0400
Date: Sat, 2 Oct 2004 19:00:22 +0200
Message-Id: <200410021700.i92H0MUF021150@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 487] m68k MM off-by-one
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Fix off-by-one error in zone size calculation (from Didier Mequignon and
Petr Stehlik)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9-rc3/arch/m68k/mm/motorola.c.old	2003-08-30 08:01:28.000000000 +0200
+++ linux-m68k-2.6.9-rc3/arch/m68k/mm/motorola.c	2004-05-07 09:01:10.000000000 +0200
@@ -258,7 +258,7 @@
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
