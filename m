Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUIOL1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUIOL1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 07:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUIOL1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 07:27:19 -0400
Received: from gprs214-49.eurotel.cz ([160.218.214.49]:22145 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265144AbUIOL1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 07:27:11 -0400
Date: Wed, 15 Sep 2004 13:26:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: ajoshi@shell.unixbox.com, linux-fbdev-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Cc: benh@kernel.crashing.org
Subject: Radeon: do not blank screen during suspend
Message-ID: <20040915112652.GA21386@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This stops ugly flashing from radeon during suspend/resume, please
apply,

								Pavel

--- clean-mm/drivers/video/aty/radeon_pm.c	2004-08-24 09:03:18.000000000 +0200
+++ linux-mm/drivers/video/aty/radeon_pm.c	2004-09-15 13:00:51.000000000 +0200
@@ -871,7 +871,8 @@
 	agp_enable(0);
 #endif
 
-	fb_set_suspend(info, 1);
+	if (system_state != SYSTEM_SNAPSHOT)
+		fb_set_suspend(info, 1);
 
 	if (!(info->flags & FBINFO_HWACCEL_DISABLED)) {
 		/* Make sure engine is reset */
@@ -880,12 +881,14 @@
 		radeon_engine_idle();
 	}
 
-	/* Blank display and LCD */
-	radeonfb_blank(VESA_POWERDOWN, info);
-
-	/* Sleep */
-	rinfo->asleep = 1;
-	rinfo->lock_blank = 1;
+	if (system_state != SYSTEM_SNAPSHOT) {
+		/* Blank display and LCD */
+		radeonfb_blank(VESA_POWERDOWN, info);
+
+		/* Sleep */
+		rinfo->asleep = 1;
+		rinfo->lock_blank = 1;
+	}
 
 	/* Suspend the chip to D2 state when supported
 	 */

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
