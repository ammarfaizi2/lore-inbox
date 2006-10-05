Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWJEMJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWJEMJf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 08:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWJEMJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 08:09:35 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:6628 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751001AbWJEMJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 08:09:34 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take19 1/4] kevent: Core files.
Date: Thu, 5 Oct 2006 14:09:31 +0200
User-Agent: KMail/1.9.4
Cc: Ulrich Drepper <drepper@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
References: <11587449471424@2ka.mipt.ru> <200610051245.03880.dada1@cosmosbay.com> <20061005105536.GA4838@2ka.mipt.ru>
In-Reply-To: <20061005105536.GA4838@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051409.31826.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 12:55, Evgeniy Polyakov wrote:
> On Thu, Oct 05, 2006 at 12:45:03PM +0200, Eric Dumazet (dada1@cosmosbay.com) 
> >
> > What is missing or not obvious is : If events are skipped because of
> > overflows, What happens ? Connections stuck forever ? Hope that
> > everything will restore itself ? Is kernel able to SIGNAL this problem to
> > user land ?
>
> Exisitng  code does not overflow by design, but can consume a lot of
> memory. I talked about the case, when there will be some limit on
> number of entries put into mapped buffer.

You still dont answer my question. Please answer the question.
Recap : You have a max of XXXX events queued. A network message come and 
kernel want to add another event. It cannot because limit is reached. How the 
User Program knows that this problem was hit ?


> It is the same.
> What if reing buffer was grown upto 3 entry, and is now empty, and we
> need to put there 4 entries? Grow it again?
> It can be done, easily, but it looks like a workaround not as solution.
> And it is highly unlikely that in situation, when there are a lot of
> event, ring can be empty.

I dont speak of re-allocation of ring buffer. I dont care to allocate at 
startup a big enough buffer.

Say you have allocated a ring buffer of 1024*1024 entries.
Then you queue 100 events per second, and dequeue them immediatly.
No need to blindly use all 1024*1024 slots in the ring buffer, doing 
index = (index+1)%(1024*1024)



> epoll() does not have mmap.
> Problem is not about how many events can be put into the kernel, but how
> many of them can be put into mapped buffer.
> There is no problem if mmap is turned off.

So zap mmap() support completely, since it is not usable at all. We wont 
discuss on it.
