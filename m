Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbTFUJUO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 05:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbTFUJUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 05:20:14 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:30934 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S265110AbTFUJUJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 05:20:09 -0400
Date: Sat, 21 Jun 2003 12:34:02 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH TRIDENT] configuration dependency with PCIGAME fix 2.4.22-pre1
Message-ID: <20030621093401.GA6550@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,=20

Please consider this patch for 2.4.22-pre2. When pcigame is chosen as
modular (CONFIG_INPUT_PCIGAME=3Dm), and trident as builtin
(CONFIG_SOUND_TRIDENT=3Dy), trident will not link because it won't find
pcigame_attach(). This patch adds a dependency for trident on pcigame,
but only if pcigame !=3D n. Patch is against 2.4.22-pre1(cvs).=20

Patch works, confirmed by the original bug reporter.

Thanks!=20

diff -Naur --exclude-from /home/mulix/dontdiff linux-2.4/drivers/sound/Conf=
ig.in linux-2.4.22-pre1-mx/drivers/sound/Config.in
--- linux-2.4/drivers/sound/Config.in	2003-06-21 10:27:44.000000000 +0300
+++ linux-2.4.22-pre1-mx/drivers/sound/Config.in	2003-06-21 10:34:21.000000=
000 +0300
@@ -70,7 +70,13 @@
     dep_tristate '  Au1000 Sound' CONFIG_SOUND_AU1000 $CONFIG_SOUND
 fi
=20
-dep_tristate '  Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio Core'=
 CONFIG_SOUND_TRIDENT $CONFIG_SOUND $CONFIG_PCI
+# This is fairly ugly. If pcigame is off, we have no dependency on it.=20
+# However, if it's on and modular, we need to be modular too=20
+if [ "$CONFIG_INPUT_PCIGAME" =3D "n" ]; then=20
a+    dep_tristate '  Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio =
Core' CONFIG_SOUND_TRIDENT $CONFIG_SOUND $CONFIG_PCI
+else=20
+    dep_tristate '  Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio C=
ore' CONFIG_SOUND_TRIDENT $CONFIG_SOUND $CONFIG_PCI $CONFIG_INPUT_PCIGAME
+fi=20
=20
 dep_tristate '  Support for Turtle Beach MultiSound Classic, Tahiti, Monte=
rey' CONFIG_SOUND_MSNDCLAS $CONFIG_SOUND
 if [ "$CONFIG_SOUND_MSNDCLAS" =3D "y" -o "$CONFIG_SOUND_MSNDCLAS" =3D "m" =
]; then
--=20
Muli Ben-Yehuda
http://www.mulix.org
http://www.livejournal.com/~mulix/


--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+9CaJKRs727/VN8sRAp7bAJ9Ux6+w6goD8Vux39JVTNqEJM66QwCfVzSS
H4yZb5kS7ix6i/HUCVNm7mc=
=s7Ey
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
