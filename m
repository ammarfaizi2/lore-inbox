Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVFUDW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVFUDW1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVFUDRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:17:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:5092 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261649AbVFTW7d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:33 -0400
Cc: yani.ioannou@gmail.com
Subject: [PATCH] I2C: add i2c sensor_device_attribute and macros
In-Reply-To: <11193083693406@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:29 -0700
Message-Id: <111930836944@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: add i2c sensor_device_attribute and macros

This patch creates a new header with a potential standard i2c sensor
attribute type (which simply includes an int representing the sensor
number/index) and the associated macros, SENSOR_DEVICE_ATTR to define
a static attribute and to_sensor_dev_attr to get a
sensor_device_attribute reference from an embedded device_attribute
reference.

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---
commit 0a3e7eeabc9f76b7496488aad2d11626ff6a2a4f
tree 0cab827910fe12199d666b84919d88fb881fb82d
parent f2d03e1b3f00f1c5971463ab0101bef0c521ad3b
author Yani Ioannou <yani.ioannou@gmail.com> Tue, 17 May 2005 22:59:05 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:36 -0700

 include/linux/i2c-sysfs.h |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c-sysfs.h b/include/linux/i2c-sysfs.h
new file mode 100644
--- /dev/null
+++ b/include/linux/i2c-sysfs.h
@@ -0,0 +1,36 @@
+/*
+ *  i2c-sysfs.h - i2c chip driver sysfs defines
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
+#ifndef _LINUX_I2C_SYSFS_H
+#define _LINUX_I2C_SYSFS_H
+
+struct sensor_device_attribute{
+	struct device_attribute dev_attr;
+	int index;
+};
+#define to_sensor_dev_attr(_dev_attr) \
+	container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
+
+#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
+struct sensor_device_attribute sensor_dev_attr_##_name = {	\
+	.dev_attr =	__ATTR(_name,_mode,_show,_store),	\
+	.index =	_index,					\
+}
+
+#endif /* _LINUX_I2C_SYSFS_H */

