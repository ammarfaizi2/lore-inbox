Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbTLKB6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTLKBal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:30:41 -0500
Received: from mail.kroah.org ([65.200.24.183]:54735 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264324AbTLKBaJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:30:09 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10711061462834@kroah.com>
Subject: Re: [PATCH] USB Fixes for 2.6.0-test11
In-Reply-To: <10711061463948@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 10 Dec 2003 17:29:06 -0800
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1520, 2003/12/09 09:42:34-08:00, trini@kernel.crashing.org

[PATCH] USB: mark the scanner driver as obsolete

On Mon, Dec 01, 2003 at 11:21:58AM -0800, Greg KH wrote:
> Can't you use xsane without the scanner kernel driver?  I thought the
> latest versions used libusb/usbfs to talk directly to the hardware.
> Because of this, the USB scanner driver is marked to be removed from the
> kernel sometime in the near future.

After a bit of mucking around (and possibly finding a bug with debian's
libusb/xsane/hotplug interaction, nothing seems to run
/etc/hotplug/usb/libusbscanner and thus only root can scan, anyone whose
got this working please let me know), the problem does not exist if I
only use  libusb xsane.

How about the following:


 drivers/usb/image/Kconfig |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/usb/image/Kconfig b/drivers/usb/image/Kconfig
--- a/drivers/usb/image/Kconfig	Wed Dec 10 16:47:34 2003
+++ b/drivers/usb/image/Kconfig	Wed Dec 10 16:47:34 2003
@@ -18,12 +18,14 @@
 	  module will be called mdc800.
 
 config USB_SCANNER
-	tristate "USB Scanner support"
+	tristate "USB Scanner support (OBSOLETE)"
 	depends on USB
 	help
 	  Say Y here if you want to connect a USB scanner to your computer's
 	  USB port. Please read <file:Documentation/usb/scanner.txt> for more
 	  information.
+
+	  This driver has been obsoleted by support via libusb.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called scanner.

