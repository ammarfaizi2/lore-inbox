Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264542AbRGDMtH>; Wed, 4 Jul 2001 08:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264582AbRGDMs5>; Wed, 4 Jul 2001 08:48:57 -0400
Received: from hood.tvd.be ([195.162.196.21]:23365 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S264542AbRGDMsk>;
	Wed, 4 Jul 2001 08:48:40 -0400
Date: Wed, 4 Jul 2001 14:45:21 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <laughing@shared-source.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac24
In-Reply-To: <20010703220532.A32104@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.05.10107041441460.3637-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2001, Alan Cox wrote:
> 2.4.5-ac24
> o	Merge 2.4.6-pre9
> 	- Ignored ATI changes versus old atyfb codebase

drivers/video/aty/ in your tree is still for the ATI Mach64 family only. So you
should keep on merging aty128fb (for ATI Rage 128). The integration of the
support for Rage 128 and Radeon in the new atyfb has not been completed yet.

Here is a patch to bring the atyfb in your tree in sync with the atyfb in
Linus' tree. This does not include the changes to aty128fb, they can be copied
from Linus' tree directly.

--- linux-2.4.5-ac24/drivers/video/aty/atyfb_base.c	Fri Jun 29 11:01:44 2001
+++ linux-atyfb-2.4.5-ac24/drivers/video/aty/atyfb_base.c	Wed Jul  4 14:43:21 2001
@@ -1430,7 +1430,7 @@
 static void atyfb_save_palette(struct fb_info *fb, int enter)
 {
 	struct fb_info_aty *info = (struct fb_info_aty *)fb;
-	int i, tmp, scale;
+	int i, tmp;
 
 	for (i = 0; i < 256; i++) {
 		tmp = aty_ld_8(DAC_CNTL, info) & 0xfc;
@@ -1439,14 +1439,11 @@
 		aty_st_8(DAC_CNTL, tmp, info);
 		aty_st_8(DAC_MASK, 0xff, info);
 
-		scale = (M64_HAS(INTEGRATED) &&
-			 info->current_par.crtc.bpp == 16) ? 3 : 0;
-		writeb(i << scale, &info->aty_cmap_regs->rindex);
-
+		writeb(i, &info->aty_cmap_regs->rindex);
 		atyfb_save.r[enter][i] = readb(&info->aty_cmap_regs->lut);
 		atyfb_save.g[enter][i] = readb(&info->aty_cmap_regs->lut);
 		atyfb_save.b[enter][i] = readb(&info->aty_cmap_regs->lut);
-		writeb(i << scale, &info->aty_cmap_regs->windex);
+		writeb(i, &info->aty_cmap_regs->windex);
 		writeb(atyfb_save.r[1-enter][i], &info->aty_cmap_regs->lut);
 		writeb(atyfb_save.g[1-enter][i], &info->aty_cmap_regs->lut);
 		writeb(atyfb_save.b[1-enter][i], &info->aty_cmap_regs->lut);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

