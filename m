Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVBXWAD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVBXWAD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVBXWAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:00:02 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:5012 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262511AbVBXV7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:59:19 -0500
Message-ID: <421E4E27.20004@yahoo.com.au>
Date: Fri, 25 Feb 2005 08:59:03 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au>     <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston>     <20050217230342.GA3115@wotan.suse.de>     <20050217153031.011f873f.davem@davemloft.net>     <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au>     <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>     <421B0163.3050802@yahoo.com.au>     <Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com>     <421D1737.1050501@yahoo.com.au>     <Pine.LNX.4.61.0502240457350.5427@goblin.wat.veritas.com>     <1109224777.5177.33.camel@npiggin-nld.site> <Pine.LNX.4.61.0502241143001.6630@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0502241143001.6630@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Thu, 24 Feb 2005, Nick Piggin wrote:
> 
>>pud_addr_end?
> 
> 
> 		next = pud_addr_end(addr, end);
> 
> Hmm, yes, I'll go with that, thanks (unless a better idea follows).
> 
> Something I do intend on top of what I sent before, is another set
> of three macros, like
> 
> 		if (pud_none_or_clear_bad(pud))
> 			continue;
> 
> to replace all the p??_none, p??_bad clauses: not to save space,
> but just for clarity, those loops now seeming dominated by the
> unlikeliest of cases.
> 
> Has anyone _ever_ seen a p??_ERROR message?  I'm inclined to just
> put three functions into mm/memory.c to do the p??_ERROR and p??_clear,
> but that way the __FILE__ and __LINE__ will always come out the same.
> I think if it ever proves a problem, we'd just add in a dump_stack.
> 

I think a function is the most sensible. And a good idea, it should
reduce the icache pressure in the loops (although gcc does seem to
do a pretty good job of moving unlikely()s away from the fastpath).

I think at the point these things get detected, there is little use
for having a dump_stack. But we may as well add one anyway if it is
an out of line function?

Nick

