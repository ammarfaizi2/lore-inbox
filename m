Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbUJXM1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbUJXM1N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 08:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUJXM1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 08:27:12 -0400
Received: from smtp-out.hotpop.com ([38.113.3.51]:7821 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261454AbUJXM1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 08:27:08 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Geert Uytterhoeven <geert@linux-m68k.org>,
       Antonino Daplas <adaplas@pol.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Atyfb: kill assignment warnings on Atari due to __iomem changes
Date: Sun, 24 Oct 2004 20:33:27 +0800
User-Agent: KMail/1.5.4
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0410241314550.27526@anakin>
In-Reply-To: <Pine.LNX.4.61.0410241314550.27526@anakin>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410242033.29075.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 October 2004 19:15, Geert Uytterhoeven wrote:
> Atyfb: kill assignment warnings on Atari due to __iomem changes

I pushed a big mach64 patch (coming from various authors) to Andrew, and
this will  get rejected.

Attached is an incremental patch for the big mach64 update.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

---diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	2004-10-22 15:57:58 +08:00
+++ b/drivers/video/aty/atyfb_base.c	2004-10-24 20:26:04 +08:00
@@ -3457,8 +3457,10 @@
 		 */
 		info->screen_base = ioremap(phys_vmembase[m64_num], phys_size[m64_num]);
 		info->fix.smem_start = (unsigned long)info->screen_base; /* Fake! */
-		par->ati_regbase = ioremap(phys_guiregbase[m64_num], 0x10000) + 0xFC00ul;
-		info->fix.mmio_start = par->ati_regbase; /* Fake! */
+		par->ati_regbase = ioremap(phys_guiregbase[m64_num],
+					   0x10000) + 0xFC00ul;
+		info->fix.mmio_start =
+			(unsigned long)par->ati_regbase; /* Fake! */
 
 		aty_st_le32(CLOCK_CNTL, 0x12345678, par);
 		clock_r = aty_ld_le32(CLOCK_CNTL, par);



