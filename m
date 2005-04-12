Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVDLTGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVDLTGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVDLTE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:04:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:53449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262216AbVDLKci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:38 -0400
Message-Id: <200504121032.j3CAWQe8005593@shell0.pdx.osdl.net>
Subject: [patch 114/198] fix u32 vs. pm_message_t in drivers/macintosh
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz, pavel@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

I thought I'm done with fixing u32 vs.  pm_message_t ...  unfortunately that
turned out not to be the case as Russel King pointed out.  Here are fixes for
drivers/macintosh.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/macintosh/macio_asic.c |    2 +-
 25-akpm/drivers/macintosh/mediabay.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/macintosh/macio_asic.c~fix-u32-vs-pm_message_t-in-drivers-macintosh drivers/macintosh/macio_asic.c
--- 25/drivers/macintosh/macio_asic.c~fix-u32-vs-pm_message_t-in-drivers-macintosh	2005-04-12 03:21:30.956430808 -0700
+++ 25-akpm/drivers/macintosh/macio_asic.c	2005-04-12 03:21:30.960430200 -0700
@@ -106,7 +106,7 @@ static void macio_device_shutdown(struct
 		drv->shutdown(macio_dev);
 }
 
-static int macio_device_suspend(struct device *dev, u32 state)
+static int macio_device_suspend(struct device *dev, pm_message_t state)
 {
 	struct macio_dev * macio_dev = to_macio_device(dev);
 	struct macio_driver * drv = to_macio_driver(dev->driver);
diff -puN drivers/macintosh/mediabay.c~fix-u32-vs-pm_message_t-in-drivers-macintosh drivers/macintosh/mediabay.c
--- 25/drivers/macintosh/mediabay.c~fix-u32-vs-pm_message_t-in-drivers-macintosh	2005-04-12 03:21:30.957430656 -0700
+++ 25-akpm/drivers/macintosh/mediabay.c	2005-04-12 03:21:30.961430048 -0700
@@ -704,7 +704,7 @@ static int __devinit media_bay_attach(st
 
 }
 
-static int __pmac media_bay_suspend(struct macio_dev *mdev, u32 state)
+static int __pmac media_bay_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
_
