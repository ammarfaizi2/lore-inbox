Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbTL2Tys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbTL2TyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:54:11 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:29613 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265110AbTL2Txn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:53:43 -0500
Date: Mon, 29 Dec 2003 20:52:46 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0 - Watchdog patches
Message-ID: <20031229205246.A32604@infomag.infomag.iguana.be>
References: <20030906125136.A9266@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030906125136.A9266@infomag.infomag.iguana.be>; from wim@iguana.be on Sat, Sep 06, 2003 at 12:51:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.5-watchdog

This will update the following files:

 drivers/char/watchdog/Kconfig |    4 ++--
 drivers/usb/input/hid-core.c  |    4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

through these ChangeSets:

<wim@iguana.be> (03/10/26 1.1350.2.1)
   [WATCHDOG] Kconfig
   
   Reflect new watchdog Documentation directory.

<wim@iguana.be> (03/12/11 1.1436)
   [USB] hid blacklist addition
   
   Added the Berkshire Products USB PC Watchdog to the hid blacklist.
   This to avoid problems with USB-Disconnects when the card feels it should reboot...


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.5-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig	Mon Dec 29 20:39:18 2003
+++ b/drivers/char/watchdog/Kconfig	Mon Dec 29 20:39:18 2003
@@ -17,7 +17,7 @@
 	  implementation entirely in software (which can sometimes fail to
 	  reboot the machine) and a driver for hardware watchdog boards, which
 	  are more robust and can also keep track of the temperature inside
-	  your computer. For details, read <file:Documentation/watchdog.txt>
+	  your computer. For details, read <file:Documentation/watchdog/watchdog.txt>
 	  in the kernel source.
 
 	  The watchdog is usually used together with the watchdog daemon
@@ -114,7 +114,7 @@
 	  This card simply watches your kernel to make sure it doesn't freeze,
 	  and if it does, it reboots your computer after a certain amount of
 	  time. This driver is like the WDT501 driver but for different
-	  hardware. Please read <file:Documentation/pcwd-watchdog.txt>. The PC
+	  hardware. Please read <file:Documentation/watchdog/pcwd-watchdog.txt>. The PC
 	  watchdog cards can be ordered from <http://www.berkprod.com/>.
 
 	  To compile this driver as a module, choose M here: the
diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Mon Dec 29 20:39:39 2003
+++ b/drivers/usb/input/hid-core.c	Mon Dec 29 20:39:39 2003
@@ -1354,6 +1354,9 @@
 #define USB_VENDOR_ID_A4TECH		0x09DA
 #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
 
+#define USB_VENDOR_ID_BERKSHIRE		0x0c98
+#define USB_DEVICE_ID_BERKSHIRE_PCWD	0x1140
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1403,6 +1406,7 @@
 	{ USB_VENDOR_ID_TANGTOP, USB_DEVICE_ID_TANGTOP_USBPS2, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MOUSE_HACK },
+	{ USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD, HID_QUIRK_IGNORE },
 	{ 0, 0 }
 };
 
