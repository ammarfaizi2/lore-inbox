Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUIEKPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUIEKPi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 06:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbUIEKPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 06:15:38 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:62864 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266519AbUIEKOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 06:14:17 -0400
Message-ID: <413AE6E7.5070103@yahoo.com.au>
Date: Sun, 05 Sep 2004 20:13:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
References: <413AA7B2.4000907@yahoo.com.au> <20040904230210.03fe3c11.davem@davemloft.net> <413AAF49.5070600@yahoo.com.au>
In-Reply-To: <413AAF49.5070600@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> David S. Miller wrote:
> 
>> On Sun, 05 Sep 2004 15:44:18 +1000
>> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>
>>
>>> So my solution? Just teach kswapd and the watermark code about higher
>>> order allocations in a fairly simple way. If pages_low is (say), 1024KB,
>>> we now also require 512KB of order-1 and above pages, 256K of order-2
>>> and up, 128K of order 3, etc. (perhaps we should stop at about order-3?)
>>
>>
>>
>> Whether to stop at order 3 is indeed an interesting question.
>>
>> The reality is that the high-order allocations come mostly from folks
>> using jumbo 9K MTUs on gigabit and faster technologies.  On x86, an
>> order 2 would cover those packet allocations, but on sparc64 for example
>> order 1 would be enough, whereas on a 2K PAGE_SIZE system order 3 would
>> be necessary.
>>
> 
> Yeah I see.
> 

Hmm, and the crowning argument for not stopping at order 3 is that if we
never use higher order allocations, nothing will care about their watermarks
anyway. I think I had myself confused when that question in the first place.

So yeah, stopping at a fixed number isn't required, and as you say it keeps
things general and special cases minimal.
