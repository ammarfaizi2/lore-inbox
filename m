Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbUDNKjs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 06:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264042AbUDNKjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 06:39:47 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:2475 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S264039AbUDNKjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 06:39:14 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 4/9] USB usbfs: fix up proc_setconfig
Date: Wed, 14 Apr 2004 12:39:11 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141239.11582.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The semaphore is now taken in the caller.

 devio.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Wed Apr 14 12:17:46 2004
+++ b/drivers/usb/core/devio.c	Wed Apr 14 12:17:46 2004
@@ -763,7 +763,6 @@
 	if (get_user(u, (unsigned int __user *)arg))
 		return -EFAULT;
 
-	down(&ps->dev->serialize);
  	actconfig = ps->dev->actconfig;
  
  	/* Don't touch the device if any interfaces are claimed.
@@ -799,7 +798,6 @@
 		else
 			status = usb_set_configuration(ps->dev, u);
 	}
-	up(&ps->dev->serialize);
 
 	return status;
 }
