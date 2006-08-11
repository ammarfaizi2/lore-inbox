Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWHKFJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWHKFJa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 01:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWHKFJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 01:09:06 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:8722 "EHLO
	asav08.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751509AbWHKFJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 01:09:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAI+t20QN
Message-Id: <20060811050611.409915104.dtor@insightbb.com>
References: <20060811050310.958962036.dtor@insightbb.com>
Date: Fri, 11 Aug 2006 01:03:14 -0400
From: Dmitry Torokhov <dtor@insightbb.com>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 4/6] Remove "owner" from backlight_properties structure
Content-Disposition: inline; filename=backlight-remove-owner.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Backlight: remove "owner" from backlight_properties structure

Nothing uses it and it is unlikely that it will ever be used -
backlight uses other means to ensure that nothing references
unloaded code.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/macintosh/via-pmu-backlight.c |    1 -
 drivers/usb/misc/appledisplay.c       |    1 -
 drivers/video/aty/aty128fb.c          |    1 -
 drivers/video/aty/atyfb_base.c        |    1 -
 drivers/video/aty/radeon_backlight.c  |    1 -
 drivers/video/backlight/corgi_bl.c    |    1 -
 drivers/video/backlight/hp680_bl.c    |    1 -
 drivers/video/backlight/locomolcd.c   |    1 -
 drivers/video/nvidia/nv_backlight.c   |    1 -
 drivers/video/riva/fbdev.c            |    1 -
 include/linux/backlight.h             |    3 ---
 include/linux/lcd.h                   |    2 --
 12 files changed, 15 deletions(-)

Index: work/drivers/macintosh/via-pmu-backlight.c
===================================================================
--- work.orig/drivers/macintosh/via-pmu-backlight.c
+++ work/drivers/macintosh/via-pmu-backlight.c
@@ -81,7 +81,6 @@ static int pmu_backlight_get_brightness(
 }
 
 static struct backlight_properties pmu_backlight_data = {
-	.owner		= THIS_MODULE,
 	.get_brightness	= pmu_backlight_get_brightness,
 	.update_status	= pmu_backlight_update_status,
 	.max_brightness	= (FB_BACKLIGHT_LEVELS - 1),
Index: work/drivers/usb/misc/appledisplay.c
===================================================================
--- work.orig/drivers/usb/misc/appledisplay.c
+++ work/drivers/usb/misc/appledisplay.c
@@ -179,7 +179,6 @@ static int appledisplay_bl_get_brightnes
 }
 
 static struct backlight_properties appledisplay_bl_data = {
-	.owner		= THIS_MODULE,
 	.get_brightness	= appledisplay_bl_get_brightness,
 	.update_status	= appledisplay_bl_update_status,
 	.max_brightness	= 0xFF
Index: work/drivers/video/aty/aty128fb.c
===================================================================
--- work.orig/drivers/video/aty/aty128fb.c
+++ work/drivers/video/aty/aty128fb.c
@@ -1792,7 +1792,6 @@ static int aty128_bl_get_brightness(stru
 }
 
 static struct backlight_properties aty128_bl_data = {
-	.owner		= THIS_MODULE,
 	.get_brightness	= aty128_bl_get_brightness,
 	.update_status	= aty128_bl_update_status,
 	.max_brightness	= (FB_BACKLIGHT_LEVELS - 1),
Index: work/drivers/video/aty/atyfb_base.c
===================================================================
--- work.orig/drivers/video/aty/atyfb_base.c
+++ work/drivers/video/aty/atyfb_base.c
@@ -2191,7 +2191,6 @@ static int aty_bl_get_brightness(struct 
 }
 
 static struct backlight_properties aty_bl_data = {
-	.owner	  = THIS_MODULE,
 	.get_brightness = aty_bl_get_brightness,
 	.update_status	= aty_bl_update_status,
 	.max_brightness = (FB_BACKLIGHT_LEVELS - 1),
Index: work/drivers/video/aty/radeon_backlight.c
===================================================================
--- work.orig/drivers/video/aty/radeon_backlight.c
+++ work/drivers/video/aty/radeon_backlight.c
@@ -134,7 +134,6 @@ static int radeon_bl_get_brightness(stru
 }
 
 static struct backlight_properties radeon_bl_data = {
-	.owner		= THIS_MODULE,
 	.get_brightness = radeon_bl_get_brightness,
 	.update_status	= radeon_bl_update_status,
 	.max_brightness = (FB_BACKLIGHT_LEVELS - 1),
Index: work/drivers/video/backlight/corgi_bl.c
===================================================================
--- work.orig/drivers/video/backlight/corgi_bl.c
+++ work/drivers/video/backlight/corgi_bl.c
@@ -106,7 +106,6 @@ EXPORT_SYMBOL(corgibl_limit_intensity);
 
 
 static struct backlight_properties corgibl_data = {
-	.owner          = THIS_MODULE,
 	.get_brightness = corgibl_get_intensity,
 	.update_status  = corgibl_set_intensity,
 };
Index: work/drivers/video/backlight/hp680_bl.c
===================================================================
--- work.orig/drivers/video/backlight/hp680_bl.c
+++ work/drivers/video/backlight/hp680_bl.c
@@ -96,7 +96,6 @@ static int hp680bl_get_intensity(struct 
 }
 
 static struct backlight_properties hp680bl_data = {
-	.owner		= THIS_MODULE,
 	.max_brightness = HP680_MAX_INTENSITY,
 	.get_brightness = hp680bl_get_intensity,
 	.update_status  = hp680bl_set_intensity,
Index: work/drivers/video/backlight/locomolcd.c
===================================================================
--- work.orig/drivers/video/backlight/locomolcd.c
+++ work/drivers/video/backlight/locomolcd.c
@@ -142,7 +142,6 @@ static int locomolcd_get_intensity(struc
 }
 
 static struct backlight_properties locomobl_data = {
-	.owner		= THIS_MODULE,
 	.get_brightness = locomolcd_get_intensity,
 	.update_status  = locomolcd_set_intensity,
 	.max_brightness = 4,
Index: work/drivers/video/nvidia/nv_backlight.c
===================================================================
--- work.orig/drivers/video/nvidia/nv_backlight.c
+++ work/drivers/video/nvidia/nv_backlight.c
@@ -104,7 +104,6 @@ static int nvidia_bl_get_brightness(stru
 }
 
 static struct backlight_properties nvidia_bl_data = {
-	.owner		= THIS_MODULE,
 	.get_brightness = nvidia_bl_get_brightness,
 	.update_status	= nvidia_bl_update_status,
 	.max_brightness = (FB_BACKLIGHT_LEVELS - 1),
Index: work/drivers/video/riva/fbdev.c
===================================================================
--- work.orig/drivers/video/riva/fbdev.c
+++ work/drivers/video/riva/fbdev.c
@@ -346,7 +346,6 @@ static int riva_bl_get_brightness(struct
 }
 
 static struct backlight_properties riva_bl_data = {
-	.owner    = THIS_MODULE,
 	.get_brightness = riva_bl_get_brightness,
 	.update_status	= riva_bl_update_status,
 	.max_brightness = (FB_BACKLIGHT_LEVELS - 1),
Index: work/include/linux/backlight.h
===================================================================
--- work.orig/include/linux/backlight.h
+++ work/include/linux/backlight.h
@@ -17,9 +17,6 @@ struct fb_info;
 /* This structure defines all the properties of a backlight
    (usually attached to a LCD). */
 struct backlight_properties {
-	/* Owner module */
-	struct module *owner;
-
 	/* Notify the backlight driver some property has changed */
 	int (*update_status)(struct backlight_device *);
 	/* Return the current backlight brightness (accounting for power,
Index: work/include/linux/lcd.h
===================================================================
--- work.orig/include/linux/lcd.h
+++ work/include/linux/lcd.h
@@ -16,8 +16,6 @@ struct fb_info;
 
 /* This structure defines all the properties of a LCD flat panel. */
 struct lcd_properties {
-	/* Owner module */
-	struct module *owner;
 	/* Get the LCD panel power status (0: full on, 1..3: controller
 	   power on, flat panel power off, 4: full off), see FB_BLANK_XXX */
 	int (*get_power)(struct lcd_device *);
