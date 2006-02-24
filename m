Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWBXL3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWBXL3L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 06:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWBXL3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 06:29:11 -0500
Received: from mouth.voxel.net ([69.9.180.118]:53958 "EHLO mail.squishy.cc")
	by vger.kernel.org with ESMTP id S932164AbWBXL3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 06:29:10 -0500
Subject: Re: [PATCH] x86_64 stack trace cleanup
From: Andres Salomon <dilinger@debian.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200602241147.03041.ak@suse.de>
References: <1140777679.5073.17.camel@localhost.localdomain>
	 <200602241147.03041.ak@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3TFBI4Cv4Hj3nNwb7JH+"
Date: Fri, 24 Feb 2006 06:29:12 -0500
Message-Id: <1140780552.5073.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3TFBI4Cv4Hj3nNwb7JH+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-02-24 at 11:47 +0100, Andi Kleen wrote:
> On Friday 24 February 2006 11:41, Andres Salomon wrote:
> > Hi,
> >=20
> > This patch cleans up the clutter of x86_64 stack traces, making the
> > output closer to what i386 and sparc64 stack traces look like.  It uses
> > print_symbol instead of resolving the symbols manually, and prints one
> > frame per line instead of displaying multiple frames per line.  I left
> > the other stuff in the stack dump alone; this affects only the frame
> > list.
> >=20
> > I know this has been brought up before
> > (http://www.uwsg.iu.edu/hypermail/linux/kernel/0602.0/2238.html,
> > although I noticed a slight problem w/ that patch, as __print_symbol
> > returns void); however, for people that don't spend all their time
> > looking at x86_64 backtraces, I think this consistency shouldn't be
> > scoffed at.  When you switch back and forth between different archs,
> > x86_64's backtrace is cluttered and confusing in comparison.
>=20
> If the formatting of the oopses is  your only problem you are a=20
> lucky man.
>=20

That would be nice.  Unfortunately, I'm trying to figure out why my dual
opteron box likes to push the load up to 15 and then hang while doing
i/o to the 3ware 9500S-8 card.  Looks like the load/d-state processes
are caused by a whole lot (well, MAX_PDFLUSH_THREADS) of pdflush
processes spinning on base->lock in lock_timer_base(); not sure if
that's intentional or not, but it seems rather odd.  Whether the hanging
is related to the high load remains to be seen.


> The problem is your new format uses more screen estate, which is precious
> after an oops because the VGA scrollback is so small.
> That is why i rejected the earlier attempts at changing this.
>=20

I don't see why this is a problem.  Other architectures have done this
for ages, without problems.  I suspect most people get their backtraces
from either serial console or logs, as copying them down from the screen
or taking a picture of the panic is a rather large pain.  It seems like
you're penalizing everyone for a few select use cases.

Of course, this is all opinion.

--=-3TFBI4Cv4Hj3nNwb7JH+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBD/u4IOmXwGc/ULyYRAvqMAJ4j/J0gBAaPFUAWffFuDg5dxITXnACfZ3Pb
rernTfLE4cDSt2bnKh7AhEo=
=1W7f
-----END PGP SIGNATURE-----

--=-3TFBI4Cv4Hj3nNwb7JH+--

