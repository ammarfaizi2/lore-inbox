Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267640AbTAQTEV>; Fri, 17 Jan 2003 14:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbTAQTEV>; Fri, 17 Jan 2003 14:04:21 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:2189 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267640AbTAQTET>;
	Fri, 17 Jan 2003 14:04:19 -0500
Date: Fri, 17 Jan 2003 11:04:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Ingo Molnar <mingo@elte.hu>,
       colpatch@us.ibm.com
cc: Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] sched-2.5.59-A2
Message-ID: <147000000.1042830254@flay>
In-Reply-To: <200301171911.29514.efocht@ess.nec.de>
References: <Pine.LNX.4.44.0301170921430.3723-100000@localhost.localdomain> <200301171535.21226.efocht@ess.nec.de> <200301171911.29514.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I repeated the tests with your B0 version and it's still not
> satisfying. Maybe too aggressive NODE_REBALANCE_IDLE_TICK, maybe the
> difference is that the other calls of load_balance() never have the
> chance to balance across nodes.

Nope, I found the problem. The topo cleanups are broken - we end up 
taking all mem accesses, etc to node 0.

Use the second half of the patch (the splitup I already posted), 
and fix the obvious compile error. Works fine now ;-)

Matt, you know the topo stuff better than anyone. Can you take a look
at the cleanup Ingo did, and see if it's easily fixable?

M.

PS. Ingo - I love the restructuring of the scheduler bits. 
I think we need > 2 multipler though ... I set it to 10 for now.
Tuning will tell ...
