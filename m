Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030730AbWKUFiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030730AbWKUFiN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 00:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030728AbWKUFiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 00:38:13 -0500
Received: from ozlabs.org ([203.10.76.45]:48813 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030726AbWKUFiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 00:38:12 -0500
Subject: Re: [PATCH 17/22] coredump: Add SPU elf notes to coredump.
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Arnd Bergmann <arnd@arndb.de>
Cc: cbe-oss-dev@ozlabs.org, linux-arch@vger.kernel.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       Dwayne Grant McConnell <decimal@us.ibm.com>
In-Reply-To: <20061120180526.374170000@arndb.de>
References: <20061120174454.067872000@arndb.de>
	 <20061120180526.374170000@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Di0HqZQDpqqiq6j0IZLF"
Date: Tue, 21 Nov 2006 16:38:08 +1100
Message-Id: <1164087488.13318.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Di0HqZQDpqqiq6j0IZLF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-11-20 at 18:45 +0100, Arnd Bergmann wrote:
> Index: linux-2.6/include/linux/elf.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/elf.h
> +++ linux-2.6/include/linux/elf.h
> @@ -368,5 +368,12 @@ extern Elf64_Dyn _DYNAMIC [];
> =20
>  #endif
> =20
> +#ifndef ARCH_HAVE_EXTRA_ELF_NOTES
> +static inline int arch_notes_size(void) { return 0; }
> +static inline int arch_write_notes(void) { return 0; }
> +
> +#define ELF_CORE_EXTRA_NOTES_SIZE arch_notes_size()
> +#define ELF_CORE_WRITE_EXTRA_NOTES arch_write_notes(file)
> +#endif /* ARCH_HAVE_EXTRA_ELF_NOTES */

This is broken for !CELL. arch_write_notes(void) can't be called as
arch_write_notes(file).

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Di0HqZQDpqqiq6j0IZLF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFYpDAdSjSd0sB4dIRAgdWAKDGO7KacnuOyxm4GKOOMRK/BXJi5gCffc3g
ZycW3TG83/VOlWKCUes4GTA=
=osyr
-----END PGP SIGNATURE-----

--=-Di0HqZQDpqqiq6j0IZLF--

