Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWC1NlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWC1NlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWC1NlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:41:10 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:59010 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S932203AbWC1NlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:41:09 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: gregkh@suse.de, akpm@osdl.org
Subject: [PATCH] Aten USB to Serial converter broken in -mm kernels
Date: Tue, 28 Mar 2006 15:33:44 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4sTKEA1ymqcfiRd"
Message-Id: <200603281533.44575.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_4sTKEA1ymqcfiRd
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
Any current -mm kernel breaks Aten USB to Serial converters. The problem turns 
out to be that gregkh-usb-usb-serial-dynamic-id.patch comments out the USB 
ID.

Simply reverting that portion of the patch fixes it (and I've just uploaded an 
entire Linux filesystem image to an ipaq using the adapter, so no problems 
there).

Any ideas why this was commented out in the first place?

Regards,
bero

--Boundary-00=_4sTKEA1ymqcfiRd
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pl2303-Aten.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pl2303-Aten.patch"

--- linux-2.6.16/drivers/usb/serial/pl2303.c.ark	2006-03-27 19:33:04.000000000 +0200
+++ linux-2.6.16/drivers/usb/serial/pl2303.c	2006-03-27 19:33:08.000000000 +0200
@@ -56,8 +56,8 @@
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_RSAQ3) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_PHAROS) },
 	{ USB_DEVICE(IODATA_VENDOR_ID, IODATA_PRODUCT_ID) },
-//	{ USB_DEVICE(ATEN_VENDOR_ID, ATEN_PRODUCT_ID) },
-//	{ USB_DEVICE(ATEN_VENDOR_ID2, ATEN_PRODUCT_ID) },
+	{ USB_DEVICE(ATEN_VENDOR_ID, ATEN_PRODUCT_ID) },
+	{ USB_DEVICE(ATEN_VENDOR_ID2, ATEN_PRODUCT_ID) },
 	{ USB_DEVICE(ELCOM_VENDOR_ID, ELCOM_PRODUCT_ID) },
 	{ USB_DEVICE(ELCOM_VENDOR_ID, ELCOM_PRODUCT_ID_UCSGT) },
 	{ USB_DEVICE(ITEGNO_VENDOR_ID, ITEGNO_PRODUCT_ID) },

--Boundary-00=_4sTKEA1ymqcfiRd--
