Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264955AbUFAJI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbUFAJI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 05:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbUFAJI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 05:08:26 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:53704 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S264955AbUFAJIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 05:08:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: compat syscall args
Date: Tue, 1 Jun 2004 11:07:42 +0200
User-Agent: KMail/1.6.1
References: <20040529122319.49eaafe1.davem@redhat.com> <20040601150633.5f708220.sfr@canb.auug.org.au>
In-Reply-To: <20040601150633.5f708220.sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_hdEvA1+vHo1mU9j";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406011107.46096.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_hdEvA1+vHo1mU9j
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 01 June 2004 07:06, Stephen Rothwell wrote:
> On Sat, 29 May 2004 12:23:19 -0700 "David S. Miller" <davem@redhat.com> w=
rote:
> > I remember discussing this with Andi Kleen before.
>=20
> Yeah, you and Andi and I (and others, I think) had this discussion, but i=
t ended like this:
>=20
> > Subject: Re: [PATCH] Consolidate sys32_utime
> > From: "David S. Miller" <davem@redhat.com>
> >=20
> > So be it, the convention is that all arguments are zero extended from
> > 32-bits to 64-bits when the syscall is invoked.
>=20
> Did something change along the way?

I wasn't aware of the convention but it absolutely makes sense. If I find
the time, I'll go through the existing compat_sys_* handlers to see if they
all do sign-extension correctly. Note that on s390, we also need 31-bit
zero-extension for pointers, which is done in architecture-specific code.
Otherwise every compat_* syscall would need to use compat_uptr_t arguments
which appears unnecessarily ugly to me.

Also, what should be the conversion for positive signed arguments like the
futex 'op' value? Sign-extension would be the formally correct solution,
but simply using the zero-extended value (like we do in most places) works
just as well.

	Arnd <><

--Boundary-02=_hdEvA1+vHo1mU9j
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAvEdh5t5GS2LDRf4RAobMAJ9z0SGlU3deLzHVCKmd6P/PqujVUwCfcBmS
PQyrK+LomsIhya0Bwo1Polg=
=MfWJ
-----END PGP SIGNATURE-----

--Boundary-02=_hdEvA1+vHo1mU9j--
