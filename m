Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282747AbRLKThb>; Tue, 11 Dec 2001 14:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282769AbRLKThV>; Tue, 11 Dec 2001 14:37:21 -0500
Received: from laibach.mweb.co.za ([196.2.53.177]:11909 "EHLO
	laibach.mweb.co.za") by vger.kernel.org with ESMTP
	id <S282747AbRLKThO>; Tue, 11 Dec 2001 14:37:14 -0500
Subject: [Patch] Compilation errors on some usb files
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: LKM <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-3v9wZ2g2zhK4GbhaaFUH"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 11 Dec 2001 21:47:40 +0200
Message-Id: <1008100062.3199.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3v9wZ2g2zhK4GbhaaFUH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is the second of the two patches that fixes compilation
errors on linux/drivers/usb/. Like I said on the previous mail,
sorry if this has been fixed already.

This one fixes compilation error on hiddev.c




--=-3v9wZ2g2zhK4GbhaaFUH
Content-Disposition: attachment; filename=usb_hiddev.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-diff; charset=ISO-8859-1

--- linux/drivers/usb/hiddev.c	Tue Nov 13 09:23:58 2001
+++ /home/bongani/dev/c/kernel/hiddev.c	Tue Dec 11 21:33:06 2001
@@ -193,7 +193,6 @@
 	struct hiddev_list *list =3D file->private_data;
 	struct hiddev_list **listptr;
=20
-	lock_kernel();
 	listptr =3D &list->hiddev->list;
 	hiddev_fasync(-1, file, 0);
=20
@@ -209,7 +208,6 @@
 	}
=20
 	kfree(list);
-	unlock_kernel();
=20
 	return 0;
 }
@@ -567,6 +565,7 @@
 	fasync:		hiddev_fasync,
 };
=20
+#ifdef CONFIG_USB_HIDDEV
 /*
  * This is where hid.c calls us to connect a hid device to the hiddev driv=
er
  */
@@ -630,6 +629,7 @@
 		hiddev_cleanup(hiddev);
 	}
 }
+#endif
=20
 /* Currently this driver is a USB driver.  It's not a conventional one in
  * the sense that it doesn't probe at the USB level.  Instead it waits to
@@ -662,6 +662,7 @@
 	minor:	HIDDEV_MINOR_BASE
 };
=20
+#ifdef CONFIG_USB_HIDDEV
 int __init hiddev_init(void)
 {
 	hiddev_devfs_handle =3D
@@ -675,3 +676,5 @@
 	devfs_unregister(hiddev_devfs_handle);
 	usb_deregister(&hiddev_driver);
 }
+#endif
+

--=-3v9wZ2g2zhK4GbhaaFUH--

