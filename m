Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVB0UkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVB0UkI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 15:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVB0UkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 15:40:08 -0500
Received: from asia.telenet-ops.be ([195.130.132.59]:35990 "EHLO
	asia.telenet-ops.be") by vger.kernel.org with ESMTP id S261260AbVB0Uj6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 15:39:58 -0500
Date: Sun, 27 Feb 2005 21:39:49 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [WATCHDOG] correct sysfs name for watchdog devices
Message-ID: <20050227203949.GD6650@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/ixp2000_wdt.c |    2 +-
 drivers/char/watchdog/ixp4xx_wdt.c  |    2 +-
 drivers/char/watchdog/sa1100_wdt.c  |    2 +-
 drivers/char/watchdog/scx200_wdt.c  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

through these ChangeSets:

<wim@iguana.be> (05/02/27 1.2065)
   [WATCHDOG] correct sysfs name for watchdog devices
   
   While looking for possible candidates for our udev.rules package,
   I found a few odd ->name properties. /dev/watchdog has minor 130
   according to devices.txt. Since all watchdog drivers use the
   misc_register() call, they will end up in /sys/class/misc/$foo.
   udev may create the /dev/watchdog node if the driver is loaded.
   I dont have such a device, so I cant test it.
   The drivers below provide names with spaces and even with / in it.
   Not a big deal, but apps may expect /dev/watchdog.
   
   Signed-off-by: Olaf Hering <olh@suse.de>
   Signed-off-by: Wim Van Sebroeck <wim@iguana.be>


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/ixp2000_wdt.c b/drivers/char/watchdog/ixp2000_wdt.c
--- a/drivers/char/watchdog/ixp2000_wdt.c	2005-02-27 21:29:13 +01:00
+++ b/drivers/char/watchdog/ixp2000_wdt.c	2005-02-27 21:29:13 +01:00
@@ -186,7 +186,7 @@
 static struct miscdevice ixp2000_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP2000 Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp2000_wdt_fops,
 };
 
diff -Nru a/drivers/char/watchdog/ixp4xx_wdt.c b/drivers/char/watchdog/ixp4xx_wdt.c
--- a/drivers/char/watchdog/ixp4xx_wdt.c	2005-02-27 21:29:13 +01:00
+++ b/drivers/char/watchdog/ixp4xx_wdt.c	2005-02-27 21:29:13 +01:00
@@ -180,7 +180,7 @@
 static struct miscdevice ixp4xx_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP4xx Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp4xx_wdt_fops,
 };
 
diff -Nru a/drivers/char/watchdog/sa1100_wdt.c b/drivers/char/watchdog/sa1100_wdt.c
--- a/drivers/char/watchdog/sa1100_wdt.c	2005-02-27 21:29:13 +01:00
+++ b/drivers/char/watchdog/sa1100_wdt.c	2005-02-27 21:29:13 +01:00
@@ -176,7 +176,7 @@
 static struct miscdevice sa1100dog_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "SA1100/PXA2xx watchdog",
+	.name		= "watchdog",
 	.fops		= &sa1100dog_fops,
 };
 
diff -Nru a/drivers/char/watchdog/scx200_wdt.c b/drivers/char/watchdog/scx200_wdt.c
--- a/drivers/char/watchdog/scx200_wdt.c	2005-02-27 21:29:13 +01:00
+++ b/drivers/char/watchdog/scx200_wdt.c	2005-02-27 21:29:13 +01:00
@@ -210,7 +210,7 @@
 
 static struct miscdevice scx200_wdt_miscdev = {
 	.minor = WATCHDOG_MINOR,
-	.name  = NAME,
+	.name  = "watchdog",
 	.fops  = &scx200_wdt_fops,
 };
 
