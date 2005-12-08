Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVLHVGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVLHVGD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVLHVGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:06:03 -0500
Received: from mail.macqel.be ([194.78.208.39]:17415 "EHLO mail.macqel.be")
	by vger.kernel.org with ESMTP id S932305AbVLHVGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:06:01 -0500
Message-Id: <200512082105.jB8L5xW12712@mail.macqel.be>
Subject: [PATCH 2.6.15-rc5] media/video/bttv : enhance ioctl debug
To: linux-kernel@vger.kernel.org
Date: Thu, 8 Dec 2005 22:05:58 +0100 (CET)
From: "Philippe De Muyter" <phdm@macqel.be>
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the current process name in the media/video/bttv ioctl debug.

Signed-off-by: Philippe De Muyter <phdm@macqel.be>

---

--- linux/drivers/media/video/bttv-driver.c.orig	2005-08-29 01:41:01.000000000 +0200
+++ linux/drivers/media/video/bttv-driver.c	2005-12-08 20:59:45.000000000 +0100
@@ -2181,19 +2182,19 @@ static int bttv_do_ioctl(struct inode *i
 	int retval = 0;
 
 	if (bttv_debug > 1) {
+		printk("bttv%d: %s: ioctl 0x%x ", btv->c.nr, current->comm,
+			cmd);
 		switch (_IOC_TYPE(cmd)) {
 		case 'v':
-			printk("bttv%d: ioctl 0x%x (v4l1, VIDIOC%s)\n",
-			       btv->c.nr, cmd, (_IOC_NR(cmd) < V4L1_IOCTLS) ?
+			printk("(v4l1, VIDIOC%s)\n",
+			       (_IOC_NR(cmd) < V4L1_IOCTLS) ?
 			       v4l1_ioctls[_IOC_NR(cmd)] : "???");
 			break;
 		case 'V':
-			printk("bttv%d: ioctl 0x%x (v4l2, %s)\n",
-			       btv->c.nr, cmd,  v4l2_ioctl_names[_IOC_NR(cmd)]);
+			printk("(v4l2, %s)\n", v4l2_ioctl_names[_IOC_NR(cmd)]);
 			break;
 		default:
-			printk("bttv%d: ioctl 0x%x (???)\n",
-			       btv->c.nr, cmd);
+			printk("(???)\n");
 		}
 	}
 	if (btv->errors)
