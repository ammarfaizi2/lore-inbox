Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268325AbUG2QgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268325AbUG2QgU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267564AbUG2QCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:02:15 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:28124 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267794AbUG2PyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:54:15 -0400
Date: Thu, 29 Jul 2004 17:54:11 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, aia21@cantab.net,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: 2.6.8-rc2-mm1: NTFS compile error with gcc 2.95
Message-ID: <20040729155411.GF26643@lug-owl.de>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Andrew Morton <akpm@osdl.org>, aia21@cantab.net,
	linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
References: <20040728020444.4dca7e23.akpm@osdl.org> <20040729144149.GC2349@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline
In-Reply-To: <20040729144149.GC2349@fs.tum.de>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-07-29 16:41:49 +0200, Adrian Bunk <bunk@fs.tum.de>
wrote in message <20040729144149.GC2349@fs.tum.de>:
> On Wed, Jul 28, 2004 at 02:04:44AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.8-rc1-mm1:
> >...
> >  bk-ntfs.patch
> >...
>=20
> This causes the following compile error when using gcc 2.95:
>=20
> <--  snip  -->
>=20
> ...
>   LD      .tmp_vmlinux1
> fs/built-in.o(.text+0x14425f): In function `ntfs_find_vcn':
> : undefined reference to `__cmpdi2'
> fs/built-in.o(.text+0x144272): In function `ntfs_find_vcn':
> : undefined reference to `__cmpdi2'
> make: *** [.tmp_vmlinux1] Error 1
>=20
> <--  snip  -->

GCC wanted to make a compare on a 8byte integer (so probably long long),
but decided there isn't an appropriate insn on that hardware platform.
So instead of emitting assembler, it generated a function call that
would have resulted in a call to libgcc. However, the Linux kernel asks
to *not* link that lib (eg. think about a gcc compiled for i686 (so is
libgcc) while compiling for i386).

With the that constraint in mind, there isn't really a "nice" solution.
Maybe Linux should provide a function of that name (and several others,
too). OTOH, the H8/300 port explicitely links in libgcc, but that's only
an option if even the oldest processor supports *all* known CPU
instructions.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBCR2jHb1edYOZ4bsRAic1AJwMWwvwnMTMeFswnmt8NtHJRtkVWwCfbwqt
ljsb1fMfWAwq0sDyMNlJ37Y=
=3kd5
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
