Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267415AbTAQHKi>; Fri, 17 Jan 2003 02:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267416AbTAQHKi>; Fri, 17 Jan 2003 02:10:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47830 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267415AbTAQHKh>;
	Fri, 17 Jan 2003 02:10:37 -0500
Date: Fri, 17 Jan 2003 08:23:40 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
In-Reply-To: <132930000.1042759915@flay>
Message-ID: <Pine.LNX.4.44.0301170817250.2431-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Jan 2003, Martin J. Bligh wrote:

> If I understand that correctly (and I'm not sure I do), you're saying
> you don't think the exec time balance should go global? That would break
> most of the concept ... *something* has to distribute stuff around
> nodes, and the exec point is the cheapest time to do that (least
> "weight" to move. [...]

the exec()-time balancing is special, since it only moves the task in
question - so the 'push' should indeed be a global decision. _But_, exec()  
is also a natural balancing point for the local node (we potentially just
got rid of a task, which might create imbalance within the node), so it
might make sense to do a 'local' balancing run as well, if the exec()-ing
task was indeed pushed to another node.

> At the moment, the high-freq balancer is only inside a node. Exec
> balancing is global, and the "low-frequency" balancer is global. WRT the
> idle-time balancing, I agree with what I *think* you're saying ... this
> shouldn't clock up the rq->nr_balanced counter ... this encourages too
> much cross-node stealing. I'll hack that change out and see what it does
> to the numbers.

yes, this should also further unify the SMP and NUMA balancing code.

	Ingo

