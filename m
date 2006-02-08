Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbWBHSvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbWBHSvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbWBHSvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:51:23 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:9905 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1030458AbWBHSvX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:51:23 -0500
Date: Wed, 8 Feb 2006 10:51:16 -0800
From: Greg KH <gregkh@suse.de>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       paul.mckenney@us.ibm.com
Subject: [patch 03/03] add EXPORT_SYMBOL_GPL_FUTURE() to USB subsystem
Message-ID: <20060208185116.GD17016@kroah.com>
References: <20060208184816.GA17016@kroah.com> <20060208184922.GB17016@kroah.com> <20060208185013.GC17016@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208185013.GC17016@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The USB core symbols will be converted to GPL-only in a few years.  Mark
this as such and update the documentation explaining why, and provide a
pointer for developers to receive help if they need it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/feature-removal-schedule.txt |   19 +++++++++++++++++++
 drivers/usb/core/driver.c                  |    6 +++---
 2 files changed, 22 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/drivers/usb/core/driver.c
+++ gregkh-2.6/drivers/usb/core/driver.c
@@ -381,7 +381,7 @@ const struct usb_device_id *usb_match_id
 
 	return NULL;
 }
-EXPORT_SYMBOL(usb_match_id);
+EXPORT_SYMBOL_GPL_FUTURE(usb_match_id);
 
 int usb_device_match(struct device *dev, struct device_driver *drv)
 {
@@ -449,7 +449,7 @@ int usb_register_driver(struct usb_drive
 
 	return retval;
 }
-EXPORT_SYMBOL(usb_register_driver);
+EXPORT_SYMBOL_GPL_FUTURE(usb_register_driver);
 
 /**
  * usb_deregister - unregister a USB driver
@@ -472,4 +472,4 @@ void usb_deregister(struct usb_driver *d
 
 	usbfs_update_special();
 }
-EXPORT_SYMBOL(usb_deregister);
+EXPORT_SYMBOL_GPL_FUTURE(usb_deregister);
--- gregkh-2.6.orig/Documentation/feature-removal-schedule.txt
+++ gregkh-2.6/Documentation/feature-removal-schedule.txt
@@ -171,3 +171,22 @@ Why:	The ISA interface is faster and sho
 	probing is also known to cause trouble in at least one case (see
 	bug #5889.)
 Who:	Jean Delvare <khali@linux-fr.org>
+
+---------------------------
+
+What:	USB driver API moves to EXPORT_SYMBOL_GPL
+When:	Febuary 2008
+Files:	include/linux/usb.h, drivers/usb/core/driver.c
+Why:	The USB subsystem has changed a lot over time, and it has been
+	possible to create userspace USB drivers using usbfs/libusb/gadgetfs
+	that operate as fast as the USB bus allows.  Because of this, the USB
+	subsystem will not be allowing closed source kernel drivers to
+	register with it, after this grace period is over.  If anyone needs
+	any help in converting their closed source drivers over to use the
+	userspace filesystems, please contact the
+	linux-usb-devel@lists.sourceforge.net mailing list, and the developers
+	there will be glad to help you out.
+Who:	Greg Kroah-Hartman <gregkh@suse.de>
+
+---------------------------
+
