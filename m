Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRACVW3>; Wed, 3 Jan 2001 16:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRACVWT>; Wed, 3 Jan 2001 16:22:19 -0500
Received: from www.inreko.ee ([195.222.18.2]:50083 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S129324AbRACVWK>;
	Wed, 3 Jan 2001 16:22:10 -0500
Date: Wed, 3 Jan 2001 23:32:52 +0200
From: Marko Kreen <marko@l-t.ee>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-fbdev@vuser.vu.union.edu
Subject: [patch] big udelay's in fb drivers (2.4.0-prerelease)
Message-ID: <20010103233252.A10972@l-t.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I hope these are right fixes...

-- 
marko


diff -urNX /home/marko/misc/diff-exclude linux-2.4.0-prerelease/drivers/video/atyfb.c linux/drivers/video/atyfb.c
--- linux-2.4.0-prerelease/drivers/video/atyfb.c	Wed Jan  3 19:55:56 2001
+++ linux/drivers/video/atyfb.c	Wed Jan  3 22:42:32 2001
@@ -1722,7 +1722,7 @@
     aty_st_8(CRTC_GEN_CNTL + 3, old_crtc_ext_disp | (CRTC_EXT_DISP_EN >> 24),
 	     info);
 
-    udelay(15000); /* delay for 50 (15) ms */
+    mdelay(15); /* delay for 50 (15) ms */
 
     program_bits = pll->program_bits;
     locationAddr = pll->locationAddr;
@@ -1754,7 +1754,7 @@
     aty_st_8(CLOCK_CNTL + info->clk_wr_offset, old_clock_cntl | CLOCK_STROBE,
 	     info);
 
-    udelay(50000); /* delay for 50 (15) ms */
+    mdelay(50); /* delay for 50 (15) ms */
     aty_st_8(CLOCK_CNTL + info->clk_wr_offset,
 	     ((pll->locationAddr & 0x0F) | CLOCK_STROBE), info);
 
diff -urNX /home/marko/misc/diff-exclude linux-2.4.0-prerelease/drivers/video/clgenfb.c linux/drivers/video/clgenfb.c
--- linux-2.4.0-prerelease/drivers/video/clgenfb.c	Mon Dec  4 20:44:57 2000
+++ linux/drivers/video/clgenfb.c	Wed Jan  3 22:42:56 2001
@@ -1899,7 +1899,7 @@
 		break;
 	case BT_PICASSO4:
 		vga_wcrt (fb_info->regs, CL_CRT51, 0x00);	/* disable flickerfixer */
-		udelay (100000);
+		mdelay (100);
 		vga_wgfx (fb_info->regs, CL_GR2F, 0x00);	/* from Klaus' NetBSD driver: */
 		vga_wgfx (fb_info->regs, CL_GR33, 0x00);	/* put blitter into 542x compat */
 		vga_wgfx (fb_info->regs, CL_GR31, 0x00);	/* mode */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
