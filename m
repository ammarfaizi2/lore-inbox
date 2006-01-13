Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422871AbWAMUCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422871AbWAMUCu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422929AbWAMUCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:02:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:41108 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422873AbWAMTu3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:29 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add i2c_bus_type probe and remove methods
In-Reply-To: <11371818101170@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:10 -0800
Message-Id: <11371818103208@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add i2c_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b864c7d5d17c171c4ead0791b44ab05d7a21dc0c
tree f9822f71b07920f819c3282084fa2831fc6d7458
parent 5b34bf88779fa965a134b92ab61688e0d1ddfe1d
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:37:50 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:07 -0800

 drivers/i2c/i2c-core.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 52b7747..0ce58b5 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
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
@@ -294,8 +294,6 @@ int i2c_register_driver(struct module *o
 	/* add the driver to the list of i2c drivers in the driver core */
 	driver->driver.owner = owner;
 	driver->driver.bus = &i2c_bus_type;
-	driver->driver.probe = i2c_device_probe;
-	driver->driver.remove = i2c_device_remove;
 
 	res = driver_register(&driver->driver);
 	if (res)

