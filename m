Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSHMIMA>; Tue, 13 Aug 2002 04:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSHMIL7>; Tue, 13 Aug 2002 04:11:59 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:44010 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S311749AbSHMIL6>; Tue, 13 Aug 2002 04:11:58 -0400
Date: Tue, 13 Aug 2002 11:10:28 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] __func__ -> __FUNCTION__
Message-ID: <20020813081028.GB2192@alhambra.actcom.co.il>
References: <3D58A45F.A7F5BDD@zip.com.au> <ajaa5h$61f$1@cesium.transmeta.com> <3D58BF90.56C75C66@zip.com.au> <20020813075944.GA2192@alhambra.actcom.co.il> <3D58BEC3.50508@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OJWLbGElk4npXSe3"
Content-Disposition: inline
In-Reply-To: <3D58BEC3.50508@zytor.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OJWLbGElk4npXSe3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2002 at 01:09:39AM -0700, H. Peter Anvin wrote:
> Muli Ben-Yehuda wrote:
> >
> >How about:=20
> >
> >/* early gcc compilers lose on __func__ */=20
> >#ifndef __func__=20
> >#define __func__ __FUNCTION__
> >#endif /* !defined __func__ */=20
>=20
> __func__ isn't a macro; it's a compiler token.

Works for me(TM).=20

mulix@alhambra:~/tmp$ cat foo.c
#include <stdio.h>

#if DEF_FUNC
#ifndef __func__
#define __func__ __FUNCTION__
#endif /* !defined __func__ */
#endif /* DEF_FUNC */=20

int main()
{
	printf("%s\n", __func__);=20
	return 0;=20
}
mulix@alhambra:~/tmp$ /usr/bin/gcc -v
Reading specs from
/usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
mulix@alhambra:~/tmp$ /usr/bin/gcc foo.c -DDEF_FUNC=3D0 -o foo
foo.c: In function `main':
foo.c:11: `__func__' undeclared (first use in this function)
foo.c:11: (Each undeclared identifier is reported only once
foo.c:11: for each function it appears in.)
mulix@alhambra:~/tmp$ /usr/bin/gcc foo.c -DDEF_FUNC=3D1 -o foo
mulix@alhambra:~/tmp$ ./foo

ObCompleteyUnrelatedQuestions: where can I find klibc?=20
--=20
"Hmm.. Cache shrink failed - time to kill something?
 Mhwahahhaha! This is the part I really like. Giggle."
					 -- linux/mm/vmscan.c
http://vipe.technion.ac.il/~mulix/	http://syscalltrack.sf.net

--OJWLbGElk4npXSe3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9WL70KRs727/VN8sRAg3OAJwIioAMqVkt28m6NGbXrDuZvSXYjwCgjdMQ
ozYAsPw+10OVSFw5/qlpZHw=
=apkC
-----END PGP SIGNATURE-----

--OJWLbGElk4npXSe3--
