Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUEQUY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUEQUY0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 16:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUEQUY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 16:24:26 -0400
Received: from lists.us.dell.com ([143.166.224.162]:45709 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261672AbUEQUYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 16:24:21 -0400
Date: Mon, 17 May 2004 15:24:11 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: efivars: add MODULE_VERSION, remove unnecessary check in exit
Message-ID: <20040517202411.GB19268@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Adds MODULE_VERSION
* Remove check for efi_enabled in efivars_exit() - we aborted module
  load at init based on this already.=20

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


=3D=3D=3D=3D=3D drivers/firmware/efivars.c 1.4 vs edited =3D=3D=3D=3D=3D
--- 1.4/drivers/firmware/efivars.c	Sat May 15 01:11:54 2004
+++ edited/drivers/firmware/efivars.c	Mon May 17 14:38:25 2004
@@ -23,6 +23,10 @@
  *
  * Changelog:
  *
+ *  17 May 2004 - Matt Domsch <Matt_Domsch@dell.com>
+ *   remove check for efi_enabled in exit
+ *   add MODULE_VERSION
+ *
  *  26 Apr 2004 - Matt Domsch <Matt_Domsch@dell.com>
  *   minor bug fixes
  *
@@ -77,11 +81,13 @@
=20
 #include <asm/uaccess.h>
=20
+#define EFIVARS_VERSION "0.08"
+#define EFIVARS_DATE "2004-May-17"
+
 MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
 MODULE_DESCRIPTION("sysfs interface to EFI Variables");
 MODULE_LICENSE("GPL");
-
-#define EFIVARS_VERSION "0.07 2004-Apr-26"
+MODULE_VERSION(EFIVARS_VERSION);
=20
 /*
  * efivars_lock protects two things:
@@ -667,7 +673,8 @@
 	if (!efi_enabled)
 		return -ENODEV;
=20
-	printk(KERN_INFO "EFI Variables Facility v%s\n", EFIVARS_VERSION);
+	printk(KERN_INFO "EFI Variables Facility v%s %s\n", EFIVARS_VERSION,
+	       EFIVARS_DATE);
=20
 	/*
 	 * For now we'll register the efi subsys within this driver
@@ -735,9 +742,6 @@
 efivars_exit(void)
 {
 	struct list_head *pos, *n;
-
-	if (!efi_enabled)
-		return;
=20
 	list_for_each_safe(pos, n, &efivar_list)
 		efivar_unregister(get_efivar_entry(pos));

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAqR9rIavu95Lw/AkRAv4pAJ0Rd+2/27YVFVf+tNaf9y1wEx28FgCfaK9o
pwjFf7NaAD87ZnHFW4O7eb0=
=zVGJ
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
