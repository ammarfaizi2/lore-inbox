Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUIEGR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUIEGR0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 02:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUIEGR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 02:17:26 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:34231 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266245AbUIEGQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 02:16:58 -0400
Message-ID: <413AAF49.5070600@yahoo.com.au>
Date: Sun, 05 Sep 2004 16:16:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: akpm@osdl.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
References: <413AA7B2.4000907@yahoo.com.au> <20040904230210.03fe3c11.davem@davemloft.net>
In-Reply-To: <20040904230210.03fe3c11.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Sun, 05 Sep 2004 15:44:18 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>So my solution? Just teach kswapd and the watermark code about higher
>>order allocations in a fairly simple way. If pages_low is (say), 1024KB,
>>we now also require 512KB of order-1 and above pages, 256K of order-2
>>and up, 128K of order 3, etc. (perhaps we should stop at about order-3?)
> 
> 
> Whether to stop at order 3 is indeed an interesting question.
> 
> The reality is that the high-order allocations come mostly from folks
> using jumbo 9K MTUs on gigabit and faster technologies.  On x86, an
> order 2 would cover those packet allocations, but on sparc64 for example
> order 1 would be enough, whereas on a 2K PAGE_SIZE system order 3 would
> be necessary.
> 

Yeah I see.

> People using e1000 cards are hitting this case, and some of the e1000
> developers are going to play around with using page array based SKBs
> (via the existing SKB page frags mechanism).  So instead of allocating
> a huge linear chunk for RX packets, they'll allocate a header area of
> 256 bytes then an array of pages to cover the rest.
> 

Yes, I guess that would be ideal from the memory manager's POV.

> Right now, my current suggestion would not be to stop at a certain order.
> 

OK I'll keep it as is and we'll see how that goes. Thanks.
