Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbUC3PCB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263706AbUC3PCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:02:01 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:6360 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263698AbUC3PBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:01:40 -0500
Date: Tue, 30 Mar 2004 07:01:04 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>, Ingo Molnar <mingo@elte.hu>
cc: Andi Kleen <ak@suse.de>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rick Lindsley <ricklind@us.ibm.com>, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <1750000.1080658863@[10.10.2.4]>
In-Reply-To: <200403300030.25734.efocht@hpce.nec.com>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <20040325214815.GA19060@elte.hu> <23100000.1080253728@flay> <200403300030.25734.efocht@hpce.nec.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Erich Focht <efocht@hpce.nec.com> wrote (on Tuesday, March 30, 2004 00:30:25 +0200):

> On Thursday 25 March 2004 23:28, Martin J. Bligh wrote:
>> Can we hold off on changing the fork/exec time balancing until we've
>> come to a plan as to what should actually be done with it? Unless we're
>> giving it some hint from userspace, it's frigging hard to be sure if
>> it's going to exec or not - and the vast majority of things do.
> 
> After more than a year (or two?) of discussions there's no better idea
> yet than giving a userspace hint. Default should be to balance at
> exec(), and maybe use a syscall for saying: balance all children a
> particular process is going to fork/clone at creation time. Everybody
> reached the insight that we can't foresee what's optimal, so there is
> only one solution: control the behavior. Give the user a tool to
> improve the performance. Just a small inheritable variable in the task
> structure is enough. Whether you give the hint at or before run-time
> or even at compile-time is not really the point...

Agreed ... absolutely.
 
> I don't think it's worth to wait and hope that somebody shows up with
> a magic algorithm which balances every kind of job optimally.

Especially as I don't believe that exists ;-) It's not deterministic.

>> Clone is a much more interesting case, though at the time, I consciously
>> decided NOT to do that, as we really mostly want threads on the same
>> node.
> 
> That is not true in the case of HPC applications. And if someone uses
> OpenMP he is just doing that kind of stuff. I consider STREAM a good
> benchmark because it shows exactly the problem of HPC applications:
> they need a lot of memory bandwidth, they don't run in cache and the
> tasks live really long. Spreading those tasks across the nodes gives
> me more bandwidth per task and I accumulate the positive effect
> because the tasks run for hours or days. It's a simple and clear case
> where the scheduler should be improved.
>
> Benchmarks simulating "user work" like SPECsdet, kernel compile, AIM7
> are not relevant for HPC. In a compute center it actually doesn't
> matter much whether some shell command returns 10% faster, it just
> shouldn't disturb my super simulation code for which I bought an
> expensive NUMA box.

OK, but the scheduler can't know the difference automatically, I don't
think ... and whether we should tune the scheduler for "user work" or
HPC is going to be a hotly contested point ;-) We need to try to find
something that works for both. And suppose you have a 4 node system,
with 4 HPC apps running? Surely you want each app to have one node to
itself? That's more the case I'm worried about than "user work" vs HPC,
to be honest.

M.
