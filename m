Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWGaSwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWGaSwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWGaSwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:52:24 -0400
Received: from ns2.suse.de ([195.135.220.15]:7312 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030320AbWGaSwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:52:22 -0400
Date: Mon, 31 Jul 2006 20:52:20 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix link error in atyfb with backlight disabled
Message-ID: <20060731185220.GA5127@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


aty_bl_set_power is only defined if CONFIG_FB_ATY_BACKLIGHT is enabled.

Signed-off-by: Olaf Hering <olh@suse.de>

Index: linux-2.6.18-rc3/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6.18-rc3.orig/drivers/video/aty/atyfb_base.c
+++ linux-2.6.18-rc3/drivers/video/aty/atyfb_base.c
@@ -2812,7 +2812,7 @@ static int atyfb_blank(int blank, struct
 	if (par->lock_blank || par->asleep)
 		return 0;
 
-#ifdef CONFIG_PMAC_BACKLIGHT
+#if defined(CONFIG_PMAC_BACKLIGHT) && defined(CONFIG_FB_ATY_BACKLIGHT)
 	if (machine_is(powermac) && blank > FB_BLANK_NORMAL)
 		aty_bl_set_power(info, FB_BLANK_POWERDOWN);
 #elif defined(CONFIG_FB_ATY_GENERIC_LCD)
@@ -2844,7 +2844,7 @@ static int atyfb_blank(int blank, struct
 	}
 	aty_st_le32(CRTC_GEN_CNTL, gen_cntl, par);
 
-#ifdef CONFIG_PMAC_BACKLIGHT
+#if defined(CONFIG_PMAC_BACKLIGHT) && defined(CONFIG_FB_ATY_BACKLIGHT)
 	if (machine_is(powermac) && blank <= FB_BLANK_NORMAL)
 		aty_bl_set_power(info, FB_BLANK_UNBLANK);
 #elif defined(CONFIG_FB_ATY_GENERIC_LCD)
