Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVBBUeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVBBUeG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVBBU3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:29:53 -0500
Received: from gprs215-95.eurotel.cz ([160.218.215.95]:39040 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262566AbVBBU0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 15:26:43 -0500
Date: Wed, 2 Feb 2005 21:26:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: bernard@blackham.com.au, linux-usb-devel@lists.sourceforge.net,
       greg@kroah.com
Subject: driver model: fix types in usb
Message-ID: <20050202202610.GA1948@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

From: Bernard Blackham <bernard@blackham.com.au>

This fixes types in USB w.r.t. driver model. It should not actually
change any code. Please apply,

								Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff -ru linux-2.6.11-rc2-2.1.5.15/drivers/usb/core/hub.c linux-2.6.11-rc2-2.1.5.16/drivers/usb/core/hub.c
--- linux-2.6.11-rc2-2.1.5.15/drivers/usb/core/hub.c	2005-01-30 13:37:32.000000000 +0800
+++ linux-2.6.11-rc2-2.1.5.16/drivers/usb/core/hub.c	2005-02-02 22:30:48.000000000 +0800
@@ -1235,10 +1235,10 @@
 		 */
 		if (udev->bus->b_hnp_enable || udev->bus->is_b_host) {
 			static int __usb_suspend_device (struct usb_device *,
-						int port1, u32 state);
+						int port1, pm_message_t state);
 			err = __usb_suspend_device(udev,
 					udev->bus->otg_port,
-					PM_SUSPEND_MEM);
+					PMSG_SUSPEND);
 			if (err < 0)
 				dev_dbg(&udev->dev, "HNP fail, %d\n", err);
 		}
@@ -1523,7 +1523,7 @@
  * Linux (2.6) currently has NO mechanisms to initiate that:  no khubd
  * timer, no SRP, no requests through sysfs.
  */
-int __usb_suspend_device (struct usb_device *udev, int port1, u32 state)
+int __usb_suspend_device (struct usb_device *udev, int port1, pm_message_t state)
 {
 	int	status;
 
@@ -1621,7 +1621,7 @@
 /**
  * usb_suspend_device - suspend a usb device
  * @udev: device that's no longer in active use
- * @state: PM_SUSPEND_MEM to suspend
+ * @state: PMSG_SUSPEND to suspend
  * Context: must be able to sleep; device not locked
  *
  * Suspends a USB device that isn't in active use, conserving power.
@@ -1670,7 +1670,7 @@
 	usb_set_device_state(udev, udev->actconfig
 			? USB_STATE_CONFIGURED
 			: USB_STATE_ADDRESS);
-	udev->dev.power.power_state = PM_SUSPEND_ON;
+	udev->dev.power.power_state = PMSG_ON;
 
  	/* 10.5.4.5 says be sure devices in the tree are still there.
  	 * For now let's assume the device didn't go crazy on resume,
@@ -1871,7 +1871,7 @@
 	return status;
 }
 
-static int hub_suspend(struct usb_interface *intf, u32 state)
+static int hub_suspend(struct usb_interface *intf, pm_message_t state)
 {
 	struct usb_hub		*hub = usb_get_intfdata (intf);
 	struct usb_device	*hdev = hub->hdev;
@@ -1943,7 +1943,7 @@
 		}
 		up(&udev->serialize);
 	}
-	intf->dev.power.power_state = PM_SUSPEND_ON;
+	intf->dev.power.power_state = PMSG_ON;
 
 	hub_activate(hub);
 	return 0;



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
