Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbTLYTvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 14:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbTLYTvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 14:51:38 -0500
Received: from smtp2.actcom.co.il ([192.114.47.15]:33754 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S263666AbTLYTvd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 14:51:33 -0500
Date: Thu, 25 Dec 2003 21:51:16 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrea Barisani <lcars@infis.univ.trieste.it>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       alsa-devel@alsa-project.org
Subject: Re: kernel 2.6.0, wrong Kconfig directives
Message-ID: <20031225195115.GQ31789@actcom.co.il>
References: <20031222235622.GA17030@sole.infis.univ.trieste.it> <87smj8bt6y.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="25rOlkxR6a4U87uN"
Content-Disposition: inline
In-Reply-To: <87smj8bt6y.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--25rOlkxR6a4U87uN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2003 at 04:20:21AM +0900, OGAWA Hirofumi wrote:
>=20
> > - SOUND_GAMEPORT option is always turned on
> >=20
> > ./drivers/input/gameport/Kconfig
> >=20
> > 22: config SOUND_GAMEPORT
> > 23:         tristate
> > 24:         default y if GAMEPORT!=3Dm
> > 25:         default m if GAMEPORT=3Dm
> >=20
> > line 24 is definetly wrong, option is enabled if GAMEPORT=3Dn.
>=20
> This patch uses "select" for the dependency of GAMEPORT.

This is wrong. It forces the joystick (GAMEPORT) in even when it's not
needed, whereas SOUND_GAMEPORT handles all cases fine. That way lies
kernel bloat. Please apply this documentation patch instead:=20

Index: drivers/input/gameport/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/muli/kernel/cvsroot/linux-2.5/drivers/input/gameport/Kconfi=
g,v
retrieving revision 1.4
diff -u -u -r1.4 Kconfig
--- drivers/input/gameport/Kconfig	26 Sep 2003 00:23:18 -0000	1.4
+++ drivers/input/gameport/Kconfig	25 Dec 2003 19:48:49 -0000
@@ -19,6 +19,17 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called gameport.
=20
+
+# Yes, this looks a bit odd. Yes, it ends up being turned on in lots
+# of cases. Please don't touch it. It is here to handle the case where
+# a sound driver can be either a module or compiled in if GAMEPORT is
+# not selected, but must be a module if the joystick is selected as a=20
+# module. The sound driver calls GAMEPORT functions. If GAMEPORT is
+# not selected, stubs are provided. If GAMEPORT is built in,
+# everything is fine. If GAMEPORT is a module, however, it would need
+# to be loaded for the sound driver to be able to link
+# properly. Therefore, the sound driver must be a module as well in
+# that case (and the GAMEPORT module must be loaded first).=20
 config SOUND_GAMEPORT
 	tristate
 	default y if GAMEPORT!=3Dm
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--25rOlkxR6a4U87uN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/6z+zKRs727/VN8sRAm87AKCzhG+XkRPHC1TYoWrhdA68zuOv+wCgn5ig
/wZMGZH7K9reZFA+CQoHSsg=
=6Olt
-----END PGP SIGNATURE-----

--25rOlkxR6a4U87uN--
