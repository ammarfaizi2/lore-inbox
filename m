Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUE1TCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUE1TCu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 15:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUE1TCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:02:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10679 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263802AbUE1TCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:02:47 -0400
Date: Fri, 28 May 2004 21:01:29 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
Message-ID: <20040528190129.GF9898@devserv.devel.redhat.com>
References: <7F740D512C7C1046AB53446D372001730182BB40@scsmsx402.amr.corp.intel.com> <2750000.1085769212@flay> <20040528184411.GE9898@devserv.devel.redhat.com> <4160000.1085770644@flay>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Content-Disposition: inline
In-Reply-To: <4160000.1085770644@flay>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 28, 2004 at 11:57:24AM -0700, Martin J. Bligh wrote:
> >> Here's my start at a list ... I'm sure it's woefully incomplete.
> >> 
> >> 1. Utilize all CPUs roughly evenly for IRQ processing load (anything that's
> >> not measured by the scheduler at least, because it's unfair to other 
> >> processes).
> > 
> > yep; irqbalance approximates irq processing load by irq count, which seems
> > to be ok-ish so far.
> 

> Isn't that exactly what the in-kernel one does though? which people were
> complaining about (wrt network backend (softirq?) processing)? And some
> interrupts are much heavier than others, surely?

irqbalance uses class based balancing to try to balance the "some are
heavier than others" thing. 

>  
> >> Also, we may well have more than 1 CPU's worth of traffic to
> >> process in a large network server.
> > 
> > One NIC? I've yet to see that ;)
> 
> No, multiple NICs. but if I shove 8 gigabit adaptors in a machine, we need
> more than 1 cpu to process it ... 

yeah, and if you have more than 1 cpu, irqbalanced *will* spread them.

> Is there actually any algorithmic difference between the user-space and
> in-kernel ones? or is this just a philosophical debate about user vs kernel
> placement of code? ;-)

the userspace one is quite different and uses different level of information
(for example it makes class groups of irq's, eg it groups all ethernet
irq's, all storage irq's etc in separate classes and uses the class info in
the balancing algorithm). That surely is beyond what you'd want to do inside
the kernel, but it works great ;)



--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAt4yJxULwo51rQBIRAsb6AKCpH7GMkxcklhBlSilY91xhvoZ52ACeJGNi
vHBk3bPDkqaptaXltRjviB4=
=3uHy
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
