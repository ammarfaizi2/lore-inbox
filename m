Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276883AbRJCGel>; Wed, 3 Oct 2001 02:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276882AbRJCGec>; Wed, 3 Oct 2001 02:34:32 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:53261 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S276883AbRJCGeU>;
	Wed, 3 Oct 2001 02:34:20 -0400
Date: Wed, 3 Oct 2001 10:34:45 +0400
To: Jerome Cornet <jerome.cornet@alcatel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SB driver, kernel 2.4.10
Message-ID: <20011003103445.A20534@orbita1.ru>
In-Reply-To: <iss.5826.3bba3705.d9786.1@kanata-mh1.ca.newbridge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <iss.5826.3bba3705.d9786.1@kanata-mh1.ca.newbridge.com>; from jerome.cornet@alcatel.com on Tue, Oct 02, 2001 at 05:52:05PM -0400
X-Uptime: 10:00am  up 26 days,  1:26,  1 user,  load average: 1.00, 1.00, 1.00
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2001 at 05:52:05PM -0400, Jerome Cornet wrote:

>     Hi there,
>=20
> The PnP initialisation of my brand old SB AWE64 PnP was not supported by =
the=20
> current (2.4.10) kernel driver (I could initialise it by using isapnptool=
s,=20
> but not directly by the pnp driver).
>=20
> I patched sb_card.c so that the device ID of my board is known by the SB=
=20
> driver, thus allowing the isapnp initialisation by the driver directly.
>=20
> I tested it on my computer, and I don't expect the patch to break anythin=
g=20
> (it's a no brainer fix)
>=20
> Maybe you can consider applying it to the next release ?
>=20
> Thank you,
>  /Jerome
>=20
> PS: please CC: me for the replies, I'm not subscribed to linux-kernel

Device ID should be added to id_table[] also. New patch attached.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.10-awe64-full.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN linux.vanilla/drivers/sound/sb_card.c linux/drivers/sound/sb_card=
.c
--- linux.vanilla/drivers/sound/sb_card.c	Wed Oct  3 10:05:56 2001
+++ linux/drivers/sound/sb_card.c	Wed Oct  3 10:11:40 2001
@@ -53,6 +53,9 @@
  *
  * 28-10-2000 Added pnplegacy support
  * 	Daniel Church <dchurch@mbhs.edu>
+ *
+ * 01-10-2001 Added a new flavor of Creative SB AWE64 PnP (CTL00E9).
+ *      Jerome Cornet <jcornet@free.fr>
  */
=20
 #include <linux/config.h>
@@ -423,6 +426,11 @@
 		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045),
 		0,0,0,0,
 		0,1,1,-1},
+	{"Sound Blaster AWE 64",
+		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00E9),=20
+		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045),
+		0,0,0,0,
+		0,1,1,-1},
 	{"ESS 1688",
 		ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x0968),=20
 		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x0968),
@@ -604,6 +612,9 @@
 		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045), 0 },
=20
 	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00E4),=20
+		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045), 0 },
+
+	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00E9),
 		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045), 0 },
=20
 	{	ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x0968),=20

--gKMricLos+KVdGMg--

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7urGFBm4rlNOo3YgRAo+AAJ9r81LvYG3b5UEf2tLJUf0yxXlzEQCgiqJH
+UzUAORtVAtUmxCKRCxr+Cs=
=Tqo6
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
