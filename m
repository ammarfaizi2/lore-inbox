Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131594AbRACWX6>; Wed, 3 Jan 2001 17:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131539AbRACWXt>; Wed, 3 Jan 2001 17:23:49 -0500
Received: from www.inreko.ee ([195.222.18.2]:27044 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S131549AbRACWXj>;
	Wed, 3 Jan 2001 17:23:39 -0500
Date: Thu, 4 Jan 2001 00:34:22 +0200
From: Marko Kreen <marko@l-t.ee>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-fbdev@vuser.vu.union.edu
Subject: Re: [patch] big udelay's in fb drivers (2.4.0-prerelease)
Message-ID: <20010104003422.A12099@l-t.ee>
In-Reply-To: <20010103233252.A10972@l-t.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010103233252.A10972@l-t.ee>; from marko@l-t.ee on Wed, Jan 03, 2001 at 11:32:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 11:32:52PM +0200, Marko Kreen wrote:
> -    udelay(15000); /* delay for 50 (15) ms */
> +    mdelay(15); /* delay for 50 (15) ms */

Per Mark Hahn suggestion here is a patch that fixes the weird
comments too.  This is cumulative to the previous patch.

-- 
marko



--- linux/drivers/video/atyfb.c.orig	Thu Jan  4 00:08:24 2001
+++ linux/drivers/video/atyfb.c	Thu Jan  4 00:09:11 2001
@@ -1722,7 +1722,7 @@
     aty_st_8(CRTC_GEN_CNTL + 3, old_crtc_ext_disp | (CRTC_EXT_DISP_EN >> 24),
 	     info);
 
-    mdelay(15); /* delay for 50 (15) ms */
+    mdelay(15); /* delay for 15 ms */
 
     program_bits = pll->program_bits;
     locationAddr = pll->locationAddr;
@@ -1754,7 +1754,7 @@
     aty_st_8(CLOCK_CNTL + info->clk_wr_offset, old_clock_cntl | CLOCK_STROBE,
 	     info);
 
-    mdelay(50); /* delay for 50 (15) ms */
+    mdelay(50); /* delay for 50 ms */
     aty_st_8(CLOCK_CNTL + info->clk_wr_offset,
 	     ((pll->locationAddr & 0x0F) | CLOCK_STROBE), info);
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
