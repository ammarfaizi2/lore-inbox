Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTDZIu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 04:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTDZIu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 04:50:58 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:35822 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263861AbTDZIu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 04:50:57 -0400
Subject: Re: Merge with DRI CVS tree: remove stale old context switching
	code and
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@transmeta.com
In-Reply-To: <200304260008.h3Q08gYK005886@hera.kernel.org>
References: <200304260008.h3Q08gYK005886@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-N1vesKew46t/SAXMfqbC"
Organization: Red Hat, Inc.
Message-Id: <1051347784.1421.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 26 Apr 2003 11:03:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-N1vesKew46t/SAXMfqbC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-04-26 at 00:58, Linux Kernel Mailing List wrote:

> =20
>  void *DRM(realloc)(void *oldpt, size_t oldsize, size_t size, int area)
>  {
>  	void *pt;
> =20
> -	if (!(pt =3D DRM(alloc)(size, area))) return NULL;
> +	if (!(pt =3D kmalloc(size, GFP_KERNEL))) return NULL;
>  	if (oldpt && oldsize) {
>  		memcpy(pt, oldpt, oldsize);
> -		DRM(free)(oldpt, oldsize, area);
> +		kfree(oldpt);
>  	}
>  	return pt;
>  }

this looks like buggy code, if you use realloc to shrink the allocation
the memcpy overwrites random memory.




--=-N1vesKew46t/SAXMfqbC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+qktIxULwo51rQBIRAkWxAJ96+Ppq8oKY5DhXXpOMsU9PIplIRgCfW+F3
tKPxeaesgt/Q57yLl7OSdi0=
=OMb0
-----END PGP SIGNATURE-----

--=-N1vesKew46t/SAXMfqbC--
