Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267768AbUHJWFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267768AbUHJWFi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267769AbUHJWFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:05:37 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:27086 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S267768AbUHJWFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:05:15 -0400
Subject: Re: 2.6.8-rc2-mm2, staircase sched and ESD
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Zan Lynx <zlynx@acm.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <cone.1091658687.786019.9775.502@pc.kolivas.org>
References: <1091655857.3088.10.camel@localhost.localdomain>
	 <cone.1091658687.786019.9775.502@pc.kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vrf+L3JSRLERwi0bk2ru"
Message-Id: <1092172133.8976.40.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 23:08:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vrf+L3JSRLERwi0bk2ru
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-08-05 at 00:31, Con Kolivas wrote:
> Zan Lynx writes:
>=20
> > The 2.6.8-rc2-mm2 kernel has the staircase scheduler, right?  Well, I a=
m
> > seeing an odd thing.  At least, I think it is odd.
> >=20
> > I'm running Fedora Core 2 and playing music with Rhythmbox.  When I
> > watch top sorted by priority, I see esd slowly increase its priority
> > until it reaches 38, then it goes back to 20.  ESD is only using 1-2%
> > CPU.
> >=20
> > This is causing a problem because doing just about anything in X, like
> > bring up a new window or drag a window causes the sound to just stop.
> >=20
> > Why does ESD's priority keep climbing?
> >=20
> > Oh yes, this does not happen if I change /proc/sys/fs/interactive to 0.=
=20
> > When it is 0, X's priority climbs faster than ESDs and does not cause
> > the problem.
>=20
> Yes this is a known issue with esd. It basically wakes up far too frequen=
tly=20
> for it's own good. esd should not be required with alsa drivers and=20
> 2.6 since alsa supports sharing of the sound card / mixing on it's own so=
=20
> adding esd adds an unnecessary layer to the sound drivers. It ends=20
> up doing this:
> esd->oss emulation->alsa.
>=20

This is not entirely true - or at least not on a more modern
distro that uses alsa:

---
nosferatu root # lsof | grep esd | grep /dev
esd        8886  azarah  mem    CHR     116,16                6226 /dev/snd=
/pcmC0D0p
esd        8886  azarah    0r   CHR        1,3                 756 /dev/nul=
l
esd        8886  azarah    1u   CHR        4,4                1193 /dev/vc/=
4
esd        8886  azarah    2u   CHR        4,4                1193 /dev/vc/=
4
esd        8886  azarah   29u   CHR     116,16                6226 /dev/snd=
/pcmC0D0p
esd        8886  azarah   30r   CHR     116,33                6058 /dev/snd=
/timer
esd       16748  azarah  mem    CHR     116,16                6226 /dev/snd=
/pcmC0D0p
esd       16748  azarah   29u   CHR     116,16                6226 /dev/snd=
/pcmC0D0p
nosferatu root # ldd `which esd` | grep asound
        libasound.so.2 =3D> /usr/lib/libasound.so.2 (0x41b0d000)
nosferatu root #
---

--=20
Martin Schlemmer

--=-vrf+L3JSRLERwi0bk2ru
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBGTllqburzKaJYLYRAv2jAJ46XIuoG+1RXdcz5ojVWPG6m5GvkACgk1mu
Ma4HS5R3WNV5KJ7A95mpMzA=
=5MPp
-----END PGP SIGNATURE-----

--=-vrf+L3JSRLERwi0bk2ru--

