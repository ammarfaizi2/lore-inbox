Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbVCXDOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbVCXDOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbVCXDNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:13:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58129 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262996AbVCXDMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:12:48 -0500
Date: Thu, 24 Mar 2005 04:12:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: vojtech@suse.cz
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/input/joystick/iforce/iforce-main.c: fix check after use
Message-ID: <20050324031245.GX1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an obvious check after use found by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/input/joystick/iforce/iforce-main.c.old	2005-03-24 02:28:48.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/input/joystick/iforce/iforce-main.c	2005-03-24 02:29:15.000000000 +0100
@@ -221,15 +221,15 @@ static int iforce_erase_effect(struct in
 	int err = 0;
 	struct iforce_core_effect* core_effect;
 
+	if (effect_id < 0 || effect_id >= FF_EFFECTS_MAX)
+		return -EINVAL;
+
 	/* Check who is trying to erase this effect */
 	if (iforce->core_effects[effect_id].owner != current->pid) {
 		printk(KERN_WARNING "iforce-main.c: %d tried to erase an effect belonging to %d\n", current->pid, iforce->core_effects[effect_id].owner);
 		return -EACCES;
 	}
 
-	if (effect_id < 0 || effect_id >= FF_EFFECTS_MAX)
-		return -EINVAL;
-
 	core_effect = iforce->core_effects + effect_id;
 
 	if (test_bit(FF_MOD1_IS_USED, core_effect->flags))

