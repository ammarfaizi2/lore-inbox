Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbTB0Owq>; Thu, 27 Feb 2003 09:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265197AbTB0Owq>; Thu, 27 Feb 2003 09:52:46 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:26829 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S265177AbTB0Owo>; Thu, 27 Feb 2003 09:52:44 -0500
Date: Thu, 27 Feb 2003 16:53:18 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] AD1848 OSS driver build fix for 2.5.63-bk (bug #289)
Message-ID: <20030227145318.GA22891@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k8ylJtLa18RSEDYA"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k8ylJtLa18RSEDYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch fixes bugzilla bug #289,
http://bugme.osdl.org/show_bug.cgi?id=3D289, PNP API breakage in the
ad1848 sound driver.=20

Tested and works fine. Please apply.=20

diff -Nru a/sound/oss/ad1848.c b/sound/oss/ad1848.c
--- a/sound/oss/ad1848.c	Thu Feb 27 10:32:05 2003
+++ b/sound/oss/ad1848.c	Thu Feb 27 10:32:05 2003
@@ -2987,7 +2987,7 @@
 	if (err < 0)
 		return(NULL);
=20
-	if((err =3D pnp_activate_dev(dev,NULL)) < 0) {
+	if((err =3D pnp_activate_dev(dev)) < 0) {
 		printk(KERN_ERR "ad1848: %s %s config failed (out of resources?)[%d]\n",=
 devname, resname, err);
=20
 		pnp_device_detach(dev);
@@ -3024,7 +3024,7 @@
=20
 static int __init ad1848_isapnp_init(struct address_info *hw_config, struc=
t pnp_card *bus, int slot)
 {
-	char *busname =3D bus->name[0] ? bus->name : ad1848_isapnp_list[slot].nam=
e;
+	char *busname =3D bus->dev.name[0] ? bus->dev.name : ad1848_isapnp_list[s=
lot].name;
=20
 	/* Initialize this baby. */
=20

--=20
Muli Ben-Yehuda
http://www.mulix.org


--k8ylJtLa18RSEDYA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+XiZeKRs727/VN8sRAgmeAKCHQ4OLHzVL/YflaZAjHg+DRWhhiACgqohH
MCSOYFjyxjuJYmd4ZKENx7w=
=FyzB
-----END PGP SIGNATURE-----

--k8ylJtLa18RSEDYA--
