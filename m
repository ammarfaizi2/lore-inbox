Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWHBGoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWHBGoT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 02:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWHBGoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 02:44:19 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:42473 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751121AbWHBGoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 02:44:18 -0400
Date: Wed, 2 Aug 2006 10:43:51 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: zach.brown@oracle.com, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org
Subject: Re: [take2 1/4] kevent: core files.
Message-ID: <20060802064351.GC6378@2ka.mipt.ru>
References: <11544248451203@2ka.mipt.ru> <44CFEA4B.3060200@oracle.com> <20060801.170138.107248641.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060801.170138.107248641.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 02 Aug 2006 10:43:54 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 05:01:38PM -0700, David Miller (davem@davemloft.net) wrote:
> From: Zach Brown <zach.brown@oracle.com>
> Date: Tue, 01 Aug 2006 16:56:59 -0700
> 
> > Even if we only have one syscall with a cmd multiplexer (which I'm not
> > thrilled with), we should at least make these arguments explicit in the
> > system call.  It's weird to hide them in a struct.  We could also think
> > about making them u32 or u64 so that we don't need compat wrappers, but
> > maybe that's overkill.
> 
> I think making the userspace data structure not require any compat
> handling is a must, thanks for pointing this out Zach.

It does not require compat macros, since unsigned int has the same size
on all normal machines where Linux runs, although it can be different.
Anyway, I will replace it with explicit syscall parameters.

> > It'd be great if these struct members could get a prefix (ala: inode ->
> > i_, socket -> sk_) so that it's less painful getting tags helpers to
> > look up instances for us.  Asking for 'lock' is hilarious.
> 
> Agreed.

Heh, it was so much less typing...

> > Hmm.  I think the current preference is not to have a lock per bucket.
> 
> Yes, it loses badly, that's why we undid this in the routing cache
> and just have a fixed sized array of locks which is hashed into.
> 
> For kevents, I think a single spinlock initially is fine and
> if we hit performance problems on SMP we can fix it.  We should
> not implement complexity we have no proof of needing yet :)

Ok, let's see how it will behave.

> > > +#define KEVENT_MAX_REQUESTS		PAGE_SIZE/sizeof(struct kevent)
> > 
> > This is unused?
> 
> It is probably groundwork for the mmap() ring buffer... :)

A lot of work, isn't it? :)

-- 
	Evgeniy Polyakov
