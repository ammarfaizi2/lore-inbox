Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265603AbUFDFfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265603AbUFDFfs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 01:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265607AbUFDFfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 01:35:48 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:61298 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265603AbUFDFfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 01:35:46 -0400
Message-ID: <40C00A2B.1040606@yahoo.com.au>
Date: Fri, 04 Jun 2004 15:35:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
References: <20040603094339.03ddfd42.pj@sgi.com>	<20040603101010.4b15734a.pj@sgi.com>	<1086313667.29381.897.camel@bach>	<40BFD839.7060101@yahoo.com.au> <20040603223005.01bbab21.pj@sgi.com>
In-Reply-To: <20040603223005.01bbab21.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
>>I don't see what you gain from having the cpumask type but having
>>to get at its internals with the bitop functions.
> 
> 
> The essential gain, in my view, of cpumask, is that it encapsulates
> the value NR_CPUS.  cpumasks are bitmaps of length NR_CPUS.
> 
> Yes, there is an open issue of whether cpumasks are worth it.
> I think enough code has taken to them that they are.
> 

Yes, I'm all for the full cpumask abstraction.

> The getting at internals (via cpus_addr(), I'm guessing you mean)
> was a workaround for some code that messed with cpumasks and simple
> unsigned longs as if they were interoperable.  "cpus_addr" should
> be marked deprecated, and its use coded out.  Its remaining uses
> are in arch-specific areas where I lack the expertise and testing
> environment to accomplish such.
> 
> I needed some legacy mechanism such as this, in order to avoid
> having such existing uses bring the entire cpumask overhaul to
> a screeching halt.
> 

No, by getting at the internals, I mean the internals of the
type itself. Its implementation, if you will. (Well I guess
that also *includes* users getting the address and derefing it
as an unsigned long).

But no, I was talking about something more general. Rusty wrote:

 >>+#define cpus_addr(src) ((src).bits)
 >
 >
 > We've discussed this before when talking about whether it'd be easier to
 > just make people use raw bitop functions directly, so I know we have
 > philosophical differences here.
 >
 > So, opinion alert: if I were doing this, I'd probably live without this
 > macro; in my mind it crosses the "too much abstraction" line.  I did
 > momentarily wonder what this macro did when I saw it used in the
 > succeeding patches.

Now in my opinion, it is either all or nothing. I could be wrong,
but I don't think there is any point with a nice cpumask type if
you are just going to get inside it and do bitmap operations on it.

In summary, I think your patches are nice :)
