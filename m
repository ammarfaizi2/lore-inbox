Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbTJPRpn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 13:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTJPRpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 13:45:43 -0400
Received: from waste.org ([209.173.204.2]:11936 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263069AbTJPRpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 13:45:41 -0400
Date: Thu, 16 Oct 2003 12:45:26 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Garzik <jgarzik@pobox.com>,
       Eli Billauer <eli_billauer@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031016174526.GM5725@waste.org>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com> <20031016102020.A7000@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016102020.A7000@schatzie.adilger.int>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 10:20:20AM -0600, Andreas Dilger wrote:
> On Oct 16, 2003  07:29 -0400, Jeff Garzik wrote:
> > Eli Billauer wrote:
> > > I suppose you're asking why having a /dev/frandom device at all. Why not 
> > > let everyone write their own little random generator (based upon 
> > > well-known C functions) whenever random data is needed.
> > > 
> > > There are plenty of handy things in the kernel, that could be done in 
> > > userspace. /dev/zero is my favourite example, but I'm sure there are 
> > > other cases where things were put in the kernel simply because people 
> > > found them handy. Which is a good reason, if you ask me.
> > 
> > This is completely bogus logic.  I can use this (incorrect) argument to 
> > similar push for applications doing bsearch(3) or qsort(3) via a system 
> > call.
> > 
> > When the _implementation_ requires that a piece of code be in-kernel 
> > (for performance or security, usually), it is.
> 
> Actually, there are several applications of low-cost RNG inside the kernel.
> 
> For Lustre we need a low-cost RNG for generating opaque 64-bit handles in
> the kernel.  The use of get_random_bytes() showed up near the top of
> our profiles and we had to invent our own low-cost crappy PRNG instead (it's
> good enough for the time being, but when we start working on real security
> it won't be enough).

Is this SMP? If so, how many processors? I wonder if you might be
running into some lock contention in the pool entropy transfer -
there's a lock held while mixing new samples into a given pool that
could potentially be a hit.

Beyond that, there are a couple small multiples that can be squeezed
out of the extraction path for a total of 5-10x.
 
> The tcp sequence numbers probably do not need to be crypto-secure (I could
> of course be wrong on that ;-)

Indeed you are.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
