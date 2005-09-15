Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030514AbVIOQXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbVIOQXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030516AbVIOQXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:23:40 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22603
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1030514AbVIOQXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:23:40 -0400
Date: Thu, 15 Sep 2005 18:23:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@novell.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: ptrace can't be transparent on readonly MAP_SHARED
Message-ID: <20050915162347.GC4122@opteron.random>
References: <20050914212405.GD4966@opteron.random> <Pine.LNX.4.61.0509151337260.16231@goblin.wat.veritas.com> <Pine.LNX.4.58.0509150805150.26803@g5.osdl.org> <20050915154702.GA4122@opteron.random> <Pine.LNX.4.58.0509150911180.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509150911180.26803@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 09:13:02AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 15 Sep 2005, Andrea Arcangeli wrote:
> 
> > On Thu, Sep 15, 2005 at 08:12:59AM -0700, Linus Torvalds wrote:
> > > have a PROT_READONLY/PROT_NONE area that is visible from the debugger, but
> > > continues to cause SIGSEGV's if the user process itself tries to access
> > > it. To me, that's good.
> > 
> > Continue to cause sigsegv yes, but on the wrong page, when it will read
> > the page it can contain different data compared to what is on
> > disk/pagecache.
> 
> So? You're not making any sense.

I'll try again: what is the point of still getting page faults on writes
when the first read will contain the wrong data?

And what is the point of writing to a prot_none with ptrace? That really
makes no sense.

I'm not saying the cow should go away, I'm saying that marking the pte
readonly after writing to it makes no sense.

I've said maybe_mkwrite makes no sense, I didn't say the cow makes no
sense.

> I repeat: we CANNOT AVOID the fact that we will do COW.
> 
> That COW is required. No way we can avoid it. It has _nothing_ to do with 
> maybe_mkwrite().
> 
> So I don't know why you continually refuse to just admit that fact. Why do 
> you mix up the COW semantics with the maybe_mkwrite() semantics.
> 
> If you can't argue against maybe_mkwrite() without involving the COW
> argument, then stop arguing. They are two totally different thigns.

I wasn't arguing about that, infact Hugh noticed that I suggested that
avoiding the cow is not an option (he's the one that disagreed with you
on this if something).
