Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757352AbWKWLx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352AbWKWLx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757346AbWKWLx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:53:57 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:29379 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1757341AbWKWLx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:53:56 -0500
Date: Thu, 23 Nov 2006 14:52:41 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
Message-ID: <20061123115240.GA20294@2ka.mipt.ru>
References: <11641265982190@2ka.mipt.ru> <4564E162.8040901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <4564E162.8040901@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 23 Nov 2006 14:52:42 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 03:46:42PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >+ int kevent_wait(int ctl_fd, unsigned int num, __u64 timeout);
> >+
> >+ctl_fd - file descriptor referring to the kevent queue 
> >+num - number of processed kevents 
> >+timeout - this timeout specifies number of nanoseconds to wait until 
> >there is +		free space in kevent queue 
> >+
> >+Return value:
> >+ number of events copied into ring buffer or negative error value.
> 
> This is not quite sufficient.  What we also need is a parameter which 
> specifies which ring buffer the code assumes is currently active.  This 
> is just like the EWOULDBLOCK error in the futex.  I.e., the kernel 
> doesn't move the thread on the wait list if the index has changed. 
> Otherwise asynchronous ring buffer filling is impossible.  Assume this
> 
>     thread                             kernel
> 
>     get current ring buffer idx
> 
>     front and tail pointer the same
> 
>                                        add new entry to ring buffer
> 
>                                        bump front pointer
> 
>     call kevent_wait()
> 
> 
> With the interface above this leads to a deadlock.  The kernel delivered 
> the event and is done with it.

Kernel does not put there a new entry, it is only done inside
kevent_wait(). Entries are put into queue (in any context), where they can be obtained
from only kevent_wait() or kevent_get_events().

-- 
	Evgeniy Polyakov
