Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268218AbUI2GG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268218AbUI2GG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 02:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUI2GG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 02:06:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:233 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268218AbUI2GFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 02:05:49 -0400
Date: Wed, 29 Sep 2004 08:05:21 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: heap-stack-gap for 2.6
Message-ID: <20040929060521.GA6975@devserv.devel.redhat.com>
References: <20040925162252.GN3309@dualathlon.random> <1096272553.6572.3.camel@laptop.fenrus.com> <20040927130919.GE28865@dualathlon.random> <20040928194351.GC5037@devserv.devel.redhat.com> <20040928221933.GG4084@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20040928221933.GG4084@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 29, 2004 at 12:19:33AM +0200, Andrea Arcangeli wrote:
> On Tue, Sep 28, 2004 at 09:43:51PM +0200, Arjan van de Ven wrote:
> > On Mon, Sep 27, 2004 at 03:09:19PM +0200, Andrea Arcangeli wrote:
> > > > which "those apps" ?
> > > 
> > > those apps that wants to allocate as close as possible to the stack.
> > > They're already using /proc/self/mapped_base, the gap of topdown isn't
> > > configurable.
> > 
> > /proc/self/mmaped_base doesn't exist...
> 
> it does with this patch that should be included in mainline too. This
> follows the redhat API that oracle requires (you invented it, didn't
> you?) so you should be fine with it.

> with mapped base people is free to allocate as much memory as the
> hardware can, with topdown not.

oh? you mean that 1Mb gap between stack and topdown? Every ISV I talked to
said they could get more VA space with topdown than with the suse
mmaped_base hack... :)

> Yeah, map fix is map fixed and when you execute map fixed on a existing
> mapping becaue topdown moved below the 1G mark (a place where there
> could never have been a "hinted" mapping before), the existing mapping
> will be destroyed and the application will behave randomly.

MAP_FIXED is to be used only on things YOU mmaped before. 
> 
> isn't the whole point of topdown to gain ~1G more of RAM. A 1G area that
> couldn't possibly be used before

wrong; brk() is there which is also used by malloc() and internally by the C
library.

> mallocs. topdown breaks that assumption and can break random apps in
> random ways.

do you have proof for that?

 
> Or did I misunderstood something? If topdown still forbids you to use
> the first 1G of address space, then what's the point?!?

You missed that you can only use MAP_FIXED on mmaps YOU mmaped before.
That's true for basically all operating systems because the runtime
(including C library) is allowed to malloc, to brk(), to mmap etc etc.


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBWlCgxULwo51rQBIRAjRvAJ9ow+Zu+Q8rjlriJXTMoDX89rbMJQCdEKOT
xt/YvzGBrZ263hoHQ8CzOQw=
=CtaS
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
