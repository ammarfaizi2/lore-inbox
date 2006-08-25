Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWHYFtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWHYFtM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 01:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWHYFtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 01:49:12 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:12187 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750708AbWHYFtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 01:49:11 -0400
Date: Fri, 25 Aug 2006 09:48:15 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [take13 1/3] kevent: Core files.
Message-ID: <20060825054815.GC16504@2ka.mipt.ru>
References: <11563322941645@2ka.mipt.ru> <11563322971212@2ka.mipt.ru> <20060824200322.GA19533@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060824200322.GA19533@infradead.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 25 Aug 2006 09:48:19 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 09:03:22PM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> One question on the implementation of kevent_user_ctl_modify/
> kevent_user_ctl_remove/kevent_user_ctl_add:  What benchmarks did you
> do to add the separate 'fastpath' with the single onstack ukevent
> structure if there are three or less events?  I can't believe this
> actually helps in practice for various reasons:
> 
>  - you add quite a lot of icache footprint by duplicating all this code
>  - kmalloc is really fast
>  - two or three small copy_from/to_user calls are quite a bit slower
>    than one that covers the size of all of them.

kmalloc is really slow actually - it always shows somewhere on top 
in profiles and brings noticeble overhead (as was shown in network tree 
allocator project, although there were used bigger allocations).
I chose 3 ukevents, since they fit exactly one cache line (on my test
machine). In general I try to avoid allocation as much as possible, and
more generic usage case (for various servers) to accept one client and
add it, instead of waiting for several of them and commit them at once.

-- 
	Evgeniy Polyakov
