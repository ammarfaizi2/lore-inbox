Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265540AbSKAAn4>; Thu, 31 Oct 2002 19:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbSKAAn4>; Thu, 31 Oct 2002 19:43:56 -0500
Received: from dhcp31182033.columbus.rr.com ([24.31.182.33]:52097 "EHLO
	caphernaum.rivenstone.net") by vger.kernel.org with ESMTP
	id <S265540AbSKAAnw>; Thu, 31 Oct 2002 19:43:52 -0500
Date: Thu, 31 Oct 2002 19:47:51 -0500
To: tytso@mit.edu, linux-kernel@vger.kernel.org
Cc: zippel@linux-m68k.org
Subject: Re: [PATCH] [BK] 0/11  Ext2/3 Updates: Extended attributes, ACL, etc.
Message-ID: <20021101004751.GB1683@rivenstone.net>
Mail-Followup-To: tytso@mit.edu, linux-kernel@vger.kernel.org,
	zippel@linux-m68k.org
References: <E187Agn-0003b9-00@snap.thunk.org> <20021101002419.GA1683@rivenstone.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20021101002419.GA1683@rivenstone.net>
User-Agent: Mutt/1.4i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2002 at 07:24:19PM -0500, Joseph Fannin wrote:
> On Thu, Oct 31, 2002 at 03:28:29AM -0500, tytso@mit.edu wrote:
> > Hi Linus,
> >=20
> > I've updated the ext2/3 patches for 2.5.45.  All of these changes can
> > also be grabbed by pulling from:
> >=20
> > 	bk://extfs.bkbits.net/extfs-2.5-update

[build error]

    Okay, this looks like it's a problem with the transition to
kconfig.  I have ext3 built in and ext2 built as a module, but
CONFIG_FS_MBCACHE=3Dm.  So the problem would be this bit, right?

# Meta block cache for Extended Attributes (ext2/ext3)
config FS_MBCACHE
       tristate
       depends on EXT2_FS_XATTR || EXT3_FS_XATTR
       default m if EXT2_FS=3Dm || EXT3_FS=3Dm
       default y if EXT2_FS=3Dy || EXT3_FS=3Dy

    Which looks right -- it depends on either ext2 or ext3, and needs
to be built in if either of ext2 or ext3 are, but if both are modular
(or one is modular and the other is not built) then FS_MBCACHE should
be modular.  But it doesn't work.

--=20
Joseph Fannin
jhf@rivenstone.net

"For future reference - don't anybody else try to send patches as vi
scripts, please. Yes, it's manly, but let's face it, so is bungee-jumping
with the cord tied to your testicles." -- Linus Torvalds

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9wc83Wv4KsgKfSVgRAoc9AJ0YBgQzqFKNj7OXtauQCAm+saj+sACeNxqz
eMkHdKnJfM3kG24elSHfQmg=
=vNOn
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
