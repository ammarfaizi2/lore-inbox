Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSHIRAY>; Fri, 9 Aug 2002 13:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSHIRAX>; Fri, 9 Aug 2002 13:00:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59666 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315179AbSHIRAX>; Fri, 9 Aug 2002 13:00:23 -0400
Date: Fri, 9 Aug 2002 09:51:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@arcor.de>
cc: frankeh@watson.ibm.com, <davidm@hpl.hp.com>,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <E17dCQa-0001Nv-00@starship>
Message-ID: <Pine.LNX.4.44.0208090949240.1436-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Aug 2002, Daniel Phillips wrote:
> > 
> > Note that even active defrag won't be able to handle the case where you 
> > want have lots of big pages, consituting a large percentage of available 
> > memory.
> 
> Perhaps I'm missing something, but I don't see why.

The statistics are against you. rmap won't help at all with all the other 
kernel allocations, and the dcache/icache is often large, and on big 
machines while there may be tens of thousands of idle entries, there will 
also be hundreds of _non_idle entries that you can't just remove.

> Slab allocations would not have GFP_DEFRAG (I mistakenly wrote GFP_LARGE 
> earlier) and so would be allocated outside ZONE_LARGE.

.. at which poin tyou then get zone balancing problems.

Or we end up with the same kind of special zone that we have _anyway_ in
the current large-page patch, in which case the point of doing this is
what?

		Linus

