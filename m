Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267335AbTAPXnz>; Thu, 16 Jan 2003 18:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267336AbTAPXnz>; Thu, 16 Jan 2003 18:43:55 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:15355 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267335AbTAPXny>; Thu, 16 Jan 2003 18:43:54 -0500
Date: Thu, 16 Jan 2003 15:31:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
Message-ID: <132930000.1042759915@flay>
In-Reply-To: <Pine.LNX.4.44.0301162110480.10526-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0301162110480.10526-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yes, i saw it, it has the same tying between idle-CPU-rebalance and
> inter-node rebalance, as Erich's patch. You've put it into
> cpus_to_balance(), but that still makes rq->nr_balanced a 'synchronously'
> coupled balancing act. There are two synchronous balancing acts currently:
> the 'CPU just got idle' event, and the exec()-balancing (*) event. Neither
> must involve any 'heavy' balancing, only local balancing. The inter-node

If I understand that correctly (and I'm not sure I do), you're saying
you don't think the exec time balance should go global? That would 
break most of the concept ... *something* has to distribute stuff around
nodes, and the exec point is the cheapest time to do that (least "weight"
to move. I'd like to base it off cached load-averages, rather than going
sniffing every runqueue, but if you're meaning we should only exec time
balance inside a node, I disagree. Am I just misunderstanding you?

At the moment, the high-freq balancer is only inside a node. Exec balancing
is global, and the "low-frequency" balancer is global. WRT the idle-time
balancing, I agree with what I *think* you're saying ... this shouldn't
clock up the rq->nr_balanced counter ... this encourages too much cross-node
stealing. I'll hack that change out and see what it does to the numbers.

Would appreciate more feedback on the first paragraph. Thanks,

M.



