Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVACAos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVACAos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 19:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVACAos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 19:44:48 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:61033 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261354AbVACAop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 19:44:45 -0500
Message-ID: <41D89579.1080801@yahoo.com.au>
Date: Mon, 03 Jan 2005 11:44:41 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.5isms
References: <20041231230624.GA29411@andromeda> <41D60C35.9000503@yahoo.com.au>	<m1acrt7bqy.fsf@muc.de> <41D743BE.3060207@yahoo.com.au> <m1brc882aw.fsf@muc.de>
In-Reply-To: <m1brc882aw.fsf@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> writes:

>>even non HT CPUs possibly slightly more efficient WRT caching the stacks of
>>multiple processes?
> 
> 
> Not on x86 no because they normally have physically indexed caches
> (except for L1, but that is not really preserved over a context switch)
> HT is just a special case because two threads essentially share cache.
> 
> In theory it could help on non x86 CPUs with virtually indexed caches,
> but it is doubtful if they don't need more advanced forms of cache 
> colouring.
> 

That makes sense. I wonder if those architectures may just want to
implement it anyway. If this is such a win here, then it may be low
hanging fruit for those architectures.

But I guess there is something fundamentally a bit different when you
have two processes competing for L1 cache *at the same time*.

> 
>>Second, on what workloads does performance suffer, can you remember? I wonder
>>if natural variations in the stack pointer as the program runs would mitigate
>>the effect of this on all but micro benchmarks?
> 
> 
> iirc on lots of different workloas that run code on both virtual
> CPUs at the same time. Without it you would get L1 cache thrashing,
> which can slow things down quite a lot.
> 
> And yes it made a real difference. The P4 cache have some pecularities
> ("64K aliasing") that made the problem worse.
> 

Interesting, thanks.
