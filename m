Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263218AbTCNBCK>; Thu, 13 Mar 2003 20:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263206AbTCNA52>; Thu, 13 Mar 2003 19:57:28 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62219 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263207AbTCNAzx>;
	Thu, 13 Mar 2003 19:55:53 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.64
In-reply-to: <1047603324728@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 13 Mar 2003 16:55 -0800
Message-id: <10476033263399@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1113, 2003/03/13 16:37:27-08:00, greg@kroah.com

driver core: Export the legacy_bus structure for drivers to use.


 drivers/base/platform.c |    3 ++-
 include/linux/device.h  |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	Thu Mar 13 16:57:00 2003
+++ b/drivers/base/platform.c	Thu Mar 13 16:57:00 2003
@@ -9,7 +9,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-static struct device legacy_bus = {
+struct device legacy_bus = {
 	.name		= "legacy bus",
 	.bus_id		= "legacy",
 };
@@ -75,5 +75,6 @@
 	return bus_register(&platform_bus_type);
 }
 
+EXPORT_SYMBOL(legacy_bus);
 EXPORT_SYMBOL(platform_device_register);
 EXPORT_SYMBOL(platform_device_unregister);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Thu Mar 13 16:57:00 2003
+++ b/include/linux/device.h	Thu Mar 13 16:57:00 2003
@@ -366,6 +366,7 @@
 extern void platform_device_unregister(struct platform_device *);
 
 extern struct bus_type platform_bus_type;
+extern struct device legacy_bus;
 
 /* drivers/base/power.c */
 extern int device_suspend(u32 state, u32 level);

