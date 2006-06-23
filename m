Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWFWRtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWFWRtl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWFWRtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:49:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20965 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751141AbWFWRtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:49:40 -0400
Date: Fri, 23 Jun 2006 10:49:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
In-Reply-To: <Pine.LNX.4.64.0606230759480.19782@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0606231042350.6483@g5.osdl.org>
References: <20060619175243.24655.76005.sendpatchset@lappy> 
 <20060619175253.24655.96323.sendpatchset@lappy> 
 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>
 <1151019590.15744.144.camel@lappy> <Pine.LNX.4.64.0606222305210.6483@g5.osdl.org>
 <Pine.LNX.4.64.0606230759480.19782@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Jun 2006, Hugh Dickins wrote:
> 
> However, I've never understood why it should be fasttracked into
> 2.6.18: we usually let such patchsets cook for a cycle in -mm.
> 2.6.N-rc can get wider exposure than 2.6.(N-1)-mm, reveal problems
> missed all the while in -mm, but a cycle in -mm is still worthwhile.

Well, I've got two reasons to want to fast-track it:

 - it's exactly what I wanted to see, so I'm obviously personally happy 
   with the patch

 - the main _real_ issues I'd expect to surface are some subtle 
   performance issues when the kernel knows about more dirty pages, and 
   the dirty limit is thus _effectively_ different (never mind even the 
   page dirtying throttling itself - just the fact that we count the dirty 
   pages will mean that we'll see different throttling behaviour for 
   regular writes too in the presense of dirty)

Now, the first one is admittedly purely personal, but the second one boils 
down to the fact that I think we want people to use it in order to find 
these problems, and I suspect the -mm users are very uniform: it's 
probably almost exclusively (kernel) developers rather than "normal 
users".

> My pathetically slow responses have hindered Peter's good work, yes,
> but I don't think they've affected the overall appropriate timing.

No, I don't thinkthat has been the problem. I think the patches have 
improved from the feedback from you and others, I just think we're quite 
possible past the point where we simply would be better off with testing 
than with arguing from a source perspective.

But maybe I'm just biased.

> Is there any particular reason why 2.6.18 rather than 2.6.19 be
> the release that fixes this issue that's been around forever?

My main worry has always been the effects of this on some strange load, 
not the stability itself.

> And have we even seen stats for it yet?  We know that it shouldn't
> affect the vast majority of loads (not mapping shared writable), but
> it won't be fixing any problem on them either; and we've had reports
> that it does fix the issue, but at what perf cost? (I may have missed)

_Exactly_. This is why I think earlier rather than later is better. 

Sitting in -mm won't get us any new unexpected load cases - only more of 
the same that hasn't shown any huge flags per se (although the dirty limit 
discussion clearly shows people are at least thinking about it).

		Linus
