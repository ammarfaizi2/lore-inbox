Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbVG3AxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbVG3AxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVG3Aux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:50:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:6832 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262760AbVG2TS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:18:56 -0400
Date: Fri, 29 Jul 2005 12:18:23 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, CHRIS.A.CONGER@saic.com
Subject: [patch 27/29] USB: fix Bug in usb-skeleton.c
Message-ID: <20050729191823.GC5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-skeleton-fix.patch"
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Conger, Chris A." <CHRIS.A.CONGER@saic.com>

Compare endpoint address to USB_ENDPOINT_DIR_MASK to determine endpoint
direction...


From: "Conger, Chris A." <CHRIS.A.CONGER@saic.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/usb-skeleton.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/usb/usb-skeleton.c	2005-07-29 11:29:47.000000000 -0700
+++ gregkh-2.6/drivers/usb/usb-skeleton.c	2005-07-29 11:36:33.000000000 -0700
@@ -257,7 +257,8 @@
 		endpoint = &iface_desc->endpoint[i].desc;
 
 		if (!dev->bulk_in_endpointAddr &&
-		    (endpoint->bEndpointAddress & USB_DIR_IN) &&
+		    ((endpoint->bEndpointAddress & USB_ENDPOINT_DIR_MASK)
+					== USB_DIR_IN) &&
 		    ((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
 					== USB_ENDPOINT_XFER_BULK)) {
 			/* we found a bulk in endpoint */
@@ -272,7 +273,8 @@
 		}
 
 		if (!dev->bulk_out_endpointAddr &&
-		    !(endpoint->bEndpointAddress & USB_DIR_OUT) &&
+		    ((endpoint->bEndpointAddress & USB_ENDPOINT_DIR_MASK)
+					== USB_DIR_OUT) &&
 		    ((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
 					== USB_ENDPOINT_XFER_BULK)) {
 			/* we found a bulk out endpoint */

--
