Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbTI2OS2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 10:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTI2OS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 10:18:28 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:6831 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262929AbTI2OSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 10:18:24 -0400
Date: Mon, 29 Sep 2003 17:18:00 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Florin Iucha <florin@iucha.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030929141800.GP29313@actcom.co.il>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <20030929132355.GA1206@iucha.net> <20030929135540.GO29313@actcom.co.il> <Pine.LNX.4.53.0309291558550.1362@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5KxTQ9fdN6Op3ksq"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309291558550.1362@pnote.perex-int.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5KxTQ9fdN6Op3ksq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2003 at 04:01:09PM +0200, Jaroslav Kysela wrote:
> On Mon, 29 Sep 2003, Muli Ben-Yehuda wrote:
>=20
> > On Mon, Sep 29, 2003 at 08:23:55AM -0500, Florin Iucha wrote:
> >
> > > I can no longer select my soundcard: In test5 it was configured by
> > > CONFIG_SND_CS46XX! This option is no longer available in test6 (make
> > > menuconfig does not offer me the opportunity).
> >
> > You need to enable CONFIG_GAMEPORT, or apply this patch. Jaroslav, is
> > there a master plan for the CONFIG_SOUND_GAMEPORT -> CONFIG_GAMEPORT
> > conversion or is it a bug? this patch reverts it.
>=20
> CONFIG_SOUND_GAMEPORT define is ugly. It's better to remove all gameport
> dependencies from the ALSA's configuration files and let drivers to
> detect the gameport presence at "compile" time.

I think it's a build system issue and thus should be handled by the
build system, not by #ifdefs. However, if that's the way you prefer
it, here's a patch to remove the GAMEPORT dependencies from
sound/pci/Kconfig. From a quick glance, all affected drivers have the
necessary ifdefs.=20

diff -Naur --exclude-from /home/muli/p/dontdiff linux-2.5/sound/pci/Kconfig=
 revert-alsa-gameport-2.6.0-t6/sound/pci/Kconfig
--- linux-2.5/sound/pci/Kconfig	Mon Sep 29 16:46:37 2003
+++ revert-alsa-gameport-2.6.0-t6/sound/pci/Kconfig	Mon Sep 29 17:14:36 2003
@@ -17,7 +17,7 @@
=20
 config SND_CS46XX
 	tristate "Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for Cirrus Logic CS4610 / CS4612 /
 	  CS4614 / CS4615 / CS4622 / CS4624 / CS4630 / CS4280 chips.
@@ -30,7 +30,7 @@
=20
 config SND_CS4281
 	tristate "Cirrus Logic (Sound Fusion) CS4281"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for Cirrus Logic CS4281.
=20
@@ -83,7 +83,7 @@
=20
 config SND_TRIDENT
 	tristate "Trident 4D-Wave DX/NX; SiS 7018"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for Trident 4D-Wave DX/NX and
 	  SiS 7018 soundcards.
@@ -110,20 +110,20 @@
=20
 config SND_ENS1370
 	tristate "(Creative) Ensoniq AudioPCI 1370"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for Ensoniq AudioPCI ES1370.
=20
 config SND_ENS1371
 	tristate "(Creative) Ensoniq AudioPCI 1371/1373"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for Ensoniq AudioPCI ES1371 and
 	  Sound Blaster PCI 64 or 128 soundcards.
=20
 config SND_ES1938
 	tristate "ESS ES1938/1946/1969 (Solo-1)"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for ESS Solo-1 (ES1938, ES1946, ES196=
9)
 	  soundcard.
@@ -173,7 +173,7 @@
=20
 config SND_SONICVIBES
 	tristate "S3 SonicVibes"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for S3 SonicVibes based soundcards.
=20

--=20
Muli Ben-Yehuda
http://www.mulix.org


--5KxTQ9fdN6Op3ksq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/eD8YKRs727/VN8sRAiWoAJ4n/MOzfZqHk1xqntoTcYsOfGMeswCcCzAG
mRb7s9LTkYv172FFuzioYD4=
=SQ6W
-----END PGP SIGNATURE-----

--5KxTQ9fdN6Op3ksq--
