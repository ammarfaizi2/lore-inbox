Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263057AbUKTCvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbUKTCvU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUKTCuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:50:24 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:2396 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263057AbUKTCqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:46:21 -0500
Message-ID: <419EAFF3.80206@yahoo.com.au>
Date: Sat, 20 Nov 2004 13:46:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
References: <Pine.LNX.4.58.0411181715280.834@schroedinger.engr.sgi.com> <419D581F.2080302@yahoo.com.au> <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com> <419D5E09.20805@yahoo.com.au> <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com> <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org> <20041120020306.GA2714@holomorphy.com> <419EAB21.8020207@yahoo.com.au> <20041120024104.GE2714@holomorphy.com>
In-Reply-To: <20041120024104.GE2714@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>Unprivileged triggers for full-tasklist scans are NMI oops material.
> 
> 
> On Sat, Nov 20, 2004 at 01:25:37PM +1100, Nick Piggin wrote:
> 
>>What about pushing the per-thread rss delta back into the global atomic
>>rss counter in each schedule()?
>>Pros:
>>This would take the task exiting problem into its stride as a matter of
>>course.
>>Single atomic read to get rss.
>>Cons:
>>would just be moving the atomic op somewhere else if we don't get
>>many page faults per schedule.
>>Not really nice dependancies.
>>Assumes schedule (not context switch) must occur somewhat regularly.
>>At present this is not true for SCHED_FIFO tasks.
>>Too nasty?
> 
> 
> This doesn't sound too hot. There's enough accounting that can't be
> done anywhere but schedule(), and this can be done elsewhere. Plus,
> you're moving an already too-frequent operation to a more frequent
> callsite.
> 

No, it won't somehow increase the number of atomic rss operations
just because schedule is called more often. The number of ops will
be at _most_ the number of page faults.

But I agree with your overall evaluation of its 'hotness'. Just
another idea. Give this monkey another thousand years at the keys
and he'll come up with the perfect solution :P
