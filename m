Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVAHGoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVAHGoq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVAHGmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:42:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:28038 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261941AbVAHFsw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:52 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632672835@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:47 -0800
Message-Id: <11051632672368@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.34, 2004/12/17 15:39:21-08:00, david-b@pacbell.net

[PATCH] USB: gadget kconfig doc updates

This updates the "USB Gadget" Kconfig support:

    -	Highlighting the the two Documentation/usb files have
	information about how to interoperate with MS-Windows
	using RNDIS or CDC-ACM;

    -	Flagging CDC ACM and CDC Ethernet support in the config
    	menu descriptions;

    -	Providing a bit more description about what a "gadget driver"
	does, for the benefit of folk coming to this part of Linux
	with background in similar proprietary driver stacks.

    -	Pointing to the Linux-USB website for this API, and the
	kerneldoc.

In short:  make important driver framework information more accessible.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/gadget/Kconfig |   35 +++++++++++++++++++++++++++++++++--
 1 files changed, 33 insertions(+), 2 deletions(-)


diff -Nru a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
--- a/drivers/usb/gadget/Kconfig	2005-01-07 15:45:15 -08:00
+++ b/drivers/usb/gadget/Kconfig	2005-01-07 15:45:15 -08:00
@@ -39,6 +39,9 @@
 	   If in doubt, say "N" and don't enable these drivers; most people
 	   don't have this kind of hardware (except maybe inside Linux PDAs).
 
+	   For more information, see <http://www.linux-usb.org/gadget> and
+	   the kernel DocBook documentation for this API.
+
 config USB_GADGET_DEBUG_FILES
 	boolean "Debugging information files"
 	depends on USB_GADGET && PROC_FS
@@ -59,6 +62,8 @@
 	help
 	   A USB device uses a controller to talk to its host.
 	   Systems should have only one such upstream link.
+	   Many controller drivers are platform-specific; these
+	   often need board-specific hooks.
 
 config USB_GADGET_NET2280
 	boolean "NetChip 2280"
@@ -234,6 +239,21 @@
 	tristate "USB Gadget Drivers"
 	depends on USB_GADGET
 	default USB_ETH
+	help
+	  A Linux "Gadget Driver" talks to the USB Peripheral Controller
+	  driver through the abstract "gadget" API.  Some other operating
+	  systems call these "client" drivers, of which "class drivers"
+	  are a subset (implementing a USB device class specification).
+	  A gadget driver implements one or more USB functions using
+	  the peripheral hardware.
+
+	  Gadget drivers are hardware-neutral, or "platform independent",
+	  except that they sometimes must understand quirks or limitations
+	  of the particular controllers they work with.  For example, when
+	  a controller doesn't support alternate configurations or provide
+	  enough of the right types of endpoints, the gadget driver might
+	  not be able work with that controller, or might need to implement
+	  a less common variant of a device class protocol.
 
 # this first set of drivers all depend on bulk-capable hardware.
 
@@ -273,7 +293,7 @@
 	  one serve as the USB host instead (in the "B-Host" role).
 
 config USB_ETH
-	tristate "Ethernet Gadget"
+	tristate "Ethernet Gadget (with CDC Ethernet support)"
 	depends on NET
 	help
 	  This driver implements Ethernet style communication, in either
@@ -314,6 +334,11 @@
 	   If you say "y" here, the Ethernet gadget driver will try to provide
 	   a second device configuration, supporting RNDIS to talk to such
 	   Microsoft USB hosts.
+	   
+	   To make MS-Windows work with this, use Documentation/usb/linux.inf
+	   as the "driver info file".  For versions of MS-Windows older than
+	   XP, you'll need to download drivers from Microsoft's website; a URL
+	   is given in comments found in that info file.
 
 config USB_GADGETFS
 	tristate "Gadget Filesystem (EXPERIMENTAL)"
@@ -352,13 +377,19 @@
 	  normal operation.
 
 config USB_G_SERIAL
-	tristate "Serial Gadget"
+	tristate "Serial Gadget (with CDC ACM support)"
 	help
 	  The Serial Gadget talks to the Linux-USB generic serial driver.
+	  This driver supports a CDC-ACM module option, which can be used
+	  to interoperate with MS-Windows hosts or with the Linux-USB
+	  "cdc-acm" driver.
 
 	  Say "y" to link the driver statically, or "m" to build a
 	  dynamically linked module called "g_serial".
 
+	  For more information, see Documentation/usb/gadget_serial.txt
+	  which includes instructions and a "driver info file" needed to
+	  make MS-Windows work with this driver.
 
 
 # put drivers that need isochronous transfer support (for audio

