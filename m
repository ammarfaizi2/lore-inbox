Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbUKTEE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbUKTEE7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263099AbUKTEA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 23:00:28 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:13682 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263103AbUKTD6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 22:58:42 -0500
Message-ID: <419EC0EC.9000106@yahoo.com.au>
Date: Sat, 20 Nov 2004 14:58:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Christoph Lameter <clameter@sgi.com>, torvalds@osdl.org, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Robin Holt <holt@sgi.com>
Subject: Re: page fault scalability patch V11 [0/7]: overview
References: <419D5E09.20805@yahoo.com.au> <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com> <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <20041120020401.GC2714@holomorphy.com> <419EA96E.9030206@yahoo.com.au> <20041120023443.GD2714@holomorphy.com> <419EAEA8.2060204@yahoo.com.au> <20041120030425.GF2714@holomorphy.com> <419EB699.4050204@yahoo.com.au> <20041120034349.GG2714@holomorphy.com>
In-Reply-To: <20041120034349.GG2714@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>Irrelevant. Unshare cachelines with hot mm-global ones, and the
>>>"problem" goes away.
> 
> 
> On Sat, Nov 20, 2004 at 02:14:33PM +1100, Nick Piggin wrote:
> 
>>That's the idea.
> 
> 
> 
> William Lee Irwin III wrote:
> 
>>>This stuff is going on and on about some purist "no atomic operations
>>>anywhere" weirdness even though killing the last atomic operation
>>>creates problems and doesn't improve performance.
> 
> 
> On Sat, Nov 20, 2004 at 02:14:33PM +1100, Nick Piggin wrote:
> 
>>Huh? How is not wanting to impact single threaded performance being
>>"purist weirdness"? Practical, I'd call it.
> 
> 
> Empirically demonstrate the impact on single-threaded performance.
> 

I can tell you its worse. I don't have to demonstrate anything, more
atomic RMW ops in the page fault path is going to have an impact.

I'm not saying we must not compromise *anywhere*, but it would
just be nice to try to avoid making the path heavier, that's all.
I'm not being purist when I say I'd first rather explore all other
options before adding atomics.

But nevermind arguing, it appears Linus' suggested method will
be fine and *does* mean we don't have to compromise.

> 
> On Sat, Nov 20, 2004 at 01:40:40PM +1100, Nick Piggin wrote:
> 
>>>Why the Hell would you bother giving each cpu a separate cacheline?
>>>The odds of bouncing significantly merely amongst the counters are not
>>>particularly high.
> 
> 
> On Sat, Nov 20, 2004 at 02:14:33PM +1100, Nick Piggin wrote:
> 
>>Hmm yeah I guess wouldn't put them all on different cachelines.
>>As you can see though, Christoph ran into a wall at 8 CPUs, so
>>having them densly packed still might not be enough.
> 
> 
> Please be more specific about the result, and cite the Message-Id.
> 

Start of this thread.
