Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVAHJaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVAHJaD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVAHJVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:21:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:34437 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261838AbVAHFsJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:09 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632654050@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:45 -0800
Message-Id: <11051632651375@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.18, 2004/12/15 16:33:56-08:00, david-b@pacbell.net

[PATCH] USB: CRIS HCD and usb_dev->epmaxpacket (6/15)

Makes the CRIS HCD stop referencing the udev->epmaxpacket[] arrays.
Also makes it stop providing device allocate/deallocate routines;
this HCD doesn't need them, and a later patch will remove that API.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/hc_crisv10.c |   20 +-------------------
 1 files changed, 1 insertion(+), 19 deletions(-)


diff -Nru a/drivers/usb/host/hc_crisv10.c b/drivers/usb/host/hc_crisv10.c
--- a/drivers/usb/host/hc_crisv10.c	2005-01-07 15:49:14 -08:00
+++ b/drivers/usb/host/hc_crisv10.c	2005-01-07 15:49:14 -08:00
@@ -479,8 +479,6 @@
 static int etrax_usb_submit_urb(struct urb *urb, int mem_flags);
 static int etrax_usb_unlink_urb(struct urb *urb, int status);
 static int etrax_usb_get_frame_number(struct usb_device *usb_dev);
-static int etrax_usb_allocate_dev(struct usb_device *usb_dev);
-static int etrax_usb_deallocate_dev(struct usb_device *usb_dev);
 
 static irqreturn_t etrax_usb_tx_interrupt(int irq, void *vhc, struct pt_regs *regs);
 static irqreturn_t etrax_usb_rx_interrupt(int irq, void *vhc, struct pt_regs *regs);
@@ -512,8 +510,6 @@
 
 static struct usb_operations etrax_usb_device_operations =
 {
-	.allocate = etrax_usb_allocate_dev,
-	.deallocate = etrax_usb_deallocate_dev,
 	.get_frame_number = etrax_usb_get_frame_number,
 	.submit_urb = etrax_usb_submit_urb,
 	.unlink_urb = etrax_usb_unlink_urb,
@@ -1579,20 +1575,6 @@
 	return (*R_USB_FM_NUMBER & 0x7ff);
 }
 
-static int etrax_usb_allocate_dev(struct usb_device *usb_dev)
-{
-	DBFENTER;
-	DBFEXIT;
-	return 0;
-}
-
-static int etrax_usb_deallocate_dev(struct usb_device *usb_dev)
-{
-	DBFENTER;
-	DBFEXIT;
-	return 0;
-}
-
 static irqreturn_t etrax_usb_tx_interrupt(int irq, void *vhc, struct pt_regs *regs)
 {
 	DBFENTER;
@@ -4546,7 +4528,7 @@
         usb_rh->speed = USB_SPEED_FULL;
         usb_rh->devnum = 1;
         hc->bus->devnum_next = 2;
-        usb_rh->epmaxpacketin[0] = usb_rh->epmaxpacketout[0] = 64;
+        usb_rh->ep0.desc.wMaxPacketSize = 64;
         usb_get_device_descriptor(usb_rh, USB_DT_DEVICE_SIZE);
 	usb_new_device(usb_rh);
 

