Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWHRLP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWHRLP2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWHRLP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:15:28 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:49547 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932291AbWHRLP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:15:27 -0400
Date: Fri, 18 Aug 2006 14:59:34 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       tglx@linutronix.de
Subject: Re: [take9 2/2] kevent: poll/select() notifications. Timer notifications.
Message-ID: <20060818105934.GA11034@2ka.mipt.ru>
References: <1155536496588@2ka.mipt.ru> <11555364962857@2ka.mipt.ru> <20060816133014.GB32499@infradead.org> <20060816134032.GB4314@2ka.mipt.ru> <20060818104120.GA20816@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060818104120.GA20816@infradead.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 18 Aug 2006 15:02:38 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 11:41:20AM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> On Wed, Aug 16, 2006 at 05:40:32PM +0400, Evgeniy Polyakov wrote:
> > > What speaks against a patch the recplaces the epoll core by something that
> > > build on kevent while still supporting the epoll interface as a compatibility
> > > shim?
> > 
> > There is no problem from my side, but epoll and kevent_poll differs on
> > some aspects, so it can be better to not replace them for a while.
> 
> Please explain the differences and why they are important.  We really
> shouldn't keep on adding code without beeing able to replace older bits.
> If there's a really good reason we can keep things separate, but
> 
>   "epoll and kevent_poll differs on some aspects"
> 
> is not one :)

kevent_poll uses hash table (actually it is kevent that uses table),
locking is simpler and part of it is hidden in kevent core.
Actually kevent_poll is just a container allocator for poll wait queue.
So epoll does not differ (except hash/tree and locking,
which is based on locks for pathes which are shared in kevent with those
ones which can be called from irq/bh context) from kevent + kevent_poll.
And since kevent_poll can be not selected while epoll is always there
(until embedded config is turned on), I recommend to have them both.
Or always turn kevent on :)

-- 
	Evgeniy Polyakov
