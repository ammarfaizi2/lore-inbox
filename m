Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTLBHIL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 02:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTLBHIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 02:08:11 -0500
Received: from coruscant.franken.de ([193.174.159.226]:40678 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S261332AbTLBHIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 02:08:05 -0500
Date: Sun, 30 Nov 2003 21:22:36 +0530
From: Harald Welte <laforge@netfilter.org>
To: Stephen Lee <mukansai@emailplus.org>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Extremely slow network with e1000 & ip_conntrack
Message-ID: <20031130155236.GJ26749@obroa-skai.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Stephen Lee <mukansai@emailplus.org>,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <20031126174943.0AA5.MUKANSAI@emailplus.org> <20031129042551.A460.MUKANSAI@emailplus.org> <20031130074532.0105.MUKANSAI@emailplus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aYrjF+tKt+ApYAdb"
Content-Disposition: inline
In-Reply-To: <20031130074532.0105.MUKANSAI@emailplus.org>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.4.23-pre7-ben0
X-Date: Today is Prickle-Prickle, the 42nd day of The Aftermath in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aYrjF+tKt+ApYAdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2003 at 07:54:15AM +0900, Stephen Lee wrote:
> Stephen Lee <mukansai@emailplus.org> wrote:
> >=20
> > I compiled lots of kernels :-( and narrowed it down to between 2.5.26
> > and 2.5.46.
> >=20
> > Kernel version	Chip		Problem?
> > 2.4.22		82540EM		N
> > 2.5.26		82540EM		N
> > 2.5.46		82540EM		Y
> > 2.6.0-test10		82540EM		Y
> > 2.6.0-test11		82540EM		Y
> > 2.6.0-test11		82547EI		N
> > 2.4.22nptlsmp		82547EI		N
>=20
> I narrowed it down to patch-2.5.44.  e1000 is updated, but I backed out
> the driver to the 2.5.43 version and it didn't fix the problem.=20
> Besides, 2.4.23 has a newer version of the driver and it doesn't have
> this problem.
>=20
> As far as I see netfilter was not updated in that patch, was it? I tried
> insmod -f ip_conntrack.o from 2.5.43 into the 2.5.44 kernel and it
> didn't stop the problem from happening, either.
>=20
> Please advice.  If you don't think this is a netfilter problem I'll go
> check with linux-kernel.

Well, the problem is certainly triggered by connection tracking. =20

If I understood correctly:

1) stock 2.5.43: OK
2) stock 2.5.44: PROBLEM
3) stock 2.5.44 with the driver from 2.5.43: PROBLEM
4) stock 2.5.44 with ip_conntrack.o from 2.5.43: PROBLEM

So it has to be a change outside of the e1000 driver and outside of the
connection tracking code.

Unfortunately I don't have a 2.5.44.patch right here on my notebook atm
(travelling to India). I'll download it at the next opportunity and try
to review which change could be the culprit.

In the meantime, I think taking the discussion back to lkml seems to be
a good idea - since neither e1000 nor ip_conntrack code seem to be the
direct cause of the problem.

> Regards,
> Stephen

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--aYrjF+tKt+ApYAdb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/yhJaXaXGVTD0i/8RAthrAJ9Z1dQHVitb7x91SPJri2W3JTzokQCgqFxL
snhKIDUbpMvZYwd8bG3AfuM=
=q1mI
-----END PGP SIGNATURE-----

--aYrjF+tKt+ApYAdb--
