Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVBOA6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVBOA6b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVBOA6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:58:30 -0500
Received: from gprs215-140.eurotel.cz ([160.218.215.140]:33990 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261481AbVBOA51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:57:27 -0500
Date: Tue, 15 Feb 2005 01:57:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: ncunningham@cyclades.com, bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Fix u32 vs. pm_message_t confusion in MMC
Message-ID: <20050215005712.GI5415@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214134658.324076c9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes u32 vs. pm_message_t confusion in MMC layer. Please apply,

								Pavel

--- clean-mm/drivers/mmc/mmc_block.c	2005-02-15 00:34:38.000000000 +0100
+++ linux-mm/drivers/mmc/mmc_block.c	2005-02-15 01:04:10.000000000 +0100
@@ -437,7 +437,7 @@
 }
 
 #ifdef CONFIG_PM
-static int mmc_blk_suspend(struct mmc_card *card, u32 state)
+static int mmc_blk_suspend(struct mmc_card *card, pm_message_t state)
 {
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
--- clean-mm/drivers/mmc/mmc_sysfs.c	2004-10-01 00:30:15.000000000 +0200
+++ linux-mm/drivers/mmc/mmc_sysfs.c	2005-02-15 01:04:10.000000000 +0100
@@ -74,7 +74,7 @@
 	return 0;
 }
 
-static int mmc_bus_suspend(struct device *dev, u32 state)
+static int mmc_bus_suspend(struct device *dev, pm_message_t state)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = dev_to_mmc_card(dev);
--- clean-mm/include/linux/mmc/card.h	2004-10-01 00:30:30.000000000 +0200
+++ linux-mm/include/linux/mmc/card.h	2005-02-15 01:04:11.000000000 +0100
@@ -75,7 +75,7 @@
 	struct device_driver drv;
 	int (*probe)(struct mmc_card *);
 	void (*remove)(struct mmc_card *);
-	int (*suspend)(struct mmc_card *, u32);
+	int (*suspend)(struct mmc_card *, pm_message_t);
 	int (*resume)(struct mmc_card *);
 };
 


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
