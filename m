Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVBNNUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVBNNUx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 08:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVBNNUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 08:20:52 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:27155 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261287AbVBNNUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 08:20:40 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       michal@logix.cz, davem@davemloft.net, adam@yggdrasil.com
In-Reply-To: <Xine.LNX.4.44.0502101247390.9159-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0502101247390.9159-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WxlXS/8+Uj35De2n46qh"
Date: Mon, 14 Feb 2005 14:20:34 +0100
Message-Id: <1108387234.8086.37.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WxlXS/8+Uj35De2n46qh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-02-10 at 12:54 -0500, James Morris wrote:

> Making a generic N-way scatterlist processor is pointless
> overengineering, causing new problems with non-trivial solutions, for
> no benefit whatsoever.

I respectfully disagree. I spend the last few days thinking about a
solution about optimally scheduling the constrained number of kmaps. The
number of kmap/kunmaps can easily be reduced by allocating on a
first-come-first-serve base, and keeping a shared kmap for all other.
This is optimal in terms of kmap/kunmaps, but it's not in terms of
memcpy bouncing for fragmented scatterlists.

Now, I found a solution for optimal mapping/remapping to minimize the
bouncing, but in fact it doesn't make sense anymore, because, even
though my algorithm does not enforce any single unnecessary pass over
the scatterlist set, it needs to book-keep too much queues, that their
maintenance causes more work than the memcpy work it tries to prevent.
It only safes work, when the stepsize is irregularly large, like >200
byte. I would have to introduce an artificial threshold level to decide
between memcpy-preventing behavior and the behavior outlined in the last
paragraph.

This is all getting more ugly than the ugliness I'm trying to escape.=20

Conclusion: The idea of high-mem and low-mem seperation is fundamentally
broken. The limitation of page table entries to a fixed set is causing
more complications than it solves. Laziness to do things right at memory
management shifts the burden to the users of the interface.=20

Being disgusted by the highmem interface and the "ungenericness" of my
generic workaround, there is not going to be any update to my LRW work
from my side. This patch set is dead.

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-WxlXS/8+Uj35De2n46qh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCEKWibjN8iSMYtrsRAgs5AJ0SzAyZij3WncKt6dmuhjmRAtt1sACZAYo+
W3TrXsDCkIWTmsT9Vq2TLVA=
=4P4J
-----END PGP SIGNATURE-----

--=-WxlXS/8+Uj35De2n46qh--
