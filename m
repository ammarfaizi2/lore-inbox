Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317410AbSFXF7F>; Mon, 24 Jun 2002 01:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317413AbSFXF7E>; Mon, 24 Jun 2002 01:59:04 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:26120 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S317410AbSFXF7C>; Mon, 24 Jun 2002 01:59:02 -0400
Date: Mon, 24 Jun 2002 08:55:26 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: drivers/sound/trident.c [2/2] missing unlock on error path
Message-ID: <20020624085526.P9997@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="1ysCV03AuJYXZqZy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1ysCV03AuJYXZqZy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,=20

Here's the second trident.c patch, to=20

* add a missing unlock on an error path
* remove a superflous lock() - nothing - unlock() pair.=20

Patch was sent to maintainer who replied that he no longer maintains
the driver.=20

Patch against 2.4.19pre9.=20

--- linux-2.4.19-pre9/drivers/sound/trident.c	Sun Jun 23 07:34:35 2002
+++ linux-2.4.19-pre9-mx/drivers/sound/trident.c	Sun Jun 23 07:44:57 2002
@@ -36,6 +36,10 @@
  *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  History
+ *  v0.14.9.f
+ *      June 23 2002 Muli Ben-Yehuda <mulix@actcom.co.il>
+ *      add a missing unlock_set_fmt, remove a superflous lock/unlock pair=
=20
+ *      with nothing in between.=20
  *  v0.14.9e
  *      June 21 2002 Muli Ben-Yehuda <mulix@actcom.co.il>=20
  *      use a debug macro instead of #ifdef CONFIG_DEBUG, trim to 80 colum=
ns=20
@@ -180,7 +184,7 @@
=20
 #include <linux/pm.h>
=20
-#define DRIVER_VERSION "0.14.9e"
+#define DRIVER_VERSION "0.14.9f"
=20
 /* magic numbers to protect our data structures */
 #define TRIDENT_CARD_MAGIC	0x5072696E /* "Prin" */
@@ -2263,6 +2267,7 @@
 						{
 							printk(KERN_ERR "trident: Record is working on the card!\n");
 							ret =3D -EBUSY;
+							unlock_set_fmt(state);=20
 							break;
 						}
=20
@@ -2697,9 +2702,6 @@
=20
 	if (file->f_mode & FMODE_WRITE) {
 		stop_dac(state);
-		lock_set_fmt(state);
-
-		unlock_set_fmt(state);
 		dealloc_dmabuf(state);
 		state->card->free_pcm_channel(state->card, dmabuf->channel->num);
=20

--1ysCV03AuJYXZqZy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9FrROKRs727/VN8sRAtHgAJ4tYkhv27L0UUD+H351FMWXwvoXIgCgpCHS
lUMtSApgESlRc5eVgBHXEy4=
=dJ5N
-----END PGP SIGNATURE-----

--1ysCV03AuJYXZqZy--
