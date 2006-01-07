Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030556AbWAGTIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030556AbWAGTIW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030554AbWAGTIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:08:22 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:58223 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030544AbWAGTIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:21 -0500
Message-Id: <20060107172059.731161000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:01 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 02/24] Mousedev: make module parameters visible in sysfs
Content-Disposition: inline; filename=mousedev-params-in-sysfs.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: mousedev - make module parameters visible in sysfs

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mousedev.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: work/drivers/input/mousedev.c
===================================================================
--- work.orig/drivers/input/mousedev.c
+++ work/drivers/input/mousedev.c
@@ -40,15 +40,15 @@ MODULE_LICENSE("GPL");
 #endif
 
 static int xres = CONFIG_INPUT_MOUSEDEV_SCREEN_X;
-module_param(xres, uint, 0);
+module_param(xres, uint, 0644);
 MODULE_PARM_DESC(xres, "Horizontal screen resolution");
 
 static int yres = CONFIG_INPUT_MOUSEDEV_SCREEN_Y;
-module_param(yres, uint, 0);
+module_param(yres, uint, 0644);
 MODULE_PARM_DESC(yres, "Vertical screen resolution");
 
 static unsigned tap_time = 200;
-module_param(tap_time, uint, 0);
+module_param(tap_time, uint, 0644);
 MODULE_PARM_DESC(tap_time, "Tap time for touchpads in absolute mode (msecs)");
 
 struct mousedev_hw_data {
@@ -155,7 +155,7 @@ static void mousedev_abs_event(struct in
 	switch (code) {
 		case ABS_X:
 			size = dev->absmax[ABS_X] - dev->absmin[ABS_X];
-			if (size == 0) size = xres;
+			if (size == 0) size = xres ? : 1;
 			if (value > dev->absmax[ABS_X]) value = dev->absmax[ABS_X];
 			if (value < dev->absmin[ABS_X]) value = dev->absmin[ABS_X];
 			mousedev->packet.x = ((value - dev->absmin[ABS_X]) * xres) / size;
@@ -164,7 +164,7 @@ static void mousedev_abs_event(struct in
 
 		case ABS_Y:
 			size = dev->absmax[ABS_Y] - dev->absmin[ABS_Y];
-			if (size == 0) size = yres;
+			if (size == 0) size = yres ? : 1;
 			if (value > dev->absmax[ABS_Y]) value = dev->absmax[ABS_Y];
 			if (value < dev->absmin[ABS_Y]) value = dev->absmin[ABS_Y];
 			mousedev->packet.y = yres - ((value - dev->absmin[ABS_Y]) * yres) / size;

