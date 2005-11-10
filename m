Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVKJXR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVKJXR6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVKJXR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:17:58 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:38791 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932251AbVKJXR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:17:57 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [RFC, PATCH] Slab counter troubles with swap prefetch?
Date: Fri, 11 Nov 2005 10:17:43 +1100
User-Agent: KMail/1.8.3
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, alokk@calsoftinc.com
References: <Pine.LNX.4.62.0511101351120.16380@schroedinger.engr.sgi.com> <200511111007.12872.kernel@kolivas.org> <Pine.LNX.4.62.0511101510240.16588@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0511101510240.16588@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4256919.Ma4ohFZ1R0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511111017.45505.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4256919.Ma4ohFZ1R0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 11 Nov 2005 10:13, Christoph Lameter wrote:
> On Fri, 11 Nov 2005, Con Kolivas wrote:
> > > This patch splits the counter into the nr_local_slab which reflects
> > > slab pages allocated from the local zones (and this number is useful
> > > at least as a guidance for the VM) and the remotely allocated pages.
> >
> > How large a contribution is the remote slab size likely to be? Would th=
is
> > information be useful to anyone potentially in future code besides swap
> > prefetch? The nature of prefetch is that this is only a fairly coarse
> > measure of how full the vm is with data we don't want to displace. Thus
> > it is also not important that it is very accurate.
>
> The size of the remote cache depends on many factors. The application can
> influence that by setting memory policies.
>
> > Unless the remote slab size can be a very large contribution, or having
> > local
>
> Yes it can be quite large. On some of my tests with applications these are
> 100%. This is typical if the application sets the policy in such a way
> that all allocations are off node or if the kernel has to allocate memory
> on a certain node for a device.

Great. Thanks for the information, and I prefer to see this patch in on tha=
t=20
basis.

> > As a side note I doubt any serious size numa hardware will ever be idle
> > enough by swap prefetch standards to even start prefetching swap pages.
> > If you think hardware of this sort is likely to benefit from swap
> > prefetch then perhaps we should look at relaxing the conditions under
> > which prefetching occurs.
>
> Small scale NUMA machines may benefit from swap prefetch but on larger
> machines people usually try to avoid swap altogether.

Then I won't alter the when-to-prefetch algorithm.

Thanks!
Con

--nextPart4256919.Ma4ohFZ1R0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDc9UZZUg7+tp6mRURAu+xAJ9jTpmLOBogQTWlRmUKWKCM3Fvs5QCffDo4
XCFR4ObZY5oBF0rMTtNg/Ik=
=nyfd
-----END PGP SIGNATURE-----

--nextPart4256919.Ma4ohFZ1R0--
