Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267169AbUFZONQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267169AbUFZONQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 10:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267171AbUFZONQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 10:13:16 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:35513 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267169AbUFZONM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 10:13:12 -0400
Date: Sat, 26 Jun 2004 16:13:11 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Goldwyn Rodrigues <goldwyn_r@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Breaking ext2 file size limit of 2TB
Message-ID: <20040626141310.GG20632@lug-owl.de>
Mail-Followup-To: Goldwyn Rodrigues <goldwyn_r@myrealbox.com>,
	linux-kernel@vger.kernel.org
References: <1088230318.9825981cgoldwyn_r@myrealbox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eyM6W95CMyGSdFbG"
Content-Disposition: inline
In-Reply-To: <1088230318.9825981cgoldwyn_r@myrealbox.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eyM6W95CMyGSdFbG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-26 11:41:58 +0530, Goldwyn Rodrigues <goldwyn_r@myrealbox.c=
om>
wrote in message <1088230318.9825981cgoldwyn_r@myrealbox.com>:
> > You're using a reserved field; how do you mean "compatible" in this
> > situation? Think of a filesystem with real files > 2TB. How will an
> > unpatched ext3fs driver handle those files? You'll only see the <2TB
> > content, right?
>=20
> When I say compatible, I mean the the filesystem need not be formatted.
> All you need to do patch the kernel, and re-coompile the module/kernel,
> and remove the old module and insert the new one (if you are using ext3
> as a module).
>=20
> Currently there is a function in ext3_max_size() which limits the file
> size to 2TB because of the number of blocks, namely i_blocks.=20

So it's an incompatible extension, which tells me that you'll need to
set another incompatibility flag in case there's any >2TB file (like
ext3 does that when the filesystem's journal contains data).

> > May an unpatched version under any circumstances clear the high-order
> > bits of the newly introduced 64bit integer, just because it doesn't know
> > to preserve this reserved field's value?
>=20
> With an unpatched version you would not be able to create a file
> greater than 2TB at all and considers that all files are below 2TB.

=2E..but consider what's happening in the case you're first running a
patched kernel, create some >2TB files, then start an unpatched kernel
and work with those (formerly >2TB) files.

First of all, the files will look like being %=3D 2TB (albeit that, I
think with any >2TB file, you'd need to set an incompatibility flag so
that an unpatched ext3fs actually *refuses* to mount any FS containing a
file >2TB). What happens if you rename() such a file? What happens if
you use a pre-2TB ext2fs with it?

Sounds like an incompatible extension, so you need to mark it as one:)

> > Being unfamiliar eith ext3's internals, are there other
> > reserved/free-for-future-use fields that don't clash with the HURD?
>=20
> Andreas has proposed a few fields but I want to make sure that those
> fields as well are not used.

If you were "offered" several chooses, why did you take this one, which
is used by the HURD? Were other possibilities already used for other
purposes?

> > Are you proposing a patch like this for ext2, too?
>=20
> Once approved, it can be used for ext2 as well. Converting the
> current patch for ext2 would be childs play. ext2 and ext3 use
> almost the same structures (actually from my point of view, exactly
> the same but am afraid to use the word "exactly").

They're "compatible" as long as there's no data in the journal; with
data in the journal, ext3 marks itself as being incompatible ext2. This
is what >2TB filesize support probably needs to do, too.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--eyM6W95CMyGSdFbG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3YR2Hb1edYOZ4bsRArzFAJ0aHYM1XEN0QODczmbCeTRiy2VscgCfUDF8
QkXHrqJ+IOsZZja86xfi60Y=
=zE0H
-----END PGP SIGNATURE-----

--eyM6W95CMyGSdFbG--
