Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUFYNeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUFYNeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 09:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266335AbUFYNeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 09:34:17 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:11685 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266341AbUFYNeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 09:34:14 -0400
Date: Fri, 25 Jun 2004 15:34:12 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Goldwyn Rodrigues <goldwyn_r@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Breaking ext2 file size limit of 2TB
Message-ID: <20040625133412.GD20632@lug-owl.de>
Mail-Followup-To: Goldwyn Rodrigues <goldwyn_r@myrealbox.com>,
	linux-kernel@vger.kernel.org
References: <1088168646.d642871cgoldwyn_r@myrealbox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FQLA4iUluN3tRX8N"
Content-Disposition: inline
In-Reply-To: <1088168646.d642871cgoldwyn_r@myrealbox.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FQLA4iUluN3tRX8N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-06-25 18:34:06 +0530, Goldwyn Rodrigues <goldwyn_r@myrealbox.c=
om>
wrote in message <1088168646.d642871cgoldwyn_r@myrealbox.com>:
> Hi,
>=20
> I have made a patch to enable file creation greater than 2TB. I
> tested it using sparse files and it works good.

Generally, a good idea, but...

> Advantages:=20
> 1. Patch is compatible with the existing filesystem and does not
> need re-formatting of the device.

You're using a reserved field; how do you mean "compatible" in this
situation? Think of a filesystem with real files > 2TB. How will an
unpatched ext3fs driver handle those files? You'll only see the <2TB
content, right?

May an unpatched version under any circumstances clear the high-order
bits of the newly introduced 64bit integer, just because it doesn't know
to preserve this reserved field's value?

> Disadvantages:=20
>=20
> 1. The patch uses l_i_reserved1 field to keep higher order 32-bits of
> i_blocks. This means the patch cannot be used with HURD filesystems,
> because it is occupied with a translator field.

Being unfamiliar eith ext3's internals, are there other
reserved/free-for-future-use fields that don't clash with the HURD?

Are you proposing a patch like this for ext2, too?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--FQLA4iUluN3tRX8N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3CnUHb1edYOZ4bsRApuPAJsH6jyV2SA6BcryMWlliVZjStHLxQCcCY8C
u40Cy/HJc+ZkpXbtsouJbZE=
=RdeY
-----END PGP SIGNATURE-----

--FQLA4iUluN3tRX8N--
