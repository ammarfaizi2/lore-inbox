Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSEHCul>; Tue, 7 May 2002 22:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315490AbSEHCuk>; Tue, 7 May 2002 22:50:40 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15249 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315485AbSEHCuj>;
	Tue, 7 May 2002 22:50:39 -0400
Message-ID: <3CD89247.8ECB01A4@vnet.ibm.com>
Date: Tue, 07 May 2002 21:49:43 -0500
From: Dave Engebretsen <engebret@vnet.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: justincarlson@cmu.edu
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Memory Barrier Definitions
In-Reply-To: <E175BY8-0008S4-00@the-village.bc.nu> <1020809750.13627.24.camel@gs256.sp.cs.cmu.edu>
X-MIMETrack: Itemize by SMTP Server on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/07/2002 09:49:50 PM,
	Serialize by Router on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/07/2002 09:49:52 PM,
	Serialize complete at 05/07/2002 09:49:52 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

justincarlson@cmu.edu wrote:
> 
> On Tue, 2002-05-07 at 16:27, Alan Cox wrote:
> > and our current heirarchy is a little bit more squashed than that. I'd
> > agree. We actually hit a corner case of this on the IDT winchip x86 where
> > we run relaxed store ordering and have to define wmb() as a locked add of
> > zero to the top of stack - which does have a penalty that isnt needed
> > for CPU ordering.
> >
> > How much of this impacts Mips64 ?
> 
> In terms of the MIPS{32|64} ISA, the current primitives seem fine;
> there's only 1 option defined in the ISA:  'sync'.  Order for all
> off-cache accesses is guaranteed around a sync.
> 
> It gets a bit more complicated when you talk about what particular
> implementations do, and ordering rules for uncached vs cached accesses,
> but to the best of my knowledge there aren't any fundamental problems as
> described for the PPC.
> 
> -Justin

PPC also guarantees every ordering when using the 'sync' instruction, so
that will give correctness at the price of a 1000 cycles or so.  You
refer to different rules for cached vs uncached on other implementations
-- that is the essence of our problem.  Are there different barrier
instructions in MIPS which provide different levels of performance for
different ordering enforcements?

Dave.
