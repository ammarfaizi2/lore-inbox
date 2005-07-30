Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263177AbVG3Wui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbVG3Wui (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 18:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbVG3Wui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 18:50:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21890 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263177AbVG3Wug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 18:50:36 -0400
Date: Sat, 30 Jul 2005 23:49:54 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Display name of fbdev device
Message-ID: <Pine.LNX.4.56.0507302347330.8398@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch displays the name of the fbdev driver in sysfs.
Down the road this will replace the current proc handle we have.


Signed-off-by: James Simmons <jsimmons@infradead.org>

--- linus-2.6/drivers/video/fbsysfs.c	2005-07-29 12:16:08.000000000 -0700
+++ fbdev-2.6/drivers/video/fbsysfs.c	2005-07-30 12:02:22.000000000 -0700
@@ -414,6 +414,13 @@
 			fb_info->var.xoffset);
 }
 
+static ssize_t show_name(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", fb_info->fix.id);
+}
+
 static struct class_device_attribute class_device_attrs[] = {
 	__ATTR(bits_per_pixel, S_IRUGO|S_IWUSR, show_bpp, store_bpp),
 	__ATTR(blank, S_IRUGO|S_IWUSR, show_blank, store_blank),
@@ -424,6 +431,7 @@
 	__ATTR(modes, S_IRUGO|S_IWUSR, show_modes, store_modes),
 	__ATTR(pan, S_IRUGO|S_IWUSR, show_pan, store_pan),
 	__ATTR(virtual_size, S_IRUGO|S_IWUSR, show_virtual, store_virtual),
+	__ATTR(name, S_IRUGO, show_name, NULL),
 };
 
 int fb_init_class_device(struct fb_info *fb_info)
