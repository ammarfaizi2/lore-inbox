Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161149AbWASTxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbWASTxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161368AbWASTxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:53:15 -0500
Received: from mx1.suse.de ([195.135.220.2]:59835 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161149AbWASTxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:53:14 -0500
Date: Thu, 19 Jan 2006 20:53:13 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/6] mm: simplify vmscan vs release refcounting
Message-ID: <20060119195312.GA13887@wotan.suse.de>
References: <20060119192131.11913.27564.sendpatchset@linux.site> <20060119192219.11913.30071.sendpatchset@linux.site> <Pine.LNX.4.64.0601191130590.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601191130590.3240@g5.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 11:35:29AM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 19 Jan 2006, Nick Piggin wrote:
> >
> > The VM has an interesting race where a page refcount can drop to zero, but
> > it is still on the LRU lists for a short time. This was solved by testing
> > a 0->1 refcount transition when picking up pages from the LRU, and dropping
> > the refcount in that case.
> 
> Heh. Now you keep the count offset, but you also end up removing all the 
> comments about it (still) being -1 for free. 
> 
> And your changelog talks about "atomic_inc_not_zero()" even though the 
> code actually does
> 
> 	atomic_add_unless(&page->_count, 1, -1);
> 
> which makes it pretty confusing ;)
> 
> I also think it's wrong - you've changed put_page_testzero() to use 
> "atomic_dec_and_test()", even though the count is based on -1.
> 
> So this patch _only_ works together with the next one, and is invalid in 
> many ways on its own. You should re-split the de-skew part correctly..
> 

Man I'm really happy one of us is awake. Sorry, I'll resend the last two.

Nick
