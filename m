Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266647AbRGTGSm>; Fri, 20 Jul 2001 02:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266629AbRGTGSX>; Fri, 20 Jul 2001 02:18:23 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:30221 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S266620AbRGTGST>;
	Fri, 20 Jul 2001 02:18:19 -0400
Date: Fri, 20 Jul 2001 10:18:21 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP BIOS: io range length bugfix
Message-ID: <20010720101821.A23419@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 10:03am  up 3 days, 39 min,  1 user,  load average: 0.15, 0.05, 0.01
X-Uname: Linux orbita1.ru 2.2.20pre2-acl 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--v9Ux+11Zm5mwPlX6
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

this patch fixes bug in pnpbios_rawdata_2_pci_dev() - miscalculated length =
of
ioport range. This function uses word at offset 6 in I/O Port Descriptor,=
=20
but according to ISA PnP specification ioport range length is a byte at off=
set 7
and byte 6 is base alignment.

BTW will it usefull to implement PnP device naming function ?

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-pnpBIOS-2

diff -urN -X /usr/dontdiff /linux.vanilla/drivers/pnp/pnp_bios.c /linux/drivers/pnp/pnp_bios.c
--- /linux.vanilla/drivers/pnp/pnp_bios.c	Tue Jul 17 23:11:14 2001
+++ /linux/drivers/pnp/pnp_bios.c	Sat Jul 21 00:08:38 2001
@@ -669,7 +669,7 @@
                         break;
                 case 0x08: // io
 			io= p[2] + p[3] *256;
-			len= p[6] + p[7] *256;
+			len = p[7];
 			i=0;
                         while(pci_dev->resource[i].start && i<DEVICE_COUNT_RESOURCE)
                                 i++;

--a8Wt8u1KmwUX3Y2C--

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7V80tBm4rlNOo3YgRAiYsAJ9z8GNT5YFRoWH+q2J+luZ9wEVJ7gCeI9sZ
L8glTQ0hhQn8cALyAifq1hQ=
=Rs1I
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
