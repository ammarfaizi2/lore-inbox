Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbSKARYO>; Fri, 1 Nov 2002 12:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSKARYN>; Fri, 1 Nov 2002 12:24:13 -0500
Received: from [24.31.182.33] ([24.31.182.33]:58752 "EHLO
	caphernaum.rivenstone.net") by vger.kernel.org with ESMTP
	id <S265508AbSKARYM>; Fri, 1 Nov 2002 12:24:12 -0500
Date: Fri, 1 Nov 2002 12:28:07 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] Fix 2.5-bk build error
Message-ID: <20021101172807.GA982@caphernaum.rivenstone.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <E187Agn-0003b9-00@snap.thunk.org> <20021101002419.GA1683@rivenstone.net> <20021101004751.GB1683@rivenstone.net> <20021101010607.GC1683@rivenstone.net> <Pine.LNX.4.44.0211011239290.6949-100000@serv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211011239290.6949-100000@serv>
User-Agent: Mutt/1.4i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2002 at 12:56:20PM +0100, Roman Zippel wrote:
> On Thu, 31 Oct 2002, Joseph Fannin wrote:
>=20
> > > # Meta block cache for Extended Attributes (ext2/ext3)
> > > config FS_MBCACHE
> > >        tristate
> > >        depends on EXT2_FS_XATTR || EXT3_FS_XATTR
> > >        default m if EXT2_FS=3Dm || EXT3_FS=3Dm
> > >        default y if EXT2_FS=3Dy || EXT3_FS=3Dy
> >=20
> >     "If multiple default statements are visible only the first is
> > used."
> >=20
> >     So the two default lines above need to be reversed.  This seems
> > backwards to me (the last should be used), but I've said enough.
>=20
> Well, I had to pick something and using the first is easier to implement,=
=20
> it's just different to cml1, which used the last definition.
> BTW xconfig is a nice way to see how the config back end works, you can=
=20
> enable "Show All Options" and above entry will also be visible and you ca=
n=20
> watch how the value changes depending on the inputs.
> BTW2 in the future above can be simplified into
>=20
> config FS_MBCACHE
> 	tristate
> 	depends on EXT2_FS_XATTR || EXT3_FS_XATTR
> 	default EXT2_FS || EXT3_FS
>=20

    Okay, here's a patch that does that.  Linus, this fixes a build
error in your current -bk tree that happens when one of ext[23] is a
module and the other is built-in.  Please apply it.



diff -urN linux-2.5.45/fs/Kconfig linux/fs/Kconfig
--- linux-2.5.45/fs/Kconfig	2002-11-01 11:42:04.000000000 -0500
+++ linux/fs/Kconfig	2002-11-01 11:59:50.000000000 -0500
@@ -1457,8 +1457,7 @@
 config FS_MBCACHE
 	tristate
 	depends on EXT2_FS_XATTR || EXT3_FS_XATTR
-	default m if EXT2_FS=3Dm || EXT3_FS=3Dm
-	default y if EXT2_FS=3Dy || EXT3_FS=3Dy
+	default EXT2_FS || EXT3_FS
=20
 # Posix ACL utility routines (for now, only ext2/ext3)
 config FS_POSIX_ACL

--=20
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William Graves Perry Jr.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9wrmnWv4KsgKfSVgRAvjPAJwOvQfy4PdVbTk+cpKStFvDA94TUgCeKqdA
dXF3lYGPp2nqD4BcU2uJ7ZU=
=XGB0
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
