Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbVH0MHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbVH0MHX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 08:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbVH0MHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 08:07:23 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:10965 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1030366AbVH0MHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 08:07:19 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: David =?iso-8859-1?q?H=E4rdeman?= <david@2gen.com>
Subject: Re: [PATCH] Use sg_init_one where appropriate
Date: Sat, 27 Aug 2005 14:06:26 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050827003340.GB9222@hansolo>
In-Reply-To: <20050827003340.GB9222@hansolo>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1735087.2S8L9oUP2N";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508271406.32111.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1735087.2S8L9oUP2N
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi David,

I appreciate your work on unifying common code, but have some comments.

On Saturday 27 August 2005 02:33, David H=E4rdeman wrote:
> The same code as in sg_init_one can be found in a number of places, this=
=20
> patch changes them to call the function instead.
> Index: linux-sginitone/include/linux/scatterlist.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sginitone.orig/include/linux/scatterlist.h	2005-03-02 08:38:32.=
000000000 +0100
> +++ linux-sginitone/include/linux/scatterlist.h	2005-08-27 00:20:53.00000=
0000 +0200
> @@ -1,8 +1,9 @@
>  #ifndef _LINUX_SCATTERLIST_H
>  #define _LINUX_SCATTERLIST_H
> =20
> -static inline void sg_init_one(struct scatterlist *sg,
> -			       u8 *buf, unsigned int buflen)
> +static inline void sg_init_one(const struct scatterlist *sg,
> +			       const u8 *buf,
> +			       const unsigned int buflen)
>  {
>  	memset(sg, 0, sizeof(*sg));
> =20

In short: please remove all "const" markers from the function,=20
	try to uninline it somewhere and resend.

Explanation:

If this compiles without any warning, then your compiler is clearly broken.

You promise to not modify the memory pointed to by "sg" and set it
to zero then?

You also assign buflen to a variable, which voids the "const" attribute
anyway. For "buf" this is also wrong. The memory pointed to it
will be assigned to a variable whose modification you cannot control.

And while you are at it, please check, wether this can be uninlined,
since it does a lot of things and is called from quite some sites
then.


Regards

Ingo Oeser



--nextPart1735087.2S8L9oUP2N
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDEFdIU56oYWuOrkARAstVAJkBk2lG2L1nTyaz3I2ezV7YrjOo5wCg2PcX
jCKrnquUAXmqkYy01YnmQJI=
=UiTa
-----END PGP SIGNATURE-----

--nextPart1735087.2S8L9oUP2N--
