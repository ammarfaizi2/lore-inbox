Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271017AbRHYGAW>; Sat, 25 Aug 2001 02:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272013AbRHYGAM>; Sat, 25 Aug 2001 02:00:12 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:55986 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S271017AbRHYGAD>; Sat, 25 Aug 2001 02:00:03 -0400
Date: Sat, 25 Aug 2001 00:59:57 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: basic module bug
Message-ID: <20010825005957.Q21497@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uRjmd8ppyyws0Tml"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uRjmd8ppyyws0Tml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

What's wrong with this minimal module?

    /* test module */
    #ifndef __KERNEL__
    #define __KERNEL__
    #ifndef MODULE
    #define MODULE
    #endif
    #include <linux/module.h>
    #include <linux/kernel.h>
    #include <linux/malloc.h>
    #ifdef MODULE
    int init_module(void)
    #else
    int test_init(void)
    #endif
    {
            return 0;
    }
    #ifdef MODULE
    void cleanup_module(void)
    {
    }
    #endif
    #endif

both egcs 2.91.66 and redhat's gcc 2.96-85 barf on it:

In file included from /usr/src/linux/include/asm/semaphore.h:11,
                 from /usr/src/linux/include/linux/fs.h:198,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from test.c:11:
/usr/src/linux/include/asm/current.h:4: global register variable follows a =
function definition
/usr/src/linux/include/asm/current.h:4: warning: call-clobbered register us=
ed for global register variable

What have I done wrong?

Thanks,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--uRjmd8ppyyws0Tml
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuHPt0ACgkQjwioWRGe9K0AxgCg+ARAH9sBH73nlH/ucRra7YN+
LpEAnRfct01ztwh7SXi2rxd8by60MB7Z
=fJcX
-----END PGP SIGNATURE-----

--uRjmd8ppyyws0Tml--
