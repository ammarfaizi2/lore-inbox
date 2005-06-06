Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVFFRdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVFFRdv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 13:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVFFRdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 13:33:51 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:63499 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261274AbVFFRdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 13:33:41 -0400
Date: Mon, 6 Jun 2005 19:34:45 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Yani Ioannou <yani.ioannou@gmail.com>
Subject: Re: More hardware monitoring drivers ported to the new sysfs
 callbacks
Message-Id: <20050606193445.28401c23.khali@linux-fr.org>
In-Reply-To: <20050606062203.GA6344@kroah.com>
References: <20050605200901.41592fe9.khali@linux-fr.org>
	<20050606062203.GA6344@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, all,

> > First, I don't much like the name of the new header file,
> > linux/i2c-sysfs.h. It isn't related with i2c at all! It's all about
> > sensors (or hardware monitoring if you prefer). I think the header
> > file should be named linux/hwmon-sysfs.h or something similar.
> 
> Sure, that would be fine.

OK, patch follows.

> > Second, is there a reason why the SENSOR_DEVICE_ATTR macro creates a
> > stucture named sensor_dev_attr_##_name rather than simply
> > dev_attr_##_name? As it seems unlikely that SENSOR_DEVICE_ATTR and
> > DEVICE_ATTR will both be called for the same file, going for the
> > short form shouldn't cause any problem. This would make the calling
> > code more readable IMHO.
> 
> Hm, I really don't care either way about this.

Let's not change it then.

---------------------------------------------------------

This patch renames the new linux/i2c-sysfs.h header file to
linux/hwmon-sysfs.h. This names seems to be more appropriate since this
file defines macros and structures not related to i2c but to hardware
monitoring drivers. The patch also updates the five hardware monitoring
driver which include that header file already.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/adm1026.c |    2 +-
 drivers/i2c/chips/it87.c    |    2 +-
 drivers/i2c/chips/lm63.c    |    2 +-
 drivers/i2c/chips/lm83.c    |    2 +-
 drivers/i2c/chips/lm90.c    |    2 +-
 include/linux/hwmon-sysfs.h |   37 +++++++++++++++++++++++++++++++++++++
 include/linux/i2c-sysfs.h   |   37 -------------------------------------
 7 files changed, 42 insertions(+), 42 deletions(-)

--- linux-2.6.12-rc5.orig/drivers/i2c/chips/adm1026.c	2005-06-05 10:53:57.000000000 +0200
+++ linux-2.6.12-rc5/drivers/i2c/chips/adm1026.c	2005-06-06 19:23:32.000000000 +0200
@@ -29,8 +29,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-#include <linux/i2c-sysfs.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon-sysfs.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
--- linux-2.6.12-rc5.orig/drivers/i2c/chips/it87.c	2005-06-05 11:51:22.000000000 +0200
+++ linux-2.6.12-rc5/drivers/i2c/chips/it87.c	2005-06-06 19:23:14.000000000 +0200
@@ -37,8 +37,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-#include <linux/i2c-sysfs.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon-sysfs.h>
 #include <asm/io.h>
 
 
--- linux-2.6.12-rc5.orig/drivers/i2c/chips/lm63.c	2005-06-06 19:09:36.000000000 +0200
+++ linux-2.6.12-rc5/drivers/i2c/chips/lm63.c	2005-06-06 19:23:01.000000000 +0200
@@ -43,7 +43,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-#include <linux/i2c-sysfs.h>
+#include <linux/hwmon-sysfs.h>
 
 /*
  * Addresses to scan
--- linux-2.6.12-rc5.orig/drivers/i2c/chips/lm83.c	2005-06-06 19:09:36.000000000 +0200
+++ linux-2.6.12-rc5/drivers/i2c/chips/lm83.c	2005-06-06 19:22:55.000000000 +0200
@@ -33,7 +33,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-#include <linux/i2c-sysfs.h>
+#include <linux/hwmon-sysfs.h>
 
 /*
  * Addresses to scan
--- linux-2.6.12-rc5.orig/drivers/i2c/chips/lm90.c	2005-06-05 19:35:05.000000000 +0200
+++ linux-2.6.12-rc5/drivers/i2c/chips/lm90.c	2005-06-06 19:22:48.000000000 +0200
@@ -76,7 +76,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-#include <linux/i2c-sysfs.h>
+#include <linux/hwmon-sysfs.h>
 
 /*
  * Addresses to scan
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-rc5/include/linux/hwmon-sysfs.h	2005-06-06 19:21:02.000000000 +0200
@@ -0,0 +1,37 @@
+/*
+ *  hwmon-sysfs.h - hardware monitoring chip driver sysfs defines
+ *
+ *  Copyright (C) 2005 Yani Ioannou <yani.ioannou@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef _LINUX_HWMON_SYSFS_H
+#define _LINUX_HWMON_SYSFS_H
+
+struct sensor_device_attribute{
+	struct device_attribute dev_attr;
+	int index;
+};
+
+#define to_sensor_dev_attr(_dev_attr) \
+container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
+
+#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
+struct sensor_device_attribute sensor_dev_attr_##_name = {	\
+	.dev_attr=__ATTR(_name,_mode,_show,_store),		\
+	.index=_index,						\
+}
+
+#endif /* _LINUX_HWMON_SYSFS_H */
--- linux-2.6.12-rc5.orig/include/linux/i2c-sysfs.h	2005-06-05 10:53:57.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,37 +0,0 @@
-/*
- *  i2c-sysfs.h - i2c chip driver sysfs defines
- *
- *  Copyright (C) 2005 Yani Ioannou <yani.ioannou@gmail.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#ifndef _LINUX_I2C_SYSFS_H
-#define _LINUX_I2C_SYSFS_H
-
-struct sensor_device_attribute{
-	struct device_attribute dev_attr;
-	int index;
-};
-
-#define to_sensor_dev_attr(_dev_attr) \
-container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
-
-#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
-struct sensor_device_attribute sensor_dev_attr_##_name = {	\
-	.dev_attr=__ATTR(_name,_mode,_show,_store),		\
-	.index=_index,						\
-}
-
-#endif /* _LINUX_I2C_SYSFS_H */


-- 
Jean Delvare
