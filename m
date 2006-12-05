Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968584AbWLEShd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968584AbWLEShd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968587AbWLEShd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:37:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42905 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968584AbWLEShc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:37:32 -0500
Date: Tue, 5 Dec 2006 18:37:30 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] backlight sysfs change to the fbdev drivers
In-Reply-To: <Pine.LNX.4.64.0612051822140.7917@pentafluge.infradead.org>
Message-ID: <Pine.LNX.4.64.0612051835001.9155@pentafluge.infradead.org>
References: <20061204204024.2401148d.akpm@osdl.org>
 <Pine.LNX.4.64.0612051538280.15711@pentafluge.infradead.org>
 <20061205100140.24888a96.akpm@osdl.org> <Pine.LNX.4.64.0612051822140.7917@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch updates the framebuffer drivers that use the backlight api to 
the change of passing in the struct device to backlight_device_register
in the -mm tree.

Please apply.

Signed-off: James Simmons <jsimmons@infradead.org>

diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index 276a215..00254d5 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -1829,7 +1829,7 @@ static void aty128_bl_init(struct aty128
 
 	snprintf(name, sizeof(name), "aty128bl%d", info->node);
 
-	bd = backlight_device_register(name, par, &aty128_bl_data);
+	bd = backlight_device_register(name, par->dev, par, &aty128_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
 		printk(KERN_WARNING "aty128: Backlight registration failed\n");
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index e815b35..4916a7b 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2221,7 +2221,7 @@ static void aty_bl_init(struct atyfb_par
 
 	snprintf(name, sizeof(name), "atybl%d", info->node);
 
-	bd = backlight_device_register(name, par, &aty_bl_data);
+	bd = backlight_device_register(name, par->dev, par, &aty_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
 		printk(KERN_WARNING "aty: Backlight registration failed\n");
diff --git a/drivers/video/aty/radeon_backlight.c b/drivers/video/aty/radeon_backlight.c
index 585eb7b..0faa720 100644
--- a/drivers/video/aty/radeon_backlight.c
+++ b/drivers/video/aty/radeon_backlight.c
@@ -163,7 +163,7 @@ void radeonfb_bl_init(struct radeonfb_in
 
 	snprintf(name, sizeof(name), "radeonbl%d", rinfo->info->node);
 
-	bd = backlight_device_register(name, pdata, &radeon_bl_data);
+	bd = backlight_device_register(name, rinfo->pdev, pdata, &radeon_bl_data);
 	if (IS_ERR(bd)) {
 		rinfo->info->bl_dev = NULL;
 		printk("radeonfb: Backlight registration failed\n");
diff --git a/drivers/video/nvidia/nv_backlight.c b/drivers/video/nvidia/nv_backlight.c
index 5b75ae4..b0d5d85 100644
--- a/drivers/video/nvidia/nv_backlight.c
+++ b/drivers/video/nvidia/nv_backlight.c
@@ -141,7 +141,7 @@ void nvidia_bl_init(struct nvidia_par *p
 
 	snprintf(name, sizeof(name), "nvidiabl%d", info->node);
 
-	bd = backlight_device_register(name, par, &nvidia_bl_data);
+	bd = backlight_device_register(name, par->pci_dev, par, &nvidia_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
 		printk(KERN_WARNING "nvidia: Backlight registration failed\n");
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index a433cc7..d7dfdb6 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -383,7 +383,7 @@ static void riva_bl_init(struct riva_par
 
 	snprintf(name, sizeof(name), "rivabl%d", info->node);
 
-	bd = backlight_device_register(name, par, &riva_bl_data);
+	bd = backlight_device_register(name, par->pdev, par, &riva_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
 		printk(KERN_WARNING "riva: Backlight registration failed\n");
