Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161187AbWASOAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbWASOAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 09:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161203AbWASOAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 09:00:47 -0500
Received: from mx1.suse.de ([195.135.220.2]:59778 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161187AbWASOAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 09:00:47 -0500
Date: Thu, 19 Jan 2006 15:00:39 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, David Miller <davem@davemloft.net>
Subject: Re: [patch 0/4] mm: de-skew page refcount
Message-ID: <20060119140039.GA958@wotan.suse.de>
References: <20060118024106.10241.69438.sendpatchset@linux.site> <Pine.LNX.4.64.0601180830520.3240@g5.osdl.org> <20060118170558.GE28418@wotan.suse.de> <Pine.LNX.4.64.0601181122120.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601181122120.3240@g5.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 11:27:13AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 18 Jan 2006, Nick Piggin wrote:
> > 
> > > So I disagree with this patch series. It has real downsides. There's a 
> > > reason we have the offset.
> > 
> > Yes, there is a reason, I detailed it in the changelog and got rid of it.
> 
> And I'm not applying it. I'd be crazy to replace good code by code that is 
> objectively _worse_.
> 

And you're not? Damn.

> The fact that you _document_ that it's worse doesn't make it any better.
> 
> The places that you improve (in the other patches) seem to have nothing at 
> all to do with the counter skew issue, so I don't see the point.
> 

You know, I believe you're right. I needed the de-skewing patch for
something unrelated and it seemed that it opened the possibility for
the following optimisations (ie. because we no longer touch a page
after its refcount goes to zero).

But actually it doesn't matter that we might touch page_count, only
that we not clear PageLRU. So the enabler is simply moving the
TestClearPageLRU after the get_page_testone.

So I'll respin the patches without the de-skewing and the series
will become much smaller and neater.

> So let me repeat: WHY DID YOU MAKE THE CODE WORSE?
> 

You've never bothered me about that until now...

Thanks for the feedback!

Nick
