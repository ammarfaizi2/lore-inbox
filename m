Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318115AbSGMH2v>; Sat, 13 Jul 2002 03:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318116AbSGMH2v>; Sat, 13 Jul 2002 03:28:51 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:37540 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S318115AbSGMH2u>; Sat, 13 Jul 2002 03:28:50 -0400
Date: Sat, 13 Jul 2002 10:26:15 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: compile the kernel with -Werror
Message-ID: <20020713102615.H739@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G44BJl3Aq1QbV/QL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A full kernel compilation, especially when using the -j switch to
make, can cause warnings to "fly off the screen" without the user
noticing them. For example, wli's patch lazy_buddy.2.5.25-1 of today
had a missing return statement in a function returning non void, which
the compiler probably complained about but the warning got lost in the
noise (a little birdie told me wli used -j64).=20

The easiest safeguard agsinst this kind of problems is to compile with
-Werror, so that wherever there's a warning, compilation
stops. Compiling 2.5.25 with -Werror with my .config found only three
warnings (quite impressive, IMHO), and patches for those were sent to
trivial@rusty.

Patch against 2.5.25 to add -Werror attached:

--- linux-2.5.25-vanilla/Makefile	Sat Jul  6 02:42:04 2002
+++ linux-2.5.25-mx/Makefile	Sat Jul 13 10:01:55 2002
@@ -39,7 +39,7 @@
 FINDHPATH	=3D $(HPATH)/asm $(HPATH)/linux $(HPATH)/scsi $(HPATH)/net
=20
 HOSTCC  	=3D gcc
-HOSTCFLAGS	=3D -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+HOSTCFLAGS	=3D -Wall -Werror -Wstrict-prototypes -O2 -fomit-frame-pointer=
=20
=20
 CROSS_COMPILE 	=3D
=20
@@ -211,7 +211,7 @@
=20
 CPPFLAGS :=3D -D__KERNEL__ -I$(HPATH)
=20
-CFLAGS :=3D $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
+CFLAGS :=3D $(CPPFLAGS) -Wall -Werror -Wstrict-prototypes -Wno-trigraphs -=
O2 \
 	  -fomit-frame-pointer -fno-strict-aliasing -fno-common
 AFLAGS :=3D -D__ASSEMBLY__ $(CPPFLAGS)

--=20
http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9L9YWKRs727/VN8sRAt71AJ0fB4bUJgutQ1tqVbRoBNLqeYN5+gCguVJD
cVHLKnckY7UoTM35gMDZZ2M=
=FHMU
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--
