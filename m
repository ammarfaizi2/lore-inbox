Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbULEUii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbULEUii (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 15:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbULEUii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 15:38:38 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:5857 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261382AbULEUid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 15:38:33 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] Document kfree and vfree NULL usage (resend)
Date: Sun, 5 Dec 2004 15:38:35 -0500
User-Agent: KMail/1.7.1
Cc: Manfred Spraul <manfred@colorfullife.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0412051628280.13644-100000@dbl.q-ag.de> <41B33E70.2000107@colorfullife.com> <1102278101.19406.0.camel@localhost>
In-Reply-To: <1102278101.19406.0.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3913258.50Zdgn5lH8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412051538.42498.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3913258.50Zdgn5lH8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 05 December 2004 03:21 pm, Pekka Enberg wrote:
> On Sun, 2004-12-05 at 17:59 +0100, Manfred Spraul wrote:
> > And you are right: for vfree, it's "must not be called". I'll send a=20
> > separate patch. Or Andrew could just change it directly.
>=20
> Please do it for vunmap() also.
>=20
> 			Pekka
>=20
>=20
Ok. Patch for vfree and vunmap below. Please discard previous patch for kfr=
ee().

Parag

Signed-off-by: Parag Warudkar <kernel-stuff@comcast.net>

=2D-- linux-mod/mm/vmalloc.c.orig 2004-12-05 12:40:50.699631616 -0500
+++ linux-mod/mm/vmalloc.c      2004-12-05 15:33:26.344334328 -0500
@@ -340,7 +340,7 @@ void __vunmap(void *addr, int deallocate
  *     Free the virtually contiguous memory area starting at @addr, as
  *     obtained from vmalloc(), vmalloc_32() or __vmalloc().
  *
=2D *     May not be called in interrupt context.
+ *     Must not be called in interrupt context.
  */
 void vfree(void *addr)
 {
@@ -358,7 +358,7 @@ EXPORT_SYMBOL(vfree);
  *     Free the virtually contiguous memory area starting at @addr,
  *     which was created from the page array passed to vmap().
  *
=2D *     May not be called in interrupt context.
+ *     Must not be called in interrupt context.
  */
 void vunmap(void *addr)
 {

--nextPart3913258.50Zdgn5lH8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBs3HSpDoTEvtc05sRAnujAJ0SYSPqDCIXi7N7s62NrZplnzg2AACgh8bL
6CAWnYK8emPj609+rod2Efo=
=3YLF
-----END PGP SIGNATURE-----

--nextPart3913258.50Zdgn5lH8--
