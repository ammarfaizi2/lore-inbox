Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266018AbUFIWky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbUFIWky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 18:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUFIWkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 18:40:53 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:8958 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S266018AbUFIWkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 18:40:52 -0400
Subject: PATCH: 2.6.7-rc3 drivers/usb/core/devio.c: user/kernel pointer bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: linux-usb-devel@lists.sourceforge.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2004 15:40:50 -0700
Message-Id: <1086820850.14179.104.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since ctrl is copied in from userspace, ctrl.data cannot safely be 
dereferenced.  Let me know if you have any questions or if I've made
a mistake.

Best,
Rob

--- linux-2.6.7-rc3-full/drivers/usb/core/devio.c.orig	Wed Jun  9 12:50:34 2004
+++ linux-2.6.7-rc3-full/drivers/usb/core/devio.c	Wed Jun  9 12:49:50 2004
@@ -558,7 +558,7 @@ static int proc_control(struct dev_state
 			if (usbfs_snoop) {
 				dev_info(&dev->dev, "control read: data ");
 				for (j = 0; j < ctrl.wLength; ++j)
-					printk ("%02x ", (unsigned char)((char *)ctrl.data)[j]);
+					printk ("%02x ", (unsigned char)(tbuf)[j]);
 				printk("\n");
 			}
 			if (copy_to_user(ctrl.data, tbuf, ctrl.wLength)) {
@@ -578,7 +578,7 @@ static int proc_control(struct dev_state
 		if (usbfs_snoop) {
 			dev_info(&dev->dev, "control write: data: ");
 			for (j = 0; j < ctrl.wLength; ++j)
-				printk ("%02x ", (unsigned char)((char *)ctrl.data)[j]);
+				printk ("%02x ", (unsigned char)(tbuf)[j]);
 			printk("\n");
 		}
 		i = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), ctrl.bRequest, ctrl.bRequestType,



