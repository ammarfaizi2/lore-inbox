Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267776AbUH1VkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267776AbUH1VkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUH1VkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:40:25 -0400
Received: from gprs214-50.eurotel.cz ([160.218.214.50]:28032 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267974AbUH1VkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:40:06 -0400
Date: Sat, 28 Aug 2004 23:35:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: benh@kernel.crashing.org, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: radeonfb: do not blank during swsusp snapshot
Message-ID: <20040828213535.GA1418@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

With display blanked, it is hard to debug anything. And display
blanking is not really needed there... Does it look okay?

								Pavel

--- clean-mm.middle/drivers/video/aty/radeon_pm.c	2004-08-15 19:15:01.000000000 +0200
+++ linux-mm/drivers/video/aty/radeon_pm.c	2004-08-28 23:26:46.000000000 +0200
@@ -880,12 +880,14 @@
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
