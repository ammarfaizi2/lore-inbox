Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVDBVsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVDBVsu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVDBVf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:35:28 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27278 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261290AbVDBVQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:16:47 -0500
Date: Sat, 2 Apr 2005 23:16:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org
Subject: fix u32 vs. pm_message_t in drivers/macintosh
Message-ID: <20050402211628.GA2087@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I thought I'm done with fixing u32 vs. pm_message_t ... unfortunately
that turned out not to be the case as Russel King pointed out. Here
are fixes for drivers/macintosh. [These patches are independend and
change no object code; therefore not numbered].

Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
                                                        Pavel


--- clean-cvs/drivers/macintosh/macio_asic.c	2005-03-29 13:29:52.000000000 +0200
+++ linux-cvs/drivers/macintosh/macio_asic.c	2005-03-31 23:54:45.000000000 +0200
@@ -106,7 +106,7 @@
 		drv->shutdown(macio_dev);
 }
 
-static int macio_device_suspend(struct device *dev, u32 state)
+static int macio_device_suspend(struct device *dev, pm_message_t state)
 {
 	struct macio_dev * macio_dev = to_macio_device(dev);
 	struct macio_driver * drv = to_macio_driver(dev->driver);
--- clean-cvs/drivers/macintosh/mediabay.c	2005-03-29 13:29:52.000000000 +0200
+++ linux-cvs/drivers/macintosh/mediabay.c	2005-03-31 23:54:45.000000000 +0200
@@ -704,7 +704,7 @@
 
 }
 
-static int __pmac media_bay_suspend(struct macio_dev *mdev, u32 state)
+static int __pmac media_bay_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
