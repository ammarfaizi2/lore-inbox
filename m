Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVKNUWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVKNUWQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVKNUTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:19:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:50886 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932090AbVKNUTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:19:22 -0500
Date: Mon, 14 Nov 2005 12:05:40 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       marcel@holtmann.org
Subject: [patch 06/12] USB: Delete leftovers from bluetty driver
Message-ID: <20051114200540.GG2319@kroah.com>
References: <20051114200100.984523000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-delete-bluetty-leftovers.patch"
In-Reply-To: <20051114200456.GA2319@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org>

This patch deletes the bluetooth.txt help file of the bluetty driver and
hands over its major device nodes for character devices to the RFCOMM TTY
implementation of the Bluetooth subsystem.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/devices.txt       |   12 +++++-----
 Documentation/usb/bluetooth.txt |   44 ----------------------------------------
 2 files changed, 6 insertions(+), 50 deletions(-)

--- usb-2.6.orig/Documentation/devices.txt
+++ usb-2.6/Documentation/devices.txt
@@ -2903,14 +2903,14 @@ Your cooperation is appreciated.
 		196 = /dev/dvb/adapter3/video0    first video decoder of fourth card
 
 
-216 char	USB BlueTooth devices
-		  0 = /dev/ttyUB0		First USB BlueTooth device
-		  1 = /dev/ttyUB1		Second USB BlueTooth device
+216 char	Bluetooth RFCOMM TTY devices
+		  0 = /dev/rfcomm0		First Bluetooth RFCOMM TTY device
+		  1 = /dev/rfcomm1		Second Bluetooth RFCOMM TTY device
 		    ...
 
-217 char	USB BlueTooth devices (alternate devices)
-		  0 = /dev/cuub0		Callout device for ttyUB0
-		  1 = /dev/cuub1		Callout device for ttyUB1
+217 char	Bluetooth RFCOMM TTY devices (alternate devices)
+		  0 = /dev/curf0		Callout device for rfcomm0
+		  1 = /dev/curf1		Callout device for rfcomm1
 		    ...
 
 218 char	The Logical Company bus Unibus/Qbus adapters
--- usb-2.6.orig/Documentation/usb/bluetooth.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-INTRODUCTION
-
-  The USB Bluetooth driver supports any USB Bluetooth device.
-  It currently works well with the Linux USB Bluetooth stack from Axis 
-  (available at http://developer.axis.com/software/bluetooth/ ) and 
-  has been rumored to work with other Linux USB Bluetooth stacks.
-
-
-CONFIGURATION
-
-  Currently the driver can handle up to 256 different USB Bluetooth 
-  devices at once. 
-
-  If you are not using devfs:
-    The major number that the driver uses is 216 so to use the driver,
-    create the following nodes:
-	mknod /dev/ttyUB0 c 216 0
-	mknod /dev/ttyUB1 c 216 1
-	mknod /dev/ttyUB2 c 216 2
-	mknod /dev/ttyUB3 c 216 3
-		.
-		.
-		.
-	mknod /dev/ttyUB254 c 216 254
-	mknod /dev/ttyUB255 c 216 255
-
-  If you are using devfs:
-    The devices supported by this driver will show up as
-    /dev/usb/ttub/{0,1,...}
-
-  When the device is connected and recognized by the driver, the driver
-  will print to the system log, which node the device has been bound to.
-
-
-CONTACT:
-
-  If anyone has any problems using this driver, please contact me, or 
-  join the Linux-USB mailing list (information on joining the mailing 
-  list, as well as a link to its searchable archive is at 
-  http://www.linux-usb.org/ )
-
-
-Greg Kroah-Hartman
-greg@kroah.com

--
