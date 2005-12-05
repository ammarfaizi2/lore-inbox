Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbVLELJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVLELJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 06:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVLELJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 06:09:17 -0500
Received: from mout1.freenet.de ([194.97.50.132]:4030 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932373AbVLELJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 06:09:16 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: [Bcm43xx-dev] Broadcom 43xx first results
Date: Mon, 5 Dec 2005 12:08:16 +0100
User-Agent: KMail/1.8.3
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <200512042058.30801.mbuesch@freenet.de> <20051205055012.GE8953@jm.kir.nu>
In-Reply-To: <20051205055012.GE8953@jm.kir.nu>
Cc: bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       Feyd <feyd@seznam.cz>
MIME-Version: 1.0
Message-Id: <200512051208.16241.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart1607291.40cs6bjRHs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1607291.40cs6bjRHs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 05 December 2005 06:50, you wrote:
> On Sun, Dec 04, 2005 at 08:58:30PM +0100, Michael Buesch wrote:
>=20
> > > Why not use the new in-kernel wifi stack?=20
> >=20
> > We do. The SoftMAC is an extension to it.
> > SoftMAC =3D Software Medium Access Control. It is about sending
> > and receiving management frames.
> > Some chips do this in hardware, so it is not part of the ieee80211 stac=
k.
> > (the ipw2x00 do it in hardware, for example.)
>=20
> Wouldn't it be better to try to get that functionality added into the
> net/ieee80211 code instead of maintaining separate extension outside the
> kernel tree? Many modern cards need the ability for the host CPU to take
> care of management frame sending and receiving and from my view point,
> this code should be in net/ieee80211. Many (all?) of the functions in
> this "SoftMAC" look like something that would be nice to have as an
> option in net/ieee80211. In other words, the low-level driver would
> indicate what kind of functionality it needs and ieee80211 stack would
> behave differently based on the underlying hardware profile.
>=20
> ipw2x00 happens to be one of the main users of net/ieee80211 at the
> moment, but it is by no means the only one and it should not be
> defining what kind of functionality ends up being included in
> net/ieee80211.

The SoftMAC is a separate module. That is _good_, so devices like
the ipw do not have to load the code, because they do not need it.
The SoftMAC ties (and integrates) very close to the ieee80211 subsystem.

device <--> Driver <----------> ieee80211 <-----> kernel networking layer
              |                     ^
              |                     |
              .--------> SoftMAC ---.

This is approximately how it works.
You see that SoftMAC is not exactly a part or the ieee80211 subsystem,
but it uses its interface to TX a frame (and the struct to get
some information about the device).
This works without any modifications to the ieee80211 layer and I
doubt big changes will have to be made in future.

In fact, we started with the SoftMAC layer integrated into the
ieee80211 subsystem. You can still find the patches on the project FTP.
We decided to drop it, because of the bad design.

This all works fine. There is absolutely no need to bloat the
ieee80211 layer with functionality, which is not needed by all devices.

=2D-=20
Greetings Michael.

--nextPart1607291.40cs6bjRHs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDlB+glb09HEdWDKgRAhucAJ9oxFQLm7efCgehKPLR+BrhwKfrcACgovlI
FzlNO6CcMjD9Rxqe70kUSNg=
=QUoA
-----END PGP SIGNATURE-----

--nextPart1607291.40cs6bjRHs--
