Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbULKAOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbULKAOf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 19:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbULKAOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 19:14:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:23482 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261876AbULKAOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 19:14:31 -0500
Date: Fri, 10 Dec 2004 16:18:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: clameter@sgi.com, torvalds@osdl.org, benh@kernel.crashing.org,
       nickpiggin@yahoo.com.au, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and
 performance tests
Message-Id: <20041210161835.5b0b0828.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0412102346470.521-100000@localhost.localdomain>
References: <20041210141258.491f3d48.akpm@osdl.org>
	<Pine.LNX.4.44.0412102346470.521-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Fri, 10 Dec 2004, Andrew Morton wrote:
> > Hugh Dickins <hugh@veritas.com> wrote:
> > >
> > > > > (I do wonder why do_anonymous_page calls mark_page_accessed as well as
> > > > > lru_cache_add_active.  The other instances of lru_cache_add_active for
> > > > > an anonymous page don't mark_page_accessed i.e. SetPageReferenced too,
> > > > > why here?  But that's nothing new with your patch, and although you've
> > > > > reordered the calls, the final page state is the same as before.)
> > 
> > The point is a good one - I guess that code is a holdover from earlier
> > implementations.
> > 
> > This is equivalent, no?
> 
> Yes, it is equivalent to use SetPageReferenced(page) there instead.
> But why is do_anonymous_page adding anything to lru_cache_add_active,
> when its other callers leave it at that?  What's special about the
> do_anonymous_page case?

do_swap_page() is effectively doing the same as do_anonymous_page(). 
do_wp_page() and do_no_page() appear to be errant.
