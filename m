Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271110AbTG1UjA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271065AbTG1Uiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:38:52 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:25260 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S271089AbTG1Ui3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:38:29 -0400
Date: Mon, 28 Jul 2003 13:37:57 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org
Subject: Re: [patch] scheduler fix for 1cpu/node case
Message-ID: <3904530000.1059424676@[10.10.2.4]>
In-Reply-To: <200307282218.19578.efocht@hpce.nec.com>
References: <200307280548.53976.efocht@gmx.net> <3900670000.1059422153@[10.10.2.4]> <200307282218.19578.efocht@hpce.nec.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the Hammer is a NUMA architecture and a working NUMA scheduler
> should be flexible enough to deal with it. And: the corner case of 1
> CPU per node is possible also on any other NUMA platform, when in some
> of the nodes (or even just one) only one CPU is configured in. Solving
> that problem automatically gives the Hammer what it needs.

OK, well what we have now is a "multi-cpu-per-node-numa-scheduler" if
you really want to say all that ;-)

The question is "does Hammer benefit from the additional complexity"?
I'm guessing not ... if so, then yes, it's worth fixing. If not, it
would seem better to just leave it at SMP for the scheduler stuff.
Simpler, more shared code with common systems.
 
>> > Fact is that the current separation of local and global balancing,
>> > where global balancing is done only in the timer interrupt at a fixed
>> > rate is way too unflexible. A CPU going idle inside a well balanced
>> > node will stay idle for a while even if there's a lot of work to
>> > do. Especially in the corner case of one CPU per node this is
>> > condemning that CPU to idleness for at least 5 ms.
>> 
>> Surely it'll hit the idle local balancer and rebalance within the node?
>> Or are you thinking of a case with 3 tasks on a 4 cpu/node system?
> 
> No, no, the local load balancer just doesn't make sense now if you
> have one cpu per node. It is called although it will never find
> another cpu in the own cell to steal from. There just is nothing
> else... (or did I misunderstand your comment?)

Right, I realise that the 1 cpu per node case is broken. However, doesn't
this also affect the multi-cpu per node case in the manner I suggested
above? So even if we turn off NUMA scheduler for Hammer, this still 
needs fixing, right?
 
> That's one way, but the proposed patch just solves the problem (in a
> more general way, also for other NUMA cases). If you deconfigure NUMA
> for a NUMA platform, we'll have problems switching it back on when
> adding smarter things like node affine or homenode extensions.

Yeah, maybe. I'd rather have the code in hand that needs it, but still ...
if Andi's happy that fixes it, then we're OK.

M.
