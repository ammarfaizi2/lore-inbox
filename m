Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTAQXIr>; Fri, 17 Jan 2003 18:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbTAQXIr>; Fri, 17 Jan 2003 18:08:47 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:62407 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261292AbTAQXIq>;
	Fri, 17 Jan 2003 18:08:46 -0500
Message-ID: <3E288D46.8020908@us.ibm.com>
Date: Fri, 17 Jan 2003 15:09:58 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Erich Focht <efocht@ess.nec.de>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] sched-2.5.59-A2
References: <Pine.LNX.4.44.0301170921430.3723-100000@localhost.localdomain> <200301171535.21226.efocht@ess.nec.de> <200301171911.29514.efocht@ess.nec.de> <147000000.1042830254@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>I repeated the tests with your B0 version and it's still not
>>satisfying. Maybe too aggressive NODE_REBALANCE_IDLE_TICK, maybe the
>>difference is that the other calls of load_balance() never have the
>>chance to balance across nodes.
> 
> 
> Nope, I found the problem. The topo cleanups are broken - we end up 
> taking all mem accesses, etc to node 0.
> 
> Use the second half of the patch (the splitup I already posted), 
> and fix the obvious compile error. Works fine now ;-)
> 
> Matt, you know the topo stuff better than anyone. Can you take a look
> at the cleanup Ingo did, and see if it's easily fixable?

Umm..  most of it looks clean.  I'm not really sure what the 
__cpu_to_node_mask(cpu) macro is supposed to do?  it looks to be just an 
alias for the __node_to_cpu_mask() macro, which makes little sense to 
me.  That's the only thing that immediately sticks out.  I'm doubly 
confused as to why it's defined twice in include/linux/topology.h?

-Matt

> 
> M.
> 
> PS. Ingo - I love the restructuring of the scheduler bits. 
> I think we need > 2 multipler though ... I set it to 10 for now.
> Tuning will tell ...
> 


