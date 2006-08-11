Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWHKGbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWHKGbI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWHKGbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:31:07 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:50911 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932092AbWHKGbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:31:05 -0400
Date: Fri, 11 Aug 2006 10:30:21 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take6 1/3] kevent: Core files.
Message-ID: <20060811063018.GB11230@2ka.mipt.ru>
References: <11551105602734@2ka.mipt.ru> <20060809152127.481fb346.akpm@osdl.org> <20060810061433.GA4689@2ka.mipt.ru> <20060810001844.ff5e7429.akpm@osdl.org> <20060810075047.GB24370@2ka.mipt.ru> <20060810010254.3b52682f.akpm@osdl.org> <20060810082235.GA21025@2ka.mipt.ru> <20060810175639.b64faaa9.akpm@osdl.org> <20060811061535.GA11230@2ka.mipt.ru> <20060810232340.ab326d3f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060810232340.ab326d3f.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 11 Aug 2006 10:30:29 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 11:23:40PM -0700, Andrew Morton (akpm@osdl.org) wrote:
> On Fri, 11 Aug 2006 10:15:35 +0400
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> > On Thu, Aug 10, 2006 at 05:56:39PM -0700, Andrew Morton (akpm@osdl.org) wrote:
> > > > Per kevent fd.
> > > > I have some ideas about better mmap ring implementation, which would
> > > > dinamically grow it's buffer when events are added and reuse the same
> > > > place for next events, but there are some nitpics unresolved yet.
> > > > Let's not see there in next releases (no merge of course), until better 
> > > > solution is ready. I will change that area when other things are ready.
> > > 
> > > This is not a problem with the mmap interface per-se.  If the proposed
> > > event code permits each user to pin 160MB of kernel memory then that would
> > > be a serious problem.
> > 
> > The main disadvantage is that all memory is allocated on the start even
> > if it will not be used later. I think dynamic grow is appropriate
> > solution, since user will have that memory used anyway, since kevents
> > are allocated, just part of them will be allocated from possibly 
> > mmaped memory.
> 
> But the worst-case remains the same, doesn't it?  160MB of pinned kernel
> memory per user?

Yes. And now I think dynamic growing is not a good solution, since user
can not know when he must call mmap() again to get additional pages
(although I have some hacks to "dynamically" replace previously mmapped
pages with new ones).

This area can be decreased down to 70mb by reducing amount of
information placed into the buffer (only user's data and flags) without
additional hints.

-- 
	Evgeniy Polyakov
