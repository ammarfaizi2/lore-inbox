Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVA3RMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVA3RMU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 12:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVA3RMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 12:12:19 -0500
Received: from natjimbo.rzone.de ([81.169.145.162]:30140 "EHLO
	natjimbo.rzone.de") by vger.kernel.org with ESMTP id S261741AbVA3RLP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 12:11:15 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: blaisorblade@yahoo.it
Subject: Re: [patch 1/1] fix syscallN() macro errno value checking for i386
Date: Sun, 30 Jan 2005 18:00:22 +0100
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dhowells@redhat.com
References: <20050129010145.1C42F8C9E4@zion>
In-Reply-To: <20050129010145.1C42F8C9E4@zion>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_mKR/BrHsIMePD4/";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501301800.22706.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_mKR/BrHsIMePD4/
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnnavend 29 Januar 2005 02:01, blaisorblade@yahoo.it wrote:
>=20
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> Cc: David Howells <dhowells@redhat.com>
>=20
> The errno values which are visible for userspace are actually in the rang=
e=20
> -1 - -129, not until -128 (): this value was added:
>=20
> #define	EKEYREJECTED	129	/* Key was rejected by service */
>=20
> And this would break ucLibc (for what I heard).
>=20
> This is just a quick-fix, because putting a macro inside errno.h instead =
of
> having it copied in two places would be probably nicer.

Yes. Note that your patch only fixes the bug on i386. The code has been
copied to many other architectures, and some of them have been updated
less recently and are checking for values lower than 128. There should
really be a way to keep them all in sync.

	Arnd <><

--Boundary-02=_mKR/BrHsIMePD4/
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB/RKm5t5GS2LDRf4RAh3dAJ4sH52UfjqtSco4X0bhZEj011D38gCfbCui
Yv6BmHGzZfIT0d/upURhItw=
=m3qW
-----END PGP SIGNATURE-----

--Boundary-02=_mKR/BrHsIMePD4/--
