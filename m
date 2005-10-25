Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVJYUjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVJYUjX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 16:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVJYUjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 16:39:23 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:34246 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932361AbVJYUjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 16:39:23 -0400
Message-ID: <435E9842.3010604@tmr.com>
Date: Tue, 25 Oct 2005 16:40:34 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>
Subject: Re: 2.6.14-rc5 e1000 and page allocation failures.. still
References: <50tDw-1FH-5@gated-at.bofh.it> <435C2D66.6030708@shaw.ca> <4807377b0510241528m6afc3501w9d98d66658a38973@mail.gmail.com>
In-Reply-To: <4807377b0510241528m6afc3501w9d98d66658a38973@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Brandeburg wrote:
> On 10/23/05, Robert Hancock <hancockr@shaw.ca> wrote:
> 
>>John Bäckstrand wrote:
>>
>>>Im seeing a massive amount of page allocation failures with 2.6.14-rc5,
>>>and also earlier kernels, see "E1000 - page allocation failure - saga
> 
> [snip]
> 
>>It looks like you have enough memory free - the problem is that the
>>driver is allocating a block of memory with order 3, which is 8 pages.
>>Quite likely there are not enough contiguous free pages to satisfy that.
>>
>>That's an awful big buffer size for a packet - I assume you're using
>>jumbo frames or something? Ideally the driver and hardware should be
>>able to allocate a buffer for those packets in multiple chunks, but I
>>have no idea if this is possible.
> 
> 
> the latest e1000 driver (6.2.15) from http://sf.net/projects/e1000
> fixes this by using multiple descriptors for jumbo frames, therefore
> only doing order 0 (single page) page allocations.
> 
> let us know how it goes.
> 
> BTW why is this so much more common with recent kernels?

I don't know why it's more common, but I agree that it seems so. I have 
speculated that it may be related to 4k stack, but I can't even generate 
a credible wild-ass guess on that, much less find any evidence, so I 
doubt that's much if any correlation.

Getting memory a page at a time is ugly, but it will probably work just 
fine.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
