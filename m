Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbUKTFvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbUKTFvS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbUKTFvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 00:51:07 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:36506 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262838AbUKTFuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 00:50:35 -0500
Message-ID: <419EDB21.3070707@yahoo.com.au>
Date: Sat, 20 Nov 2004 16:50:25 +1100
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
References: <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com> <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org> <20041120020306.GA2714@holomorphy.com> <419EBBE0.4010303@yahoo.com.au> <20041120035510.GH2714@holomorphy.com> <419EC205.5030604@yahoo.com.au> <20041120042340.GJ2714@holomorphy.com> <419EC829.4040704@yahoo.com.au> <20041120053802.GL2714@holomorphy.com>
In-Reply-To: <20041120053802.GL2714@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>Very, very wrong. The tasklist scans hold the read side of the lock
>>>and aren't even what's running with interrupts off. The contenders
>>>on the write side are what the NMI oopser oopses.
> 
> 
> On Sat, Nov 20, 2004 at 03:29:29PM +1100, Nick Piggin wrote:
> 
>>*blinks*
>>So explain how this is "very very wrong", then?
> 
> 
> There isn't anything left to explain. So if there's a question, be
> specific about it.
> 

Why am I very very wrong? Why won't touch_nmi_watchdog work from
the read loop?

And let's just be nice and try not to jump at the chance to point
out when people are very very wrong, and keep count of the times
they have been very very wrong. I'm trying to be constructive.

> 
> William Lee Irwin III wrote:
> 
>>>And supposing the arch reenables interrupts in the write side's
>>>spinloop, you just get a box that silently goes out of service for
>>>extended periods of time, breaking cluster membership and more. The
>>>NMI oopser is just the report of the problem, not the problem itself.
>>>It's not a false report. The box is dead for > 5s at a time.
> 
> 
> On Sat, Nov 20, 2004 at 03:29:29PM +1100, Nick Piggin wrote:
> 
>>The point is, adding a for-each-thread loop or two in /proc isn't
>>going to cause a problem that isn't already there.
>>If you had zero for-each-thread loops then you might have a valid
>>complaint. Seeing as you have more than zero, with slim chances of
>>reducing that number, then there is no valid complaint.
> 
> 
> This entire line of argument is bogus. A preexisting bug of a similar
> nature is not grounds for deliberately introducing any bug.
> 

Sure, if that is a bug and someone is just about to fix it then
yes you're right, we shouldn't introduce this. I didn't realise
it was a bug. Sounds like it would be causing you lots of problems
though - have you looked at how to fix it?
