Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264848AbUEJQTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264848AbUEJQTy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbUEJQTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:19:54 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:25800 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S264848AbUEJQTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:19:51 -0400
Subject: Re: [PATCH] hci-usb bugfix
From: Marcel Holtmann <marcel@holtmann.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sebastian Schmidt <yath@yath.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0405101211350.669-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0405101211350.669-100000@ida.rowland.org>
Content-Type: multipart/mixed; boundary="=-5TjnQ85svBkib1lbCz9U"
Message-Id: <1084205974.9639.16.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 18:19:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5TjnQ85svBkib1lbCz9U
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Alan,

> It looks like the problem is that hci_usb_disconnect() is trying to do too 
> much.  When called for the SCO interface it should simply return.

I came to the same conclusion, but I used the attached patch.

> Does this patch improve the situation?

Not tested ;)

Regards

Marcel


--=-5TjnQ85svBkib1lbCz9U
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/bluetooth/hci_usb.c 1.49 vs edited =====
--- 1.49/drivers/bluetooth/hci_usb.c	Sat Apr 17 00:23:48 2004
+++ edited/drivers/bluetooth/hci_usb.c	Mon May 10 12:03:05 2004
@@ -976,11 +971,13 @@
 static void hci_usb_disconnect(struct usb_interface *intf)
 {
 	struct hci_usb *husb = usb_get_intfdata(intf);
-	struct hci_dev *hdev = husb->hdev;
+	struct hci_dev *hdev;
 
-	if (!husb)
+	if (!husb || intf == husb->isoc_iface)
 		return;
+
 	usb_set_intfdata(intf, NULL);
+	hdev = husb->hdev;
 
 	BT_DBG("%s", hdev->name);
 

--=-5TjnQ85svBkib1lbCz9U--

