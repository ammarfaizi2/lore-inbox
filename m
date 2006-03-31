Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWCaKFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWCaKFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 05:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWCaKFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 05:05:14 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:12845 "EHLO
	linux") by vger.kernel.org with ESMTP id S932074AbWCaKEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 05:04:48 -0500
Message-Id: <20060331100424.254579000@towertech.it>
References: <20060331100423.175139000@towertech.it>
User-Agent: quilt/0.43-1
Date: Fri, 31 Mar 2006 12:04:29 +0200
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@osdl.org
Subject: [PATCH 06/10] RTC subsystem, RS5C372 sysfs fix
Content-Disposition: inline; filename=rtc-subsys-rs5c372-fix-sysfs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 fixed sysfs show() return code

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

---
 drivers/rtc/rtc-rs5c372.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- linux-rtc.orig/drivers/rtc/rtc-rs5c372.c	2006-03-29 02:41:04.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-rs5c372.c	2006-03-29 02:46:40.000000000 +0200
@@ -169,24 +169,26 @@ static struct rtc_class_ops rs5c372_rtc_
 static ssize_t rs5c372_sysfs_show_trim(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	int trim;
+	int err, trim;
 
-	if (rs5c372_get_trim(to_i2c_client(dev), NULL, &trim) == 0)
-		return sprintf(buf, "0x%2x\n", trim);
+	err = rs5c372_get_trim(to_i2c_client(dev), NULL, &trim);
+	if (err)
+		return err;
 
-	return 0;
+	return sprintf(buf, "0x%2x\n", trim);
 }
 static DEVICE_ATTR(trim, S_IRUGO, rs5c372_sysfs_show_trim, NULL);
 
 static ssize_t rs5c372_sysfs_show_osc(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	int osc;
+	int err, osc;
 
-	if (rs5c372_get_trim(to_i2c_client(dev), &osc, NULL) == 0)
-		return sprintf(buf, "%d.%03d KHz\n", osc / 1000, osc % 1000);
+	err = rs5c372_get_trim(to_i2c_client(dev), &osc, NULL);
+	if (err)
+		return err;
 
-	return 0;
+	return sprintf(buf, "%d.%03d KHz\n", osc / 1000, osc % 1000);
 }
 static DEVICE_ATTR(osc, S_IRUGO, rs5c372_sysfs_show_osc, NULL);
 

--
