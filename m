Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271351AbTG2KFS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 06:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271375AbTG2KFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 06:05:18 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:56570 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S271351AbTG2KFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 06:05:07 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] scheduler fix for 1cpu/node case
Date: Tue, 29 Jul 2003 12:08:25 +0200
User-Agent: KMail/1.5.1
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org
References: <200307280548.53976.efocht@gmx.net> <200307282218.19578.efocht@hpce.nec.com> <3904530000.1059424676@[10.10.2.4]>
In-Reply-To: <3904530000.1059424676@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307291208.25965.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 July 2003 22:37, Martin J. Bligh wrote:
> > But the Hammer is a NUMA architecture and a working NUMA scheduler
> > should be flexible enough to deal with it. And: the corner case of 1
> > CPU per node is possible also on any other NUMA platform, when in some
> > of the nodes (or even just one) only one CPU is configured in. Solving
> > that problem automatically gives the Hammer what it needs.
>
> OK, well what we have now is a "multi-cpu-per-node-numa-scheduler" if
> you really want to say all that ;-)

And with the fix posted it will just be called "numa-scheduler". It's
a simplification, as you noticed.

> The question is "does Hammer benefit from the additional complexity"?
> I'm guessing not ... if so, then yes, it's worth fixing. If not, it
> would seem better to just leave it at SMP for the scheduler stuff.
> Simpler, more shared code with common systems.

Hammer will just go for the other nodes, as it should, when the own
node is free. Then you can benefit of NUMA improvements in the load
calculation and later of smarter distribution across the
nodes. Reverting to SMP is a quick fix but for improvements we'll have
to get back to NUMA. So why not fix it now and stay with NUMA.

> > No, no, the local load balancer just doesn't make sense now if you
> > have one cpu per node. It is called although it will never find
> > another cpu in the own cell to steal from. There just is nothing
> > else... (or did I misunderstand your comment?)
>
> Right, I realise that the 1 cpu per node case is broken. However, doesn't
> this also affect the multi-cpu per node case in the manner I suggested
> above? So even if we turn off NUMA scheduler for Hammer, this still
> needs fixing, right?

Yes.

> > That's one way, but the proposed patch just solves the problem (in a
> > more general way, also for other NUMA cases). If you deconfigure NUMA
> > for a NUMA platform, we'll have problems switching it back on when
> > adding smarter things like node affine or homenode extensions.
>
> Yeah, maybe. I'd rather have the code in hand that needs it, but still ...
> if Andi's happy that fixes it, then we're OK.

http://marc.theaimsgroup.com/?l=linux-kernel&m=105854610325226&w=2
Andi mentioned in his talk to follow that path, too. We'll have to
experiment a while with the ideas we currently have to get the initial
load balancing/ dynamic homenode issue solved, there's no "golden way"
right now. I'll post the stuff I mentioned in my talk soon, but want
to gain some experience with it, first.

Regards,
Erich


