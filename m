Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264409AbUE0Njs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbUE0Njs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUE0Njs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:39:48 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:46842 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S264409AbUE0Njj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:39:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Subject: Re: [PATCH 3/4] Consolidate sys32 select
Date: Thu, 27 May 2004 15:39:01 +0200
User-Agent: KMail/1.6.1
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       ultralinux@vger.kernel.org
References: <26879984$108552555440b3ce3274ba74.46765993@config21.schlund.de> <1085551771.969.109.camel@tux.rsn.bth.se>
In-Reply-To: <1085551771.969.109.camel@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_49etAllAgQ2zWrw";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405271539.05069.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_49etAllAgQ2zWrw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 26 May 2004 08:09, Martin Josefsson wrote:

> Your patch will fix the problem, I don't even need to test it.
> Thanks, looking forward to see a fix in mainline :)

I have thought about it again and am no longer sure it is really=20
the right fix. Can anyone explain why this problem only happens=20
for the fifth argument, but not for the other pointers (inp, outp,
exp)?

If sparc64 has this problem only for the fifth syscall argument,=20
does that mean that e.g. compat_sys_futex and=20
compat_sys_mq_timed{send,receive} have the same bug? If this is
a more general, i.e. not limited to the last argument, there is a
potential problem in lots of syscalls.

	Arnd <><

> > =3D=3D=3D=3D=3D fs/compat.c 1.24 vs edited =3D=3D=3D=3D=3D
> > --- 1.24/fs/compat.c=A0=A0Sat May 22 06:31:47 2004
> > +++ edited/fs/compat.c=A0=A0=A0=A0=A0=A0=A0=A0Wed May 26 00:57:49 2004
> > @@ -1300,13 +1300,15 @@
> > =A0
> > =A0asmlinkage long
> > =A0compat_sys_select(int n, compat_ulong_t __user *inp, compat_ulong_t
> > __user *outp,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0compat_ulong_t __user *exp, str=
uct compat_timeval __user *tvp)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0compat_ulong_t __user *exp, com=
pat_uptr_t utv)
> > =A0{
> > =A0=A0=A0=A0=A0=A0fd_set_bits fds;
> > +=A0=A0=A0=A0=A0struct compat_timeval __user *tvp;
> > =A0=A0=A0=A0=A0=A0char *bits;
> > =A0=A0=A0=A0=A0=A0long timeout;
> > =A0=A0=A0=A0=A0=A0int ret, size, max_fdset;
> > =A0
> > +=A0=A0=A0=A0=A0tvp =3D compat_ptr(utv);
> > =A0=A0=A0=A0=A0=A0timeout =3D MAX_SCHEDULE_TIMEOUT;
> > =A0=A0=A0=A0=A0=A0if (tvp) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0time_t sec, usec;

--Boundary-02=_49etAllAgQ2zWrw
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAte945t5GS2LDRf4RAvP6AJ49HaqqHZLigQC+6wrCmW2B7qY9BACfWZrg
oepLKPiPzWnX0G0hZWUgV6Y=
=feld
-----END PGP SIGNATURE-----

--Boundary-02=_49etAllAgQ2zWrw--
