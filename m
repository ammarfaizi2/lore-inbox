Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUASFTn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 00:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbUASFTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 00:19:43 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:31687 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S264358AbUASFTl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 00:19:41 -0500
Date: Mon, 19 Jan 2004 18:20:45 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: Help port swsusp to ppc.
In-reply-to: <1074483354.10595.5.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hugang <hugang@soulinfo.com>, ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074489645.2111.8.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-rMw8OtQTd2QbnV4N+YGK";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <20040119105237.62a43f65@localhost>
 <1074483354.10595.5.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rMw8OtQTd2QbnV4N+YGK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

I can answer a couple of the questions:

On Mon, 2004-01-19 at 16:35, Benjamin Herrenschmidt wrote:
> What is this file ? It's absolutely horrible....

It should contain the .S equivalent to the swsusp2.c file. It would be
best if swsusp2.c could simply be compiled, but it appears that it can't
at the moment on x86 (I need to learn x86 assembly so I can understand
why).


> >Index: arch/ppc/kernel/vmlinux.lds.S
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >--- arch/ppc/kernel/vmlinux.lds.S	(revision 192)
> >+++ arch/ppc/kernel/vmlinux.lds.S	(working copy)
> >@@ -72,6 +72,12 @@
> >     CONSTRUCTORS
> >   }
> >=20
> >+  . =3D ALIGN(4096);
> >+  __nosave_begin =3D .;
> >+  .data_nosave : { *(.data.nosave) }
> >+  . =3D ALIGN(4096);
> >+  __nosave_end =3D .;
> >+
> >   . =3D ALIGN(32);
> >   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
>=20
> Why do you need the above for ?

That idea is to have a section that doesn't get replaced when we copy
the original kernel back. Thus, small amounts of data that suspend uses
or stores can be given the __nosave attribute. An example is the cpu
frequency value, which should match the boot kernel, not the value at
suspend time.

Regards,

Nigel


--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-rMw8OtQTd2QbnV4N+YGK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAC2ktVfpQGcyBBWkRAt2+AKCj4q1JcUdUVQBpoXgBuTVhwxo2LACfeCjC
h5LFaMcYrDamGxbiSlhAQ6o=
=5X/U
-----END PGP SIGNATURE-----

--=-rMw8OtQTd2QbnV4N+YGK--

