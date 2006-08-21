Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751873AbWHUL0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbWHUL0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 07:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWHUL0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 07:26:53 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:55231 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751873AbWHUL0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 07:26:52 -0400
Date: Mon, 21 Aug 2006 15:26:10 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       tglx@linutronix.de
Subject: Re: [take9 2/2] kevent: poll/select() notifications. Timer notifications.
Message-ID: <20060821112609.GD8608@2ka.mipt.ru>
References: <1155536496588@2ka.mipt.ru> <11555364962857@2ka.mipt.ru> <20060816133014.GB32499@infradead.org> <20060816134032.GB4314@2ka.mipt.ru> <20060818104120.GA20816@infradead.org> <20060818105934.GA11034@2ka.mipt.ru> <20060821110104.GC28759@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060821110104.GC28759@infradead.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 21 Aug 2006 15:26:11 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 12:01:04PM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> On Fri, Aug 18, 2006 at 02:59:34PM +0400, Evgeniy Polyakov wrote:
> > > If there's a really good reason we can keep things separate, but
> > > 
> > >   "epoll and kevent_poll differs on some aspects"
> > > 
> > > is not one :)
> > 
> > kevent_poll uses hash table (actually it is kevent that uses table),
> > locking is simpler and part of it is hidden in kevent core.
> > Actually kevent_poll is just a container allocator for poll wait queue.
> > So epoll does not differ (except hash/tree and locking,
> > which is based on locks for pathes which are shared in kevent with those
> > ones which can be called from irq/bh context) from kevent + kevent_poll.
> > And since kevent_poll can be not selected while epoll is always there
> > (until embedded config is turned on), I recommend to have them both.
> > Or always turn kevent on :)
> 
> You mention a lot of implementation details that absoultely shouldn't
> matter to the userspace interface.
> 
> I might not have explained enough what the point behind all this is, so
> I'll try to explain it again:
> 
>  - the fate of aio, inotify, epoll, etc shows we badly need a generic
>    event mechnism that unifies event based interfaces of various subsystem.
>    Only having a single mechanisms allows things like unified event loops
>    and gives application progreammers the chance to learn that one interface
>    for real and get it right.
>  - kevent looks like the right way to do this.  but to show it can really
>    archive this it needs to show it can do the things the existing event
>    systems can do at least as good.  reimplementing their user interfaces
>    ontop of kevent is the best (or maybe only) way to show that.
>    epoll is probably the easiest of the ones we have, so I'd suggest starting
>    with it.  inotify will be a lot harder, but we'll need that aswell.
>    the kevent inode hooks you had in your earlier patches will never ever
>    get in.
> 
> Was this clear enough?

Sure, but if I say that it would sound like advertisement :)
Some inotify notifications (inode create/remove) are implemented already
in (dropped) FS notification patchset.

-- 
	Evgeniy Polyakov
