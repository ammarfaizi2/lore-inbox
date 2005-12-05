Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbVLEUVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbVLEUVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbVLEUVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:21:55 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:35854 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751416AbVLEUVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:21:54 -0500
Date: Mon, 5 Dec 2005 21:23:37 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH] Minor change to platform_device_register_simple prototype
Message-Id: <20051205212337.74103b96.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Propose patch for platform driver core. Greg, can you add it to your
driver queue?

Thanks.

Content-Disposition: inline; filename=driver-platform-device-name-as-const-char.patch

The name parameter of platform_device_register_simple should be of
type const char * instead of char *, as we simply pass it to
platform_device_alloc, where it has type const char *.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/base/platform.c         |    2 +-
 include/linux/platform_device.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc2.orig/drivers/base/platform.c	2005-11-13 21:02:31.000000000 +0100
+++ linux-2.6.15-rc2/drivers/base/platform.c	2005-12-05 20:44:43.000000000 +0100
@@ -327,7 +327,7 @@
  *	to be unloaded iwithout waiting for the last reference to the device
  *	to be dropped.
  */
-struct platform_device *platform_device_register_simple(char *name, unsigned int id,
+struct platform_device *platform_device_register_simple(const char *name, unsigned int id,
 							struct resource *res, unsigned int num)
 {
 	struct platform_device *pdev;
--- linux-2.6.15-rc2.orig/include/linux/platform_device.h	2005-11-13 21:02:59.000000000 +0100
+++ linux-2.6.15-rc2/include/linux/platform_device.h	2005-12-05 20:44:30.000000000 +0100
@@ -35,7 +35,7 @@
 extern int platform_get_irq_byname(struct platform_device *, char *);
 extern int platform_add_devices(struct platform_device **, int);
 
-extern struct platform_device *platform_device_register_simple(char *, unsigned int, struct resource *, unsigned int);
+extern struct platform_device *platform_device_register_simple(const char *, unsigned int, struct resource *, unsigned int);
 
 extern struct platform_device *platform_device_alloc(const char *name, unsigned int id);
 extern int platform_device_add_resources(struct platform_device *pdev, struct resource *res, unsigned int num);


-- 
Jean Delvare
