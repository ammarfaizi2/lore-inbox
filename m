Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbUL0Lbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbUL0Lbw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 06:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUL0Lbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 06:31:52 -0500
Received: from natjimbo.rzone.de ([81.169.145.162]:31667 "EHLO
	natjimbo.rzone.de") by vger.kernel.org with ESMTP id S261871AbUL0Lbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 06:31:49 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Date: Sun, 26 Dec 2004 23:49:20 +0100
User-Agent: KMail/1.6.2
Cc: Chris Wedgwood <cw@f00f.org>, Andi Kleen <ak@suse.de>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org,
       pavel@suse.cz, gordon.jin@intel.com
References: <200412151847.09598.arnd@arndb.de> <20041216040608.GB32718@wotan.suse.de> <20041226222653.GB29474@taniwha.stupidest.org>
In-Reply-To: <20041226222653.GB29474@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_0/zzB0xvJL5qRZD";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200412262349.24856.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_0/zzB0xvJL5qRZD
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnndag 26 Dezember 2004 23:26, Chris Wedgwood wrote:
> > It's an internal error code as Arnd pointed out.
>=20
> can we be sure this will never escape to userspace? =A0i can think of
> somewhere else we already do this (EFSCORRUPTED) and it does (somewhat
> deliberately escape to userspace) and this causes confusion from time
> to time when applications see 'errno =3D=3D 990'

It's safe for the compat ioctl case. If someone wants to use the
same function for the compat and native handler, it would be a bug
to return -ENOIOCTLCMD from that handler with the current code.

To work around this, we could either convert -ENOIOCTLCMD to -EINVAL
when returning from sys_ioctl(). Or we could WARN_ON(err =3D=3D -ENOIOCTLCM=
D)
for the native path in order to make the intention clear.

 Arnd <><

--Boundary-02=_0/zzB0xvJL5qRZD
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBzz/05t5GS2LDRf4RAhxYAJ0S9VtmEUUTSidEBWKZunULy8D/rACeM4V1
cLugx/gI44qnsr24itAKE1w=
=ZjXb
-----END PGP SIGNATURE-----

--Boundary-02=_0/zzB0xvJL5qRZD--
