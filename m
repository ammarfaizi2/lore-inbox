Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272454AbTGaLiq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 07:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272456AbTGaLiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 07:38:46 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:62860 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272454AbTGaLim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 07:38:42 -0400
Date: Thu, 31 Jul 2003 13:38:39 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Emulating i486 on i386 (was: TSCs are a no-no on i386)
Message-ID: <20030731113838.GU1873@lug-owl.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de> <20030731002230.GE22991@fs.tum.de> <20030731062252.GM1873@lug-owl.de> <20030731071719.GA26249@alpha.home.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="um9JZCHlKYg1FKF0"
Content-Disposition: inline
In-Reply-To: <20030731071719.GA26249@alpha.home.local>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--um9JZCHlKYg1FKF0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-31 09:17:19 +0200, Willy Tarreau <willy@w.ods.org>
wrote in message <20030731071719.GA26249@alpha.home.local>:
> On Thu, Jul 31, 2003 at 08:22:52AM +0200, Jan-Benedict Glaw wrote:
> > > The 486 emlation patch for 386 is the way to still allow 386's to run=
=20
> > > Debian.
> >=20
> > Okay, I'll have a look at it. Where's the 2.6.x version?
>=20
> It doesn't exist, but could certainly easily be ported from 2.4.

> So to resume, everything can be done through emulation, but that's probab=
ly
> not what we want as a standard for performance reasons. When I have time,=
 I
> may port it to 2.6, but that's not no my priority list.

Thanks for that. In the meantime, I've started to give a try to the
userspace version (using a LD_PRELOAD lib). My current Problem:

amtus:~/sigill_catcher# LD_PRELOAD=3D./libsigill.so ls
sigill.c:_init():69: sigill started, sigaction() =3D 0
build.sh  intercept.h  libsigill.so  run.sh  sigill.c  sigill.o
amtus:~/sigill_catcher# LD_PRELOAD=3D./libsigill.so apt-get update
Illegal instruction

See? It's loaded at the "ls" call, but it seems to be not loaded for
apt-get.

I've tried to put the lib's name into /etc/ld.so.preload, but it seems
it's never loaded then (for apt-get, ls is doing fine...):

amtus:~/sigill_catcher# cat /etc/ld.so.preload=20
sigill.c:_init():69: sigill started, sigaction() =3D 0
/root/sigill_catcher/libsigill.so
amtus:~/sigill_catcher# apt-get update
Illegal instruction

Where's the difference? Seems I don't know enough about ld.so...
Any useful hints for me?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--um9JZCHlKYg1FKF0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KP++Hb1edYOZ4bsRAo5GAJ0fEeqSlrc/BEv8j2Jzj7zQLp5eRQCaAkfJ
vlREYNWwJ4ruKCoITp0nW84=
=WWv+
-----END PGP SIGNATURE-----

--um9JZCHlKYg1FKF0--
