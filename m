Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUCHUHw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 15:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbUCHUHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 15:07:52 -0500
Received: from smtp02.web.de ([217.72.192.151]:63265 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261181AbUCHUHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 15:07:46 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Andrew Morton <akpm@osdl.org>, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: 2.6.4-rc2-mm1
Date: Mon, 8 Mar 2004 21:05:17 +0100
User-Agent: KMail/1.5.4
References: <20040307223221.0f2db02e.akpm@osdl.org>
In-Reply-To: <20040307223221.0f2db02e.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/HNTAxH3r55A4mJ"
Message-Id: <200403082105.19328.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_/HNTAxH3r55A4mJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

the bk-usb.patch leads to following error:

drivers/char/watchdog/pcwd_usb.c: In function `usb_pcwd_probe':
drivers/char/watchdog/pcwd_usb.c:592: error: structure has no member named 
`act_altsetting'

The attached patch fixes it.

Best regards
   Thomas Schlichter

--Boundary-00=_/HNTAxH3r55A4mJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix-pcwd_usb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix-pcwd_usb.diff"

--- linux-2.6.4-rc2-mm1/drivers/char/watchdog/pcwd_usb.c.orig	2004-03-04 07:16:39.000000000 +0100
+++ linux-2.6.4-rc2-mm1/drivers/char/watchdog/pcwd_usb.c	2004-03-08 15:07:20.000000000 +0100
@@ -589,7 +589,7 @@ static int usb_pcwd_probe(struct usb_int
 	}
 
 	/* get the active interface descriptor */
-	iface_desc = &interface->altsetting[interface->act_altsetting];
+	iface_desc = interface->cur_altsetting;
 
 	/* check out that we have a HID device */
 	if (!(iface_desc->desc.bInterfaceClass == USB_CLASS_HID)) {

--Boundary-00=_/HNTAxH3r55A4mJ--

