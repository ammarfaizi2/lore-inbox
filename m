Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUAGQk5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUAGQk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:40:57 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:60547 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266218AbUAGQky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:40:54 -0500
Subject: Re: [PATCH] Simplify node/zone field in page->flags
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: colpatch@us.ibm.com
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       mbligh@aracnet.com
In-Reply-To: <3FFB35CE.8020905@us.ibm.com>
References: <3FE74B43.7010407@us.ibm.com>
	 <20031222131126.66bef9a2.akpm@osdl.org> <3FF9D5B1.3080609@us.ibm.com>
	 <20040105213736.GA19859@sgi.com>  <3FF9E64D.5080107@us.ibm.com>
	 <1073345023.6075.357.camel@nosferatu.lan>  <3FFB35CE.8020905@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uhprMP0Unq2n9chrQCRJ"
Message-Id: <1073493823.6075.393.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 07 Jan 2004 18:43:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uhprMP0Unq2n9chrQCRJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-01-07 at 00:25, Matthew Dobson wrote:

> >=20
> > Get this with gcc-3.3.2 cvs:
> >=20
> > --
> > include/linux/mm.h: In function `page_nodenum':
> > include/linux/mm.h:337: warning: right shift count >=3D width of type
> > include/linux/mm.h:337: warning: suggest parentheses around + or -
> > inside shift
> > --
> >=20
> > Think we could get those () in to make it more clear and the compiler
> > happy?
> >=20
> >=20
> > Thanks,
> >=20
>=20
> Figured out what the right shift count message was about.  On UP with=20
> MAX_NODES_SHIFT =3D 0, the node bitfield has no length so the bitshift wa=
s=20
> too far.  Setting MAX_NODES_SHIFT =3D 1 gives the node bitfield a size of=
=20
> 1, and we just store a 0 there for node 0.
>=20
> Updated patch attatched.

Hmm, have smp here:

--
 # grep SMP /usr/src/linux-2.6.1-rc1-bk6/.config
CONFIG_BROKEN_ON_SMP=3Dy
# CONFIG_X86_BIGSMP is not set
CONFIG_SMP=3Dy
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_SMP=3Dy
--

but yes, last patch fixes it!


Thanks,

--=20
Martin Schlemmer

--=-uhprMP0Unq2n9chrQCRJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA//Dc/qburzKaJYLYRArpgAJ9fymbV9CYdQi5vXIMLEd2dckBXRwCfWovt
LuIMfD2XPNJSUHqpCBm/0ic=
=vYTk
-----END PGP SIGNATURE-----

--=-uhprMP0Unq2n9chrQCRJ--

