Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVAWEeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVAWEeD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVAWEa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:30:57 -0500
Received: from soundwarez.org ([217.160.171.123]:31371 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261210AbVAWE1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:27:16 -0500
Date: Sun, 23 Jan 2005 05:27:10 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 7/7] inifiniband: pass dev_t to class core
Message-ID: <20050123042710.GC9256@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== drivers/infiniband/core/user_mad.c 1.2 vs edited =====
--- 1.2/drivers/infiniband/core/user_mad.c	2005-01-21 06:01:17 +01:00
+++ edited/drivers/infiniband/core/user_mad.c	2005-01-22 15:34:10 +01:00
@@ -518,15 +518,6 @@ static struct ib_client umad_client = {
 	.remove = ib_umad_remove_one
 };
 
-static ssize_t show_dev(struct class_device *class_dev, char *buf)
-{
-	struct ib_umad_port *port =
-		container_of(class_dev, struct ib_umad_port, class_dev);
-
-	return print_dev_t(buf, port->dev.dev);
-}
-static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
-
 static ssize_t show_ibdev(struct class_device *class_dev, char *buf)
 {
 	struct ib_umad_port *port =
@@ -625,16 +616,13 @@ static void ib_umad_add_one(struct ib_de
 			     umad_dev->port[i - s].devnum, 1))
 			goto err;
 
-		umad_dev->port[i - s].class_dev.class = &umad_class;
+		umad_dev->port[i - s].class_dev.devt  = umad_dev->port[i - s].dev.dev;
 		umad_dev->port[i - s].class_dev.dev   = device->dma_device;
 		snprintf(umad_dev->port[i - s].class_dev.class_id,
 			 BUS_ID_SIZE, "umad%d", umad_dev->port[i - s].devnum);
 		if (class_device_register(&umad_dev->port[i - s].class_dev))
 			goto err_class;
 
-		if (class_device_create_file(&umad_dev->port[i - s].class_dev,
-					     &class_device_attr_dev))
-			goto err_class;
 		if (class_device_create_file(&umad_dev->port[i - s].class_dev,
 					     &class_device_attr_ibdev))
 			goto err_class;

