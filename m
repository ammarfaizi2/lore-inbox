Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVKNUWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVKNUWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVKNUWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:22:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:5063 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932095AbVKNUTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:19:43 -0500
Date: Mon, 14 Nov 2005 12:06:00 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com, akpm@osdl.org
Subject: [patch 08/12] USB: usbdevfs_ioctl 32bit fix
Message-ID: <20051114200600.GI2319@kroah.com>
References: <20051114200100.984523000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-usbdevfs_ioctl-from-32bit-fix.patch"
In-Reply-To: <20051114200456.GA2319@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

drivers/usb/core/devio.c: In function `proc_ioctl_compat':
drivers/usb/core/devio.c:1401: warning: passing arg 1 of `compat_ptr' makes integer from pointer without a cast

NFI if this is correct...

Cc: Pete Zaitcev <zaitcev@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/usb/core/devio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/usb/core/devio.c	2005-11-02 09:25:03.000000000 -0800
+++ gregkh-2.6/drivers/usb/core/devio.c	2005-11-02 12:02:56.000000000 -0800
@@ -1392,7 +1392,7 @@
 }
 
 #ifdef CONFIG_COMPAT
-static int proc_ioctl_compat(struct dev_state *ps, void __user *arg)
+static int proc_ioctl_compat(struct dev_state *ps, compat_uptr_t arg)
 {
 	struct usbdevfs_ioctl32 __user *uioc;
 	struct usbdevfs_ioctl ctrl;
@@ -1511,7 +1511,7 @@
 
 	case USBDEVFS_IOCTL32:
 		snoop(&dev->dev, "%s: IOCTL\n", __FUNCTION__);
-		ret = proc_ioctl_compat(ps, p);
+		ret = proc_ioctl_compat(ps, (compat_uptr_t)(long)p);
 		break;
 #endif
 

--
