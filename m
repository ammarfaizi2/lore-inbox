Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVCEPEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVCEPEu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVCEPEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:04:49 -0500
Received: from europa.telenet-ops.be ([195.130.132.60]:12981 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261359AbVCEPEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:04:20 -0500
Date: Sat, 5 Mar 2005 16:03:43 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       dsaxena@plexity.net, ben-linux@fluff.org, green@crimea.edu,
       wingel@nano-system.com
Subject: [WATCHDOG] v2.6.11 patches
Message-ID: <20050305150343.GG6650@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/ixp2000_wdt.c |    2 +-
 drivers/char/watchdog/ixp4xx_wdt.c  |    2 +-
 drivers/char/watchdog/pcwd_usb.c    |    9 +++++----
 drivers/char/watchdog/s3c2410_wdt.c |    8 +++-----
 drivers/char/watchdog/sa1100_wdt.c  |    2 +-
 drivers/char/watchdog/scx200_wdt.c  |    2 +-
 6 files changed, 12 insertions(+), 13 deletions(-)

through these ChangeSets:

<wim@iguana.be> (05/03/05 1.2122)
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

<wim@iguana.be> (05/03/05 1.2123)
   [WATCHDOG] pcwd_usb: usb_control_msg-timeout-patch
   
   set timeout in usb_control_msg to USB_COMMAND_TIMEOUT instead of a 
   full second.

<ben-linux@fluff.org> (05/03/05 1.2124)
   [WATCHDOG] s3c2410-divide-patch
   
   The s3c2410 watchdog driver has an incorrect /2
   in the timer calculation, fix this problem
   
   Signed-off-by: Ben Dooks <ben-linux@fluff.org>


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/ixp2000_wdt.c b/drivers/char/watchdog/ixp2000_wdt.c
--- a/drivers/char/watchdog/ixp2000_wdt.c	2005-03-05 15:58:26 +01:00
+++ b/drivers/char/watchdog/ixp2000_wdt.c	2005-03-05 15:58:26 +01:00
@@ -186,7 +186,7 @@
 static struct miscdevice ixp2000_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP2000 Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp2000_wdt_fops,
 };
 
diff -Nru a/drivers/char/watchdog/ixp4xx_wdt.c b/drivers/char/watchdog/ixp4xx_wdt.c
--- a/drivers/char/watchdog/ixp4xx_wdt.c	2005-03-05 15:58:26 +01:00
+++ b/drivers/char/watchdog/ixp4xx_wdt.c	2005-03-05 15:58:26 +01:00
@@ -180,7 +180,7 @@
 static struct miscdevice ixp4xx_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP4xx Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp4xx_wdt_fops,
 };
 
diff -Nru a/drivers/char/watchdog/sa1100_wdt.c b/drivers/char/watchdog/sa1100_wdt.c
--- a/drivers/char/watchdog/sa1100_wdt.c	2005-03-05 15:58:26 +01:00
+++ b/drivers/char/watchdog/sa1100_wdt.c	2005-03-05 15:58:26 +01:00
@@ -176,7 +176,7 @@
 static struct miscdevice sa1100dog_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "SA1100/PXA2xx watchdog",
+	.name		= "watchdog",
 	.fops		= &sa1100dog_fops,
 };
 
diff -Nru a/drivers/char/watchdog/scx200_wdt.c b/drivers/char/watchdog/scx200_wdt.c
--- a/drivers/char/watchdog/scx200_wdt.c	2005-03-05 15:58:26 +01:00
+++ b/drivers/char/watchdog/scx200_wdt.c	2005-03-05 15:58:26 +01:00
@@ -210,7 +210,7 @@
 
 static struct miscdevice scx200_wdt_miscdev = {
 	.minor = WATCHDOG_MINOR,
-	.name  = NAME,
+	.name  = "watchdog",
 	.fops  = &scx200_wdt_fops,
 };
 
diff -Nru a/drivers/char/watchdog/pcwd_usb.c b/drivers/char/watchdog/pcwd_usb.c
--- a/drivers/char/watchdog/pcwd_usb.c	2005-03-05 15:58:29 +01:00
+++ b/drivers/char/watchdog/pcwd_usb.c	2005-03-05 15:58:29 +01:00
@@ -1,7 +1,7 @@
 /*
  *	Berkshire USB-PC Watchdog Card Driver
  *
- *	(c) Copyright 2004 Wim Van Sebroeck <wim@iguana.be>.
+ *	(c) Copyright 2004-2005 Wim Van Sebroeck <wim@iguana.be>.
  *
  *	Based on source code of the following authors:
  *	  Ken Hollis <kenji@bitgate.com>,
@@ -33,6 +33,7 @@
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/notifier.h>
@@ -56,8 +57,8 @@
 
 
 /* Module and Version Information */
-#define DRIVER_VERSION "1.00"
-#define DRIVER_DATE "12 Jun 2004"
+#define DRIVER_VERSION "1.01"
+#define DRIVER_DATE "05 Mar 2005"
 #define DRIVER_AUTHOR "Wim Van Sebroeck <wim@iguana.be>"
 #define DRIVER_DESC "Berkshire USB-PC Watchdog driver"
 #define DRIVER_LICENSE "GPL"
@@ -227,7 +228,7 @@
 	if (usb_control_msg(usb_pcwd->udev, usb_sndctrlpipe(usb_pcwd->udev, 0),
 			HID_REQ_SET_REPORT, HID_DT_REPORT,
 			0x0200, usb_pcwd->interface_number, buf, sizeof(buf),
-			HZ) != sizeof(buf)) {
+			msecs_to_jiffies(USB_COMMAND_TIMEOUT)) != sizeof(buf)) {
 		dbg("usb_pcwd_send_command: error in usb_control_msg for cmd 0x%x 0x%x 0x%x\n", cmd, *msb, *lsb);
 	}
 	/* wait till the usb card processed the command,
diff -Nru a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c	2005-03-05 15:58:32 +01:00
+++ b/drivers/char/watchdog/s3c2410_wdt.c	2005-03-05 15:58:32 +01:00
@@ -26,6 +26,8 @@
  *	05-Oct-2004	BJD	Added semaphore init to stop crashes on open
  *				Fixed tmr_count / wdt_count confusion
  *				Added configurable debug
+ *
+ *	11-Jan-2004	BJD	Fixed divide-by-2 in timeout code
 */
 
 #include <linux/module.h>
@@ -163,11 +165,7 @@
 	if (timeout < 1)
 		return -EINVAL;
 
-	/* I think someone must have missed a divide-by-2 in the 2410,
-	 * as a divisor of 128 gives half the calculated delay...
-	 */
-
-	freq /= 128/2;
+	freq /= 128;
 	count = timeout * freq;
 
 	DBG("%s: count=%d, timeout=%d, freq=%d\n",
