Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbVKBI47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbVKBI47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbVKBI47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:56:59 -0500
Received: from mail9.messagelabs.com ([194.205.110.133]:28816 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S932662AbVKBI47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:56:59 -0500
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-24.tower-9.messagelabs.com!1130921809!21487380!1
X-StarScan-Version: 5.5.9.1; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Subject: [WATCHDOG] sa1100_wdt.c sparse cleanups
From: Ian Campbell <icampbell@arcom.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Wed, 02 Nov 2005 08:56:49 +0000
Message-Id: <1130921809.12578.179.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following makes drivers/char/watchdog/sa1100_wdt.c sparse clean.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

Index: 2.6/drivers/char/watchdog/sa1100_wdt.c
===================================================================
--- 2.6.orig/drivers/char/watchdog/sa1100_wdt.c	2005-10-28 14:31:05.000000000 +0100
+++ 2.6/drivers/char/watchdog/sa1100_wdt.c	2005-10-28 14:31:16.000000000 +0100
@@ -74,7 +74,7 @@
 	return 0;
 }
 
-static ssize_t sa1100dog_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+static ssize_t sa1100dog_write(struct file *file, const char __user *data, size_t len, loff_t *ppos)
 {
 	if (len)
 		/* Refresh OSMR3 timer. */
@@ -96,20 +96,20 @@
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-		ret = copy_to_user((struct watchdog_info *)arg, &ident,
+		ret = copy_to_user((struct watchdog_info __user *)arg, &ident,
 				   sizeof(ident)) ? -EFAULT : 0;
 		break;
 
 	case WDIOC_GETSTATUS:
-		ret = put_user(0, (int *)arg);
+		ret = put_user(0, (int __user *)arg);
 		break;
 
 	case WDIOC_GETBOOTSTATUS:
-		ret = put_user(boot_status, (int *)arg);
+		ret = put_user(boot_status, (int __user *)arg);
 		break;
 
 	case WDIOC_SETTIMEOUT:
-		ret = get_user(time, (int *)arg);
+		ret = get_user(time, (int __user *)arg);
 		if (ret)
 			break;
 
@@ -123,7 +123,7 @@
 		/*fall through*/
 
 	case WDIOC_GETTIMEOUT:
-		ret = put_user(pre_margin / OSCR_FREQ, (int *)arg);
+		ret = put_user(pre_margin / OSCR_FREQ, (int __user *)arg);
 		break;
 
 	case WDIOC_KEEPALIVE:

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
