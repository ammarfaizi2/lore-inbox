Return-Path: <linux-kernel-owner+w=401wt.eu-S1755143AbWL3Pka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143AbWL3Pka (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 10:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755142AbWL3Pka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 10:40:30 -0500
Received: from tim.rpsys.net ([194.106.48.114]:47028 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755144AbWL3Pk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 10:40:29 -0500
Subject: Fix backlight_device_register compile failures/breakage
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Luming.yu@intel.com,
       len.brown@intel.com
Content-Type: text/plain
Date: Sat, 30 Dec 2006 15:40:11 +0000
Message-Id: <1167493211.5626.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix breakage from commit 519ab5f2be65b72cf12ae99c89752bbe79b44df6 which
didn't update all references to backlight_device_register causing
compile failures.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

---
 drivers/macintosh/via-pmu-backlight.c |    2 +-
 drivers/video/backlight/corgi_bl.c    |    2 +-
 drivers/video/backlight/hp680_bl.c    |    2 +-
 drivers/video/backlight/locomolcd.c   |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

Index: git/drivers/macintosh/via-pmu-backlight.c
===================================================================
--- git.orig/drivers/macintosh/via-pmu-backlight.c	2006-12-30 14:17:47.000000000 +0000
+++ git/drivers/macintosh/via-pmu-backlight.c	2006-12-30 15:28:26.000000000 +0000
@@ -147,7 +147,7 @@ void __init pmu_backlight_init()
 
 	snprintf(name, sizeof(name), "pmubl");
 
-	bd = backlight_device_register(name, NULL, &pmu_backlight_data);
+	bd = backlight_device_register(name, NULL, NULL, &pmu_backlight_data);
 	if (IS_ERR(bd)) {
 		printk("pmubl: Backlight registration failed\n");
 		goto error;
Index: git/drivers/video/backlight/corgi_bl.c
===================================================================
--- git.orig/drivers/video/backlight/corgi_bl.c	2006-12-30 14:18:15.000000000 +0000
+++ git/drivers/video/backlight/corgi_bl.c	2006-12-30 15:29:40.000000000 +0000
@@ -121,7 +121,7 @@ static int corgibl_probe(struct platform
 		machinfo->limit_mask = -1;
 
 	corgi_backlight_device = backlight_device_register ("corgi-bl",
-		NULL, &corgibl_data);
+		&pdev->dev, NULL, &corgibl_data);
 	if (IS_ERR (corgi_backlight_device))
 		return PTR_ERR (corgi_backlight_device);
 
Index: git/drivers/video/backlight/hp680_bl.c
===================================================================
--- git.orig/drivers/video/backlight/hp680_bl.c	2006-12-30 14:18:15.000000000 +0000
+++ git/drivers/video/backlight/hp680_bl.c	2006-12-30 15:29:49.000000000 +0000
@@ -105,7 +105,7 @@ static struct backlight_properties hp680
 static int __init hp680bl_probe(struct platform_device *dev)
 {
 	hp680_backlight_device = backlight_device_register ("hp680-bl",
-		NULL, &hp680bl_data);
+		&dev->dev, NULL, &hp680bl_data);
 	if (IS_ERR (hp680_backlight_device))
 		return PTR_ERR (hp680_backlight_device);
 
Index: git/drivers/video/backlight/locomolcd.c
===================================================================
--- git.orig/drivers/video/backlight/locomolcd.c	2006-12-30 14:18:15.000000000 +0000
+++ git/drivers/video/backlight/locomolcd.c	2006-12-30 15:30:04.000000000 +0000
@@ -184,7 +184,7 @@ static int locomolcd_probe(struct locomo
 
 	local_irq_restore(flags);
 
-	locomolcd_bl_device = backlight_device_register("locomo-bl", NULL, &locomobl_data);
+	locomolcd_bl_device = backlight_device_register("locomo-bl", &ldev->dev, NULL, &locomobl_data);
 
 	if (IS_ERR (locomolcd_bl_device))
 		return PTR_ERR (locomolcd_bl_device);


