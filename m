Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264037AbUDNKmU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 06:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264042AbUDNKmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 06:42:19 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:47049 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264037AbUDNKkf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 06:40:35 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 5/9] USB usbfs: fix up proc_ioctl
Date: Wed, 14 Apr 2004 12:40:32 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141240.32262.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The semaphore is now taken in the caller.

 devio.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Wed Apr 14 12:17:56 2004
+++ b/drivers/usb/core/devio.c	Wed Apr 14 12:17:56 2004
@@ -1133,7 +1133,6 @@
 		return -ENODEV;
 	}
 
-	down(&ps->dev->serialize);
 	if (ps->dev->state != USB_STATE_CONFIGURED)
 		retval = -ENODEV;
 	else if (!(ifp = usb_ifnum_to_if (ps->dev, ctrl.ifno)))
@@ -1171,7 +1170,6 @@
 		}
 		up_read(&usb_bus_type.subsys.rwsem);
 	}
-	up(&ps->dev->serialize);
 
 	/* cleanup and return */
 	if (retval >= 0
