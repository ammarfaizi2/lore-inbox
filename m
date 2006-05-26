Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWEZJls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWEZJls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 05:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWEZJls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 05:41:48 -0400
Received: from bataysk.donpac.ru ([80.254.111.21]:26072 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S1751361AbWEZJld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 05:41:33 -0400
Date: Fri, 26 May 2006 13:42:04 +0400
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc man page before 2.6.17
Message-ID: <20060526094204.GA31971@pazke.donpac.ru>
Mail-Followup-To: Paul Drynoff <pauldrynoff@gmail.com>,
	Pekka J Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <36e6b2150605260007h1601aa04v31c6c698c6e4d1b9@mail.gmail.com> <84144f020605260017i4682c409vc4a004d016c31270@mail.gmail.com> <36e6b2150605260058h5c1fbc0cla686a37d5bf3e34e@mail.gmail.com> <Pine.LNX.4.58.0605261059360.30386@sbz-30.cs.Helsinki.FI> <36e6b2150605260120s2fb692fegf4fef1eecf7c4674@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <36e6b2150605260120s2fb692fegf4fef1eecf7c4674@mail.gmail.com>
X-Uname: Linux 2.6.8-12-amd64-k8 x86_64
User-Agent: Mutt/1.5.9i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 146, 05 26, 2006 at 12:20:56PM +0400, Paul Drynoff wrote:
> Currently kernel-doc doesn't produce the man page for "kmalloc",

Of course it doesn't. You need to add line

!Iinclude/linux/slab.h

into Documentation/DocBook/kernel-api.tmpl. And BTW you can add comment
for kzalloc() too. Something like this:

/**
 * kzalloc - allocate memory. The memory is set to zero.
 * @size: how many bytes of memory are required.
 * @flags: the type of memory to allocate.
 */

> I think that is a big lack of documentation. This patch should help.
> Now
> scripts/kernel-doc -man -function kmalloc include/linux/slab.h  |
> nroff -man | less
> creates suitable "man page".
>=20
> Signed-off-by: Paul Drynoff <pauldrynoff@gmail.com>
>=20
> ---
>=20
> Index: linux-2.6.17-rc4/mm/slab.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.17-rc4.orig/mm/slab.c
> +++ linux-2.6.17-rc4/mm/slab.c
> @@ -3244,26 +3244,10 @@ EXPORT_SYMBOL(kmalloc_node);
> #endif
>=20
> /**
> - * kmalloc - allocate memory
> + * __do_kmalloc - allocate memory
>  * @size: how many bytes of memory are required.
> - * @flags: the type of memory to allocate.
> + * @flags: the type of memory to allocate(see kmalloc).
>  * @caller: function caller for debug tracking of the caller
> - *
> - * kmalloc is the normal method of allocating memory
> - * in the kernel.
> - *
> - * The @flags argument may be one of:
> - *
> - * %GFP_USER - Allocate memory on behalf of user.  May sleep.
> - *
> - * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
> - *
> - * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handle=
rs.
> - *
> - * Additionally, the %GFP_DMA flag may be set to indicate the memory
> - * must be suitable for DMA.  This can mean different things on different
> - * platforms.  For example, on i386, it means that the memory must come
> - * from the first 16MB.
>  */
> static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
> 					  void *caller)
> Index: linux-2.6.17-rc4/include/linux/slab.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.17-rc4.orig/include/linux/slab.h
> +++ linux-2.6.17-rc4/include/linux/slab.h
> @@ -87,6 +87,27 @@ extern void *__kmalloc_track_caller(size
>     __kmalloc_track_caller(size, flags, __builtin_return_address(0))
> #endif
>=20
> +/**
> + * kmalloc - allocate memory
> + * @size: how many bytes of memory are required.
> + * @gfp: the type of memory to allocate.
> + *
> + * kmalloc is the normal method of allocating memory
> + * in the kernel.
> + *
> + * The @gfp argument may be one of:
> + *
> + * %GFP_USER - Allocate memory on behalf of user.  May sleep.
> + *
> + * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
> + *
> + * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handle=
rs.
> + *
> + * Additionally, the %GFP_DMA flag may be set to indicate the memory
> + * must be suitable for DMA.  This can mean different things on different
> + * platforms.  For example, on i386, it means that the memory must come
> + * from the first 16MB.
> + */
> static inline void *kmalloc(size_t size, gfp_t flags)
> {
> 	if (__builtin_constant_p(size)) {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEds1sPjHNUy6paxMRAocgAJ9lRVXu3nnsPUQgEIRs82INQLyXhQCdEuW5
A4p82ItsL5HbX4Bz1hm+fKY=
=PpAy
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
