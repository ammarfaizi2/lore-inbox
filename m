Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTF0Mqb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 08:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTF0Mqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 08:46:31 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:33664 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264246AbTF0Mq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 08:46:29 -0400
Date: Fri, 27 Jun 2003 14:00:42 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] My research agenda for 2.7
In-Reply-To: <200306270222.27727.phillips@arcor.de>
Message-ID: <Pine.LNX.4.53.0306271345330.14677@skynet>
References: <200306250111.01498.phillips@arcor.de> <200306262100.40707.phillips@arcor.de>
 <Pine.LNX.4.53.0306262030500.5910@skynet> <200306270222.27727.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jun 2003, Daniel Phillips wrote:

> On Thursday 26 June 2003 22:01, Mel Gorman wrote:
> > I think that finding pages like this together is unlikely, especially if
> > the system has been running a long time. In the worst case you will have
> > every easily-moved page adjactent to a near-impossible-to-move page.
>
> I addressed that in my previous post: "Most slab pages are hard to move
> ... we could just tell slab to use its own biggish chunks of memory,
> which it can play in as it sees fit".

Ah, ok, sorry, I missed that but it wouldn't be the first time I missed
something. It was just a few days ago I wrote a pile of material on the
new buddy allocator as part of a publication and still missed that the
order of pages can be identified because of compound pages, thanks Andrew.

> > I also wonder if moving kernel pages is really worth the hassle.
>
> That's the question of course.  The benefit is getting rid of high order
> allocation failures, and gaining some confidence that larger filesystem
> blocksizes will work reliably, however the workload evolves.

I'm still working on 2.6 documentation which I expect will be published in
a few months. When I get that written, I'll look into seeing what can be
done with VM Regress to calculate fragmentation and to see how often do
high order allocations actually fail. It might help determine where
defragging is most needed.

IIRC, Martin J. Bligh had a patch which displayed information about the
buddy allocator freelist so that will probably be the starting point. From
there, it should be handy enough to see how intermixed are kernel page
allocations with user allocations. It might turn out that kernel pages
tend to be clustered together anyway.

> > If order0 pages were in slab, the whole searching problem becomes trivial
> > (just go to the relevant cache and scan the slabs).
>
> You might want to write a separate [rfc] to describe your idea.  For one
> thing, I don't see why you'd want to use slab for that.
>

You're right, I will need to write a proper RFC one way or the other. I
was thinking of using slabs because that way there wouldn't be need to
scan all of mem_map, just a small number of slabs. I have no basis for
this other than hand waving gestures though.

Anyway, as I know I won't be coding any time soon due to writing docs,
I'll shut up for the moment :-)

-- 
Mel Gorman
