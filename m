Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTKFHH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 02:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbTKFHHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 02:07:25 -0500
Received: from mcgroarty.net ([64.81.147.195]:23269 "EHLO pinkbits.internal")
	by vger.kernel.org with ESMTP id S263388AbTKFHHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 02:07:24 -0500
Date: Thu, 6 Nov 2003 01:07:21 -0600
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BK2CVS problem
Message-ID: <20031106070721.GA18028@mcgroarty.net>
References: <20031105204522.GA11431@work.bitmover.com> <20031105125813.A5648@one-eyed-alien.net> <20031105222302.GA12992@work.bitmover.com> <Pine.LNX.4.53.0311051733310.6824@montezuma.fsmlabs.com> <20031105225134.GA14149@win.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20031105225134.GA14149@win.tue.nl>
X-Debian-GNU-Linux: Rocks
From: Brian McGroarty <brian@mcgroarty.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2003 at 11:51:34PM +0100, Andries Brouwer wrote:
> On Wed, Nov 05, 2003 at 05:33:40PM -0500, Zwane Mwaikambo wrote:
> > On Wed, 5 Nov 2003, Larry McVoy wrote:
> >=20
> > > On Wed, Nov 05, 2003 at 12:58:13PM -0800, Matthew Dharm wrote:
> > > > Out of curiosity, what were the changed lines?
> > >=20
> > > --- GOOD        2003-11-05 13:46:44.000000000 -0800
> > > +++ BAD 2003-11-05 13:46:53.000000000 -0800
> > > @@ -1111,6 +1111,8 @@
> > >                 schedule();
> > >                 goto repeat;
> > >         }
> > > +       if ((options =3D=3D (__WCLONE|__WALL)) && (current->uid =3D 0=
))
> > > +                       retval =3D -EINVAL;
> >=20
> > That looks odd
>=20
> Not if you hope to get root.

You got it. Short-circuiting will make the second half of the
conditional execute only when the first half is true. So if options
equals __WCLONE|__WALL exactly, then the user is changed to root.

I believe the two flags would normally be mutually exclusive (why
would you wait on everything as well as waiting on only non-SIGCHLD?)
so having to set the strange process flags makes it look like a local
exploit.

I wonder why someone who thought they had access to the tree wouldn't
have tried to make something that worked remotely?

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/qfMp2PBacobwYH4RAlGNAJ9hrpNwAD6nq3X5vC+nBY9caeLrpACfTxya
J63MZg5uemydYFNQg+lOSEs=
=jXBu
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
