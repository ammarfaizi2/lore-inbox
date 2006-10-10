Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbWJJVqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbWJJVqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030506AbWJJVqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:46:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40900 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030505AbWJJVpi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:45:38 -0400
To: torvalds@osdl.org
Subject: [PATCH] devio __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPPt-0007Kz-6K@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:45:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/core/devio.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 2c9c946..724822c 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1216,7 +1216,7 @@ static int proc_submiturb_compat(struct 
 {
 	struct usbdevfs_urb uurb;
 
-	if (get_urb32(&uurb,(struct usbdevfs_urb32 *)arg))
+	if (get_urb32(&uurb,(struct usbdevfs_urb32 __user *)arg))
 		return -EFAULT;
 
 	return proc_do_submiturb(ps, &uurb, ((struct usbdevfs_urb32 __user *)arg)->iso_frame_desc, arg);
@@ -1251,7 +1251,7 @@ static int processcompl_compat(struct as
 	}
 
 	free_async(as);
-	if (put_user((u32)(u64)addr, (u32 __user *)arg))
+	if (put_user(ptr_to_compat(addr), (u32 __user *)arg))
 		return -EFAULT;
 	return 0;
 }
@@ -1520,7 +1520,7 @@ #ifdef CONFIG_COMPAT
 
 	case USBDEVFS_IOCTL32:
 		snoop(&dev->dev, "%s: IOCTL\n", __FUNCTION__);
-		ret = proc_ioctl_compat(ps, (compat_uptr_t)(long)p);
+		ret = proc_ioctl_compat(ps, ptr_to_compat(p));
 		break;
 #endif
 
-- 
1.4.2.GIT


