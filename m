Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVKESNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVKESNx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVKESNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:13:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36369 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932141AbVKESNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:13:52 -0500
Date: Sat, 5 Nov 2005 18:13:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert arch/um/
Message-ID: <20051105181347.GC14419@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051105181122.GD12228@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105181122.GD12228@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform drivers to use struct platform_driver

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -285,9 +285,10 @@ void uml_net_user_timer_expire(unsigned 
 static DEFINE_SPINLOCK(devices_lock);
 static struct list_head devices = LIST_HEAD_INIT(devices);
 
-static struct device_driver uml_net_driver = {
-	.name  = DRIVER_NAME,
-	.bus   = &platform_bus_type,
+static struct platform_driver uml_net_driver = {
+	.driver = {
+		.name  = DRIVER_NAME,
+	},
 };
 static int driver_registered;
 
@@ -334,7 +335,7 @@ static int eth_configure(int n, void *in
 
 	/* sysfs register */
 	if (!driver_registered) {
-		driver_register(&uml_net_driver);
+		platform_driver_register(&uml_net_driver);
 		driver_registered = 1;
 	}
 	device->pdev.id = n;
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -823,9 +823,10 @@ static int ubd_mc_init(void)
 
 __initcall(ubd_mc_init);
 
-static struct device_driver ubd_driver = {
-	.name  = DRIVER_NAME,
-	.bus   = &platform_bus_type,
+static struct platform_driver ubd_driver = {
+	.driver = {
+		.name  = DRIVER_NAME,
+	},
 };
 
 int ubd_init(void)
@@ -850,7 +851,7 @@ int ubd_init(void)
 		if (register_blkdev(fake_major, "ubd"))
 			return -1;
 	}
-	driver_register(&ubd_driver);
+	platform_driver_register(&ubd_driver);
 	for (i = 0; i < MAX_DEV; i++) 
 		ubd_add(i);
 	return 0;


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
