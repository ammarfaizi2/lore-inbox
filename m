Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVCYU4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVCYU4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVCYU4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:56:19 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:17112 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261256AbVCYU4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:56:04 -0500
Date: Fri, 25 Mar 2005 22:56:03 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Kyle Moffett <mrmacman_g4@mac.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Separate platform device name from platform device number
Message-ID: <20050325205603.GD4192@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Kyle Moffett <mrmacman_g4@mac.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <1110414879646@kroah.com> <11104148792069@kroah.com> <20050325180136.GA4192@linux-sh.org> <20050325181014.GA13436@kroah.com> <20050325183534.GB4192@linux-sh.org> <5c0804da3486a6e735a46220d73c9637@mac.com> <20050325195826.GC4192@linux-sh.org> <20050325202508.A12715@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
In-Reply-To: <20050325202508.A12715@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2005 at 08:25:08PM +0000, Russell King wrote:
> Eh?  How do you end up with "/sys/devices/platform/foobar0.0" for the
> former case?  It has an ID of "-1", and not zero.  Your idea doesn't
> make any sense.
>=20
Yes, I missed the -1 part, so Kyle is correct.

It would be trivial to treat them both as foobar0 and have the
registration succeed for whoever gets it first, but I could see that this
would be problematic in the serial8250 case. On the other hand, this is
then serial8250's problem.

> > The first case is a corner case, and really shouldn't happen that much =
in
> > practice outside of broken drivers.
>=20
> It does happen today.  Firstly, the 8250 driver registers a device of
> "serial8250" with id =3D -1 for the backwards-compatible devices.
> Platforms can then register a platform device called "serial8250"
> with zero or positive id numbers.
>=20
That's fine, but that still doesn't make it any less of a corner case.

> > We don't go around changing /dev semantics everytime someone decides to
> > call their device something silly, I don't see why platform devices
> > should be treated differently, better to just fix the broken drivers..
>=20
> It's not about something being called something silly.  It's about
> the original concept of how to generate the path being down right
> stupid.
>=20
<dev><id> is a fairly common thing, if you have a problem with this,
maybe you would like to audit /dev while you are at it. I don't disagree
with you that this is useful for the devices that do end with numbers in
their names, but breaking everything else as a result of this makes no
sense either.

What would you do if you needed to register a character device using the
name of the device (which may end in a number, and there was a range of
them)? This likely doesn't happen enough in practice for anyone to
actually care, but you would have the same problem there otherwise.

This should arguably be the problem of the corner case driver, it
certainly shouldn't change convention for everyone else. While the
original concept of how to generate the path may have been "down right
stupid", it works for /dev, and I don't see how adding a superfluous . in
the paths of devices that just don't care and subsequently breaking
existing expectations of behaviour is any more inspired..

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCRHrj1K+teJFxZ9wRAkBUAJ0WJCftwheXTf1W8XPDkBIiNTXIjACeLDkS
N2kImwDd8zMBjq8MyrLeKLE=
=+M9I
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--
