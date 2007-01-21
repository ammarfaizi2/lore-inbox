Return-Path: <linux-kernel-owner+w=401wt.eu-S1751082AbXAUCPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbXAUCPE (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 21:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbXAUCPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 21:15:03 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:45173 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbXAUCO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 21:14:59 -0500
Date: Sun, 21 Jan 2007 05:14:37 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
Subject: Re: Possible ways of dealing with OOM conditions.
Message-ID: <20070121021436.GA25292@2ka.mipt.ru>
References: <1169122724.6197.50.camel@twins> <20070118135839.GA7075@2ka.mipt.ru> <1169133052.6197.96.camel@twins> <20070118155003.GA6719@2ka.mipt.ru> <1169141513.6197.115.camel@twins> <20070118183430.GA3345@2ka.mipt.ru> <1169211195.6197.143.camel@twins> <20070119225643.GA22728@2ka.mipt.ru> <45B29953.5010505@surriel.com> <20070121014644.GA12070@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20070121014644.GA12070@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 21 Jan 2007 05:14:40 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Jan 20, 2007 at 05:36:03PM -0500, Rik van Riel (riel@surriel.com) wrote:
> > Due to the way everything in the kernel works, you cannot
> > prevent the memory allocator from allocating everything and
> > running out, except maybe by setting aside reserves to deal
> > with special subsystems.

As a technical side gets described, this is exactly the way I proposed -
there is special dedicated pool which does not depend on main system
allocator, so if the latter is empty, the former still _can_ work,
although it is possible that it will be empty too.

Separation. 
It removes avalanche effect when one problem produces several different.

I do not say that some allocator is the best for dealing with such
situation, I just pointed that critical pathes were separated in NTA, so
they do not depend on each one's failure.

Actually that separation was introduced way too long ago with memory
pools, this is some kind of continuation, which adds a lot of additional
extremely useful features.

NTA used for network allocations is that pool, since in real life
packets can not be allocated in advance without memory overhead. For
simple situations like only ACK generatinos it is possible, which I
suggested first, but long-term solution is special allocator.
I selected NTA for this task because it has _additional_ features like
self-deragmentation, which is very useful part for networking, but if
only OOM recovery condition is concerned, then actually any other
allocator can be used of course.

-- 
	Evgeniy Polyakov
