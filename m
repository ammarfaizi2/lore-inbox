Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268712AbUILMyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268712AbUILMyW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 08:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbUILMyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 08:54:22 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:55731 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S268712AbUILMx0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 08:53:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Duncan Sands <baldrick@free.fr>
Subject: Re: Writable module parameters - should be volatile?
Date: Sun, 12 Sep 2004 14:52:45 +0200
User-Agent: KMail/1.6.2
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       rusty@rustcorp.com.au
References: <200409121357.25915.baldrick@free.fr>
In-Reply-To: <200409121357.25915.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_haERB7GaiWNUZkz";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409121452.49139.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_haERB7GaiWNUZkz
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sonntag, 12. September 2004 13:57, Duncan Sands wrote:
> I declare a writable module parameter as follows:
>=20
> static unsigned int num_rcv_urbs =3D UDSL_DEFAULT_RCV_URBS;
>=20
> module_param (num_rcv_urbs, uint, S_IRUGO | S_IWUSR);
>=20
> Shouldn't I declare num_rcv_urbs volatile?  Otherwise compiler
> optimizations could (for example) stick it in a register and miss
> any changes made by someone writing to it...

Even worse, AFAICS there is no guarantee that writes are atomic,
which can give unpredictable results in case of strings or arrays.
Both problems can be solved by serializing access to writable
module parameters.

Maybe we could have a global module_param_rwsem. Making the
parameter volatile does not sound like the right solution, in
fact volatile is almost always a bad idea.

	Arnd <><

--Boundary-02=_haERB7GaiWNUZkz
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBREah5t5GS2LDRf4RAkPDAJ9xx7DEcTQTgwMChsYRQAPIrrUpuQCfQlga
KBzCAeCkYCT0RQBMHGzRfGs=
=UeKn
-----END PGP SIGNATURE-----

--Boundary-02=_haERB7GaiWNUZkz--
