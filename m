Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTIUIEP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 04:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTIUIEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 04:04:15 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:5275 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262359AbTIUIEM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 04:04:12 -0400
Date: Sun, 21 Sep 2003 11:04:07 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Doug Gilbert <dgilbert@interlog.com>
Cc: linux-scsi@vger.kernel.org, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix compile warning with version string in sg.c
Message-ID: <20030921080406.GB4938@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When compiling without CONFIG_SCSI_PROC_FS, I get a warning:
drivers/scsi/sg.c:21: warning: `sg_version_str' defined but not used

This patch fixes it, by definining sg_version_str only if
CONFIG_SCSI_PROC_FS is set. It also turns sg_version_str from char* to
char[], to move it from 'data' to 'rodata'.=20

diff --exclude-from /home/muli/p/dontdiff -Naur ../linux-2.5/drivers/scsi/s=
g.c 2.6.0-t5-Werror/drivers/scsi/sg.c
--- ../linux-2.5/drivers/scsi/sg.c	Sat Sep  6 00:19:59 2003
+++ 2.6.0-t5-Werror/drivers/scsi/sg.c	Sun Sep 21 10:29:43 2003
@@ -18,7 +18,11 @@
  *
  */
 #include <linux/config.h>
-static char *sg_version_str =3D "3.5.29 [20030529]";
+
+#ifdef CONFIG_SCSI_PROC_FS
+const static char sg_version_str[] =3D "3.5.29 [20030529]";
+#endif /* CONFIG_SCSI_PROC_FS */=20
+
 static int sg_version_num =3D 30529;	/* 2 digits for each component */
 /*
  *  D. P. Gilbert (dgilbert@interlog.com, dougg@triode.net.au), notes:

--=20
Muli Ben-Yehuda
http://www.mulix.org


--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/bVt2KRs727/VN8sRAnD5AKCdb+3vphpkq8hUcFI3O7zdBJA/HgCeLWO1
Z8114KaUV81Snlg0GlX8huQ=
=yx7L
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
