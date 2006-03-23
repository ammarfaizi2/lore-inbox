Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbWCWSQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbWCWSQb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWCWSQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:16:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:924 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422643AbWCWSQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:16:30 -0500
Date: Thu, 23 Mar 2006 10:15:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, bob.picco@hp.com,
       iwamoto@valinux.co.jp, christoph@lameter.com, wfg@mail.ustc.edu.cn,
       npiggin@suse.de, riel@redhat.com
Subject: Re: [PATCH 00/34] mm: Page Replacement Policy Framework
In-Reply-To: <20060323205324.GA11676@dmt.cnet>
Message-ID: <Pine.LNX.4.64.0603231003390.26286@g5.osdl.org>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
 <20060322145132.0886f742.akpm@osdl.org> <20060323205324.GA11676@dmt.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Mar 2006, Marcelo Tosatti wrote:
> 
> IMHO the page replacement framework intent is wider than fixing the     
> currently known performance problems.
> 
> It allows easier implementation of new algorithms, which are being
> invented/adapted over time as necessity appears.

Yes and no.

It smells wonderful for a pluggable page replacement standpoint, but 
here's a couple of observations/questions:
 a) the current one actually seems to have beaten the on-comers (except 
    for loads that were actually made up to try to defeat LRU)
 b) is page replacement actually a huge issue?

Now, the reason I ask about (b) is that these days, you buy a Mac Mini, 
and it comes with half a gig of RAM, and some apple users seem to worry 
about the fact that the UMA graphics removes 50MB or something of that is 
a problem.

IOW, just under half a _gigabyte_ of RAM is apparently considered to be 
low end, and this is when talking about low-end (modern) hardware!

And don't tell me that the high-end people care, because both databases 
(high end commercial) and video/graphics editing (high end desktop) very 
much do _not_ care, since they tend to try to do their own memory 
management anyway.

> One example (which I mentioned several times) is power saving:
> 
> PB-LRU: A Self-Tuning Power Aware Storage Cache Replacement Algorithm
> for Conserving Disk Energy.

Please name a load that really actually hits the page replacement today.

It smells like university research to me.

And don't flame me: I'm perfectly happy to be shown to be wrong. I just 
get a very strong feeling that the people who care about tight memory 
conditions and perhaps about page replacement are the same people who 
think that our kernel is too big - the embedded people. And somehow I'm 
not convinced they want the added abstraction either - they'd probably 
rather just have a smaller kernel ;)

What I'm trying to say is that page replacement hasn't been what seems to 
have worried people over the last year or two. We had some ugly problems 
in the early 2.4.x timeframe, and I'll claim that most (but not all) of 
those were related to highmem/zoning issues which we largely solved. Which 
was about page replacement, but really a very specific issue within that 
area.

So seriously, I suspect Andrew's "Holy cow" comes from the fact that he is 
more worried about VM maintainability and stability than page replacement. 
I certainly am.

		Linus
