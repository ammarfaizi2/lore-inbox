Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVDZJwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVDZJwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVDZJvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:51:18 -0400
Received: from gizmo12bw.bigpond.com ([144.140.70.43]:34443 "HELO
	gizmo12bw.bigpond.com") by vger.kernel.org with SMTP
	id S261448AbVDZJrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:47:37 -0400
Subject: Re: [patch 1/1] uml: fix handling of no fpx_regs [critical, for
	2.6.12]
From: Andree Leidenfrost <aleidenf@bigpond.net.au>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: blaisorblade@yahoo.it, akpm@osdl.org, jdike@addtoit.com,
       bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <1114459067.983.22.camel@localhost.localdomain>
References: <20050425191253.B9FE045EBB@zion>
	 <1114459067.983.22.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WTkJhPQ+Im/q2sIT5W80"
Organization: private
Date: Tue, 26 Apr 2005 19:44:15 +1000
Message-Id: <1114508655.7716.28.camel@aurich.ostfriesland>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WTkJhPQ+Im/q2sIT5W80
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Alexander

On Mon, 2005-04-25 at 21:57 +0200, Alexander Nyberg wrote:
> m=E5n 2005-04-25 klockan 21:12 +0200 skrev blaisorblade@yahoo.it:
> > From: Andree Leidenfrost <aleidenf@bigpond.net.au>, Paolo 'Blaisorblade=
' Giarrusso <blaisorblade@yahoo.it>
> >=20
> > Fix the error path, which is triggered when the processor misses the fp=
x regs
> > (i.e. the "fxsr" cpuinfo feature). For instance by VIA C3 Samuel2. Test=
ed and
> > obvious, please merge ASAP.
> >=20
> > Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > ---
> >=20
> >  linux-2.6.12-paolo/arch/um/os-Linux/sys-i386/registers.c |    7 ++++--=
-
> >  1 files changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff -puN arch/um/os-Linux/sys-i386/registers.c~uml-fix-no_fpx_regs_han=
dling arch/um/os-Linux/sys-i386/registers.c
> > --- linux-2.6.12/arch/um/os-Linux/sys-i386/registers.c~uml-fix-no_fpx_r=
egs_handling	2005-04-25 21:03:11.000000000 +0200
> > +++ linux-2.6.12-paolo/arch/um/os-Linux/sys-i386/registers.c	2005-04-25=
 21:08:07.000000000 +0200
> > @@ -105,14 +105,15 @@ void init_registers(int pid)
> >  		panic("check_ptrace : PTRACE_GETREGS failed, errno =3D %d",
> >  		      err);
> > =20
> > +	errno =3D 0;
> >  	err =3D ptrace(PTRACE_GETFPXREGS, pid, 0, exec_fpx_regs);
> >  	if(!err)
> >  		return;
> > +	if(errno !=3D EIO)
> > +		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno =3D %d",
> > +		      errno);
>=20
> Looks like you mean "if (err !=3D EIO)" here

No. The patch is correct.

ptrace will always return -1 in case of an error. The actual error code
is in errno, hence this is what needs to be compared to EIO. Please also
see the ptrace manpage.

> >  	have_fpx_regs =3D 0;
> > -	if(err !=3D EIO)
> > -		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno =3D %d",
> > -		      err);
> > =20
> >  	err =3D ptrace(PTRACE_GETFPREGS, pid, 0, exec_fp_regs);
> >  	if(err)

Best regards
Andree
--=20
Andree Leidenfrost
Sydney - Australia


--=-WTkJhPQ+Im/q2sIT5W80
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD4DBQBCbg1viLvX3b2IzawRAis8AJdu1kbsiI36tmyHFbdyLMHlj70LAKDQ+1Vr
y5Yk684QAemZ2dRWaPJxgg==
=VYH2
-----END PGP SIGNATURE-----

--=-WTkJhPQ+Im/q2sIT5W80--

