Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318908AbSH1QNp>; Wed, 28 Aug 2002 12:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318911AbSH1QNp>; Wed, 28 Aug 2002 12:13:45 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:34699 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S318908AbSH1QNb>; Wed, 28 Aug 2002 12:13:31 -0400
Date: Wed, 28 Aug 2002 11:17:44 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: linux-kernel@vger.kernel.org
Cc: Tuukka Toivonen <tuukkat@ees2.oulu.fi>
Subject: Module includes
Message-ID: <20020828161744.GI735@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4BlIp4fARb6QCoOq"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4BlIp4fARb6QCoOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

What is the accepted way to deal with Makefiles when building a module
that lives outside the kernel tree?  (I'm playing with kernel 2.4)

I thought that the answer was to:
    include /usr/src/linux/arch/$(ARCH)/Makefile
    include /usr/src/linux/Rules.make
in your makefile.  However, the arch/i386/Makefile (and a few others)
define some targets which wreak havoc with another project's Makefile
(in particular, the 'install' target).

It is absolutely necessary to include the arch/$(ARCH)/Makefile in order
to get the proper CFLAGS needed to build a kernel module, in an
arch-independent manner.  (for instance, alpha needs -ffixed-8 or gcc
will build a bad module, and other archs need similar things)

The ALSA project has a long block of configure magic which basically
duplicates the CFLAGS in arch/$(ARCH)/Makefile without including them,
but this is hardly desirable.

Looking through make.info I do not see a way to override all targets in
an included Makefile.

Cheers,
-- Bob  (please CC me as I'm not on this list)

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

"No nation could preserve its freedom in the midst of continual warfare."
    --James Madison, April 20, 1795

--4BlIp4fARb6QCoOq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1s96gACgkQjwioWRGe9K2k0gCg7wjQ35RaA3EPY71FYIGyb/PH
2EYAnRchlmrc8hrMyEn7R36iZBeEJNmX
=Mh3o
-----END PGP SIGNATURE-----

--4BlIp4fARb6QCoOq--
