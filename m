Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268463AbUIPRtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268463AbUIPRtX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268383AbUIPRrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:47:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56962 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268381AbUIPRpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:45:40 -0400
Date: Thu, 16 Sep 2004 19:45:30 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Utz Lehmann <lkml@de.tecosim.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flexmmap: optimise mmap_base gap for hard limited stack
Message-ID: <20040916174529.GA16439@devserv.devel.redhat.com>
References: <20040916165613.GA10825@de.tecosim.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20040916165613.GA10825@de.tecosim.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 16, 2004 at 06:56:13PM +0200, Utz Lehmann wrote:
> Hi
> 
> With the flexmmap memory layout there is at least a 128 MB gap between
> mmap_base and TASK_SIZE. I think this is for the case that a running process
> can expand it's stack soft rlimit.
> 
> If there is a hard limit for the stack this minium gap is just a waste of
> space. This patch reduce the gap to the hard limit + 1 MB hole. If a process
> has a 8192 KB hard limit it have additional 119 MB space available over the
> current behavior.


I'm not so convinced this is the right approach... a bit of room for the
apps to increase their stack sounds useful. (and a "reasonable" amount is
SuS specified afaik, 128Mb is quite reasonable)

 
> And the current implemention has a problem. If the stack soft limit is
> 128+ MB there is no hole between the stack and mmap_base. If there is a
> mapping at mmap_base stack overflows are not detected. The patch made a
> 1MB hole between them.

ack on this part.

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBSdE4xULwo51rQBIRAtKjAJ9edlzP9P1zgrpMXUffl+FDTNVWswCcCumP
vX/sRHkQ8Xd3JnChRKAb8Pg=
=jb8C
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
