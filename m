Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVCRIq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVCRIq4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 03:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVCRIqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 03:46:55 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:29370 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261506AbVCRIqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 03:46:40 -0500
Message-ID: <423A9569.3040105@yahoo.com.au>
Date: Fri, 18 Mar 2005 19:46:33 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
CC: Linux kernel list <linux-kernel@vger.kernel.org>,
       Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.11 vs 2.6.10 slowdown on i686
References: <E1DBtvc-0002c4-00@mta1.cl.cam.ac.uk> <42397A04.2060703@yahoo.com.au> <20050318082554.GA12536@tpkurt.garloff.de>
In-Reply-To: <20050318082554.GA12536@tpkurt.garloff.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff wrote:
> Hi Nick,
> 

Hi Kurt!

> On Thu, Mar 17, 2005 at 11:37:24PM +1100, Nick Piggin wrote:
> 
>>Ian Pratt wrote:
>>
>>>fork: 166 -> 235  (40% slowdown)
>>>exec: 857 -> 1003 (17% slowdown)
>>>
>>>I'm guessing this is down to the 4 level pagetables. This is rather a
>>>surprise as I thought the compiler would optimise most of these
>>>changes away. Apparently not. 
>>
>>There are some changes in the current -bk tree (which are a
>>bit in-flux at the moment) which introduce some optimisations.
>>
>>They should bring 2-level performance close to par with 2.6.10.
>>If not, complain again :)
> 
> 
> Is there a clean patchset that we should look at to test?
> 

Probably the best thing would be to wait and see what happens
with the ptwalk patches. There is a fix in there for ia64 now,
but I think that may be a temporary one.

Andi is probably keeping an eye on that, but if not then I
could put a patchset together when things finalise in 2.6.

 From the profiles I have seen, the ptwalk patches bring page
table walking performance pretty well back to 2.6.10 levels,
however the "aggressive page table freeing" (clear_page_range)
changes that went in at the same time as the 4level stuff
seem to be what is slowing down exit() and unmapping performance.

Not by a huge amount, mind you, and it is not completely wasted
performance, because it provides better page table freeing.
But it is enough to be annoying! I haven't had much time to look
at it lately, but I hope to get onto it soon.

Nick

