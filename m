Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282655AbRLKToB>; Tue, 11 Dec 2001 14:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282792AbRLKTnw>; Tue, 11 Dec 2001 14:43:52 -0500
Received: from supermail.mweb.co.za ([196.2.53.171]:17415 "EHLO
	supermail.mweb.co.za") by vger.kernel.org with ESMTP
	id <S282655AbRLKTnj>; Tue, 11 Dec 2001 14:43:39 -0500
Subject: [Patch] Compilation errors on some usb file
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: LKM <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-WBYOlOuyzhRZY4FNPJH0"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 11 Dec 2001 21:54:02 +0200
Message-Id: <1008100443.3236.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WBYOlOuyzhRZY4FNPJH0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sorry about the first two patches they both apply on top
of 2.4.17-pre7. I have attached both of them again I case ...



--=-WBYOlOuyzhRZY4FNPJH0
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

--=-WBYOlOuyzhRZY4FNPJH0
Content-Disposition: attachment; filename=usb_inode.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-diff; charset=ISO-8859-1

--- linux/drivers/usb/inode.c	Sun Oct 21 04:13:11 2001
+++ /home/bongani/dev/c/kernel/inode.c	Tue Dec 11 21:23:46 2001
@@ -667,7 +667,7 @@
 			inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D CURRENT_TIME;
 	}
 }
-
+#ifdef CONFIG_USB_DEVICEFS
=20
 void usbdevfs_add_bus(struct usb_bus *bus)
 {
@@ -731,13 +731,15 @@
 	unlock_kernel();
 	usbdevfs_conn_disc_event();
 }
-
+#endif
 /* --------------------------------------------------------------------- *=
/
=20
 #ifdef CONFIG_PROC_FS	=09
 static struct proc_dir_entry *usbdir =3D NULL;
 #endif=09
=20
+#ifdef CONFIG_USB_DEVICEFS
+
 int __init usbdevfs_init(void)
 {
 	int ret;
@@ -767,6 +769,7 @@
                 remove_proc_entry("usb", proc_bus);
 #endif
 }
+#endif
=20
 #if 0
 module_init(usbdevfs_init);

--=-WBYOlOuyzhRZY4FNPJH0--

