Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbULESN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbULESN0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 13:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbULESN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 13:13:26 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:18900 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261320AbULESNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 13:13:18 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] Document kfree and vfree NULL usage (resend)
Date: Sun, 5 Dec 2004 13:12:53 -0500
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
References: <Pine.LNX.4.44.0412051628280.13644-100000@dbl.q-ag.de> <200412051244.36449.kernel-stuff@comcast.net> <41B34C25.3060500@colorfullife.com>
In-Reply-To: <41B34C25.3060500@colorfullife.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10603220.6fNJA1USON";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412051313.22581.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10603220.6fNJA1USON
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ok. So need for changing vmalloc() documentation then.

Here is the same previous patch inline instead of the attachment, with Sign=
ed-off-by -

(Sorry this is my first patch  !)

Parag

Signed-off-by: Parag Warudkar <kernel-stuff@comcast.net>

=2D-- linux-mod/mm/vmalloc.c.orig 2004-12-05 12:40:50.699631616 -0500
+++ linux-mod/mm/vmalloc.c      2004-12-05 12:37:17.279076472 -0500
@@ -340,7 +340,7 @@ void __vunmap(void *addr, int deallocate
  *     Free the virtually contiguous memory area starting at @addr, as
  *     obtained from vmalloc(), vmalloc_32() or __vmalloc().
  *
=2D *     May not be called in interrupt context.
+ *     Must not be called in interrupt context.
  */
 void vfree(void *addr)
 {

On Sunday 05 December 2004 12:57 pm, Manfred Spraul wrote:
> Kernel Stuff wrote:
>=20
> >The attached patch changes the vfree() documentation to correct "May not=
 be=20
> >called in interrupt context" to "Must not be called in interrupt context=
".=20
> >Latter is compliant to  RFC2119 and matches the absolute requirement for=
 =20
> >vfree.
> >
> >Is not the same requirement true for vmalloc() - or is it ok to call vma=
lloc()=20
> >in interrupt?
> >
> > =20
> >
> No, it's not ok.
> But that's not something worth mentioning: only a few functions are=20
> permitted from interrupt context. The special thing about vfree is the=20
> asymmetry: kfree from irq context is ok, vfree is forbidden. That's why=20
> it's documented.
>=20
> --
>     Manfred
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--nextPart10603220.6fNJA1USON
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBs0/CpDoTEvtc05sRAk5NAKDP6MdXQC0PMTdamqhDkcT4O01rXQCgmK3V
PBVUOb9QbGt6h65twcXqWgk=
=niWI
-----END PGP SIGNATURE-----

--nextPart10603220.6fNJA1USON--
