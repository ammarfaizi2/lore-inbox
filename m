Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWAEOh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWAEOh7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWAEOh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:37:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41743 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751367AbWAEOh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:37:56 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, I2C <lm-sensors@lm-sensors.org>
Subject: [CFT 16/29] Add i2c_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:37:50 +0000
Message-ID: <20060105142951.13.16@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/i2c/i2c-core.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/i2c/i2c-core.c linux/drivers/i2c/i2c-core.c
--- linus/drivers/i2c/i2c-core.c	Sun Nov  6 22:15:59 2005
+++ linux/drivers/i2c/i2c-core.c	Sun Nov 13 16:21:32 2005
@@ -63,13 +63,6 @@ static int i2c_bus_resume(struct device 
 	return rc;
 }
 
-struct bus_type i2c_bus_type = {
-	.name =		"i2c",
-	.match =	i2c_device_match,
-	.suspend =      i2c_bus_suspend,
-	.resume =       i2c_bus_resume,
-};
-
 static int i2c_device_probe(struct device *dev)
 {
 	return -ENODEV;
@@ -80,6 +73,15 @@ static int i2c_device_remove(struct devi
 	return 0;
 }
 
+struct bus_type i2c_bus_type = {
+	.name =		"i2c",
+	.match =	i2c_device_match,
+	.probe =	i2c_device_probe,
+	.remove =	i2c_device_remove,
+	.suspend =      i2c_bus_suspend,
+	.resume =       i2c_bus_resume,
+};
+
 void i2c_adapter_dev_release(struct device *dev)
 {
 	struct i2c_adapter *adap = dev_to_i2c_adapter(dev);
@@ -90,8 +92,6 @@ struct device_driver i2c_adapter_driver 
 	.owner = THIS_MODULE,
 	.name =	"i2c_adapter",
 	.bus = &i2c_bus_type,
-	.probe = i2c_device_probe,
-	.remove = i2c_device_remove,
 };
 
 static void i2c_adapter_class_dev_release(struct class_device *dev)
@@ -298,8 +298,6 @@ int i2c_add_driver(struct i2c_driver *dr
 	driver->driver.owner = driver->owner;
 	driver->driver.name = driver->name;
 	driver->driver.bus = &i2c_bus_type;
-	driver->driver.probe = i2c_device_probe;
-	driver->driver.remove = i2c_device_remove;
 
 	res = driver_register(&driver->driver);
 	if (res)
