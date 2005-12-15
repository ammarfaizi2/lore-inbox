Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422653AbVLOJU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbVLOJU4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbVLOJTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:19:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:15530 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422645AbVLOJSU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:18:20 -0500
To: torvalds@osdl.org
Subject: [PATCH] __user annotations (booke_wdt.c)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpFk-0007zo-1l@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:18:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/char/watchdog/booke_wdt.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

da97b05bea02426009ecab8d63a1ec469fb61fc6
diff --git a/drivers/char/watchdog/booke_wdt.c b/drivers/char/watchdog/booke_wdt.c
index 65830ec..c800cce 100644
--- a/drivers/char/watchdog/booke_wdt.c
+++ b/drivers/char/watchdog/booke_wdt.c
@@ -72,7 +72,7 @@ static __inline__ void booke_wdt_ping(vo
 /*
  * booke_wdt_write:
  */
-static ssize_t booke_wdt_write (struct file *file, const char *buf,
+static ssize_t booke_wdt_write (struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	booke_wdt_ping();
@@ -92,14 +92,15 @@ static int booke_wdt_ioctl (struct inode
 			    unsigned int cmd, unsigned long arg)
 {
 	u32 tmp = 0;
+	u32 __user *p = (u32 __user *)arg;
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-		if (copy_to_user ((struct watchdog_info *) arg, &ident,
+		if (copy_to_user ((struct watchdog_info __user *) arg, &ident,
 				sizeof(struct watchdog_info)))
 			return -EFAULT;
 	case WDIOC_GETSTATUS:
-		return put_user(ident.options, (u32 *) arg);
+		return put_user(ident.options, p);
 	case WDIOC_GETBOOTSTATUS:
 		/* XXX: something is clearing TSR */
 		tmp = mfspr(SPRN_TSR) & TSR_WRS(3);
@@ -109,14 +110,14 @@ static int booke_wdt_ioctl (struct inode
 		booke_wdt_ping();
 		return 0;
 	case WDIOC_SETTIMEOUT:
-		if (get_user(booke_wdt_period, (u32 *) arg))
+		if (get_user(booke_wdt_period, p))
 			return -EFAULT;
 		mtspr(SPRN_TCR, (mfspr(SPRN_TCR)&~WDTP(0))|WDTP(booke_wdt_period));
 		return 0;
 	case WDIOC_GETTIMEOUT:
-		return put_user(booke_wdt_period, (u32 *) arg);
+		return put_user(booke_wdt_period, p);
 	case WDIOC_SETOPTIONS:
-		if (get_user(tmp, (u32 *) arg))
+		if (get_user(tmp, p))
 			return -EINVAL;
 		if (tmp == WDIOS_ENABLECARD) {
 			booke_wdt_ping();
-- 
0.99.9.GIT

