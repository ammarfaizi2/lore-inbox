Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131986AbRDZQLJ>; Thu, 26 Apr 2001 12:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133108AbRDZQLA>; Thu, 26 Apr 2001 12:11:00 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:47745 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S131986AbRDZQKs>; Thu, 26 Apr 2001 12:10:48 -0400
Date: Thu, 26 Apr 2001 11:10:34 -0500
From: Bob McElrath <rsmcelrath@students.wisc.edu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: it isn't aa's rwsem-generic-6 bug but something else [Re: aa's rwsem-generic-6 bug?  Process stuck in 'R' state.]
Message-ID: <20010426111034.B5697@draal.physics.wisc.edu>
In-Reply-To: <20010425223939.A26763@draal.physics.wisc.edu> <20010426061110.A819@athlon.random> <20010426003802.A738@draal.physics.wisc.edu> <20010426174553.B819@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010426174553.B819@athlon.random>; from andrea@suse.de on Thu, Apr 26, 2001 at 05:45:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Andrea Arcangeli [andrea@suse.de] wrote:
> On Thu, Apr 26, 2001 at 12:38:02AM -0500, Bob McElrath wrote:
> > When I posted this bug originally, you came right out and said it was
> > probably the rwsemaphores.  I really have no idea how the rwsemaphores
>=20
> You were talking about the ps table hang when I told you about the rwsem
> races. I had the same trouble on my alpha and I reproduced the races
> trivially by lanucing:
>=20
> 	make MAKE=3D'make -j2' -j2 &
>=20
> 	while :; do ps xa ; sleep 1 ; done
>=20
> After a few seconds ps deadlocked. Try that on the old asm semaphores.

This does not cause a hang on my machine with your new rwsemaphores.

> It was 100% reproducible, and after I rewrote the rwsemaphores the
> deadlock gone away completly.
>=20
> Your X hanging in R state is completly unrelated to the rwsem ps table
> hang problem as far I can tell.

Ok, so what are the other alternatives?  In the R state, the scheduler
should give it some CPU at the first available jiffy, correct?  After
several minutes it was still stuck in the R state, and had received 0
CPU time.

Could this be a scheduler bug?

Another thing I just noticed: watching the ps list, gcc is getting
called with -mcpu=3Dev56, which in turn is calling as with -mev6.  Since
this is an ev56 processor, not the newer ev6, this could conceivable be
generating illegal instructions, though I haven't ever seen any kernel
illegal instruction faults.

*Sigh*
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjroSHoACgkQjwioWRGe9K2zdgCfTVbx+JJ6kYqXgHFmalICSQLv
IaoAoNqYc1tOWzGUQDCRS7D+/ATLg0Gc
=41ea
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
