Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUIERgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUIERgm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 13:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUIERgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 13:36:42 -0400
Received: from jade.spiritone.com ([216.99.193.136]:2796 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266891AbUIERgl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 13:36:41 -0400
Date: Sun, 05 Sep 2004 10:36:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>
cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
Message-ID: <503530000.1094405791@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0409051021290.2331@ppc970.osdl.org>
References: <413AA7B2.4000907@yahoo.com.au> <20040904230210.03fe3c11.davem@davemloft.net><413AAF49.5070600@yahoo.com.au> <413AE6E7.5070103@yahoo.com.au> <Pine.LNX.4.58.0409051021290.2331@ppc970.osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hmm, and the crowning argument for not stopping at order 3 is that if we
>> never use higher order allocations, nothing will care about their watermarks
>> anyway. I think I had myself confused when that question in the first place.
>> 
>> So yeah, stopping at a fixed number isn't required, and as you say it keeps
>> things general and special cases minimal.
> 
> Hey, please refute my "you need 20% free" to get even to order-3 for most
> cases first.
> 
> It's probably acceptable to have a _very_ backgrounded job that does
> freeing if order-3 isn't available, but it had better be pretty
> slow-moving, I suspect. On the order of "It's probably ok to try to aim
> for up to 25% free 'overnight' if the machine is idle" but it's almost
> certainly not ok to aggressively push things out to that degree..

IIRC, the way we free pages is basically random shootdown. We don't even 
attempt to free pages in a contiguous block, so it's unsuprising it doesn't
work. Now we have rmap, we should be able to walk through a block, see if
everything in it looks swappable, and then try to shoot it down. If not,
move onto the next one. I think that'd be a damned sight more likely
to free things up for higher order allocs if they do happen.

M.

