Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263083AbUKTEhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbUKTEhG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbUKTEfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 23:35:38 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:64657 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263117AbUKTE3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 23:29:40 -0500
Message-ID: <419EC829.4040704@yahoo.com.au>
Date: Sat, 20 Nov 2004 15:29:29 +1100
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
References: <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com> <419D5E09.20805@yahoo.com.au> <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com> <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org> <20041120020306.GA2714@holomorphy.com> <419EBBE0.4010303@yahoo.com.au> <20041120035510.GH2714@holomorphy.com> <419EC205.5030604@yahoo.com.au> <20041120042340.GJ2714@holomorphy.com>
In-Reply-To: <20041120042340.GJ2714@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>/proc/ triggering NMI oopses was a persistent problem even before that
>>>code was merged. I've not bothered testing it as it at best aggravates it.
> 
> 
> On Sat, Nov 20, 2004 at 03:03:17PM +1100, Nick Piggin wrote:
> 
>>It isn't a problem. If it ever became a problem then we can just
>>touch the nmi oopser in the loop.
> 
> 
> Very, very wrong. The tasklist scans hold the read side of the lock
> and aren't even what's running with interrupts off. The contenders
> on the write side are what the NMI oopser oopses.
> 

*blinks*

So explain how this is "very very wrong", then?

> And supposing the arch reenables interrupts in the write side's
> spinloop, you just get a box that silently goes out of service for
> extended periods of time, breaking cluster membership and more. The
> NMI oopser is just the report of the problem, not the problem itself.
> It's not a false report. The box is dead for > 5s at a time.
> 

The point is, adding a for-each-thread loop or two in /proc isn't
going to cause a problem that isn't already there.

If you had zero for-each-thread loops then you might have a valid
complaint. Seeing as you have more than zero, with slim chances of
reducing that number, then there is no valid complaint.

> 
> William Lee Irwin III wrote:
> 
>>>And thread groups can share mm's. do_for_each_thread() won't suffice.
> 
> 
> On Sat, Nov 20, 2004 at 03:03:17PM +1100, Nick Piggin wrote:
> 
>>I think it will be just fine.
> 
> 
> And that makes it wrong on both counts. The above fails any time
> LD_ASSUME_KERNEL=2.4 is used, we well as when actual Linux features
> are used directly.
> 

See my followup.
