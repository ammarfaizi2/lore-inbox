Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289347AbSBONVd>; Fri, 15 Feb 2002 08:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289372AbSBONVX>; Fri, 15 Feb 2002 08:21:23 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:12292 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S289347AbSBONVM>;
	Fri, 15 Feb 2002 08:21:12 -0500
Date: Fri, 15 Feb 2002 16:24:46 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove annoying ISAPNP message
Message-ID: <20020215132446.GA275@pazke.ipt>
Mail-Followup-To: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.3-dj3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

here is first (I hope) patch for you :))

This patch removes useless messages like:
"isapnp: Calling quirk for 02:00".

These were debug messages some years ago and IMHO totally useless now.

Patch applies cleanly to 2.5.5 and should also apply to 2.4.x.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-isapnp-q
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/dontdiff /linux.vanilla/drivers/pnp/quirks.c /linux/drive=
rs/pnp/quirks.c
--- /linux.vanilla/drivers/pnp/quirks.c	Tue Oct 30 15:55:32 2001
+++ /linux/drivers/pnp/quirks.c	Tue Oct 30 16:59:45 2001
@@ -18,6 +18,10 @@
 #include <linux/isapnp.h>
 #include <linux/string.h>
=20
+#if 0
+#define ISAPNP_DEBUG
+#endif
+
 static void __init quirk_awe32_resources(struct pci_dev *dev)
 {
 	struct isapnp_port *port, *port2, *port3;
@@ -139,8 +143,10 @@
 	while (isapnp_fixups[i].vendor !=3D 0) {
 		if ((isapnp_fixups[i].vendor =3D=3D dev->vendor) &&
 		    (isapnp_fixups[i].device =3D=3D dev->device)) {
+#ifdef ISAPNP_DEBUG
 			printk(KERN_DEBUG "isapnp: Calling quirk for %02x:%02x\n",
 			       dev->bus->number, dev->devfn);
+#endif
 			isapnp_fixups[i].quirk_function(dev);
 		}
 		i++;

--+QahgC5+KEYLbs62--

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8bQweBm4rlNOo3YgRAjcEAKCLXW1CVhpK5Y4KRZfefualL92+OwCeOnic
1bbBezzrd7Le81vixYSloHo=
=eGlk
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
