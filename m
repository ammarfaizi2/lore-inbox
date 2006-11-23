Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757358AbWKWMZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358AbWKWMZZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 07:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757359AbWKWMZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 07:25:24 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:28838 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1757358AbWKWMZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 07:25:22 -0500
Date: Thu, 23 Nov 2006 15:22:25 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061123122225.GD20294@2ka.mipt.ru>
References: <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <4563FD53.7030307@redhat.com> <20061122120933.GA32681@2ka.mipt.ru> <20061122121516.GA7229@2ka.mipt.ru> <4564CE00.9030904@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4564CE00.9030904@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 23 Nov 2006 15:22:28 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 02:24:00PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >On Wed, Nov 22, 2006 at 03:09:34PM +0300, Evgeniy Polyakov 
> >(johnpol@2ka.mipt.ru) wrote:
> >>Ok, to solve the problem in the way which should be good for both I
> >>decided to implement additional syscall which will allow to mark any
> >>event as ready and thus wake up appropriate threads. If userspace will
> >>request zero events to be marked as ready, syscall will just
> >>interrupt/wakeup one of the listeners parked in syscall.
> 
> I'll wait for the new code drop to comment.

I posted it.
 
> >Btw, what about putting aditional multiplexer into add/remove/modify
> >switch? There will be logical 'ready' addon?
> 
> Is it needed?  Usually this is done with a *_wait call with a timeout of 
> zero.  That code path might have to be optimized but it should already 
> be there.

It does not allow to mark events as ready.
And current interfaces wake up when either timeout is zero (in this case
thread itself does not sleep and can process events), or when there is
_new_ work - since there is no _new_ work, when thread awakened to
process it was killed, kernel does not think that something is wrong.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
