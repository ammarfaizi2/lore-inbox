Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVBSTCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVBSTCI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 14:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVBSTCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 14:02:07 -0500
Received: from mail00.svc.cra.dublin.eircom.net ([159.134.118.16]:35689 "HELO
	mail00.svc.cra.dublin.eircom.net") by vger.kernel.org with SMTP
	id S261768AbVBSTCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 14:02:00 -0500
Subject: [PATCH] Remove unnecessary addition operations from usb/core/hub.c
From: Telemaque Ndizihiwe <telendiz@eircom.net>
To: rddunlap@osdl.org, bhards@bigpond.net.au
Cc: torvalds@osdl.org, akpm@osdl.org, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 19 Feb 2005 19:03:27 +0000
Message-Id: <1108839807.7748.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch removes unnecessary addition operations from
usb/core/hub.c in kernel 2.6.10.

	usb_disable_endpoint(udev, 0 + USB_DIR_IN);   //replaced by
	usb_disable_endpoint(udev, USB_DIR_IN);

	usb_disable_endpoint(udev, 0 + USB_DIR_OUT);  //replaced by	
	usb_disable_endpoint(udev, USB_DIR_OUT);


Signed-off-by: Telemaque Ndizihiwe <telendiz@eircom.net>


--- linux-2.6.10/drivers/usb/core/hub.c.orig	2005-02-19
12:26:28.682067480 +0000
+++ linux-2.6.10/drivers/usb/core/hub.c	2005-02-19 12:38:55.059600848
+0000
@@ -2044,8 +2044,8 @@ static int hub_set_address(struct usb_de
 		int m = udev->epmaxpacketin[0];
 
 		usb_set_device_state(udev, USB_STATE_ADDRESS);
-		usb_disable_endpoint(udev, 0 + USB_DIR_IN);
-		usb_disable_endpoint(udev, 0 + USB_DIR_OUT);
+		usb_disable_endpoint(udev, USB_DIR_IN);
+		usb_disable_endpoint(udev, USB_DIR_OUT);
 		udev->epmaxpacketin[0] = udev->epmaxpacketout[0] = m;
 	}
 	return retval;
@@ -2244,8 +2244,8 @@ hub_port_init (struct usb_device *hdev, 
 	i = udev->descriptor.bMaxPacketSize0;
 	if (udev->epmaxpacketin[0] != i) {
 		dev_dbg(&udev->dev, "ep0 maxpacket = %d\n", i);
-		usb_disable_endpoint(udev, 0 + USB_DIR_IN);
-		usb_disable_endpoint(udev, 0 + USB_DIR_OUT);
+		usb_disable_endpoint(udev, USB_DIR_IN);
+		usb_disable_endpoint(udev, USB_DIR_OUT);
 		udev->epmaxpacketin[0] = udev->epmaxpacketout[0] = i;
 	}
   
@@ -2508,8 +2508,8 @@ static void hub_port_connect_change(stru
 
 loop:
 		hub_port_disable(hdev, port);
-		usb_disable_endpoint(udev, 0 + USB_DIR_IN);
-		usb_disable_endpoint(udev, 0 + USB_DIR_OUT);
+		usb_disable_endpoint(udev, USB_DIR_IN);
+		usb_disable_endpoint(udev, USB_DIR_OUT);
 		release_address(udev);
 		usb_put_dev(udev);
 		if (status == -ENOTCONN)
@@ -2893,8 +2893,8 @@ int usb_reset_device(struct usb_device *
 
 		/* ep0 maxpacket size may change; let the HCD know about it.
 		 * Other endpoints will be handled by re-enumeration. */
-		usb_disable_endpoint(udev, 0 + USB_DIR_IN);
-		usb_disable_endpoint(udev, 0 + USB_DIR_OUT);
+		usb_disable_endpoint(udev, USB_DIR_IN);
+		usb_disable_endpoint(udev, USB_DIR_OUT);
 		ret = hub_port_init(parent, udev, port, i);
 		if (ret >= 0)
 			break;


