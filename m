Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933321AbWKXQuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933321AbWKXQuL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 11:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934472AbWKXQuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 11:50:10 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:35040 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S933321AbWKXQuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 11:50:08 -0500
Date: Fri, 24 Nov 2006 19:49:16 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
Message-ID: <20061124164916.GA4012@2ka.mipt.ru>
References: <11641265982190@2ka.mipt.ru> <4564E2AB.1020202@redhat.com> <20061123115504.GB20294@2ka.mipt.ru> <4565FDED.2050003@redhat.com> <20061124114614.GA32545@2ka.mipt.ru> <45671E16.6060005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <45671E16.6060005@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 24 Nov 2006 19:49:21 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 08:30:14AM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >>Very much simplified but it should show that we need a writable copy of 
> >>the uidx.  And this value at any time must be consistent with the index 
> >>the kernel assumes.
> >
> >I seriously doubt it is simpler than having index provided by kernel.
> 
> What has simpler to do with it?  The userlevel code should not modify 
> the ring buffer structure at all.  If we'd do this then all operations, 
> at least on the uidx field, would have to be atomic operations.  This is 
> currently not the case for the kernel side since it's protected by a 
> lock for the event queue.  Using the uidx field from userlevel would 
> therefore just make things slower.

That index is provided by kernel for userspace so that userspace could
determine where indexes are - of course userspace can maintain it
itself, but it can also use provided by kernel. It is not written
explicitly, but only through kevent_commit().

> And for what?  Changing the uidx value would make the commit syscall 
> unnecessary.  This might be an argument but it sounds too dangerous. 
> IMO the value should be protected by the kernel.
> 
> And in any case, the uidx value cannot be updated until the event 
> actually has been processed.  But the threads still need to coordinate 
> distributing the events from the ring buffer amongst themselves.  This 
> will in any case require a second variable.
> 
> So, if you want to do away with the commit syscall, keep the uidx value. 
>  This also requires that the ring buffer head will always be writable 
> (something I'd like to avoid making part of the interface but I'm 
> flexible on this).  Otherwise, the ring_uidx element can go away, it's 
> not needed and will only make people think about wrong approaches to use it.

No, head will not be writeable - it is absolutely.

I do not care actually about that index, but as you have probably noticed, 
there was such an interface already, and I changed it. So, this will be the 
last change of the interface. You think it should not be exported -
fine, it will not be.

-- 
	Evgeniy Polyakov
