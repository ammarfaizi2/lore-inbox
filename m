Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVBGPpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVBGPpx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 10:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVBGPpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 10:45:25 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:45088 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261161AbVBGPmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 10:42:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=dajrI94h0u+5nUKzUGoZ5HqS8+xQsypC59lti5s3Hg2XCkj5JDc7QH4B5Bya9Fmq+zENhWMoQ/L1RQnw3fTRcSPJhq5u2+EejEjgH1gdfHwdT3zKudvDu1t5daioermvBc4EyPP24x+p3Vg8t5iY4cReg+Am+ghdvRU4iQ2s+I4=
Date: Mon, 7 Feb 2005 16:44:24 +0100
From: Mikkel Krautz <krautz@gmail.com>
To: vojtech@ucw.cz
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Message-ID: <20050207154424.GB4742@omnipotens.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And, here's an updated version of hid-core.c:

Signed-off-by: Mikkel Krautz <krautz@gmail.com>
---
--- clean/drivers/usb/input/hid-core.c
+++ dirty/drivers/usb/input/hid-core.c
@@ -37,13 +37,20 @@
  * Version Information
  */
 
-#define DRIVER_VERSION "v2.0"
+#define DRIVER_VERSION "v2.01"
 #define DRIVER_AUTHOR "Andreas Gal, Vojtech Pavlik"
 #define DRIVER_DESC "USB HID core driver"
 #define DRIVER_LICENSE "GPL"
 
 static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", "Joystick",
 				"Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};
+/*
+ * Module parameters.
+ */
+
+static unsigned int hid_mousepoll_interval;
+module_param_named(mousepoll, hid_mousepoll_interval, uint, 0644);
+MODULE_PARM_DESC(mousepoll, "Polling interval of mice");
 
 /*
  * Register a new report for a device.
@@ -1695,6 +1702,12 @@
 		if (dev->speed == USB_SPEED_HIGH)
 			interval = 1 << (interval - 1);
 
+		/* Change the polling interval of mice. */
+		if (hid->collection->usage == HID_GD_MOUSE && hid_mousepoll_interval > 0)
+			interval = hid_mousepoll_interval;
+		else
+			hid_mousepoll_interval = interval;
+		
 		if (endpoint->bEndpointAddress & USB_DIR_IN) {
 			if (hid->urbin)
 				continue;


