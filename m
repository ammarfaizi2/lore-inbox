Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129135AbQKADfP>; Tue, 31 Oct 2000 22:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbQKADfE>; Tue, 31 Oct 2000 22:35:04 -0500
Received: from [209.249.10.20] ([209.249.10.20]:40602 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129135AbQKADes>; Tue, 31 Oct 2000 22:34:48 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 31 Oct 2000 19:42:46 -0800
Message-Id: <200011010342.TAA08318@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        torvalds@transmeta.com
Subject: Patch: linux-2.4.0-test10-pre7/drivers/usb/usb.c driver matching bug
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.4.0-test10-pre7/drivers/usb/usb.c introduced a really
cool feature, where USB drivers can declare a data structure that
describes the various ID bytes of the USB devices that they are
relevant to.  Updated versions of depmod and hotplug are then
used so that the appropriate USB drivers can then be loaded
automatically as soon as you plug in a device, without any
need to create additional system configuration files.

	Anyhow, the USB implementation of this has a tiny bug,
where it does an apples-and-oranges comparison.  The patch is
attached below.

	Since the USB device table support is in
linux-2.4.0-test10-pre7 and not in the HEAD branch of the
linux-usb CVS tree on sourceforge.net, and since the bug fix
is very clear and small, I am sending this patch to Linus and 
linux-kernel in addition to linux-usb-devel.  If there is some
better way that I should submit a patch in this sort of situation,
please let me know.  I don't mean to step on anyone's toes.

	By the way, I was able to test this all the way to the
point of plugging in a USB printer and watching the module
automatically load and bind to the printer interface.  (I
will submit the usb/printer.c device table support patch to
linux-usb-devel momentarily.)

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--- linux-2.4.0-test10-pre7/drivers/usb/usb.c	Tue Oct 31 02:42:50 2000
+++ linux/drivers/usb/usb.c	Tue Oct 31 19:26:14 2000
@@ -540,7 +540,7 @@
 			    if (id->bInterfaceClass
 				    && id->bInterfaceClass == intf->bInterfaceClass) {
 				if (id->bInterfaceSubClass && id->bInterfaceSubClass
-					!= intf->bInterfaceClass)
+					!= intf->bInterfaceSubClass)
 				    continue;
 				if (id->bInterfaceProtocol && id->bInterfaceProtocol
 					!= intf->bInterfaceProtocol)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
