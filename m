Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268730AbUIQNVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268730AbUIQNVu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268734AbUIQNVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:21:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63932 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268730AbUIQNVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:21:30 -0400
Date: Fri, 17 Sep 2004 15:21:20 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Utz Lehmann <lkml@de.tecosim.com>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] flexmmap: optimise mmap_base gap for hard limited stack
Message-ID: <20040917132120.GA3151@devserv.devel.redhat.com>
References: <20040916165613.GA10825@de.tecosim.com> <20040916174529.GA16439@devserv.devel.redhat.com> <20040916182139.GA21870@de.tecosim.com> <4149E46E.7010804@redhat.com> <20040917131829.GA15000@de.tecosim.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20040917131829.GA15000@de.tecosim.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 17, 2004 at 03:18:30PM +0200, Utz Lehmann wrote:
> Ulrich Drepper [drepper@redhat.com] wrote:
> > > A check for CAP_SYS_RESOURCE can be added. But i dont think it's worth.
> > 
> > It is needed.  Otherwise how do you allow increasing the stack size
> > again once it has been limited?  I've no problem with using the smallest
> > reserved stack region with !CAP_SYS_RESOURCE, but otherwise the existing
> > method should be used.
> 
> I made that change. The following patch only reduce the gap when the
> application can not extend the stack space anyway (hard limited stack &&
> !CAP_SYS_RESOURCE). All other cases stay unchanged except for the 1 MB hole
> for soft limited stacks >128 MB.
> 
> It gave a nice way for making most of the default 128 MB gap usable for
> applications. Just run them with a hard stack limit.
> 
> Now i can allocate more than 3.8GiB in one chunk on x86 (this patch +
> exec-shield + 4g/4g + ulimit -H -s 8192).

Ack; nice work!

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBSuTPxULwo51rQBIRAg+fAJ91Bqzs15RaLk3TX26TjT9pAH87HQCcCu6K
UD4Z27+F/GaKRcJR1Ucut74=
=Uqzi
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
