Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269639AbRHYP5A>; Sat, 25 Aug 2001 11:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269632AbRHYP4v>; Sat, 25 Aug 2001 11:56:51 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:42419 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S269543AbRHYP4k>; Sat, 25 Aug 2001 11:56:40 -0400
Date: Sat, 25 Aug 2001 10:56:45 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: Evgeny Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: basic module bug
Message-ID: <20010825105645.T21497@draal.physics.wisc.edu>
In-Reply-To: <20010825005957.Q21497@draal.physics.wisc.edu> <200108251122.f7PBMvl17221@www.2ka.mipt.ru> <20010825102756.R21497@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tRcR9GoWqjXrt11v"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010825102756.R21497@draal.physics.wisc.edu>; from mcelrath@draal.physics.wisc.edu on Sat, Aug 25, 2001 at 10:27:56AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tRcR9GoWqjXrt11v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Also I don't know if I mentioned this is on the alpha architecture.
I've tried egcs 2.91.66, gcc-2.96-85 (redhat), binutils-2.10.91.0.2-3.
All kernel versions I've tried (2.4.4, 2.4.5, 2.4.7, 2.4.9, 2.2.19)
generate the same message.  What am I doing wrong?

Where can I find a "skeleton" kernel module for comparison?

Bob McElrath [mcelrath@draal.physics.wisc.edu] wrote:
> Evgeny Polyakov [johnpol@2ka.mipt.ru] wrote:
> > How do you compile this module?
> > I've just trying to do this with the following command and all is OK:
> > gcc ./test.c -c -o ./test.o -D__KERNEL__ -DMODULE.
>=20
> That's because if you -D__KERNEL__ the whole file is ifdef'ed out.  ;)
>=20
> Remove the #ifdef __KERNEL__ stuff if you want to compile it that way.

Here's a simpler case more compatible with the options passed to gcc
when the kernel is compiled:

    /* test module.  Compile with: gcc -c -I/usr/src/linux/include
     * -D__KERNEL__ -DMODULE test.c  */
    #include <linux/module.h>
    #include <linux/kernel.h>
    #include <asm/current.h>
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

(0)<mcelrath@draal:/home/mcelrath> gcc -c -I/usr/src/linux/include -D__KERN=
EL__ -DMODULE test.c
In file included from test.c:5:
/usr/src/linux/include/asm/current.h:4: warning: call-clobbered register us=
ed for global register variable

Yet a simpler case:

    #include <asm/current.h>
    int main() {}

Generates the same warning message.  Why does this message not occur
when compiling the kernel?

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--tRcR9GoWqjXrt11v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuHyr0ACgkQjwioWRGe9K2tlACgzWn9UDatbzIf55RMw4+zD7mG
DVsAoPyhduijlLZLfbS90luFBm9XBPmS
=v3g5
-----END PGP SIGNATURE-----

--tRcR9GoWqjXrt11v--
