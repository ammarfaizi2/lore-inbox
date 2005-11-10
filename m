Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVKJXHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVKJXHc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVKJXHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:07:32 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:21424 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932219AbVKJXHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:07:31 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [RFC, PATCH] Slab counter troubles with swap prefetch?
Date: Fri, 11 Nov 2005 10:07:10 +1100
User-Agent: KMail/1.8.3
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, alokk@calsoftinc.com
References: <Pine.LNX.4.62.0511101351120.16380@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0511101351120.16380@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8791064.sHTDJVpIcL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511111007.12872.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8791064.sHTDJVpIcL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Christoph

On Fri, 11 Nov 2005 08:55, Christoph Lameter wrote:
> Currently the slab allocator uses a page_state counter called nr_slab.
> The VM swap prefetch code assumes that this describes the number of pages
> used on a node by the slab allocator. However, that is not really true.
>
> Currently nr_slab is the number of total pages allocated which may
> be local or remote pages. Remote allocations may artificially inflate
> nr_slab and therefore disable swap prefetching.

Thanks for pointing this out.

> This patch splits the counter into the nr_local_slab which reflects
> slab pages allocated from the local zones (and this number is useful
> at least as a guidance for the VM) and the remotely allocated pages.

How large a contribution is the remote slab size likely to be? Would this=20
information be useful to anyone potentially in future code besides swap=20
prefetch? The nature of prefetch is that this is only a fairly coarse measu=
re=20
of how full the vm is with data we don't want to displace. Thus it is also=
=20
not important that it is very accurate.=20

Unless the remote slab size can be a very large contribution, or having loc=
al=20
and remote slab sizes is useful potentially to some other code I'm inclined=
=20
to say this is unnecessary. A simple comment saying something like "the=20
nr_slab estimation is artificially elevated by remote slab pages on numa,=20
however this contribution is not important to the accuracy of this=20
algorithm". Of course it is nice to be more accurate and if you think=20
worthwhile then we can do this - I'll be happy to be guided by your=20
judgement.

As a side note I doubt any serious size numa hardware will ever be idle eno=
ugh=20
by swap prefetch standards to even start prefetching swap pages. If you thi=
nk=20
hardware of this sort is likely to benefit from swap prefetch then perhaps =
we=20
should look at relaxing the conditions under which prefetching occurs.

Cheers,
Con

--nextPart8791064.sHTDJVpIcL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDc9KgZUg7+tp6mRURAjHTAJ9cGt52v2y+xo3GJ3D/k/cGa/yMEQCghWem
fDtuFSUieo8ZJnAcNd4i53w=
=BmLf
-----END PGP SIGNATURE-----

--nextPart8791064.sHTDJVpIcL--
