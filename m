Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268159AbUHQINz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268159AbUHQINz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268162AbUHQINr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:13:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50344 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268159AbUHQIMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:12:17 -0400
Date: Tue, 17 Aug 2004 10:11:07 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Jens Maurer <Jens.Maurer@gmx.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use x86 SSE instructions for clear_page, copy_page
Message-ID: <20040817081107.GA12690@devserv.devel.redhat.com>
References: <4121A211.8080902@gmx.net> <1092727670.2792.4.camel@laptop.fenrus.com> <20040817081009.GA806@pazke>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20040817081009.GA806@pazke>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 17, 2004 at 12:10:09PM +0400, Andrey Panin wrote:
> On 230, 08 17, 2004 at 09:27:51AM +0200, Arjan van de Ven wrote:
> > On Tue, 2004-08-17 at 08:13, Jens Maurer wrote:
> > > The attached patch (against kernel 2.6.8.1) enables using SSE
> > > instructions for copy_page and clear_page.
> > > 
> > > A user-space test on my Pentium III 850 MHz shows a 3x speedup for
> > > clear_page (compared to the default "rep stosl"), and a 50% speedup
> > > for copy_page (compared to the default "rep movsl").  For a Pentium-4,
> > > the speedup is about 50% in both the clear_page and copy_page cases.
> > 
> > 
> > we used to have code like this in 2.4 but it got removed: the non
> > temperal store code is faster in a microbenchmark but has the
> > fundamental problem that it evics the data from the cpu cache; the
> > actual USE of the data thus is a LOT more expensive, result is that the
> > overall system performance goes down ;(
> 
> Did SSE clear_page() suffered from this issue too ?

yes especially clear_page; the kernel only calls clear_page when it's *just
about* to use it, so it's actually the worst case example ;(

(and clear_page gains the most because non-temperal stores avoid the write
allocate so it like halves the memory bandwidth)

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBIb2axULwo51rQBIRAhgZAKCQYeUdZ3hW+0/qhk9WEeNLvVHFpwCdFPw+
Qr6IhwQr+ct8BCQ0srrryGU=
=zsyG
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
