Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbUJXLZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUJXLZk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 07:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbUJXLRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 07:17:24 -0400
Received: from nl-ams-slo-l4-01-pip-5.chellonetwork.com ([213.46.243.21]:33851
	"EHLO amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261450AbUJXLPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 07:15:54 -0400
Date: Sun, 24 Oct 2004 13:15:52 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Antonino Daplas <adaplas@pol.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] Atyfb: kill assignment warnings on Atari due to __iomem
 changes
Message-ID: <Pine.LNX.4.61.0410241314550.27526@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Atyfb: kill assignment warnings on Atari due to __iomem changes

--- linux-2.6.10-rc1/drivers/video/aty/atyfb_base.c.orig	2004-10-23 10:33:27.000000000 +0200
+++ linux-2.6.10-rc1/drivers/video/aty/atyfb_base.c	2004-10-24 12:59:07.000000000 +0200
@@ -2344,9 +2344,9 @@ int __init atyfb_do_init(void)
 		info->screen_base = ioremap(phys_vmembase[m64_num],
 					 		   phys_size[m64_num]);	
 		info->fix.smem_start = (unsigned long)info->screen_base;	/* Fake! */
-		default_par->ati_regbase = (unsigned long)ioremap(phys_guiregbase[m64_num],
-							  0x10000) + 0xFC00ul;
-		info->fix.mmio_start = default_par->ati_regbase; /* Fake! */
+		default_par->ati_regbase = ioremap(phys_guiregbase[m64_num],
+						   0x10000) + 0xFC00ul;
+		info->fix.mmio_start = (unsigned long)default_par->ati_regbase; /* Fake! */
 
 		aty_st_le32(CLOCK_CNTL, 0x12345678, default_par);
 		clock_r = aty_ld_le32(CLOCK_CNTL, default_par);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
