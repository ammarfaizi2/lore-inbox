Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267319AbTALGur>; Sun, 12 Jan 2003 01:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbTALGur>; Sun, 12 Jan 2003 01:50:47 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:5344
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S267319AbTALGuq>; Sun, 12 Jan 2003 01:50:46 -0500
Date: Sat, 11 Jan 2003 22:59:21 -0800
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: some curiosities on the filesystems layout in kernel config
Message-ID: <20030112065921.GA18290@kanoe.ludicrus.net>
References: <Pine.LNX.4.44.0301120053420.21687-100000@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301120053420.21687-100000@dell>
User-Agent: Mutt/1.5.3i
From: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2003 at 01:00:40AM -0500, Robert P. J. Day wrote:

> 1) where is the USMDOS selection that's listed in the Kconfig file?
>    it doesn't appear in the menu

I think you have to select DOS filesystem first and MSDOS fs support,=20
then it shows up.

>=20
> 2) shouldn't ext3 depend on ext2?
>=20

It doesn't currently, but it should.
Patch to 2.4.20 vanilla is attached, it should apply with some fuzz to=20
patched trees such as -ac and -ck. (I also renamed Second extended fs to=20
Ext2, a pet peeve of mine..)

> 3) currently, since quotas are only supported for ext2, ext3 and
>    reiserfs, shouldn't quotas depend on at least one of those
>    being selected?

Not sure whether this is true, I'm not quite sure.
And plus I don't know enough about Config.ins to write that into the=20
patch (Is it even possible in 2.4's Kconfig?)

Regards
Josh

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ext3_dep_ext2.diff"
Content-Transfer-Encoding: quoted-printable

--- fs/Config.in.orig	2003-01-11 22:53:20.000000000 -0800
+++ fs/Config.in	2003-01-11 22:56:18.000000000 -0800
@@ -24,7 +24,9 @@
=20
 dep_tristate 'BFS file system support (EXPERIMENTAL)' CONFIG_BFS_FS $CONFI=
G_EXPERIMENTAL
=20
-tristate 'Ext3 journalling file system support' CONFIG_EXT3_FS
+tristate 'Ext2 file system support' CONFIG_EXT2_FS
+
+dep_tristate 'Ext3 journalling file system support' CONFIG_EXT3_FS $CONFIG=
_EXT2_FS
 # CONFIG_JBD could be its own option (even modular), but until there are
 # other users than ext3, we will simply make it be the same as CONFIG_EXT3=
_FS
 # dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD =
$CONFIG_EXT3_FS
@@ -83,8 +85,6 @@
=20
 tristate 'ROM file system support' CONFIG_ROMFS_FS
=20
-tristate 'Second extended fs support' CONFIG_EXT2_FS
-
 tristate 'System V/Xenix/V7/Coherent file system support' CONFIG_SYSV_FS
=20
 tristate 'UDF file system support (read only)' CONFIG_UDF_FS

--82I3+IH0IqGh5yIs--

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+IRJJ6TRUxq22Mx4RArTgAJwPKgpwJ2rhu7tJEoNfjqcTsnD2+ACfdIBV
EJWRTcLQDPzToPyMoijJXeU=
=c1+/
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
