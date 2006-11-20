Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934023AbWKTIx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934023AbWKTIx3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 03:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934019AbWKTIx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 03:53:29 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:8644 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S934020AbWKTIx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 03:53:28 -0500
Date: Mon, 20 Nov 2006 11:51:59 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061120085158.GA2816@2ka.mipt.ru>
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <20061120004301.d1815a95.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061120004301.d1815a95.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 20 Nov 2006 11:52:00 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 12:43:01AM -0800, Andrew Morton (akpm@osdl.org) wrote:
> > > >If thread calls kevent_wait() it means it has processed previous entries, 
> > > >one can call kevent_wait() with $num parameter as zero, which
> > > >means that thread does not want any new events, so nothing will be
> > > >copied.
> > > 
> > > This doesn't solve the problem.  You could only request new events when 
> > > all previously reported events are processed.  Plus: how do you report 
> > > events if the you don't allow get_event pass them on?
> > 
> > Userspace should itself maintain order and possibility to get event in
> > this implementation, kernel just returns events which were requested.
> 
> That would mean that in a multithreaded application (or multi-processes
> sharing the same MAP_SHARED ringbuffer), all threads/processes will be
> slowed down to wait for the slowest one.

Not at all - all other threads can call kevent_get_events() with theirs
own place in the ring buffer, so while one of them is processing an
entry, others can fill next entries.

> > > >They all already imeplemented. Just all above, and it was done several
> > > >months ago already. No need to reinvent what is already there.
> > > >Even if we will decide to remove kevent_get_events() in favour of ring
> > > >buffer-only implementation, winting-for-event syscall will be
> > > >essentially kevent_get_events() without pointer to the place where to
> > > >put events.
> > > 
> > > Right, but this limitation of the interface is important.  It means the 
> > > interface of the kernel is smaller: fewer possibilities for problems and 
> > > fewer constraints if in future something should be changed (and smaller 
> > > kernel).
> > 
> > Ok, lets see for ring buffer implementation right now, and then we will
> > decide if we want to remove or to stay with kevent_get_events() syscall.
> 
> I agree that kevent_get_events() is duplicative and we shouldn't need it. 
> Better to concentrate all our development effort on the single and most
> flexible means of delivery.

Let's wait for ring buffer imeplementation first :)

-- 
	Evgeniy Polyakov
