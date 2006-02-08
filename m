Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030485AbWBHD0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbWBHD0b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbWBHDZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:25:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:64128 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030485AbWBHDTM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:19:12 -0500
To: torvalds@osdl.org
Subject: [PATCH 16/29] drivers/char/watchdog/sbc_epx_c3.c __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6frM-0006D5-3I@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:19:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138791855 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/char/watchdog/sbc_epx_c3.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

73a09e626b9717851d3f7fd0230e401492ee326b
diff --git a/drivers/char/watchdog/sbc_epx_c3.c b/drivers/char/watchdog/sbc_epx_c3.c
index 7a4dfb9..837b1ec 100644
--- a/drivers/char/watchdog/sbc_epx_c3.c
+++ b/drivers/char/watchdog/sbc_epx_c3.c
@@ -92,7 +92,7 @@ static int epx_c3_release(struct inode *
 	return 0;
 }
 
-static ssize_t epx_c3_write(struct file *file, const char *data,
+static ssize_t epx_c3_write(struct file *file, const char __user *data,
 			size_t len, loff_t *ppos)
 {
 	/* Refresh the timer. */
@@ -105,6 +105,7 @@ static int epx_c3_ioctl(struct inode *in
 			unsigned int cmd, unsigned long arg)
 {
 	int options, retval = -EINVAL;
+	int __user *argp = (void __user *)arg;
 	static struct watchdog_info ident = {
 		.options		= WDIOF_KEEPALIVEPING |
 					  WDIOF_MAGICCLOSE,
@@ -114,20 +115,19 @@ static int epx_c3_ioctl(struct inode *in
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-		if (copy_to_user((struct watchdog_info *)arg,
-				 &ident, sizeof(ident)))
+		if (copy_to_user(argp, &ident, sizeof(ident)))
 			return -EFAULT;
 		return 0;
 	case WDIOC_GETSTATUS:
 	case WDIOC_GETBOOTSTATUS:
-		return put_user(0,(int *)arg);
+		return put_user(0, argp);
 	case WDIOC_KEEPALIVE:
 		epx_c3_pet();
 		return 0;
 	case WDIOC_GETTIMEOUT:
-		return put_user(WATCHDOG_TIMEOUT,(int *)arg);
-	case WDIOC_SETOPTIONS: {
-		if (get_user(options, (int *)arg))
+		return put_user(WATCHDOG_TIMEOUT, argp);
+	case WDIOC_SETOPTIONS:
+		if (get_user(options, argp))
 			return -EFAULT;
 
 		if (options & WDIOS_DISABLECARD) {
@@ -141,7 +141,6 @@ static int epx_c3_ioctl(struct inode *in
 		}
 
 		return retval;
-	}
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
0.99.9.GIT

