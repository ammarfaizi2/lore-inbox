Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWCaKEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWCaKEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 05:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWCaKEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 05:04:45 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:17965 "EHLO
	linux") by vger.kernel.org with ESMTP id S932068AbWCaKEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 05:04:44 -0500
Message-Id: <20060331100423.694555000@towertech.it>
References: <20060331100423.175139000@towertech.it>
User-Agent: quilt/0.43-1
Date: Fri, 31 Mar 2006 12:04:26 +0200
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@osdl.org
Subject: [PATCH 03/10] RTC subsystem, X1205 sysfs cleanup
Content-Disposition: inline; filename=rtc-subsys-x1205-fix-sysfs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 fixed sysfs show() return code

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

---
 drivers/rtc/rtc-x1205.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- linux-rtc.orig/drivers/rtc/rtc-x1205.c	2006-03-29 02:14:50.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-x1205.c	2006-03-29 02:33:57.000000000 +0200
@@ -19,7 +19,7 @@
 #include <linux/rtc.h>
 #include <linux/delay.h>
 
-#define DRV_VERSION "1.0.6"
+#define DRV_VERSION "1.0.7"
 
 /* Addresses to scan: none. This chip is located at
  * 0x6f and uses a two bytes register addressing.
@@ -473,24 +473,26 @@ static struct rtc_class_ops x1205_rtc_op
 static ssize_t x1205_sysfs_show_atrim(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	int atrim;
+	int err, atrim;
 
-	if (x1205_get_atrim(to_i2c_client(dev), &atrim) == 0)
-		return sprintf(buf, "%d.%02d pF\n",
-			atrim / 1000, atrim % 1000);
-	return 0;
+	err = x1205_get_atrim(to_i2c_client(dev), &atrim);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d.%02d pF\n", atrim / 1000, atrim % 1000);
 }
 static DEVICE_ATTR(atrim, S_IRUGO, x1205_sysfs_show_atrim, NULL);
 
 static ssize_t x1205_sysfs_show_dtrim(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	int dtrim;
+	int err, dtrim;
 
-	if (x1205_get_dtrim(to_i2c_client(dev), &dtrim) == 0)
-		return sprintf(buf, "%d ppm\n", dtrim);
+	err = x1205_get_dtrim(to_i2c_client(dev), &dtrim);
+	if (err)
+		return err;
 
-	return 0;
+	return sprintf(buf, "%d ppm\n", dtrim);
 }
 static DEVICE_ATTR(dtrim, S_IRUGO, x1205_sysfs_show_dtrim, NULL);
 

--
