Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWG0OTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWG0OTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWG0OTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:19:49 -0400
Received: from adsl-230-146.dsl.uva.nl ([146.50.230.146]:23975 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id S1751338AbWG0OTs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:19:48 -0400
Date: Thu, 27 Jul 2006 16:19:59 +0200
From: Frank v Waveren <fvw@var.cx>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux capabilities oddity
Message-ID: <20060727141959.GC22794@var.cx>
References: <20060723143646.GA2840@var.cx> <20060725184719.GA8076@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Content-Disposition: inline
In-Reply-To: <20060725184719.GA8076@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2006 at 01:47:19PM -0500, Serge E. Hallyn wrote:
> Quoting Frank v Waveren (fvw@var.cx):
> > While debugging an odd problem where /proc/sys/kernel/cap-bound wasn't
> > working, I came across the following code at
> > linux-2.6.x/security/commoncap.c:140:
> >=20
> >    void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
> >    {
> >            /* Derived from fs/exec.c:compute_creds. */
> >            kernel_cap_t new_permitted, working;
> >=20
> >            new_permitted =3D cap_intersect (bprm->cap_permitted, cap_bs=
et);
> >            working =3D cap_intersect (bprm->cap_inheritable,
> >                                     current->cap_inheritable);
> >            new_permitted =3D cap_combine (new_permitted, working);
> >            ...
> >=20
> > Here the new permitted set gets limited to the bits in cap_bset, which
> > is as it should be, but then the intersection of the of the current
> > and exec inheritable masks get added to that set, whereas as I
> > understand it, cap_bset should always be the bounding set.
> [...]
>=20
> Actually going by the faq
> (http://ftp.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4/cap=
faq-0.2.txt)
> it seems like the cap_intersect with current->cap_inheritable is *too*
> limiting.  I haven't checked what the posix draft actually says, but the
> bprm->cap_inheritable is called the 'forced' set, and is supposed to be
> like setuid.

I don't think the force set should be able to override the cap bound
though. Like the force/setuid analogy, I think we can compare the
cap_bset to the old securelevel system, which means that it should be
the bounding factor. Even if you have setuids on a system with a
raised securelevel, they still can't do the restricted operations.

Once again, this is not based on what the POSIX 1003.1e says, as a
matter of fact I can't find anything about lowering the systemwide
bound externally (as opposed to by not having forced-set executables
and dropping the caps from all processes) at all in a quick grep of
the document, so I suspect this is entirely outside of the spec anyway.

--=20
Frank v Waveren                                  Key fingerprint: BDD7 D61E
fvw@var.cx                                              5D39 CF05 4BFC F57A
Public key: hkp://wwwkeys.pgp.net/468D62C8              FA00 7D51 468D 62C8

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEyMuP+gB9UUaNYsgRAjlwAKCKCpPC2o9fYCpUqB9sicNc0Yt8UQCeNbNu
3lZWkw0BJ3P1Fik65RbfjFo=
=5aBN
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
