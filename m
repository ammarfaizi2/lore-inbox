Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966722AbWKTVq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966722AbWKTVq1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966717AbWKTVq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:46:27 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:1962 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966705AbWKTVq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:46:26 -0500
Message-ID: <45622228.80803@garzik.org>
Date: Mon, 20 Nov 2006 16:46:16 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com>
In-Reply-To: <4562102B.5010503@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Evgeniy Polyakov wrote:
>> It is exactly how previous ring buffer (in mapped area though) was
>> implemented.
> 
> Not any of those I saw.  The one I looked at always started again at 
> index 0 to fill the ring buffer.  I'll wait for the next implementation.

I like the two-pointer ring buffer approach, one pointer for the 
consumer and one for the producer.


> You don't want to have a channel like this.  The userlevel code doesn't 
> know which threads are waiting in the kernel on the event queue.  And it 

Agreed.


> You are still completely focused on AIO.  We are talking here about a 
> new generic event handling.  It is not tied to AIO.  We will add all 

Agreed.


> As I said, relative timeouts are unable to cope with settimeofday calls 
> or ntp adjustments.  AIO is certainly usable in situations where 
> timeouts are related to wall clock time.

I think we have lived with relative timeouts for so long, it would be 
unusual to change now.  select(2), poll(2), epoll_wait(2) all take 
relative timeouts.

	Jeff


