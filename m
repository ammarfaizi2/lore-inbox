Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbVKLUUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVKLUUj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVKLUUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:20:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54441 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932496AbVKLUUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:20:38 -0500
Date: Sat, 12 Nov 2005 21:20:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [patch] fix collie for -rc1
Message-ID: <20051112202028.GA13617@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes compilation for collie after -rc1 platform_device
changes. And yes, it even boots.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -623,8 +623,6 @@ static int locomo_resume(struct platform
 	locomo_writel(0x1, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KCMD);
 
 	spin_unlock_irqrestore(&lchip->lock, flags);
-
-	dev->power.saved_state = NULL;
 	kfree(save);
 
 	return 0;
@@ -775,7 +820,7 @@ static int locomo_probe(struct platform_
 
 static int locomo_remove(struct platform_device *dev)
 {
-	struct locomo *lchip = platform__get_drvdata(dev);
+	struct locomo *lchip = platform_get_drvdata(dev);
 
 	if (lchip) {
 		__locomo_remove(lchip);
diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -153,7 +153,7 @@ int __init scoop_probe(struct platform_d
 	printk("Sharp Scoop Device found at 0x%08x -> 0x%08x\n",(unsigned int)mem->start,(unsigned int)devptr->base);
 
 	SCOOP_REG(devptr->base, SCOOP_MCR) = 0x0140;
-	reset_scoop(dev);
+	reset_scoop(&pdev->dev);
 	SCOOP_REG(devptr->base, SCOOP_GPCR) = inf->io_dir & 0xffff;
 	SCOOP_REG(devptr->base, SCOOP_GPWR) = inf->io_out & 0xffff;
 

-- 
Thanks, Sharp!
