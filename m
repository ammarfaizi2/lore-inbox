Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272861AbRIGVtW>; Fri, 7 Sep 2001 17:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272860AbRIGVtO>; Fri, 7 Sep 2001 17:49:14 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:38668 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272857AbRIGVtH>; Fri, 7 Sep 2001 17:49:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        riel@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Defragmentation proposal: preventative maintenance and cleanup [LONG]
Date: Fri, 7 Sep 2001 23:56:33 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <20010907062851Z16136-26184+30@humbolt.nl.linux.org> <1426827386.999856726@[169.254.198.40]>
In-Reply-To: <1426827386.999856726@[169.254.198.40]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010907214921Z16337-26183+212@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 7, 2001 10:58 am, Alex Bligh - linux-kernel wrote:
> Some comments in line - if you are modelling this, vital you
> understand the first!
> 
> >> The buddy allocator will attempt (by looking at lowest order lists first)
> >> to allocate pages from fragmented areas first. Assuming pages are freed
> >> at random, this would act as a defragmentation process. However, if a
> >> system is taken to high utilization and back again to idle, the
> >> dispersion of persistent pages (for instance InactiveDirty pages)
> >> becomes great, and the buddy allocator performs poorly at coalescing
> >> blocks.
> >
> > It becomes effectively useless.  The probability of all 8 pages of a given
> > 8 page unit being free when only 1% of memory is free is (1/100)**8 =
> > 1/(10**16).
> 
> I thought that, then I tested & measured, and it simply isn't true.
> Your mathematical model is wrong.

Yes, a simple thought experiment show this.  Suppose we start with an intial 
state of every second 0 order page allocated.  Now, the next 0 order 
allocation must coalesce to a 1 order unit but the next allocate will come 
from a half-allocated allocated unit.  If we continue randomly in this way, 
allocating one page and freeing one, we will eventually arrive at a state 
where half the pages are in 1 order units and the other half are fully 
allocated.

So, the fragmentation is far from uniformly random.  This is going to require 
deeper analysis.  IMO, it's worth putting in the effort to get a handle on 
this.

--
Daniel
