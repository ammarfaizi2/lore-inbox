Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVBZEY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVBZEY4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 23:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVBZEYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 23:24:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:9101 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261413AbVBZEYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 23:24:53 -0500
Date: Fri, 25 Feb 2005 20:24:28 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB: Fix usbfs regression
Message-ID: <20050226042428.GA10783@kroah.com>
References: <20050226022510.GA7870@bode.aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050226022510.GA7870@bode.aurel32.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are correct, the patch is valid, nice catch.  Linus, please apply.

------------

I have just tested kernel version 2.6.11-rc5 and noticed it is not
possible to do an USB transfer by submitting an URB to an output 
endpoint. This breaks newest versions of libusb and thus SANE, 
gphoto2, and a lot of software.

The bug has been introduced in version 2.6.11-rc1 and is due to a 
wrong comparison.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -urN linux-2.6.11-rc5.orig/drivers/usb/core/devio.c linux-2.6.11-rc5/drivers/usb/core/devio.c
--- linux-2.6.11-rc5.orig/drivers/usb/core/devio.c	2005-02-26 03:15:14.000000000 +0100
+++ linux-2.6.11-rc5/drivers/usb/core/devio.c	2005-02-26 03:16:15.000000000 +0100
@@ -841,7 +841,7 @@
 		if ((ret = checkintf(ps, ifnum)))
 			return ret;
 	}
-	if ((uurb.endpoint & ~USB_ENDPOINT_DIR_MASK) != 0)
+	if ((uurb.endpoint & USB_ENDPOINT_DIR_MASK) != 0)
 		ep = ps->dev->ep_in [uurb.endpoint & USB_ENDPOINT_NUMBER_MASK];
 	else
 		ep = ps->dev->ep_out [uurb.endpoint & USB_ENDPOINT_NUMBER_MASK];
		

