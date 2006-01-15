Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWAOUeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWAOUeS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWAOUeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:34:18 -0500
Received: from outmx026.isp.belgacom.be ([195.238.4.91]:10376 "EHLO
	outmx026.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750711AbWAOUeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:34:17 -0500
Date: Sun, 15 Jan 2006 21:34:02 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] MAINTAINERS + sa1100_wdt.c sparse patch
Message-ID: <20060115203402.GA4201@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please do a

	git pull rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 MAINTAINERS                        |    6 ++++++
 drivers/char/watchdog/sa1100_wdt.c |   12 ++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

with these Changes:

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun Jan 15 21:21:14 2006 +0100

    [PATCH] MAINTAINERS: watchdog device drivers
    
    Add a MAINTAINER entry for the watchdog device drivers.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Ian Campbell <icampbell@arcom.com>
Date:   Wed Nov 2 08:56:49 2005 +0000

    [WATCHDOG] sa1100_wdt.c sparse cleanups
    
    The following makes drivers/char/watchdog/sa1100_wdt.c sparse clean.
    
    Signed-off-by: Ian Campbell <icampbell@arcom.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>


The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 513f3b6..ce3c8f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2965,6 +2965,12 @@ M:	dm@sangoma.com
 W:	http://www.sangoma.com
 S:	Supported
 
+WATCHDOG DEVICE DRIVERS
+P:	Wim Van Sebroeck
+M:	wim@iguana.be
+T:	git kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
+S:	Maintained
+
 WAVELAN NETWORK DRIVER & WIRELESS EXTENSIONS
 P:	Jean Tourrilhes
 M:	jt@hpl.hp.com
diff --git a/drivers/char/watchdog/sa1100_wdt.c b/drivers/char/watchdog/sa1100_wdt.c
index fb88b40..b474ea5 100644
--- a/drivers/char/watchdog/sa1100_wdt.c
+++ b/drivers/char/watchdog/sa1100_wdt.c
@@ -74,7 +74,7 @@ static int sa1100dog_release(struct inod
 	return 0;
 }
 
-static ssize_t sa1100dog_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+static ssize_t sa1100dog_write(struct file *file, const char __user *data, size_t len, loff_t *ppos)
 {
 	if (len)
 		/* Refresh OSMR3 timer. */
@@ -96,20 +96,20 @@ static int sa1100dog_ioctl(struct inode 
 
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
 
@@ -123,7 +123,7 @@ static int sa1100dog_ioctl(struct inode 
 		/*fall through*/
 
 	case WDIOC_GETTIMEOUT:
-		ret = put_user(pre_margin / OSCR_FREQ, (int *)arg);
+		ret = put_user(pre_margin / OSCR_FREQ, (int __user *)arg);
 		break;
 
 	case WDIOC_KEEPALIVE:
