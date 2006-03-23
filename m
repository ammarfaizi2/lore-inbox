Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422667AbWCWTDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422667AbWCWTDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422668AbWCWTDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:03:52 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:34084 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1422667AbWCWTDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:03:50 -0500
Subject: Re: [PATCH 00/34] mm: Page Replacement Policy Framework
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, iwamoto@valinux.co.jp,
       christoph@lameter.com, wfg@mail.ustc.edu.cn, npiggin@suse.de,
       riel@redhat.com, axboe@suse.de
In-Reply-To: <Pine.LNX.4.64.0603231003390.26286@g5.osdl.org>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
	 <20060322145132.0886f742.akpm@osdl.org> <20060323205324.GA11676@dmt.cnet>
	 <Pine.LNX.4.64.0603231003390.26286@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 20:03:43 +0100
Message-Id: <1143140623.9589.58.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 10:15 -0800, Linus Torvalds wrote:
> 
> On Thu, 23 Mar 2006, Marcelo Tosatti wrote:
> > 
> > IMHO the page replacement framework intent is wider than fixing the     
> > currently known performance problems.
> > 
> > It allows easier implementation of new algorithms, which are being
> > invented/adapted over time as necessity appears.
> 
> Yes and no.
> 
> It smells wonderful for a pluggable page replacement standpoint, but 
> here's a couple of observations/questions:
>  a) the current one actually seems to have beaten the on-comers (except 
>     for loads that were actually made up to try to defeat LRU)
>  b) is page replacement actually a huge issue?
> 
> Now, the reason I ask about (b) is that these days, you buy a Mac Mini, 
> and it comes with half a gig of RAM, and some apple users seem to worry 
> about the fact that the UMA graphics removes 50MB or something of that is 
> a problem.
> 
> IOW, just under half a _gigabyte_ of RAM is apparently considered to be 
> low end, and this is when talking about low-end (modern) hardware!
> 
> And don't tell me that the high-end people care, because both databases 
> (high end commercial) and video/graphics editing (high end desktop) very 
> much do _not_ care, since they tend to try to do their own memory 
> management anyway.

Sure, however there is quite a large group in between. Especially the
desktop users.

For example see this thread:
  http://lkml.org/lkml/2006/3/23/25
where Jens says:
  http://lkml.org/lkml/2006/3/23/39

Typical desktop use cases that hit page-reclaim are things like
burning/copying/unrar'ing dvd images. Also bittorrent can hit the
page-cache quite hard.

Not to mention memory hogs such as Gnome and OpenOffice.

Other things that hit my page-cache are: git, cscope and grep.

> > One example (which I mentioned several times) is power saving:
> > 
> > PB-LRU: A Self-Tuning Power Aware Storage Cache Replacement Algorithm
> > for Conserving Disk Energy.
> 
> Please name a load that really actually hits the page replacement today.
> 
> It smells like university research to me.
> 
> And don't flame me: I'm perfectly happy to be shown to be wrong. I just 
> get a very strong feeling that the people who care about tight memory 
> conditions and perhaps about page replacement are the same people who 
> think that our kernel is too big - the embedded people. And somehow I'm 
> not convinced they want the added abstraction either - they'd probably 
> rather just have a smaller kernel ;)

Well, I for one am not an embedded user, not have any interrests in that
direction.

As for the added abstraction, I find that having abstraction layers is
generaly good - it forces one to think on the concepts involved.
Layering violations become painfully clear.

> What I'm trying to say is that page replacement hasn't been what seems to 
> have worried people over the last year or two. We had some ugly problems 
> in the early 2.4.x timeframe, and I'll claim that most (but not all) of 
> those were related to highmem/zoning issues which we largely solved. Which 
> was about page replacement, but really a very specific issue within that 
> area.

As Rik said, is would be good to have the VM work in more cases.

> So seriously, I suspect Andrew's "Holy cow" comes from the fact that he is 
> more worried about VM maintainability and stability than page replacement. 
> I certainly am.

I can understand this with regard to having more than one policy in the
kernel. However I feel that if the abstraction is maintained, the
stock-kernel could just carry one, preferably CLOCK-Pro. This should
greatly reduce the maintenance burden.

However PB-LRU might be very interresting for laptop users (haven't
looked into that one yet though so just rambling here).

Peter

