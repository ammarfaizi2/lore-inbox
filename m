Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVEQKkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVEQKkR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 06:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVEQKkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 06:40:17 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:4217 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261364AbVEQKje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 06:39:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=p5x2QD5kLwUnQa24s8ojZ/RCNpxjl4fEUvXjP/jLMyqWvHAy6o6bOu0BIQshI8ZANahUOqG+B5FzZrFRNVjyqs7IbgxGZB/A7OzJLPf8F3yzEQmoD1wB3+HaXv6H7RJYWZ/HcITUh/W6Sgl74m7dqx5lvbKQxh7IOpKkZxVhoCc=
Message-ID: <253818670505170339187ebecd@mail.gmail.com>
Date: Tue, 17 May 2005 06:39:34 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: [PATCH 2.6.12-rc4 2/15] drivers/base/core.c, include/linux/device.h: change device_attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_252_18578562.1116326374179"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_252_18578562.1116326374179
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch adds the device_attribute paramerter to the
device_attribute store and show sysfs callback functions, and passes a
reference to the attribute when the callbacks are called.

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_252_18578562.1116326374179
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr.diff.diffstat.txt"

 drivers/base/core.c    |    4 ++--
 include/linux/device.h |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)


------=_Part_252_18578562.1116326374179
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4/drivers/base/core.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/base/core.c
--- linux-2.6.12-rc4/drivers/base/core.c	2005-05-07 03:37:15.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/base/core.c	2005-05-16 20:50:02.000000000 -0400
@@ -41,7 +41,7 @@ dev_attr_show(struct kobject * kobj, str
 	ssize_t ret = 0;
 
 	if (dev_attr->show)
-		ret = dev_attr->show(dev, buf);
+		ret = dev_attr->show(dev, dev_attr, buf);
 	return ret;
 }
 
@@ -54,7 +54,7 @@ dev_attr_store(struct kobject * kobj, st
 	ssize_t ret = 0;
 
 	if (dev_attr->store)
-		ret = dev_attr->store(dev, buf, count);
+		ret = dev_attr->store(dev, dev_attr, buf, count);
 	return ret;
 }
 
diff -uprN -X dontdiff linux-2.6.12-rc4/include/linux/device.h linux-2.6.12-rc4-sysfsdyncallback-deviceattr/include/linux/device.h
--- linux-2.6.12-rc4/include/linux/device.h	2005-05-07 03:37:24.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr/include/linux/device.h	2005-05-16 20:58:43.000000000 -0400
@@ -335,8 +335,9 @@ extern void driver_attach(struct device_
 
 struct device_attribute {
 	struct attribute	attr;
-	ssize_t (*show)(struct device * dev, char * buf);
-	ssize_t (*store)(struct device * dev, const char * buf, size_t count);
+	ssize_t (*show)(struct device * dev, struct device_attribute *attr, char * buf);
+	ssize_t (*store)(struct device * dev, struct device_attribute *attr, 
+			const char * buf, size_t count);
 };
 
 #define DEVICE_ATTR(_name,_mode,_show,_store) \


------=_Part_252_18578562.1116326374179--
