Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbWAGNUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbWAGNUO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 08:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWAGNUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 08:20:13 -0500
Received: from lug-owl.de ([195.71.106.12]:30377 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1030440AbWAGNUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 08:20:12 -0500
Date: Sat, 7 Jan 2006 14:20:08 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: mark.fasheh@oracle.com, kurt.hackel@oracle.com
Cc: linux-kernel@vger.kernel.org
Subject: OCFS2: __init / __exit problem
Message-ID: <20060107132008.GE820@lug-owl.de>
Mail-Followup-To: mark.fasheh@oracle.com, kurt.hackel@oracle.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EXKGNeO8l0xGFBjy"
Content-Disposition: inline
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EXKGNeO8l0xGFBjy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

$ make ARCH=3Dvax CROSS_COMPILE=3Dvax-linux-uclibc- mopboot
:
  LD      .tmp_vmlinux1
`exit_ocfs2_uptodate_cache' referenced in section `.init.text' of fs/built-=
in.o: defined in discarded section `.exit.text' of fs/built-in.o
`exit_ocfs2_extent_maps' referenced in section `.init.text' of fs/built-in.=
o: defined in discarded section `.exit.text' of fs/built-in.o
make: *** [.tmp_vmlinux1] Error 1

This happens with CONFIG_MODULES=3Dn because:

super.c:
~~~~~~~~
static int __init ocfs2_init(void)
{
:
leave: =20
        if (status < 0) {
                ocfs2_free_mem_caches();
                exit_ocfs2_uptodate_cache();
                exit_ocfs2_extent_maps();
        }
:
}


uptodate.h:void __exit exit_ocfs2_uptodate_cache(void);
extent_map.c:void __exit exit_ocfs2_extent_maps(void)
extent_map.h:void exit_ocfs2_extent_maps(void);

So an __inint function references __exit functions (which are
discarded for non-modular builds) and the declaration of
exit_ocfs2_extent_maps() in extent_map.h is missing __exit.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--EXKGNeO8l0xGFBjy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDv8AIHb1edYOZ4bsRAmFjAJ4vJgIFmp1D0VFd/JKbKF1Mgr3wHwCdHi8K
dOYqbsVbMxqF2KkiPDvO9CQ=
=PZUu
-----END PGP SIGNATURE-----

--EXKGNeO8l0xGFBjy--
