Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbTLORtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTLORtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:49:17 -0500
Received: from 82-32-19-107.cable.ubr03.azte.blueyonder.co.uk ([82.32.19.107]:27803
	"EHLO amphibian.dyndns.org") by vger.kernel.org with ESMTP
	id S263667AbTLORtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:49:14 -0500
Date: Mon, 15 Dec 2003 17:49:08 +0000
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 'bad: scheduling while atomic!', preempt kernel, 2.6.1-test11, reading an apparently duff DVD-R
Message-ID: <20031215174908.GA29901@amphibian.dyndns.org>
References: <20031215135802.GA4332@amphibian.dyndns.org> <Pine.LNX.4.58.0312150715410.1488@home.osdl.org> <3FDDD923.30509@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <3FDDD923.30509@pobox.com>
User-Agent: Mutt/1.5.4i
From: Toad <toad@amphibian.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2003 at 10:54:11AM -0500, Jeff Garzik wrote:
> Linus Torvalds wrote:
> >
> >On Mon, 15 Dec 2003, Toad wrote:
> >
> >>I got the following when trying to mount a particular DVD-R on Linux
> >>2.6.0-test11, using an IDE DVD-RW drive, using SCSI emulation, with the
> >>preempt kernel option enabled, and taskfile I/O:
> >>(the middle bit was repeated several times):
> >
> >
> >ide-scsi does
> >
> >        spin_lock_irqsave(&ide_lock, flags);
> >        while (HWGROUP(drive)->handler) {
> >                HWGROUP(drive)->handler =3D NULL;
> >                schedule_timeout(1);
> >        }
> >
> >which is obvious crap. Scheduling while holding a spinlock is not a good
> >idea.
> >
> >You could try dropping the lock over the schedule and re-aquire it
> >afterwards, but the comment tries to say that it is required for avoiding
> >new requests.
> >
> >This is why ide-scsi needs a maintainer, btw - somebody who cares about
> >it, and actually tries to resolve the current mess.
>=20
>=20
> Pardon me for asking a dumb and possibly impertinent question, but why=20
> keep it around at all?
>=20
> In 2.6 it just seems like it's causing more problems than it's worth.  I=
=20
> mean, replacing ide-scsi with a simple 4-line driver would suffice...
>=20
> int init_module(void)
> {
> 	printk(KERN_INFO "fix your app to use SG_IO\n");
> }
>=20
> Since the major app, cdrecord, has already been fixed, that just leaves=
=20
> a few IMO minor apps out there that (a) should be using SG IO and (b)=20
> are depending on an unmaintained and perpetually broken driver anyway.

I've been completely unable to get cdrtools to compile... The version in
debian is 2.0a19, which works with IDE-SCSI, and doesn't work without
it. The RPM from the oss-dvd extension site doesn't work either without
IDE-SCSI. Nor does dvd+rwtools. Anyone attempting to write DVDs will
have real problems if IDE-SCSI is removed, judging by this experience.
>=20
> 	Jeff
>=20
>=20
> P.S. Yes, libata will probably (not definite) use the SCSI layer to=20
> drive ATAPI devices... but that's a long way off, and will not be using=
=20
> the ide-scsi code.  ide-scsi is basically a glue driver specifically for=
=20
> drivers/ide.
>=20

--=20
Matthew J Toseland - toad@amphibian.dyndns.org
Freenet Project Official Codemonkey - http://freenetproject.org/
ICTHUS - Nothing is impossible. Our Boss says so.

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/3fQUr5e+zmpNTm8RAiVgAJ4wQBo240rlP6lGwB17ZK16UJvBIgCaA2SZ
w1WDiUOPag7jc7H16oTzRjE=
=A6pb
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
