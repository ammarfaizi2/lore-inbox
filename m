Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbVKQSIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbVKQSIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVKQSIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:08:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:29858 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932615AbVKQSEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:15 -0500
Date: Thu, 17 Nov 2005 09:47:02 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch 08/22] USB: usbdevfs_ioctl 32bit fix
Message-ID: <20051117174702.GH11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-usbdevfs_ioctl-from-32bit-fix.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
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

--- usb-2.6.orig/drivers/usb/core/devio.c
+++ usb-2.6/drivers/usb/core/devio.c
@@ -1392,7 +1392,7 @@ static int proc_ioctl_default(struct dev
 }
 
 #ifdef CONFIG_COMPAT
-static int proc_ioctl_compat(struct dev_state *ps, void __user *arg)
+static int proc_ioctl_compat(struct dev_state *ps, compat_uptr_t arg)
 {
 	struct usbdevfs_ioctl32 __user *uioc;
 	struct usbdevfs_ioctl ctrl;
@@ -1511,7 +1511,7 @@ static int usbdev_ioctl(struct inode *in
 
 	case USBDEVFS_IOCTL32:
 		snoop(&dev->dev, "%s: IOCTL\n", __FUNCTION__);
-		ret = proc_ioctl_compat(ps, p);
+		ret = proc_ioctl_compat(ps, (compat_uptr_t)(long)p);
 		break;
 #endif
 

--
