Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbVHEVON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbVHEVON (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbVHEVON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:14:13 -0400
Received: from lug-owl.de ([195.71.106.12]:48322 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S263127AbVHEVOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:14:11 -0400
Date: Fri, 5 Aug 2005 23:14:10 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] remove support for gcc < 3.2
Message-ID: <20050805211410.GE7464@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Adrian Bunk <bunk@stusta.de>
References: <20050731222606.GL3608@stusta.de> <21d7e99705080318347d6b58d5@mail.gmail.com> <20050804065447.GB25606@lug-owl.de> <20050804203831.GD4029@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline
In-Reply-To: <20050804203831.GD4029@stusta.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-04 22:38:31 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> On Thu, Aug 04, 2005 at 08:54:47AM +0200, Jan-Benedict Glaw wrote:
> >...
> > Current GCC from CVS (plus minor configury patches) seems to work. We
> > had -fno-unit-at-a-time missing in our arch Makefile which hides a bug
> > in kernel's sources.
> >=20
> > I guess that if you remove -fno-unit-at-a-time from i386 and use a
> > current GCC, you'll run into that fun, too.
>=20
> What bug exactly?

-fno-unit-at-a-time grounded:

jbglaw@d2:~/test_gcc/linux-2.6.13-rc5-git3$ grep fno-unit-at arch/i386/Make=
file=20
# CFLAGS +=3D $(call cc-option,-fno-unit-at-a-time)

For presenting it, I built a gcc right from CVS:

jbglaw@d2:~/test_gcc/linux-2.6.13-rc5-git3$ i486-linux-gcc -v
Using built-in specs.
Target: i486-linux
Configured with: /home/jbglaw/vax-linux/scm/build-20050802-192552-i486-linu=
x/src/gcc/configure --disable-multilib --with-newlib --disable-nls --enable=
-threads=3Dno --disable-threads --enable-symvers=3Dgnu --enable-__cxa_atexi=
t --disable-shared --target=3Di486-linux --prefix=3D/home/jbglaw/vax-linux/=
scm/build-20050802-192552-i486-linux/install/usr --enable-languages=3Dc
Thread model: single
gcc version 4.1.0 20050802 (experimental)

=2E..and here you can see it explode even on i386:

jbglaw@d2:~/test_gcc/linux-2.6.13-rc5-git3$ make CC=3Di486-linux-gcc V=3D1 =
bzImage
[...]
  CHK     include/asm-i386/asm_offsets.h
make -f scripts/Makefile.build obj=3Dinit
  i486-linux-gcc -Wp,-MD,init/.main.o.d  -nostdinc -isystem /home/jbglaw/va=
x-linux/scm/build-20050802-192552-i486-linux/install/usr/lib/gcc/i486-linux=
/4.1.0/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigr=
aphs -fno-strict-aliasing -fno-common -ffreestanding -O2     -fomit-frame-p=
ointer -pipe -msoft-float -mpreferred-stack-boundary=3D2 -march=3Di686 -mtu=
ne=3Dpentium4 -Iinclude/asm-i386/mach-default -Wdeclaration-after-statement=
 -Wno-pointer-sign    -DKBUILD_BASENAME=3Dmain -DKBUILD_MODNAME=3Dmain -c -=
o init/main.o init/main.c
init/main.c:415: error: tmp_cmdline causes a section type conflict
init/main.c:414: error: done causes a section type conflict
init/main.c:536: error: initcall_debug causes a section type conflict
include/asm/bugs.h:35: error: __setup_str_no_halt causes a section type con=
flict
include/asm/bugs.h:43: error: __setup_str_mca_pentium causes a section type=
 conflict
include/asm/bugs.h:52: error: __setup_str_no_387 causes a section type conf=
lict
init/main.c:146: error: __setup_str_nosmp causes a section type conflict
init/main.c:154: error: __setup_str_maxcpus causes a section type conflict
init/main.c:211: error: __setup_str_debug_kernel causes a section type conf=
lict
init/main.c:212: error: __setup_str_quiet_kernel causes a section type conf=
lict
init/main.c:220: error: __setup_str_loglevel causes a section type conflict
init/main.c:298: error: __setup_str_init_setup causes a section type confli=
ct
init/main.c:543: error: __setup_str_initcall_debug_setup causes a section t=
ype conflict
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC89aiHb1edYOZ4bsRAiJIAJ9SG6uB8I1uHHDXH6xMZahjOkv8rgCfdtBs
ppZTU6qOq+SPbokr3QLuZWI=
=l7UR
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--
