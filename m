Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVAHIvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVAHIvY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVAHItl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:49:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:55685 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261885AbVAHFs1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:27 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632601628@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:40 -0800
Message-Id: <11051632601397@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.16, 2004/12/20 17:25:07-08:00, greg@kroah.com

USB Gadget: fix up simple sparse warnings (NULL stuff) in dummy_hcd.c driver

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/gadget/dummy_hcd.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)


diff -Nru a/drivers/usb/gadget/dummy_hcd.c b/drivers/usb/gadget/dummy_hcd.c
--- a/drivers/usb/gadget/dummy_hcd.c	2005-01-07 15:42:02 -08:00
+++ b/drivers/usb/gadget/dummy_hcd.c	2005-01-07 15:42:02 -08:00
@@ -375,7 +375,7 @@
 	dum = ep_to_dummy (ep);
 
 	spin_lock_irqsave (&dum->lock, flags);
-	ep->desc = 0;
+	ep->desc = NULL;
 	retval = 0;
 	nuke (dum, ep);
 	spin_unlock_irqrestore (&dum->lock, flags);
@@ -391,12 +391,12 @@
 	struct dummy_request	*req;
 
 	if (!_ep)
-		return 0;
+		return NULL;
 	ep = usb_ep_to_dummy_ep (_ep);
 
 	req = kmalloc (sizeof *req, mem_flags);
 	if (!req)
-		return 0;
+		return NULL;
 	memset (req, 0, sizeof *req);
 	INIT_LIST_HEAD (&req->queue);
 	return &req->req;
@@ -432,7 +432,7 @@
 	dum = ep_to_dummy (ep);
 
 	if (!dum->driver)
-		return 0;
+		return NULL;
 	retval = kmalloc (bytes, mem_flags);
 	*dma = (dma_addr_t) retval;
 	return retval;
@@ -516,7 +516,7 @@
 	struct dummy		*dum;
 	int			retval = -EINVAL;
 	unsigned long		flags;
-	struct dummy_request	*req = 0;
+	struct dummy_request	*req = NULL;
 
 	if (!_ep || !_req)
 		return retval;
@@ -730,7 +730,7 @@
 		ep->ep.maxpacket = ~0;
 		ep->last_io = jiffies;
 		ep->gadget = &dum->gadget;
-		ep->desc = 0;
+		ep->desc = NULL;
 		INIT_LIST_HEAD (&ep->queue);
 	}
 
@@ -744,8 +744,8 @@
 	dev_dbg (dummy_dev(dum), "binding gadget driver '%s'\n",
 			driver->driver.name);
 	if ((retval = driver->bind (&dum->gadget)) != 0) {
-		dum->driver = 0;
-		dum->gadget.dev.driver = 0;
+		dum->driver = NULL;
+		dum->gadget.dev.driver = NULL;
 		return retval;
 	}
 
@@ -807,7 +807,7 @@
 	spin_unlock_irqrestore (&dum->lock, flags);
 
 	driver->unbind (&dum->gadget);
-	dum->driver = 0;
+	dum->driver = NULL;
 
 	device_release_driver (&dum->gadget.dev);
 
@@ -1117,7 +1117,7 @@
 		struct urb		*urb;
 		struct dummy_request	*req;
 		u8			address;
-		struct dummy_ep		*ep = 0;
+		struct dummy_ep		*ep = NULL;
 		int			type;
 
 		urb = urbp->urb;
@@ -1372,7 +1372,7 @@
 			ep->already_seen = ep->setup_stage = 0;
 
 		spin_unlock (&dum->lock);
-		usb_hcd_giveback_urb (dummy_to_hcd(dum), urb, 0);
+		usb_hcd_giveback_urb (dummy_to_hcd(dum), urb, NULL);
 		spin_lock (&dum->lock);
 
 		goto restart;
@@ -1644,7 +1644,7 @@
 
 	INIT_LIST_HEAD (&dum->urbp_list);
 
-	root = usb_alloc_dev (0, &hcd->self, 0);
+	root = usb_alloc_dev (NULL, &hcd->self, 0);
 	if (!root)
 		return -ENOMEM;
 
@@ -1696,7 +1696,7 @@
 
 static int dummy_h_get_frame (struct usb_hcd *hcd)
 {
-	return dummy_g_get_frame (0);
+	return dummy_g_get_frame (NULL);
 }
 
 static const struct hc_driver dummy_hcd = {

