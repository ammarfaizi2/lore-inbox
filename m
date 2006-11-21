Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031313AbWKUSwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031313AbWKUSwD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 13:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031310AbWKUSwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 13:52:02 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:20402 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030869AbWKUSwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 13:52:01 -0500
Date: Tue, 21 Nov 2006 21:46:05 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061121184605.GA7787@2ka.mipt.ru>
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061121174334.GA25518@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 21 Nov 2006 21:46:06 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 08:43:34PM +0300, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> > I've explained this multiple times.  The struct sigevent structure needs 
> > to be extended to get a new part in the union.  Something like
> > 
> >   struct {
> >     int kevent_fd;
> >     void *data;
> >   } _sigev_kevent;
> > 
> > Then define SIGEV_KEVENT as a value distinct from the other SIGEV_ 
> > values.  In the code which handles setup of timers (the timer_create 
> > syscall), recognize SIGEV_KEVENT and handle it appropriately.  I.e., 
> > call into the code to register the event source, just like you'd do with 
> > the current interface.  Then add the code to post an event to the event 
> > queue where currently signals would be sent et voilà.
> 
> Ok, I see.
> It is doable and simple.
> I will try to implement it tomorrow.

I've checked the code.
Since it will be a union, it is impossible to use _sigev_thread and it
becomes just SIGEV_SIGNAL case with different delivery mechanism.
Is it what you want?

-- 
	Evgeniy Polyakov
