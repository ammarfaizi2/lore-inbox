Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263226AbSJIAuu>; Tue, 8 Oct 2002 20:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263224AbSJIAuC>; Tue, 8 Oct 2002 20:50:02 -0400
Received: from air-2.osdl.org ([65.172.181.6]:41388 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S263226AbSJIAtr>;
	Tue, 8 Oct 2002 20:49:47 -0400
Date: Tue, 8 Oct 2002 17:57:53 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210081747180.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210081757440.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.601, 2002-10-08 17:32:56-07:00, mochel@osdl.org
  USB: call device_unregister() instead of put_device() when removing devices.

diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	Tue Oct  8 17:55:15 2002
+++ b/drivers/usb/core/usb.c	Tue Oct  8 17:55:15 2002
@@ -797,7 +797,7 @@
 			struct usb_interface *interface = &dev->actconfig->interface[i];
 
 			/* remove this interface */
-			put_device(&interface->dev);
+			device_unregister(&interface->dev);
 		}
 	}
 
@@ -805,7 +805,7 @@
 	if (dev->devnum > 0) {
 		clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 		usbfs_remove_device(dev);
-		put_device(&dev->dev);
+		device_unregister(&dev->dev);
 	}
 
 	/* Decrement the reference count, it'll auto free everything when */

