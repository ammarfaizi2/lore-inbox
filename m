Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUKIQ4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUKIQ4K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 11:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbUKIQ4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 11:56:10 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:30731 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261580AbUKIQ4H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 11:56:07 -0500
Date: Tue, 9 Nov 2004 16:56:05 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Antonino Sergi <Antonino.Sergi@roma1.infn.it>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: isa memory address
In-Reply-To: <1100014956.30102.54.camel@delphi.roma1.infn.it>
Message-ID: <Pine.LNX.4.58L.0411091638570.9795@blysk.ds.pg.gda.pl>
References: <1099901664.2718.92.camel@delphi.roma1.infn.it>  <418FA2F1.2090003@osdl.org>
 <1100014956.30102.54.camel@delphi.roma1.infn.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004, Antonino Sergi wrote:

> I looked for iomem with a kernel-2.4.2:
> 
> /proc/iomem reports
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-1fffbfff : System RAM
> 
> Nothing in the region 000d0000-000d0006 (used by my driver),
> so why is it BUSY?

 Because you are trying to use the region in the I/O port space.  That's
probably not what you want to do and an 8-bit ISA board cannot decode it
at all anyway.  Actually for some platforms using the I/O space outside
the low 16-bit range may be quite difficult even for buses and devices
that support it and Linux does not support it then, either.  So Linux 
correctly informs you you cannot use that range.

> > > I'm working with an old data acquisition system that uses an 8-bit card
> > > in an ISA slot (address 0xd0000), by a simple driver I ported from
> > > kernel 1.1.x to 2.2.24.
> > > 
> > > It works fine, but I'd like to have features by newer kernels (2.4 or
> > > even 2.6), like new filesystems support.
> > > 
> > > On kernels >=2.4.0 check_region returns -EBUSY for that address,
> > > but it is not actually used; I tried to understand if something has been
> > > changed/removed, because of obsolescence of devices, in IO management,
> > > but I couldn't.

 Try check_mem_region() instead, ...

> > You might have to dummy up a call to release_resource() first,
> > then use request_resource() to acquire it.

 ... or better yet request_mem_region()/release_resource(), as the former 
is deprecated and will be removed.

  Maciej
