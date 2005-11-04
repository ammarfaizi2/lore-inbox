Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030586AbVKDB1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030586AbVKDB1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbVKDB1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 20:27:05 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:24241 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030573AbVKDB1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 20:27:01 -0500
Date: Fri, 4 Nov 2005 01:26:51 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <Pine.LNX.4.64.0511031704590.27915@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0511040112590.9172@skynet>
References: <4366C559.5090504@yahoo.com.au>
 <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu>
 <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu>
 <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu>
 <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost>
 <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]>
 <4369824E.2020407@yahoo.com.au> <306020000.1131032193@[10.10.2.4]>
 <1131032422.2839.8.camel@laptopd505.fenrus.org>  <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
 <Pine.LNX.4.58.0511031613560.3571@skynet>  <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org>
 <309420000.1131036740@[10.10.2.4]>  <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org>
 <311050000.1131040276@[10.10.2.4]> <1131040786.2839.18.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0511031006550.27915@g5.osdl.org> <312300000.1131041824@[10.1!
 0.2.4]> <436AB241.2030403@yahoo.com.au> <Pine.LNX.4.64.0511031704590.27915@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Linus Torvalds wrote:

>
>
> On Fri, 4 Nov 2005, Nick Piggin wrote:
> >
> > Looks like ppc64 is getting 64K page support, at which point higher
> > order allocations (eg. for stacks) basically disappear don't they?
>
> Yes and no, HOWEVER, nobody sane will ever use 64kB pages on a
> general-purpose machine.
>
> 64kB pages are _only_ usable for databases, nothing else.
>

Very well, but if the infrastructure required to help get 64kB pages still
performs the same, or better, than the current infrastructure that gives
4kB pages, then why not? I am biased obviously and probably optimistic but
I am hoping we have a case here where we get our cake and eat it twice.

> Why? Do the math. Try to cache the whole kernel source tree in 4kB pages
> vs 64kB pages. See how the memory usage goes up by a factor of _four_.
>

I don't know, but I doubt they would use 64kB pages as the default size
unless it is a specialised machine. I could be wrong, I don't have a ppc64
machine, I don't work on a ppc64 machine, I haven't read the architectures
documentation and I didn't write this code for a ppc64 machine. If the
machine here in question it's a specialised machine, they go into the
0.01% category of people, but it's a group that we can still help without
introducing static zones they have to configure.

I'm still waiting on figures that say the approach proposed here is
actually really slow, rather than makes people unhappy slow. If this is
proved to be slow, then I'll admit there is a problem and put more effort
into the plans to use zones instead. I just haven't found a problem on the
machines I have available to me, be it aim9, bench-stresshighalloc or
building kernels (which I think is important considering how often I build
test kernels). If it's a documentation problem with these patches, I'll
write up VM docs on the allocator and submit it as a patch, complete with
downsides and caveats to be fair.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
