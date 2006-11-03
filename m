Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752878AbWKCA25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbWKCA25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 19:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbWKCA25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 19:28:57 -0500
Received: from ozlabs.org ([203.10.76.45]:39102 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1752877AbWKCA25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 19:28:57 -0500
Subject: Re: [PATCH] spufs: always map local store non-guarded
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, cbe-oss-dev <cbe-oss-dev@ozlabs.org>
In-Reply-To: <200611021346.49473.arnd@arndb.de>
References: <200611021346.49473.arnd@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vMd54lCZzLxY/25hzOPt"
Date: Fri, 03 Nov 2006 11:28:54 +1100
Message-Id: <1162513734.8999.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vMd54lCZzLxY/25hzOPt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-02 at 13:46 +0100, Arnd Bergmann wrote:
> When fixing spufs to map the 'mem' file backing store cacheable,
> I incorrectly set the physical mapping to use both cache-inhibited
> and guarded mapping, which resulted in a serious performance
> degradation.
>=20
> Accessing the real local store memory needs to be cache-inhibited,
> in order to maintain data consistency, but since it is actual
> RAM, there is no point in a guarded mapping.
>=20
> Debugged-by: Michael Ellerman <michael@ellerman.id.au>
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> ---

Looks good, cheers

Acked-by: Michael Ellerman <michael@ellerman.id.au>

>=20
> This fixes a regression in 2.6.19, please merge.
>=20
> Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
> +++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
> @@ -104,11 +104,11 @@ spufs_mem_mmap_nopage(struct vm_area_str
> =20
>  	if (ctx->state =3D=3D SPU_STATE_SAVED) {
>  		vma->vm_page_prot =3D __pgprot(pgprot_val(vma->vm_page_prot)
> -					& ~(_PAGE_NO_CACHE | _PAGE_GUARDED));
> +							& ~_PAGE_NO_CACHE);
>  		page =3D vmalloc_to_page(ctx->csa.lscsa->ls + offset);
>  	} else {
>  		vma->vm_page_prot =3D __pgprot(pgprot_val(vma->vm_page_prot)
> -					| _PAGE_NO_CACHE | _PAGE_GUARDED);
> +							| _PAGE_NO_CACHE);
>  		page =3D pfn_to_page((ctx->spu->local_store_phys + offset)
>  				   >> PAGE_SHIFT);
>  	}
--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-vMd54lCZzLxY/25hzOPt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFSo1GdSjSd0sB4dIRApKCAJwJu1pKt4FkpIUdGyOAFwtck02llgCgnz06
f1GwOynbCVGxnxWO7xwVYcs=
=zdse
-----END PGP SIGNATURE-----

--=-vMd54lCZzLxY/25hzOPt--

