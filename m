Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVACAuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVACAuv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 19:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVACAuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 19:50:51 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:41309 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261368AbVACAtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 19:49:35 -0500
Message-ID: <41D8969B.2030701@yahoo.com.au>
Date: Mon, 03 Jan 2005 11:49:31 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5isms
References: <20041231230624.GA29411@andromeda>	 <41D60C35.9000503@yahoo.com.au> <m1acrt7bqy.fsf@muc.de>	 <41D743BE.3060207@yahoo.com.au> <1104656340.4185.5.camel@laptopd505.fenrus.org>
In-Reply-To: <1104656340.4185.5.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>I'm curious about a couple of points though. First, is that it is basically
>>just adding a cache colouring to the stack, right? In that case why do only
>>older HT CPUs have bad performance without it? And wouldn't it possibly make
>>even non HT CPUs possibly slightly more efficient WRT caching the stacks of
>>multiple processes?
> 
> 
> it's a win on more than older HT cpus. It's just that those suffer it
> the most... (since there you have 2 "cpus" share the cache, meaning you
> get double the aliasing)
> 
> 
> 
>>Second, on what workloads does performance suffer, can you remember? I wonder
>>if natural variations in the stack pointer as the program runs would mitigate
>>the effect of this on all but micro benchmarks?
> 
> 
> one of the problem cases I remember is network daemons all waiting in
> accept() for connections. All from the same codepath basically.
> Randomizing the stackpointer is a gain for that on all cpus that have
> finite affinity on their caches.
> 

I see. Yes, that would be a prime candidate.

> 
> 
>>But even if that were so so, it seems simple enough that I don't have any
>>real problem with keeping it of course.
> 
> 
> The reason my patch does it much more is that it makes it a step harder
> to write exploits for stack buffer overflows. 
> 
> 

Oh yeah I realised that. I just meant specifically the code to do arch
specific stack colouring.

Thanks
Nick
