Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVEMHVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVEMHVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 03:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVEMHVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 03:21:05 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:49293 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S262273AbVEMHUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 03:20:49 -0400
Date: Fri, 13 May 2005 09:19:24 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hbryan@us.ibm.com, ericvh@gmail.com, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050513071924.GA9667@vagabond>
References: <OF1BD633A3.AED1499B-ON88256FFF.006E4A76-88256FFF.00742B3D@us.ibm.com> <E1DWT0t-0000of-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <E1DWT0t-0000of-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 13, 2005 at 07:47:07 +0200, Miklos Szeredi wrote:
> > >    2) Not giving up suid for cloned and propagated mounts, but having
> > >       extra limitations (suid/sgid programs cannot access unprivileged
> > >       "synthetic" mounts)
> >=20
> > (2) isn't realistic.  There's no such thing as a suid program.  Suid is=
 a=20
> > characteristic of a _file_.  There's no way to know whether a given=20
> > executing program is running with privileges that came from a suid file=
=20
> > getting exec'ed.  Bear in mind that that exec could be pretty remote --=
=20
> > done by a now-dead ancestor with three more execs in between.
> >=20
> > Many user space programs contain hacks to try to discern this informati=
on,=20
> > and they often cause me headaches and I have to fix them.  The usual ha=
cks=20
> > are euid=3D=3Duid, euid=3D=3Dsuid, and/or euid=3D=3D0.  It would be an =
order of=20
> > magnitude worse for the kernel to contain such a hack.
>=20
> Guess what?  It's already there.  Look in ptrace_attach() in
> kernel/ptrace.c
>=20
> You could argue about the usefulness of ptrace.  The point is, that
> suid/sgid programs _can_ be discerned, and ptrace _needs_ to discern
> them.

I actually neither needs to, nor does. For ptrace the definition is:
    If the tracee has different privilegies, than the tracer, than it
    can't be traced.

For this definition, the check is not a hack. It's the only way to go.

Now this definition is really what is needed for the filesystem case
too, so I think it's not a hack either.=20

> And for the same reason, user controlled filesystems also need to do
> this check.  See Documentation/filesystems/fuse.txt in -mm and later
> discussion in this thread for more information.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFChFT8Rel1vVwhjGURAj0yAKDDlwQbsQjPrzGC1sT60u9sTLLLdACg1R/C
L+/Gnn12L8xIRJJcpBFA+FE=
=jl4U
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
