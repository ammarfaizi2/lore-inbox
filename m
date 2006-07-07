Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWGGLmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWGGLmD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWGGLmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:42:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57525 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751123AbWGGLmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:42:01 -0400
Date: Fri, 7 Jul 2006 13:41:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, patches@arm.linux.org.uk
Cc: Dirk@Opfer-Online.de
Subject: [patch] fix ucb initialization on collie
Message-ID: <20060707114145.GA5195@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dirk Opfer <Dirk@Opfer-Online.de>

Fix ucb initialization on collie. Wrong frequency was used and that
led to things not working quite correctly. (I had to actually disable
checks in my tree to get it to boot).

Signed-off-by: Pavel Machek <pavel@suse.cz>

PATCH FOLLOWS
KernelVersion: 2.6.18-rc1-git

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index a6bab50..5e2a84e 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -83,8 +83,8 @@ static struct scoop_pcmcia_config collie
 
 
 static struct mcp_plat_data collie_mcp_data = {
-	.mccr0          = MCCR0_ADM,
-	.sclk_rate      = 11981000,
+	.mccr0          = MCCR0_ADM | MCCR0_ExtClk,
+	.sclk_rate      = 9216000,
 };
 
 #ifdef CONFIG_SHARP_LOCOMO
diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index 632bc21..8a93563 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -479,7 +481,7 @@ static int ucb1x00_probe(struct mcp *mcp
 	mcp_enable(mcp);
 	id = mcp_reg_read(mcp, UCB_ID);
 
-	if (id != UCB_ID_1200 && id != UCB_ID_1300) {
+	if (id != UCB_ID_1200 && id != UCB_ID_1300 && id != UCB_ID_TC35143) {
 		printk(KERN_WARNING "UCB1x00 ID not found: %04x\n", id);
 		goto err_disable;
 	}

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
