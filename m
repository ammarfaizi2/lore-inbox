Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbUDUPUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUDUPUl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 11:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbUDUPUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 11:20:41 -0400
Received: from linux.us.dell.com ([143.166.224.162]:24204 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263167AbUDUPUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 11:20:31 -0400
Date: Wed, 21 Apr 2004 10:18:44 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Michael_E_Brown@dell.com
Subject: EDD - set sysfs attr owner field
Message-ID: <20040421151844.GA11269@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Andrew, the patch below from Michael E. Brown properly sets the owner
field of a sysfs attribute.  Without this patch, it is possible to
crash the kernel with a simultaneous insmod/rmmod while reading files
exported by the module.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/04/21 00:13:44-05:00 michael_e_brown@meb-laptop.michaels-house.net=
=20
#   fix edd module unload race vs sysfs access
#=20
# drivers/firmware/edd.c
#   2004/04/21 00:13:35-05:00 michael_e_brown@meb-laptop.michaels-house.net=
 +1 -1
#   fix edd module unload race vs sysfs access
#=20
diff -Nru a/drivers/firmware/edd.c b/drivers/firmware/edd.c
--- a/drivers/firmware/edd.c	Wed Apr 21 00:41:03 2004
+++ b/drivers/firmware/edd.c	Wed Apr 21 00:41:03 2004
@@ -86,7 +86,7 @@
=20
 #define EDD_DEVICE_ATTR(_name,_mode,_show,_test) \
 struct edd_attribute edd_attr_##_name =3D { 	\
-	.attr =3D {.name =3D __stringify(_name), .mode =3D _mode },	\
+	.attr =3D {.name =3D __stringify(_name), .mode =3D _mode, .owner =3D THIS=
_MODULE },	\
 	.show	=3D _show,				\
 	.test	=3D _test,				\
 };

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAhpDUIavu95Lw/AkRAti8AJ4svxefYckOotQOpqwB+l8bMS2X6QCaAkGQ
gFK8PJwI666zSTqs6u3wLDQ=
=9mxB
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
