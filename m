Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVJXUqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVJXUqX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 16:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVJXUqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 16:46:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33221 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751278AbVJXUqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 16:46:22 -0400
Date: Mon, 24 Oct 2005 21:46:21 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] Return the line length via sysfs for fbdev
Message-ID: <Pine.LNX.4.56.0510242142520.13921@pentafluge.infradead.org>
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


This small patch returns the stride/line length of the framebuffer via 
sysfs. Please apply.

Signed-off-by: James Simmons <jsimmons@infradead.org>

--- linus-2.6/drivers/video/fbsysfs.c	2005-07-31 15:45:22.000000000 -0700
+++ fbdev-2.6/drivers/video/fbsysfs.c	2005-09-21 13:54:02.000000000 -0700
@@ -242,6 +242,13 @@
 			fb_info->var.yres_virtual);
 }
 
+static ssize_t show_stride(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info =
+		(struct fb_info *)class_get_devdata(class_device);
+	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->fix.line_length);
+}
+
 /* Format for cmap is "%02x%c%4x%4x%4x\n" */
 /* %02x entry %c transp %4x red %4x blue %4x green \n */
 /* 256 rows at 16 chars equals 4096, the normal page size */
@@ -432,6 +439,7 @@
 	__ATTR(pan, S_IRUGO|S_IWUSR, show_pan, store_pan),
 	__ATTR(virtual_size, S_IRUGO|S_IWUSR, show_virtual, store_virtual),
 	__ATTR(name, S_IRUGO, show_name, NULL),
+	__ATTR(stride, S_IRUGO, show_stride, NULL),
 };
 
 int fb_init_class_device(struct fb_info *fb_info)
