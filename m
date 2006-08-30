Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWH3WIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWH3WIf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWH3WIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:08:35 -0400
Received: from adsl-230-146.dsl.uva.nl ([146.50.230.146]:36803 "EHLO
	pan.var.cx") by vger.kernel.org with ESMTP id S1751063AbWH3WIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:08:34 -0400
Date: Thu, 31 Aug 2006 00:08:36 +0200
From: Frank v Waveren <fvw@var.cx>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
Message-ID: <20060830220836.GA21987@var.cx>
References: <1156927468.29250.113.camel@localhost.localdomain> <20060830214441.GA21353@var.cx> <1156975503.29250.220.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <1156975503.29250.220.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2006 at 12:05:02AM +0200, Thomas Gleixner wrote:
> > With this patch, we sleep shorter than specified, and don't signal
> > this in any way. Returning EINVAL for anything except negative tv_sec
> > or invalid tv_nsec breaks the spec too, but I prefer errors to
> > silently sleeping too short.
>=20
> I really don't care whether we sleep 100 or 5000 years in the case of
> "sleep MAX_LONG"
Don't sell your patch short, it still manages nearly 300 years..

> > I'll grant this is more of an aesthetic point than something that'll
> > cause real-world problems (300 years is a long time for any sleep),
> > but if things break I like them to do so as loudly as possible, as a
> > general rule.
>=20
> One thing you ignore is that your patch does not cure the introduced
> user space breakage, it just replaces the overflow caused very short
> sleep by a return -EINVAL, which is breaking existing userspace in a
> different way. We have to preserve user space interfaces even when they
> violate your aesthetic well-being.

The userspace interface gets broken either way. The error might
actually serve as a decent portability wake up call, solaris 64 bit
also silently overflows in nanosleep, and since I've only had the
opportunity to check on solaris and linux, I wouldn't be surprised if
other OSes had the same problem.

--=20
Frank v Waveren                                  Key fingerprint: BDD7 D61E
fvw@var.cx                                              5D39 CF05 4BFC F57A
Public key: hkp://wwwkeys.pgp.net/468D62C8              FA00 7D51 468D 62C8

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFE9gxj+gB9UUaNYsgRAossAJ9slIGcSA1ZYPMVjBPSKBqOpqmdAgCfdncb
2QfC+Ws33vkpZWhf3LxVRIA=
=lkW6
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
