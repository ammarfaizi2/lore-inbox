Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282736AbRLKThb>; Tue, 11 Dec 2001 14:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282747AbRLKThW>; Tue, 11 Dec 2001 14:37:22 -0500
Received: from laibach.mweb.co.za ([196.2.53.177]:10885 "EHLO
	laibach.mweb.co.za") by vger.kernel.org with ESMTP
	id <S282736AbRLKThO>; Tue, 11 Dec 2001 14:37:14 -0500
Subject: [Patch] Compilation errors on some usb files
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: LKM <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-j38rnn5coQtmFKkJm2rw"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 11 Dec 2001 21:47:39 +0200
Message-Id: <1008100061.3137.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-j38rnn5coQtmFKkJm2rw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sorry if this has been posted or fixed already but here it goes. 
This is the two patche that fixes some compilation errors on
linux/drivers/usb

This fixes the compilation error on inode.c



--=-j38rnn5coQtmFKkJm2rw
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

--=-j38rnn5coQtmFKkJm2rw--

