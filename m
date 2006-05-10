Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWEJGGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWEJGGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 02:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWEJGGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 02:06:18 -0400
Received: from ozlabs.org ([203.10.76.45]:39829 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964825AbWEJGGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 02:06:17 -0400
Subject: Re: [PATCH] SPARSEMEM + NUMA can't handle unaligned memory regions?
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com
In-Reply-To: <4460A6F3.5060303@shadowen.org>
References: <20060509070343.57853679F2@ozlabs.org>
	 <44609A7B.7010103@shadowen.org>  <4460A6F3.5060303@shadowen.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/FVD241TYDCqr0IjKmXF"
Date: Wed, 10 May 2006 16:06:13 +1000
Message-Id: <1147241173.8091.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/FVD241TYDCqr0IjKmXF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-09 at 15:28 +0100, Andy Whitcroft wrote:
> Andy Whitcroft wrote:
> > 3) record the nid -- when we record the memory present in the system we
> > are passed the nid.
> >=20
> > Somehow the last of these seems the most logical given we have the
> > correct information at the time we record that we need to instantiate
> > the section.  So I had a quick go at something which seems to have come
> > out pretty clean.  Attached is a completly untested patch to show what =
I
> > am proposing.
>=20
> Ok.  Attached is a version which builds and boots.  The patch looks
> pretty simple.  Michael could you give it a spin on the broken machine
> for me.

Hey, it's not broken, it's just special :D

That works a treat, boots and otherwise seems fine.

> Signed-off-by: Andy Whitcroft <apw@shadowen.org>

> +/*
> + * During early boot we need to record the nid from which we will
> + * later allocate the section mem_map.  Encode this into the section
> + * pointer.  Overload the section_mem_map with this information.
> + */
> +static inline unsigned long sparse_encode_early_nid(int nid)
> +{
> +	return (nid << SECTION_MAP_LAST_BIT);
> +}
> +
> +static inline int sparse_early_nid(struct mem_section *section)
> +{
> +	unsigned long nid =3D section->section_mem_map;
> +	return (nid >> SECTION_MAP_LAST_BIT);
> +}

What about just for readability: (in linux/mmzone.h)

#define SECTION_MARKED_PRESENT  (1UL<<0)
#define SECTION_HAS_MEM_MAP     (1UL<<1)
#define SECTION_MAP_LAST_BIT    (1UL<<2)
#define SECTION_NID_SHIFT       SECTION_MAP_LAST_BIT

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-/FVD241TYDCqr0IjKmXF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEYYLVdSjSd0sB4dIRAtz4AKDI1Q8IWCeTXLq5CsIBBjmgw0bChQCbBVZe
xY96ZZfi43TavWK+C8KoFlM=
=Zxbh
-----END PGP SIGNATURE-----

--=-/FVD241TYDCqr0IjKmXF--

