Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314471AbSEHP2i>; Wed, 8 May 2002 11:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314475AbSEHP2h>; Wed, 8 May 2002 11:28:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51419 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314471AbSEHP2f>;
	Wed, 8 May 2002 11:28:35 -0400
Message-ID: <3CD943CE.296717DF@vnet.ibm.com>
Date: Wed, 08 May 2002 10:27:10 -0500
From: Dave Engebretsen <engebret@vnet.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: justincarlson@cmu.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, anton@samba.org, davidm@hpl.hp.com,
        ak@suse.de
Subject: Re: Memory Barrier Definitions
In-Reply-To: <E175BY8-0008S4-00@the-village.bc.nu> <1020809750.13627.24.camel@gs256.sp.cs.cmu.edu> <3CD89247.8ECB01A4@vnet.ibm.com>
X-MIMETrack: Itemize by SMTP Server on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/08/2002 10:27:13 AM,
	Serialize by Router on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/08/2002 10:27:27 AM,
	Serialize complete at 05/08/2002 10:27:27 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Engebretsen wrote:
> 
> justincarlson@cmu.edu wrote:
> >
> > On Tue, 2002-05-07 at 16:27, Alan Cox wrote:
> > > and our current heirarchy is a little bit more squashed than that. I'd
> > > agree. We actually hit a corner case of this on the IDT winchip x86 where
> > > we run relaxed store ordering and have to define wmb() as a locked add of
> > > zero to the top of stack - which does have a penalty that isnt needed
> > > for CPU ordering.
> > >
> > > How much of this impacts Mips64 ?
> >
> > In terms of the MIPS{32|64} ISA, the current primitives seem fine;
> > there's only 1 option defined in the ISA:  'sync'.  Order for all
> > off-cache accesses is guaranteed around a sync.
> >
> > It gets a bit more complicated when you talk about what particular
> > implementations do, and ordering rules for uncached vs cached accesses,
> > but to the best of my knowledge there aren't any fundamental problems as
> > described for the PPC.
> >
> > -Justin

I am curious what the definition of memory barriers is for IA64, Sparc,
and x86-64.  

>From what I can tell, sparc and x86-64 are like alpha and map directly
to the existing mb, wmb, and rmb semantics, incluing ordering between
system memory and I/O space.  Is that an accurate assesment?

IA64 has both the mf and mf.a instructions, one for system memory the
other for I/O space.  What is required for ordering of references
between the spaces?  That is not clear to me looking at the ia64
headers.

Thanks for any input -

Dave.
