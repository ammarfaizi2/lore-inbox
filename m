Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUIOPhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUIOPhV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUIOPhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:37:21 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:64722 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266481AbUIOPg6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:36:58 -0400
Date: Wed, 15 Sep 2004 17:35:28 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.8.1/x86] The kernel is _always_ compiled with -msoft-float
Message-ID: <20040915153528.GE24818@thundrix.ch>
References: <20040915021418.A1621@natasha.ward.six>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <20040915021418.A1621@natasha.ward.six>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Wed, Sep 15, 2004 at 02:14:18AM +0600, Denis Zaitsev wrote:
> Why this kernel is always compiled with the FP emulation for x86?
> This is the line from the beginning of arch/i386/Makefile:
>=20
> CFLAGS +=3D -pipe -msoft-float
>=20
> And it's hardcoded, it does not depend on CONFIG_MATH_EMULATION.  So,
> is this just a typo or not?

The problem  is that  the kernel can't  use the  FPU. I think  this is
because  its context  is  not  saved on  context  switch (userland  ->
kernel),  so  we'd end  up  messing up  the  FPU  state, and  userland
applications  would get  silly results  for calculations  with context
switches in between.

Thus  we force gcc  to use  the library  functions for  floating point
arith, and  since we  don't link  against gcc's lib,  FPU users  get a
fancy linker error.

If  you want to  use floating  point arith  inside the  kernel, you're
probably wrong wanting it. If you really need it, you can

a) emulate it using fixed-point math on unsigned long or
b) manually save the FPU state, load your operations into it, operate,
   get the results and restore the FPU state.

I have yet to see someone  who really needs to do floating point maths
inside the kernel.

			    Tonnerre

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBSGE//4bL7ovhw40RAjQ+AJ95LaxvepvOXyLz4fXlulAhR6nBkACeM3I8
J7B0uYaFsdEnXNnyDGSSQIs=
=MI0z
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
