Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVKGKVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVKGKVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVKGKVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:21:50 -0500
Received: from [194.205.110.133] ([194.205.110.133]:52919 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S964815AbVKGKVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:21:49 -0500
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-30.tower-9.messagelabs.com!1131358900!22060061!1
X-StarScan-Version: 5.5.9.1; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Subject: Re: [WATCHDOG] sa1100_wdt.c sparse cleanups
From: Ian Campbell <icampbell@arcom.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org
In-Reply-To: <20051105101026.GA28438@flint.arm.linux.org.uk>
References: <1130921809.12578.179.camel@icampbell-debian>
	 <20051105101026.GA28438@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Mon, 07 Nov 2005 10:21:24 +0000
Message-Id: <1131358884.14696.57.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-05 at 10:10 +0000, Russell King wrote:

> It's probably better to use a union with these, eg:

The common idiom in the watchdog drivers seems to be to use separate
variables. I'll leave it up to Wim if he wants to change that.

The following makes drivers/char/watchdog/sa1100_wdt.c sparse clean.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

Index: 2.6/drivers/char/watchdog/sa1100_wdt.c
===================================================================
--- 2.6.orig/drivers/char/watchdog/sa1100_wdt.c	2005-11-03 11:02:05.000000000 +0000
+++ 2.6/drivers/char/watchdog/sa1100_wdt.c	2005-11-07 09:51:47.000000000 +0000
@@ -74,7 +74,7 @@
 	return 0;
 }
 
-static ssize_t sa1100dog_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+static ssize_t sa1100dog_write(struct file *file, const char __user *data, size_t len, loff_t *ppos)
 {
 	if (len)
 		/* Refresh OSMR3 timer. */
@@ -93,23 +93,24 @@
 {
 	int ret = -ENOIOCTLCMD;
 	int time;
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-		ret = copy_to_user((struct watchdog_info *)arg, &ident,
-				   sizeof(ident)) ? -EFAULT : 0;
+		ret = copy_to_user(argp, &ident, sizeof(ident)) ? -EFAULT : 0;
 		break;
 
 	case WDIOC_GETSTATUS:
-		ret = put_user(0, (int *)arg);
+		ret = put_user(0, p);
 		break;
 
 	case WDIOC_GETBOOTSTATUS:
-		ret = put_user(boot_status, (int *)arg);
+		ret = put_user(boot_status, p);
 		break;
 
 	case WDIOC_SETTIMEOUT:
-		ret = get_user(time, (int *)arg);
+		ret = get_user(time, p);
 		if (ret)
 			break;
 
@@ -123,7 +124,7 @@
 		/*fall through*/
 
 	case WDIOC_GETTIMEOUT:
-		ret = put_user(pre_margin / OSCR_FREQ, (int *)arg);
+		ret = put_user(pre_margin / OSCR_FREQ, p);
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
