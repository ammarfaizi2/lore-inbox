Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271837AbRICWcc>; Mon, 3 Sep 2001 18:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271848AbRICWcW>; Mon, 3 Sep 2001 18:32:22 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:7040 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S271837AbRICWcI>; Mon, 3 Sep 2001 18:32:08 -0400
Date: Tue, 4 Sep 2001 03:32:43 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using O_DIRECT
Message-ID: <20010904033243.A7872@draal.physics.wisc.edu>
In-Reply-To: <20010903104544.X23180@draal.physics.wisc.edu> <20010903175333.P699@athlon.random> <20010903105714.Y23180@draal.physics.wisc.edu> <20010903180524.Q699@athlon.random> <20010903151342.A2247@draal.physics.wisc.edu> <20010904000902.Z699@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010904000902.Z699@athlon.random>; from andrea@suse.de on Tue, Sep 04, 2001 at 12:09:02AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Andrea Arcangeli [andrea@suse.de] wrote:
> On Mon, Sep 03, 2001 at 03:13:42PM -0500, Bob McElrath wrote:
> > I have written a small program to use O_DIRECT (attached), after
> > applying your patch o_direct-14 to kernel 2.4.9.  Opening the file with
> > O_DIRECT is successful, but attempts to write to the fd return EINVAL.
> >=20
> > Am I doing something wrong?  Should I have to recompile glibc too?
>=20
> eh, the alignment and size of the buffer have basically the same
> restrictions of running read/write on a raw device, with the only
> difference that for rawio the granularity is the hardblocksize, while
> for O_DIRECT the granularity is the softblocksize of the filesystem.

Ah, thanks, it's working now.  Makes sense that it should use blocksize
granularity...

> We'll have to relax the granularity of the I/O down to the hardblocksize
> for O_DIRECT too eventually.

I don't really care about the granularity.  The bigger the better,
actually, since I'm streaming data to disk quickly.  ;)

Thanks,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuUkasACgkQjwioWRGe9K2Z7ACbB4mbcNVyiipDMyYdeXinq/GJ
fJIAoNEFmrKUookWuj8H7iR912+M1C5+
=RTRJ
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
