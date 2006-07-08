Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWGHM5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWGHM5L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 08:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWGHM5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 08:57:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49053 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964780AbWGHM5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 08:57:10 -0400
Date: Sat, 8 Jul 2006 14:56:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, patches@arm.linux.org.uk
Subject: [patch] sharpsl_pm: warn about wrong temperature
Message-ID: <20060708125648.GA2006@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also warn users about charging in unsuitable temperature.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Acked-by: Richard Purdie <rpurdie@rpsys.net>

PATCH FOLLOWS
KernelVersion: 2.6.18-rc1-git

diff --git a/arch/arm/common/sharpsl_pm.c b/arch/arm/common/sharpsl_pm.c
index 045e37e..12beac3 100644
--- a/arch/arm/common/sharpsl_pm.c
+++ b/arch/arm/common/sharpsl_pm.c
@@ -412,8 +429,10 @@ static int sharpsl_check_battery_temp(vo
 	val = get_select_val(buff);
 
 	dev_dbg(sharpsl_pm.dev, "Temperature: %d\n", val);
-	if (val > sharpsl_pm.machinfo->charge_on_temp)
+	if (val > sharpsl_pm.machinfo->charge_on_temp) {
+		printk(KERN_WARNING "Not charging: temperature out of limits.\n"); 
 		return -1;
+	}
 
 	return 0;
 }

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
