Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVA0Mse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVA0Mse (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 07:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVA0Mse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 07:48:34 -0500
Received: from cantor.suse.de ([195.135.220.2]:48817 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262598AbVA0Msa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 07:48:30 -0500
Date: Thu, 27 Jan 2005 13:48:14 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Deepak Saxena <dsaxena@plexity.net>, Oleg Drokin <green@crimea.edu>,
       Christer Weinigel <wingel@nano-system.com>
Subject: [PATCH] correct sysfs name for watchdog devices
Message-ID: <20050127124814.GA22674@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While looking for possible candidates for our udev.rules package,
I found a few odd ->name properties. /dev/watchdog has minor 130 according
to devices.txt. Since all watchdog drivers use the misc_register() call,
they will end up in /sys/class/misc/$foo. udev may create the
/dev/watchdog node if the driver is loaded.
I dont have such a device, so I cant test it.
The drivers below provide names with spaces and even with / in it.
Not a big deal, but apps (which apps?) may expect /dev/watchdog.


Signed-off-by: Olaf Hering <olh@suse.de>


 ixp2000_wdt.c |    2 +-
 ixp4xx_wdt.c  |    2 +-
 sa1100_wdt.c  |    2 +-
 scx200_wdt.c  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff -purN linux-2.6.11-rc2/drivers/char/watchdog/ixp2000_wdt.c linux-2.6.10/drivers/char/watchdog/ixp2000_wdt.c
--- linux-2.6.11-rc2/drivers/char/watchdog/ixp2000_wdt.c	2005-01-22 02:47:18.000000000 +0100
+++ linux-2.6.10/drivers/char/watchdog/ixp2000_wdt.c	2005-01-27 13:29:04.767990264 +0100
@@ -186,7 +186,7 @@ static struct file_operations ixp2000_wd
 static struct miscdevice ixp2000_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP2000 Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp2000_wdt_fops,
 };
 
diff -purN linux-2.6.11-rc2/drivers/char/watchdog/ixp4xx_wdt.c linux-2.6.10/drivers/char/watchdog/ixp4xx_wdt.c
--- linux-2.6.11-rc2/drivers/char/watchdog/ixp4xx_wdt.c	2005-01-22 02:48:48.000000000 +0100
+++ linux-2.6.10/drivers/char/watchdog/ixp4xx_wdt.c	2005-01-27 13:29:25.564948422 +0100
@@ -180,7 +180,7 @@ static struct file_operations ixp4xx_wdt
 static struct miscdevice ixp4xx_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP4xx Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp4xx_wdt_fops,
 };
 
diff -purN linux-2.6.11-rc2/drivers/char/watchdog/sa1100_wdt.c linux-2.6.10/drivers/char/watchdog/sa1100_wdt.c
--- linux-2.6.11-rc2/drivers/char/watchdog/sa1100_wdt.c	2005-01-22 02:48:00.000000000 +0100
+++ linux-2.6.10/drivers/char/watchdog/sa1100_wdt.c	2005-01-27 13:30:33.613746093 +0100
@@ -176,7 +176,7 @@ static struct file_operations sa1100dog_
 static struct miscdevice sa1100dog_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "SA1100/PXA2xx watchdog",
+	.name		= "watchdog",
 	.fops		= &sa1100dog_fops,
 };
 
diff -purN linux-2.6.11-rc2/drivers/char/watchdog/scx200_wdt.c linux-2.6.10/drivers/char/watchdog/scx200_wdt.c
--- linux-2.6.11-rc2/drivers/char/watchdog/scx200_wdt.c	2005-01-22 02:48:28.000000000 +0100
+++ linux-2.6.10/drivers/char/watchdog/scx200_wdt.c	2005-01-27 13:32:08.321384209 +0100
@@ -210,7 +210,7 @@ static struct file_operations scx200_wdt
 
 static struct miscdevice scx200_wdt_miscdev = {
 	.minor = WATCHDOG_MINOR,
-	.name  = NAME,
+	.name  = NAME, /* make that "watchdog" ? */
 	.fops  = &scx200_wdt_fops,
 };
 
