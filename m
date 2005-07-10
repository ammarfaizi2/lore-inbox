Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVGJIF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVGJIF1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 04:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVGJIF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 04:05:27 -0400
Received: from mout1.freenet.de ([194.97.50.132]:33229 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261872AbVGJIFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 04:05:08 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6-mm swapped kmalloc args.
Date: Sun, 10 Jul 2005 10:04:42 +0200
User-Agent: KMail/1.8.1
References: <20050709054935.GA9130@redhat.com>
In-Reply-To: <20050709054935.GA9130@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7681047.BLqDnnHbzG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507101004.42774.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7681047.BLqDnnHbzG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Dave Jones <davej@redhat.com>:
> Repeat after me Cris developers..  "Size, then flags."  :-)
>=20
> aacraid suffers the same affliction.  Yay for type-unsafe interfaces.
>=20
> Signed-off-by: Dave Jones <davej@redhat.com>
>=20
>=20
> --- 2.6-mm/arch/cris/arch-v32/mm/intmem.c~	2005-07-09 00:13:54 -04:00
> +++ 2.6-mm/arch/cris/arch-v32/mm/intmem.c	2005-07-09 00:14:48 -04:00
> @@ -28,7 +28,7 @@ static void crisv32_intmem_init(void)
>  	static int initiated =3D 0;
>  	if (!initiated) {
>  		struct intmem_allocation* alloc =3D
> -		  (struct intmem_allocation*)kmalloc(GFP_KERNEL, sizeof *alloc);
> +		  (struct intmem_allocation*)kmalloc(sizeof *alloc, GFP_KERNEL);
>  		INIT_LIST_HEAD(&intmem_allocations);
>  		intmem_virtual =3D ioremap(MEM_INTMEM_START, MEM_INTMEM_SIZE);
>  		initiated =3D 1;
> @@ -57,7 +57,7 @@ void* crisv32_intmem_alloc(unsigned size
>  			if (allocation->size > size + alignment) {
>  				struct intmem_allocation* alloc =3D
>  					(struct intmem_allocation*)
> -					kmalloc(GFP_ATOMIC, sizeof *alloc);
> +					kmalloc(sizeof *alloc, GFP_ATOMIC);
>  				alloc->status =3D STATUS_FREE;
>  				alloc->size =3D allocation->size - size - alignment;
>  				alloc->offset =3D allocation->offset + size;
> @@ -66,7 +66,7 @@ void* crisv32_intmem_alloc(unsigned size
>  				if (alignment) {
>  					struct intmem_allocation* tmp;
>  					tmp =3D (struct intmem_allocation*)
> -						kmalloc(GFP_ATOMIC, sizeof *tmp);
> +						kmalloc(sizeof *tmp, GFP_ATOMIC);

What about also removing these void* to struct intmem_allocation* casts?

=2D-=20
Greetings, Michael



--nextPart7681047.BLqDnnHbzG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC0NaaFGK1OIvVOP4RApRrAKDhkAQxPSwrpN1i+BNyFBjnZtBkQgCfTyom
aJUM/V053ApvFoja+LXGnhA=
=AHJV
-----END PGP SIGNATURE-----

--nextPart7681047.BLqDnnHbzG--
