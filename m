Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWGFOSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWGFOSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 10:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWGFOSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 10:18:16 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:52477 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030287AbWGFOSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 10:18:16 -0400
Date: Thu, 06 Jul 2006 10:17:40 -0400
From: David Hollis <dhollis@davehollis.com>
Subject: Re: D-Link DUB-E100 Revision B1
In-reply-to: <200607040333.13649.bero@arklinux.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, pchang23@sbcglobal.net
Message-id: <1152195460.15718.4.camel@dhollis-lnx.sunera.com>
MIME-version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5)
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-r7YlLVf6XEBcPANNBSnf"
References: <200607040333.13649.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-r7YlLVf6XEBcPANNBSnf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-07-04 at 03:33 +0200, Bernhard Rosenkraenzer wrote:
> Looks like D-Link is getting into the funny "change the chipset but leave=
 the=20
> product name the same" game again.
>=20
> DUB-E100 cards up to Revision A4 work perfectly, Revision B1 doesn't work=
 at=20
> all.
>=20
> The patch I've attached has the beginnings of a fix; unfortunately this=20
> trivialty doesn't fix it fully -- with the patch, the module loads, the M=
AC=20
> address is detected correctly, the LEDs go on, but pings don't get throug=
h=20
> yet.
>=20

In the ax88772_bind() function, there is a spot where we read the
PHYSID1 and validate that it's 0x003b.  If it's not, we bail out and
don't complete the initialization.  As it turns out, with the B1 rev,
they use an external PHY that has a different identifier so this check
is no longer valid.  Simply removing that check, or getting rid of the
"goto out2;" part, the device appears to operate with no issues.

--=20
David Hollis <dhollis@davehollis.com>

--=-r7YlLVf6XEBcPANNBSnf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBErRuDxasLqOyGHncRAnkPAKCkYmsxCWvSKhKu9GZUZ9ZOuZYkLACfRt5M
PlgFIUp0VbglL/OLaaNR9dw=
=evr8
-----END PGP SIGNATURE-----

--=-r7YlLVf6XEBcPANNBSnf--

