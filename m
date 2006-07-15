Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945945AbWGOAgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945945AbWGOAgW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945940AbWGOAfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:35:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32777 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945944AbWGOAfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:35:54 -0400
Date: Sat, 15 Jul 2006 02:35:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [RFC: -mm patch] drivers/usb/core/driver.c: make 2 functions static
Message-ID: <20060715003552.GJ3633@stusta.de>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/core/driver.c |    4 ++--
 drivers/usb/core/usb.h    |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.18-rc1-mm2-full/drivers/usb/core/usb.h.old	2006-07-14 23:30:01.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/drivers/usb/core/usb.h	2006-07-14 23:30:27.000000000 +0200
@@ -32,14 +32,12 @@
 
 #ifdef	CONFIG_PM
 
-extern int usb_suspend_both(struct usb_device *udev, pm_message_t msg);
 extern int usb_resume_both(struct usb_device *udev);
 extern int usb_port_suspend(struct usb_device *dev);
 extern int usb_port_resume(struct usb_device *dev);
 
 #else
 
-#define usb_suspend_both(udev, msg)	0
 #define usb_resume_both(udev)		0
 #define usb_port_suspend(dev)		0
 #define usb_port_resume(dev)		0
--- linux-2.6.18-rc1-mm2-full/drivers/usb/core/driver.c.old	2006-07-14 23:29:20.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/drivers/usb/core/driver.c	2006-07-14 23:29:51.000000000 +0200
@@ -471,7 +471,7 @@
 }
 EXPORT_SYMBOL_GPL_FUTURE(usb_match_id);
 
-int usb_device_match(struct device *dev, struct device_driver *drv)
+static int usb_device_match(struct device *dev, struct device_driver *drv)
 {
 	/* devices and interfaces are handled separately */
 	if (is_usb_device(dev)) {
@@ -877,7 +877,7 @@
 }
 
 /* Caller has locked udev */
-int usb_suspend_both(struct usb_device *udev, pm_message_t msg)
+static int usb_suspend_both(struct usb_device *udev, pm_message_t msg)
 {
 	int			status = 0;
 	int			i = 0;

