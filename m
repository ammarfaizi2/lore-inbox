Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263519AbUC3IyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 03:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUC3IyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 03:54:18 -0500
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:58242 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263519AbUC3IyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 03:54:15 -0500
Message-ID: <406935A6.4030203@yahoo.com.au>
Date: Tue, 30 Mar 2004 18:53:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@suse.de>,
       jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
References: <20040329080150.4b8fd8ef.ak@suse.de> <20040329114635.GA30093@elte.hu> <20040329221434.4602e062.ak@suse.de> <4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de> <40691BCE.2010302@yahoo.com.au> <205870000.1080630837@[10.10.2.4]> <4069223E.9060609@yahoo.com.au> <20040330080530.GA22195@elte.hu> <40692D95.8030605@yahoo.com.au> <20040330084501.GA23069@elte.hu>
In-Reply-To: <20040330084501.GA23069@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>You're probably mostly right, but I really don't know if I'd start
>>with the assumption that threads don't share anything. I think they're
>>very likely to share memory and cache.
> 
> 
> it all depends on the workload i guess, but generally if the application
> scales well then the threads only share data in a read-mostly manner -
> hence we can balance at creation time.
> 
> if the application does not scale well then balancing too early cannot
> make the app perform much worse.
> 
> things like JVMs tend to want good balancing - they really are userspace
> simulations of separate contexts with little sharing and good overall
> scalability of the architecture.
> 

Well, it will be interesting to see how it goes. Unfortunately
I don't have a single realistic benchmark. In fact the only
threaded one I have is volanomark.

> 
>>Also, these additional system wide balance points don't come for free
>>if you attach them to common operations (as opposed to the slow
>>periodic balancing).
> 
> 
> yes, definitely.
> 
> the implementation in sched2.patch does not take this into account yet. 
> There are a number of things we can do about the 500 CPUs case. Eg. only
> do the balance search towards the next N nodes/cpus (tunable via a
> domain parameter).

Yeah I think we shouldn't worry too much about the 500 CPUs
case, because they will obviously end up using their own
domains. But it is possible this would hurt smaller CPU
counts too. Again, it means testing.

I think we should probably aim to have a usable and decent
default domain for 32, maybe 64 CPUs, and not worry about
larger numbers too much if it would hurt lower end performance.
