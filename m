Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbUKJA7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUKJA7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 19:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbUKJA7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 19:59:50 -0500
Received: from hera.cwi.nl ([192.16.191.8]:37822 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261784AbUKJA7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 19:59:47 -0500
Date: Wed, 10 Nov 2004 01:59:43 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove explicit k_name use in atmel_cs.c, bt3c_cs.c
Message-ID: <20041110005941.GA9336@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -uprN -X /linux/dontdiff a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
--- a/drivers/bluetooth/bt3c_cs.c	2004-08-26 22:05:15.000000000 +0200
+++ b/drivers/bluetooth/bt3c_cs.c	2004-11-10 01:23:01.000000000 +0100
@@ -489,13 +489,10 @@ static int bt3c_hci_ioctl(struct hci_dev
 
 static struct device *bt3c_device(void)
 {
-	static char *kobj_name = "bt3c";
-
 	static struct device dev = {
 		.bus_id = "pcmcia",
 	};
-	dev.kobj.k_name = kmalloc(strlen(kobj_name) + 1, GFP_KERNEL);
-	strcpy(dev.kobj.k_name, kobj_name);
+	kobject_set_name(&dev.kobj, "bt3c");
 	kobject_init(&dev.kobj);
 
 	return &dev;
diff -uprN -X /linux/dontdiff a/drivers/net/wireless/atmel_cs.c b/drivers/net/wireless/atmel_cs.c
--- a/drivers/net/wireless/atmel_cs.c	2004-08-26 22:05:25.000000000 +0200
+++ b/drivers/net/wireless/atmel_cs.c	2004-11-10 01:20:55.000000000 +0100
@@ -350,13 +350,10 @@ static struct { 
 /* This is strictly temporary, until PCMCIA devices get integrated into the device model. */
 static struct device *atmel_device(void)
 {
-	static char *kobj_name = "atmel_cs";
-
 	static struct device dev = {
 		.bus_id    = "pcmcia",
 	};
-	dev.kobj.k_name = kmalloc(strlen(kobj_name)+1, GFP_KERNEL);
-	strcpy(dev.kobj.k_name, kobj_name);
+	kobject_set_name(&dev.kobj, "atmel_cs");
 	kobject_init(&dev.kobj);
 	
 	return &dev;
