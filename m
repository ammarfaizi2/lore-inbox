Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTEIXqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTEIXmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:42:31 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:8159 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263587AbTEIXmG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:42:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10525245943169@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.69
In-Reply-To: <10525245943581@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 9 May 2003 16:56:34 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1083.2.6, 2003/05/09 16:12:53-07:00, greg@kroah.com

[PATCH] i2c: register the i2c_adapter_driver so things link up properly in sysfs


 drivers/i2c/i2c-core.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Fri May  9 16:47:36 2003
+++ b/drivers/i2c/i2c-core.c	Fri May  9 16:47:36 2003
@@ -55,8 +55,8 @@
 	return 0;
 }
 
-static struct device_driver i2c_generic_driver = {
-	.name =	"i2c",
+static struct device_driver i2c_adapter_driver = {
+	.name =	"i2c_adapter",
 	.bus = &i2c_bus_type,
 	.probe = i2c_device_probe,
 	.remove = i2c_device_remove,
@@ -98,7 +98,7 @@
 	if (adap->dev.parent == NULL)
 		adap->dev.parent = &legacy_bus;
 	sprintf(adap->dev.bus_id, "i2c-%d", adap->nr);
-	adap->dev.driver = &i2c_generic_driver;
+	adap->dev.driver = &i2c_adapter_driver;
 	device_register(&adap->dev);
 
 	/* Add this adapter to the i2c_adapter class */
@@ -462,12 +462,16 @@
 	retval = bus_register(&i2c_bus_type);
 	if (retval)
 		return retval;
+	retval = driver_register(&i2c_adapter_driver);
+	if (retval)
+		return retval;
 	return class_register(&i2c_adapter_class);
 }
 
 static void __exit i2c_exit(void)
 {
 	class_unregister(&i2c_adapter_class);
+	driver_unregister(&i2c_adapter_driver);
 	bus_unregister(&i2c_bus_type);
 }
 

