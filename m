Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271290AbUKAQ4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271290AbUKAQ4d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 11:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267575AbUKAQ3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 11:29:47 -0500
Received: from cantor.suse.de ([195.135.220.2]:37508 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269360AbUKAPwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 10:52:42 -0500
Date: Mon, 1 Nov 2004 16:47:23 +0100
From: Olaf Hering <olh@suse.de>
To: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] set correct mclk/xclk values for aty in ibook
Message-ID: <20041101154723.GA14379@suse.de>
References: <20041101141622.GA14335@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041101141622.GA14335@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The first iBook needs special mclk/xclk values, or the screen will show
only garbage. A patch like this went into 2.4.23. It stopped working
after 2.6.10-rc1.

http://linux.bkbits.net:8080/linux-2.4/cset@3f966ca7mqKxZorh7Uw2SBAuVbv3mA

It was discussed here:
http://marc.theaimsgroup.com/?t=106345749200001&r=1&w=4

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.10-rc1-bk9.orig/drivers/video/aty/atyfb_base.c linux-2.6.10-rc1-bk9-olh/drivers/video/aty/atyfb_base.c
--- linux-2.6.10-rc1-bk9.orig/drivers/video/aty/atyfb_base.c	2004-10-30 20:13:02.000000000 +0200
+++ linux-2.6.10-rc1-bk9-olh/drivers/video/aty/atyfb_base.c	2004-11-01 16:29:57.613561216 +0100
@@ -2190,6 +2190,14 @@ static int __init aty_init(struct fb_inf
 
 	par->aty_cmap_regs =
 	    (struct aty_cmap_regs __iomem *) (par->ati_regbase + 0xc0);
+#ifdef CONFIG_PPC_PMAC
+	/* The Apple iBook1 uses non-standard memory frequencies. We detect it
+	 * and set the frequency manually. */
+	if (machine_is_compatible("PowerBook2,1")) {
+		par->pll_limits.mclk = 70;
+		par->pll_limits.xclk = 53;
+	}
+#endif
 
 	if (pll)
 		par->pll_limits.pll_max = pll;

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
