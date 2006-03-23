Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWCWSNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWCWSNu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbWCWSNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:13:50 -0500
Received: from kanga.kvack.org ([66.96.29.28]:25569 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932087AbWCWSNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:13:49 -0500
Date: Thu, 23 Mar 2006 15:13:40 -0600
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, bob.picco@hp.com,
       iwamoto@valinux.co.jp, christoph@lameter.com, wfg@mail.ustc.edu.cn,
       npiggin@suse.de, torvalds@osdl.org, riel@redhat.com
Subject: Re: [PATCH 00/34] mm: Page Replacement Policy Framework
Message-ID: <20060323211340.GB11676@dmt.cnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet> <20060322145132.0886f742.akpm@osdl.org> <44220614.1090101@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44220614.1090101@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Thu, Mar 23, 2006 at 01:21:08PM +1100, Nick Piggin wrote:
> Andrew Morton wrote:
> >Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> >
> >>
> >>This patch-set introduces a page replacement policy framework and 4 new 
> >>experimental policies.
> >
> >
> >Holy cow.
> >
> >
> >>The page replacement algorithm determines which pages to swap out.
> >>The current algorithm has some problems that are increasingly noticable, 
> >>even
> >>on desktop workloads.
> >
> >
> >Rather than replacing the whole lot four times I'd really prefer to see
> >precise descriptions of these problems, see if we can improve the situation
> >incrementally rather than wholesale slash-n-burn...
> >
> 
> The other thing is that a lot of the "policy" stuff you've abstracted
> out is actually low-level "mechanism" stuff that has implications beyond
> page reclaim. Taking a refcount on lru pages, for example.

On "cache pages" you mean :) 

Yes, some low-level mechanisms have also been abstracted away... I think
a nice way to avoid explicit knowledge of page reference acquision at
the moment of candidate selection hasnt been found.

Do you have any suggestions?

> you should be submitting them (eg. patch 25, or patch 1) rather than
> sitting on them and sending them in a huge patchset where they don't
> really belong.

I guess Peter and myself expected folks to criticise and help shape the
API to something acceptable.

BTW, patches 1 and 25 are not crucial improvements for mainline (there's
not much point in having them in mainline), and I don't see any others?

> Some of the API names aren't very nice either. It's great that you want
> to keep the namespace consistent, but it shouldn't be at the expense of
> more descriptive names, and having the page_replace_ prefix itself makes
> many functions read like crap. I'd suggest something like a pgrep_
> prefix and try to make the rest of the name make sense.

"pgrep_" looks more pleasant to me.

> Aside from all that, I'm with Andrew in that problems need to be
> identified first and foremost. 

See my previous message.

> But also I don't like the chances of this
> whole framework flying at all -- Linus vetoed a similar framework for
> sched.c that was actually a reasonable API, with little or no
> consequences outside sched.c. With good reason.

Aren't we talking about very different things here? IMHO there is a lot
of point in allowing pluggable page replacement instead of trying to
make one policy fit all needs (which is obviously impossible).

> Nice work, though :)

Indeed - Peter has done a very nice job.


