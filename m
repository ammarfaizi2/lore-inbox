Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTJ1SMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 13:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbTJ1SMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 13:12:21 -0500
Received: from crl-mail.crl.dec.com ([192.58.206.9]:44515 "EHLO
	crl-mail.crl.dec.com") by vger.kernel.org with ESMTP
	id S261239AbTJ1SMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 13:12:13 -0500
Subject: Re: PATCH: rename legacy bus to platform bus
From: Jamey Hicks <jamey.hicks@hp.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0310271445210.13116-100000@cherise>
References: <Pine.LNX.4.44.0310271445210.13116-100000@cherise>
Content-Type: multipart/mixed; boundary="=-v4yorNUZ1YH6ckOhVGuW"
Message-Id: <1067364722.529.127.camel@vimes.crl.hpl.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-5mdk 
Date: Tue, 28 Oct 2003 13:12:02 -0500
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.9,
	required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v4yorNUZ1YH6ckOhVGuW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-10-27 at 17:46, Patrick Mochel wrote:
> > Many of us, especially in the embedded computing world, think that 
> > "legacy bus" is a misnomer.  It's not going away.  What do root PCI 
> > buses connect to?  At the root of the device tree there is a bus.  This 
> > patch changes the name from legacy bus to platform bus.  I'm hoping this 
> > change can be made even this late in the development cycle.  It is a 
> > pretty small patch but I think that naming is very important.
> 
> Thanks, I've been meaning to fix it for some time. However, it didn't 
> apply: 
> 
> patching file drivers/base/platform.c
> Hunk #3 FAILED at 105.
> Hunk #4 FAILED at 136.
> Hunk #5 FAILED at 447.
> Hunk #6 FAILED at 111.
> Hunk #7 FAILED at 372.
> 5 out of 7 hunks FAILED -- saving rejects to file 
> drivers/base/platform.c.rej
> 

Regenerated from a cleanly modified 2.6.0-test9 tree.

Jamey


--=-v4yorNUZ1YH6ckOhVGuW
Content-Disposition: attachment; filename=platform-bus.patch
Content-Type: text/x-patch; name=platform-bus.patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -urN -X dontdiff linux-2.6.0-test9/drivers/base/platform.c linux-2.6.0-test9-jeh1/drivers/base/platform.c
--- linux-2.6.0-test9/drivers/base/platform.c	2003-10-25 14:42:57.000000000 -0400
+++ linux-2.6.0-test9-jeh1/drivers/base/platform.c	2003-10-28 13:04:06.000000000 -0500
@@ -1,5 +1,5 @@
 /*
- * platform.c - platform 'psuedo' bus for legacy devices
+ * platform.c - platform 'psuedo' bus for root devices
  *
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs
@@ -14,8 +14,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-struct device legacy_bus = {
-	.bus_id		= "legacy",
+struct device platform_bus = {
+	.bus_id		= "platform",
 };
 
 /**
@@ -29,7 +29,7 @@
 		return -EINVAL;
 
 	if (!pdev->dev.parent)
-		pdev->dev.parent = &legacy_bus;
+		pdev->dev.parent = &platform_bus;
 
 	pdev->dev.bus = &platform_bus_type;
 	
@@ -105,11 +105,11 @@
 
 int __init platform_bus_init(void)
 {
-	device_register(&legacy_bus);
+	device_register(&platform_bus);
 	return bus_register(&platform_bus_type);
 }
 
-EXPORT_SYMBOL(legacy_bus);
+EXPORT_SYMBOL(platform_bus);
 EXPORT_SYMBOL(platform_bus_type);
 EXPORT_SYMBOL(platform_device_register);
 EXPORT_SYMBOL(platform_device_unregister);
diff -urN -X dontdiff linux-2.6.0-test9/drivers/i2c/i2c-core.c linux-2.6.0-test9-jeh1/drivers/i2c/i2c-core.c
--- linux-2.6.0-test9/drivers/i2c/i2c-core.c	2003-10-25 14:43:00.000000000 -0400
+++ linux-2.6.0-test9-jeh1/drivers/i2c/i2c-core.c	2003-10-28 13:04:41.000000000 -0500
@@ -136,10 +136,10 @@
 
 	/* Add the adapter to the driver core.
 	 * If the parent pointer is not set up,
-	 * we add this adapter to the legacy bus.
+	 * we add this adapter to the platform bus.
 	 */
 	if (adap->dev.parent == NULL)
-		adap->dev.parent = &legacy_bus;
+		adap->dev.parent = &platform_bus;
 	sprintf(adap->dev.bus_id, "i2c-%d", adap->nr);
 	adap->dev.driver = &i2c_adapter_driver;
 	adap->dev.release = &i2c_adapter_dev_release;
diff -urN -X dontdiff linux-2.6.0-test9/drivers/i2c/i2c-dev.c linux-2.6.0-test9-jeh1/drivers/i2c/i2c-dev.c
--- linux-2.6.0-test9/drivers/i2c/i2c-dev.c	2003-10-25 14:44:17.000000000 -0400
+++ linux-2.6.0-test9-jeh1/drivers/i2c/i2c-dev.c	2003-10-28 13:04:54.000000000 -0500
@@ -447,7 +447,7 @@
 
 	/* register this i2c device with the driver core */
 	i2c_dev->adap = adap;
-	if (adap->dev.parent == &legacy_bus)
+	if (adap->dev.parent == &platform_bus)
 		i2c_dev->class_dev.dev = &adap->dev;
 	else
 		i2c_dev->class_dev.dev = adap->dev.parent;
diff -urN -X dontdiff linux-2.6.0-test9/drivers/scsi/hosts.c linux-2.6.0-test9-jeh1/drivers/scsi/hosts.c
--- linux-2.6.0-test9/drivers/scsi/hosts.c	2003-10-25 14:42:51.000000000 -0400
+++ linux-2.6.0-test9-jeh1/drivers/scsi/hosts.c	2003-10-28 13:05:45.000000000 -0500
@@ -111,7 +111,7 @@
 	}
 
 	if (!shost->shost_gendev.parent)
-		shost->shost_gendev.parent = dev ? dev : &legacy_bus;
+		shost->shost_gendev.parent = dev ? dev : &platform_bus;
 
 	error = device_add(&shost->shost_gendev);
 	if (error)
diff -urN -X dontdiff linux-2.6.0-test9/include/linux/device.h linux-2.6.0-test9-jeh1/include/linux/device.h
--- linux-2.6.0-test9/include/linux/device.h	2003-10-25 14:44:42.000000000 -0400
+++ linux-2.6.0-test9-jeh1/include/linux/device.h	2003-10-28 13:06:04.000000000 -0500
@@ -372,7 +372,7 @@
 extern void platform_device_unregister(struct platform_device *);
 
 extern struct bus_type platform_bus_type;
-extern struct device legacy_bus;
+extern struct device platform_bus;
 
 /* drivers/base/power.c */
 extern void device_shutdown(void);

--=-v4yorNUZ1YH6ckOhVGuW--

