Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbUDNKos (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 06:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbUDNKos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 06:44:48 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:47533 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S264048AbUDNKlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 06:41:50 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 6/9] USB usbfs: fix up releaseintf
Date: Wed, 14 Apr 2004 12:41:47 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141241.47751.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The semaphore is now taken in the callers.

 devio.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Wed Apr 14 12:18:08 2004
+++ b/drivers/usb/core/devio.c	Wed Apr 14 12:18:08 2004
@@ -399,7 +399,6 @@
 		return -EINVAL;
 	err = -EINVAL;
 	dev = ps->dev;
-	down(&dev->serialize);
 	/* lock against other changes to driver bindings */
 	down_write(&usb_bus_type.subsys.rwsem);
 	if (test_and_clear_bit(intf, &ps->ifclaimed)) {
@@ -408,7 +407,6 @@
 		err = 0;
 	}
 	up_write(&usb_bus_type.subsys.rwsem);
-	up(&dev->serialize);
 	return err;
 }
 
