Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVBZCZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVBZCZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 21:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVBZCZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 21:25:28 -0500
Received: from farad.aurel32.net ([82.232.2.251]:65465 "EHLO farad.aurel32.net")
	by vger.kernel.org with ESMTP id S261167AbVBZCZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 21:25:21 -0500
Date: Sat, 26 Feb 2005 03:25:11 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] Fix USB stack regression in 2.6.11-rc5
Message-ID: <20050226022510.GA7870@bode.aurel32.net>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.6+20040907i (CVS)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have just tested kernel version 2.6.11-rc5 and noticed it is not
possible to do an USB transfer by submitting an URB to an output 
endpoint. This breaks newest versions of libusb and thus SANE, 
gphoto2, and a lot of software.

The bug has been introduced in version 2.6.11-rc1 and is due to a 
wrong comparison. Please find a patch below to fix that.

Bye,
Aurelien


Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

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
		

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
