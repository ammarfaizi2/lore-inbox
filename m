Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbULJXxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbULJXxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 18:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbULJXxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 18:53:13 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31509 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261880AbULJXxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 18:53:01 -0500
Date: Fri, 10 Dec 2004 23:52:30 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: clameter@sgi.com, <torvalds@osdl.org>, <benh@kernel.crashing.org>,
       <nickpiggin@yahoo.com.au>, <linux-mm@kvack.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
    tests
In-Reply-To: <20041210141258.491f3d48.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0412102346470.521-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > > > (I do wonder why do_anonymous_page calls mark_page_accessed as well as
> > > > lru_cache_add_active.  The other instances of lru_cache_add_active for
> > > > an anonymous page don't mark_page_accessed i.e. SetPageReferenced too,
> > > > why here?  But that's nothing new with your patch, and although you've
> > > > reordered the calls, the final page state is the same as before.)
> 
> The point is a good one - I guess that code is a holdover from earlier
> implementations.
> 
> This is equivalent, no?

Yes, it is equivalent to use SetPageReferenced(page) there instead.
But why is do_anonymous_page adding anything to lru_cache_add_active,
when its other callers leave it at that?  What's special about the
do_anonymous_page case?

Hugh

