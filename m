Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWEBANs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWEBANs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 20:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWEBANs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 20:13:48 -0400
Received: from ozlabs.org ([203.10.76.45]:172 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751262AbWEBANr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 20:13:47 -0400
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific
	files
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org
In-Reply-To: <445690F7.5050605@am.sony.com>
References: <20060429232812.825714000@localhost.localdomain>
	 <20060429233922.167124000@localhost.localdomain>
	 <F989FA67-91B5-493B-9A12-D02C3C14A984@kernel.crashing.org>
	 <445690F7.5050605@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nY39FS7qB/bu6/mFRtjo"
Date: Tue, 02 May 2006 10:13:28 +1000
Message-Id: <1146528809.27495.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nY39FS7qB/bu6/mFRtjo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-01 at 15:51 -0700, Geoff Levand wrote:
> Segher, a problem with your suggestion is that our
> makefiles don't have as rich a set of logical ops as the
> config files.  Its easy to express 'build A if B', but not
> so easy to do 'build A if not C'.  To make this work
> cleanly I made PPC_CELL denote !SOME_HYPERVISOR_THING,
> so I can have constructions like this in the makefile:
>=20
> obj-$(CONFIG_PPC_CELL)	+=3D ...

Hi Geoff,

I've been ignoring this discussion, but now that I read it I think this
is all kinda backwards.

PPC_CELL should not denote !SOME_HYPERVISOR, it should just mean "basic
cell support", ie. PPC_CELL gets you platforms/cell built in.

Then we can have SOME_HYPERVISOR which _adds_ support for that
hypervisor. And PPC_CELL_BLADE which selects things which are actually
specific to that hardware, like SPIDERNET etc.

But SOME_HYPERVISOR should not remove support for running on bare metal,
it should just give you the option of running on the hypervisor. Yes
that may require testing things at runtime, that's what
firmware_has_feature() is for.

The goal should be that we have one kernel which can boot on all Cell
implementations. In fact the ultimate goal is to have one kernel that
can boot any platform under powerpc, that's a way off still, but we
don't want to start going backwards.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-nY39FS7qB/bu6/mFRtjo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEVqQodSjSd0sB4dIRAtxEAJkBaKgtzuYNyel3Y/d6pa2aoj9KqACfVXo6
GYN82hBz+PqYmf62EOmeI3s=
=uhPV
-----END PGP SIGNATURE-----

--=-nY39FS7qB/bu6/mFRtjo--

