Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUHTLsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUHTLsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 07:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUHTLsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 07:48:30 -0400
Received: from mail.donpac.ru ([80.254.111.2]:38542 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S266591AbUHTLrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 07:47:47 -0400
Date: Fri, 20 Aug 2004 15:47:46 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.8.1-mm3, fix qla1280 build on visws
Message-ID: <20040820114746.GC794@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <20040820031919.413d0a95.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040803i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: multipart/mixed; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

attached patch fixes qla1280 SCSI driver build failure on visws
due to undefined RD_REG_WORD_dmasync() macro.

Please consider applying.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-qla1280-visws
Content-Transfer-Encoding: quoted-printable

diff -urpNX /usr/share/dontdiff -U 6 linux-2.6.8.1-mm3.vanilla/drivers/scsi=
/qla1280.h linux-2.6.8.1-mm3/drivers/scsi/qla1280.h
--- linux-2.6.8.1-mm3.vanilla/drivers/scsi/qla1280.h	2004-08-20 14:45:17.00=
0000000 +0400
+++ linux-2.6.8.1-mm3/drivers/scsi/qla1280.h	2004-08-20 14:56:20.000000000 =
+0400
@@ -59,12 +59,13 @@
 #if MEMORY_MAPPED_IO
 #define RD_REG_WORD(addr)		readw_relaxed(addr)
 #define RD_REG_WORD_dmasync(addr)	readw(addr)
 #define WRT_REG_WORD(addr, data)	writew(data, addr)
 #else				/* MEMORY_MAPPED_IO */
 #define RD_REG_WORD(addr)		inw((unsigned long)addr)
+#define RD_REG_WORD_dmasync(addr)	RD_REG_WORD(addr)
 #define WRT_REG_WORD(addr, data)	outw(data, (unsigned long)addr)
 #endif				/* MEMORY_MAPPED_IO */
=20
 /*
  * Host adapter default definitions.
  */

--VywGB/WGlW4DM4P8--

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBJeTiby9O0+A2ZecRAi1cAJ4jKQAQM1mFeDT9aMNVRmJ5eY1L7gCfargG
DX7sTpjJl0lGb2II6Qy+oxc=
=MFiZ
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
