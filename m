Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261231AbVCEX7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVCEX7c (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 5 Mar 2005 18:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVCEXom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:44:42 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:34948 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261236AbVCEXhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:37:33 -0500
Date: Sat, 05 Mar 2005 17:37:32 -0600 (CST)
Date-warning: Date header was inserted by vms040.mailsrvcs.net
From: James Nelson <james4765@cwazy.co.uk>
Subject: [PATCH 4/13] lh7a40x_udc: Clean up printk()'s in
 drivers/usb/gadget/lh7a40x_udc.c
In-reply-to: <20050305233712.7648.24364.93822@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-id: <20050305233731.7648.47319.17412@localhost.localdomain>
References: <20050305233712.7648.24364.93822@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add KERN_ constants to drivers/usb/gadget/lh7a40x_udc.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -Nurp -x dontdiff-osdl --exclude='*~' linux-2.6.11-mm1-original/drivers/usb/gadget/lh7a40x_udc.c linux-2.6.11-mm1/drivers/usb/gadget/lh7a40x_udc.c
--- linux-2.6.11-mm1-original/drivers/usb/gadget/lh7a40x_udc.c	2005-03-05 13:29:48.000000000 -0500
+++ linux-2.6.11-mm1/drivers/usb/gadget/lh7a40x_udc.c	2005-03-05 15:04:10.000000000 -0500
@@ -437,7 +437,7 @@ int usb_gadget_register_driver(struct us
 	device_add(&dev->gadget.dev);
 	retval = driver->bind(&dev->gadget);
 	if (retval) {
-		printk("%s: bind to driver %s --> error %d\n", dev->gadget.name,
+		printk(KERN_ERR "%s: bind to driver %s --> error %d\n", dev->gadget.name,
 		       driver->driver.name, retval);
 		device_del(&dev->gadget.dev);
 
@@ -450,7 +450,7 @@ int usb_gadget_register_driver(struct us
 	 * for set_configuration as well as eventual disconnect.
 	 * NOTE:  this shouldn't power up until later.
 	 */
-	printk("%s: registered gadget driver '%s'\n", dev->gadget.name,
+	pr_info("%s: registered gadget driver '%s'\n", dev->gadget.name,
 	       driver->driver.name);
 
 	udc_enable(dev);
@@ -585,7 +585,7 @@ static int read_fifo(struct lh7a40x_ep *
 			 * discard the extra data.
 			 */
 			if (req->req.status != -EOVERFLOW)
-				printk("%s overflow %d\n", ep->ep.name, count);
+				printk(KERN_ERR "%s overflow %d\n", ep->ep.name, count);
 			req->req.status = -EOVERFLOW;
 		} else {
 			*buf++ = byte;
@@ -835,7 +835,7 @@ static void lh7a40x_out_epn(struct lh7a4
 						       queue);
 
 				if (!req) {
-					printk("%s: NULL REQ %d\n",
+					printk(KERN_WARNING "%s: NULL REQ %d\n",
 					       __FUNCTION__, ep_idx);
 					flush(ep);
 					break;
@@ -848,7 +848,7 @@ static void lh7a40x_out_epn(struct lh7a4
 
 	} else {
 		/* Throw packet away.. */
-		printk("%s: No descriptor?!?\n", __FUNCTION__);
+		printk(KERN_WARNING "%s: no descriptor\n", __FUNCTION__);
 		flush(ep);
 	}
 }
