Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbUCMWes (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 17:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUCMWes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 17:34:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61092 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263203AbUCMWeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 17:34:46 -0500
Subject: Re: finding out the value of HZ from userspace
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Micha Feigin <michf@post.tau.ac.il>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040313221418.GF5960@luna.mooo.com>
References: <20040311141703.GE3053@luna.mooo.com>
	 <1079198671.4446.3.camel@laptop.fenrus.com> <4053624D.6080806@BitWagon.com>
	 <20040313193852.GC12292@devserv.devel.redhat.com>
	 <20040313221418.GF5960@luna.mooo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Gcj1rtdmykoL4dqzJQ5M"
Organization: Red Hat, Inc.
Message-Id: <1079217159.4915.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 13 Mar 2004 23:32:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Gcj1rtdmykoL4dqzJQ5M
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-03-13 at 23:14, Micha Feigin wrote:
> On Sat, Mar 13, 2004 at 08:38:52PM +0100, Arjan van de Ven wrote:
> > On Sat, Mar 13, 2004 at 11:34:37AM -0800, John Reiser wrote:
> > > Arjan van de Ven wrote:
> > > >On Thu, 2004-03-11 at 15:17, Micha Feigin wrote:
> > > >
> > > >>Is it possible to find out what the kernel's notion of HZ is from u=
ser
> > > >>space?
> > > >>It seem to change from system to system and between 2.4 (100 on i38=
6)
> > > >>to 2.6 (1000 on i386).
> > > >
> > > >
> > > >if you can see 1000 from userspace that is a bad kernel bug; can you=
 say
> > > >where you find something in units of 1000 ?
> > >=20
> > > create_elf_tables() in fs/binfmt_elf.c tells every ELF execve():
> > >         NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
> > > which can be found by crawling through the stack above the pointer
> > > to the last environment variable.
> >=20
> > Ugh that should say 100 on x86....
> > but..
> > param.h:# define USER_HZ        100             /* .. some user interfa=
ces are in "ticks" */
> > param.h:# define CLOCKS_PER_SEC (USER_HZ)       /* like times() */
> > .....
> > that looks like 100 to me.
> >=20
>=20
> When dealing with bdflush and a few other interfaces the values need to
> be in jiffies which requires knowledge of the kernels notion of HZ not
> userspace.

Wrong. Any such interface is supposed to convert automatically. Any
interface you can find that doesn't should be reported as a serious bug!


--=-Gcj1rtdmykoL4dqzJQ5M
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAU4wGxULwo51rQBIRArEBAJ4jA91b04kmfFBIC2jNynhQ1Cm4FACeLuuz
zRyfgqxVGQI6Gj5rZQhhOGY=
=qi8C
-----END PGP SIGNATURE-----

--=-Gcj1rtdmykoL4dqzJQ5M--

