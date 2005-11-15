Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVKODbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVKODbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVKODbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:31:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52886 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932351AbVKODbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:31:01 -0500
Date: Mon, 14 Nov 2005 19:30:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, info@colognechip.com,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] i4l: update hfc_usb driver
Message-Id: <20051114193025.7ca34fac.akpm@osdl.org>
In-Reply-To: <20051115004518.GA26922@redhat.com>
References: <200511071721.jA7HLC18028788@hera.kernel.org>
	<20051115004518.GA26922@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Mon, Nov 07, 2005 at 09:21:12AM -0800, Linux Kernel wrote:
>  > tree 0bb0aeb735a917561cf4d91d4c3fa1ed5434bede
>  > parent 6978bbc097c2f665c336927a9d56ae39ef75fa56
>  > author Martin Bachem <info@colognechip.com> Mon, 07 Nov 2005 17:00:20 -0800
>  > committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 07 Nov 2005 23:53:47 -0800
>  > 
>  > [PATCH] i4l: update hfc_usb driver
>  > 
>  >   - cleanup source
>  >   - remove nonfunctional code parts
> 
> Something isn't right with this.  We've got a number of reports from
> Fedora rawhide users over the last few days since this went in that
> this module is now auto-loading itself, and preventing other usb devices
> from working.

Putting the USB_DEVICE() thingies back in seems to fix it up?


--- devel/drivers/isdn/hisax/hfc_usb.c~a	2005-11-14 19:23:18.000000000 -0800
+++ devel-akpm/drivers/isdn/hisax/hfc_usb.c	2005-11-14 19:25:59.000000000 -0800
@@ -71,78 +71,68 @@ typedef struct {
 /****************************************/
 static struct usb_device_id hfcusb_idtab[] = {
 	{
-	 .idVendor = 0x0959,
-	 .idProduct = 0x2bd0,
+	 USB_DEVICE(0x0959, 0x2bd0),
 	 .driver_info = (unsigned long) &((hfcsusb_vdata)
 			  {LED_OFF, {4, 0, 2, 1},
 			   "ISDN USB TA (Cologne Chip HFC-S USB based)"}),
 	},
 	{
-	 .idVendor = 0x0675,
-	 .idProduct = 0x1688,
+	 USB_DEVICE(0x0675, 0x1688),
 	 .driver_info = (unsigned long) &((hfcsusb_vdata)
 			  {LED_SCHEME1, {1, 2, 0, 0},
 			   "DrayTek miniVigor 128 USB ISDN TA"}),
 	},
 	{
-	 .idVendor = 0x07b0,
-	 .idProduct = 0x0007,
+	 USB_DEVICE(0x07b0, 0x0007),
 	 .driver_info = (unsigned long) &((hfcsusb_vdata)
 			  {LED_SCHEME1, {0x80, -64, -32, -16},
 			   "Billion tiny USB ISDN TA 128"}),
 	},
 	{
-	 .idVendor = 0x0742,
-	 .idProduct = 0x2008,
+	 USB_DEVICE(0x0742, 0x2008),
 	 .driver_info = (unsigned long) &((hfcsusb_vdata)
 			  {LED_SCHEME1, {4, 0, 2, 1},
 			   "Stollmann USB TA"}),
 	 },
 	{
-	 .idVendor = 0x0742,
-	 .idProduct = 0x2009,
+	 USB_DEVICE(0x0742, 0x2009),
 	 .driver_info = (unsigned long) &((hfcsusb_vdata)
 			  {LED_SCHEME1, {4, 0, 2, 1},
 			   "Aceex USB ISDN TA"}),
 	 },
 	{
-	 .idVendor = 0x0742,
-	 .idProduct = 0x200A,
+	 USB_DEVICE(0x0742, 0x200A),
 	 .driver_info = (unsigned long) &((hfcsusb_vdata)
 			  {LED_SCHEME1, {4, 0, 2, 1},
 			   "OEM USB ISDN TA"}),
 	 },
 	{
-	 .idVendor = 0x08e3,
-	 .idProduct = 0x0301,
+	 USB_DEVICE(0x08e3, 0x0301),
 	 .driver_info = (unsigned long) &((hfcsusb_vdata)
 			  {LED_SCHEME1, {2, 0, 1, 4},
 			   "Olitec USB RNIS"}),
 	 },
 	{
-	 .idVendor = 0x07fa,
-	 .idProduct = 0x0846,
+	 USB_DEVICE(0x07fa, 0x0846),
 	 .driver_info = (unsigned long) &((hfcsusb_vdata)
 			  {LED_SCHEME1, {0x80, -64, -32, -16},
 			   "Bewan Modem RNIS USB"}),
 	 },
 	{
-	 .idVendor = 0x07fa,
-	 .idProduct = 0x0847,
+	 USB_DEVICE(0x07fa, 0x0847),
 	 .driver_info = (unsigned long) &((hfcsusb_vdata)
 			  {LED_SCHEME1, {0x80, -64, -32, -16},
 			   "Djinn Numeris USB"}),
 	 },
 	{
-	 .idVendor = 0x07b0,
-	 .idProduct = 0x0006,
+	 USB_DEVICE(0x07b0, 0x0006),
 	 .driver_info = (unsigned long) &((hfcsusb_vdata)
 			  {LED_SCHEME1, {0x80, -64, -32, -16},
 			   "Twister ISDN TA"}),
 	 },
+	{ }
 };
 
-
 /***************************************************************/
 /* structure defining input+output fifos (interrupt/bulk mode) */
 /***************************************************************/
_

