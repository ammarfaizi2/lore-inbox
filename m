Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264871AbTLKKSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 05:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbTLKKSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 05:18:13 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:5876 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S264871AbTLKKSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 05:18:07 -0500
Date: Thu, 11 Dec 2003 11:16:10 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Andrea Arcangeli <andrea@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031211101610.GA5192@k3.hellgate.ch>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031210215235.GC11193@dualathlon.random> <20031210220525.GA28912@k3.hellgate.ch> <20031210224445.GE11193@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210224445.GE11193@dualathlon.random>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003 23:44:46 +0100, Andrea Arcangeli wrote:
> more processes can be optimized even better by adding unfariness.
> Either ways a significant slowdown of qsbench probably means worse core
> VM, at least if compared with 2.4 that isn't adding huge unfariness just
> to optimize qsbench.

Can you be a bit more specific about the type of unfairness? The only
instance I clearly noticed is that one process can grow its RSS at the
expense of others if they already have a high PFF. That happens more
often in 2.4 and helps a lot with some benchmarks.

I did notice, though, that after an initial slowdown, qsbench improved
during 2.5, while the compile benchmarks got even worse.

> > Also, the 2.6 core VM doesn't seem all that bad since it was introduced in
> > 2.5.27 but most of the problems I measured were introduced after 2.5.40.
> > Check out the graph I posted.
> 
> you're confusing rmap with core vm. rmap in no way can be defined as the
> core vm, rmap is just a method used by the core vm to find some

Incidentally, all these places where rmap is used by the core VM were
introduced in 2.5.27 as well. In particular vmscan.c was completely
overhauled. But apparently you suspect subsequent changes to the core
to be a problem. I am curious what they are if that can help fixing
the slowdowns I'm seeing.

Roger
