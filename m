Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVICSFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVICSFK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 14:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVICSFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 14:05:09 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:25316 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751149AbVICSFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 14:05:08 -0400
Date: Sun, 4 Sep 2005 06:10:24 +0200
From: Harald Welte <laforge@netfilter.org>
To: Jouni Malinen <jkmaline@cc.hut.fi>
Cc: David Miller <davem@davemloft.net>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Netdev List <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: [PATCH 2/2] [NETFILTER] remove bogus hand-coded htonll()
Message-ID: <20050904041024.GJ4415@rama.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Jouni Malinen <jkmaline@cc.hut.fi>,
	David Miller <davem@davemloft.net>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Netdev List <netdev@vger.kernel.org>,
	linux-kernel@vger.kernel.org, bunk@stusta.de
References: <20050903084315.GD4415@rama.de.gnumonks.org> <20050903165425.GZ7781@jm.kir.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+2GlJm56SCtLHYlr"
Content-Disposition: inline
In-Reply-To: <20050903165425.GZ7781@jm.kir.nu>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+2GlJm56SCtLHYlr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 03, 2005 at 09:54:25AM -0700, Jouni Malinen wrote:
> On Sat, Sep 03, 2005 at 10:43:15AM +0200, Harald Welte wrote:
>=20
> > htonll() is nothing else than cpu_to_be64(), so we'd rather call the
> > latter.
>=20
> Actually, the htonll() implementation does not seem to be doing what
> cpu_to_be64() is doing.. However, I would assume this is a bug in
> htonll() and this change to use cpu_to_be64() is fixing that.=20

ACK.

> Can this bug cause any major problems in the current implementation?

the "current implementation" was only merged after 2.6.13 is released,
so I doubt anyone but the netfilter developers is using it yet.

> I would assume that the first index should have had '-i' added to it, if
> the purpose is to swap byte order.. The code here is leaving some
> arbitrary data in 7 bytes of the 64-bit variable and setting
> (u8*)&out[7] =3D (u8*)&in[7] in somewhat inefficient way ;-). In addition,
> this looks more like swap-8-bytes-unconditionally than doing this based
> on host byte order..

yes, yes, yes.  Somehow this ancient buggy implementation slipped into
mainline.  I know I had fixed this before.

So please let's all forget about this embarrassing htonll() and move on.=20

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--+2GlJm56SCtLHYlr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDGnOwXaXGVTD0i/8RAhJyAJwLxw7FtbHTtxZrFF8zkMhM9gleZQCfQqJJ
aY1iTW76RK51YnVjV3RvhXs=
=a4dJ
-----END PGP SIGNATURE-----

--+2GlJm56SCtLHYlr--
