Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbUJ0DDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbUJ0DDO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbUJ0DDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:03:14 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:45210 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261618AbUJ0DB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:01:57 -0400
Message-ID: <417F0FA2.4090800@yahoo.com.au>
Date: Wed, 27 Oct 2004 13:01:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
References: <417DCFDD.50606@yahoo.com.au> <Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com> <20041027005425.GO14325@dualathlon.random> <417F025F.5080001@yahoo.com.au> <20041027022920.GS14325@dualathlon.random>
In-Reply-To: <20041027022920.GS14325@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Wed, Oct 27, 2004 at 12:05:19PM +1000, Nick Piggin wrote:
> 
>>Andrea Arcangeli wrote:
>>
>>
>>>the per-classzone kswapd treshold was very well taken care of in 2.4,
>>>thanks the watermarks embedding the low/min/high and the classzone being
>>>passed up to the kswapd wakeup function.
>>>
>>
>>Kswapd actually should take care of this properly: see the
>>initial loop before the real scanning loop.
> 
> 
> I don't see how it can take care of it, if it doesn't even get a wakeup?
> kswapd just sleeps.
> 
> kswapd is just an optimization, we try provide async allocation if the
> kswapd watermarks can it keep up between low and high (and we hang
> synchronosly while hitting the wall at min), so it's not fatal that
> kswapd sleeps, but it can be fixed easily with the patch I just posted
> some minute ago.
> 

See my reply.

> 
>>I thought this was a bit subtle, but it seems to work fine,
>>and Andrew likes it.
>>
>>I have a patch to explicitly have kswapd use the lower zone
>>protection watermarks but I haven't really demonstrated it is
>>better than what is currently there (other than being simpler).
> 

[snip]

> shouldn't we take the full watermarks into account in the above too?
> I think so, otherwise we wakeup but it goes back to sleep, i.e.
> overscheduling but nothing done still, so I'm going to fixup the stop as
> well.
> 

Please don't just yet. I've already got this patch to do it, but
I've got more kswapd work underneath that (which makes kswapd
work properly with higher order allocations).

Currently it does not overschedule, because one zone is always
going to be low by the time kswapd wakes up. This causes all zones
below to be scanned as well.
