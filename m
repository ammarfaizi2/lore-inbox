Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268541AbUIXIMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268541AbUIXIMV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 04:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268544AbUIXIMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 04:12:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27285 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268541AbUIXIMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 04:12:08 -0400
Date: Fri, 24 Sep 2004 10:11:46 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Martin Diehl <lists@mdiehl.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2: devmem_is_allowed
Message-ID: <20040924081145.GA16455@devserv.devel.redhat.com>
References: <1096008029.2612.37.camel@laptop.fenrus.com> <Pine.LNX.4.44.0409240947230.14340-100000@notebook.home.mdiehl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409240947230.14340-100000@notebook.home.mdiehl.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Fri, Sep 24, 2004 at 10:09:40AM +0200, Martin Diehl wrote:
> On Fri, 24 Sep 2004, Arjan van de Ven wrote:
> 
> > On Fri, 2004-09-24 at 00:37, Martin Diehl wrote:
> > > Hi,
> > > 
> > > after switching from working 2.6.9-rc2 to -mm2, X refused to start on my 
> > > testbox. It turned out this was because it failed (EPERM) reading from 
> > > /dev/mem beyond the 1MB limit.
> > 
> > can you get me a strace of the failing X server?
> > The code as is is as designed; X has no business messing with kernel ram
> > over 1Mb, there is nothing there for it to (ab)use.
> > (There is PCI memory much higher up but that is allowed again)
> 
> See below. I've reduced it to show the critical parts (AFAICS). Please 
> tell me if I shall mail you the whole unmodified strace -f output from 
> startx.

this looks good already; I'll investigate this further

> It looks like it is scanning /dev/mem page-by-page for some reason trying 
> to get or identify some 512 page mapping. If /dev/mem does not return 
> EPERM after 1MB (i.e. with my patch applied), it scans the whole 192MB of 
> physical memory in the box entirely before it continues.

WHAT? WHY?

> Btw, if reading from /dev/mem is intended to fail above 1MB, it seems 
> there might be an off-by-one somewhere, because the read starting at
> 1048576 (=1024 x 1024) below succeeds. I.e. the first page failing the 
> read is page 257 on zero-based page counting, not 256.

the first page after 1Mb is "magic" for some bioses so this was deliberate

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBU9bBxULwo51rQBIRAp4tAJ9d/Ys+q/A52mc+s/fceTSxn03MGACdG15J
kcmVaDm8J5FMMo1EybWPrKI=
=x1Kf
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
