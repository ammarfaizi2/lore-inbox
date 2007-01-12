Return-Path: <linux-kernel-owner+w=401wt.eu-S1161131AbXALWLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbXALWLu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbXALWLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:11:50 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38667 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161131AbXALWLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:11:49 -0500
Date: Fri, 12 Jan 2007 17:09:09 -0500 (EST)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Chris Mason <chris.mason@oracle.com>, dean gaudet <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
In-Reply-To: <45A8038F.2040609@tls.msk.ru>
Message-ID: <Pine.LNX.4.64.0701121705440.3470@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru>
 <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
 <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org>
 <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org> <20070112202316.GA28400@think.oraclecorp.com>
 <45A7F396.4080600@tls.msk.ru> <45A7F4F2.2080903@tls.msk.ru>
 <45A7F7A7.1080108@tls.msk.ru> <Pine.LNX.4.64.0701121611370.3470@woody.osdl.org>
 <45A8038F.2040609@tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Jan 2007, Michael Tokarev wrote:
> > 
> > At that point, O_DIRECT would be a way of saying "we're going to do 
> > uncached accesses to this pre-allocated file". Which is a half-way 
> > sensible thing to do.
> 
> Half-way?

I suspect a lot of people actually have other reasons to avoid caches. 

For example, the reason to do O_DIRECT may well not be that you want to 
avoid caching per se, but simply because you want to limit page cache 
activity. In which case O_DIRECT "works", but it's really the wrong thing 
to do. We could export other ways to do what people ACTUALLY want, that 
doesn't have the downsides.

For example, the page cache is absolutely required if you want to mmap. 
There's no way you can do O_DIRECT and mmap at the same time and expect 
any kind of sane behaviour. It may not be what a DB wants to use, but it's 
an example of where O_DIRECT really falls down.

> > But what O_DIRECT does right now is _not_ really sensible, and the 
> > O_DIRECT propeller-heads seem to have some problem even admitting that 
> > there _is_ a problem, because they don't care. 
> 
> Well.  In fact, there's NO problems to admit.
> 
> Yes, yes, yes yes - when you think about it from a general point of
> view, and think how non-O_DIRECT and O_DIRECT access fits together,
> it's a complete mess, and you're 100% right it's a mess.

You can't admit that even O_DIRECT _without_ any non-O_DIRECT actually 
fails in many ways right now.

I've already mentioned ftruncate and block allocation. You don't seem to 
understand that those are ALSO a problem.

				Linus
