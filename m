Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSGBPK0>; Tue, 2 Jul 2002 11:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316794AbSGBPKZ>; Tue, 2 Jul 2002 11:10:25 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:14864 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316792AbSGBPKZ>; Tue, 2 Jul 2002 11:10:25 -0400
Date: Tue, 2 Jul 2002 11:07:59 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
In-Reply-To: <Pine.LNX.4.44.0207012041110.13852-100000@e2>
Message-ID: <Pine.LNX.3.96.1020702104931.27954C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002, Ingo Molnar wrote:

> 
> On Mon, 1 Jul 2002, Bill Davidsen wrote:
> 
> > What's the issue? The most popular trees have been using it without
> > issue for six months or so, and I know of no cases of bad behaviour.  
> > [...]
> 
> well, the patch is barely 6 months old. A new scheduler changes the
> 'heart' of the kernel and something like that should not be done for the
> stable branch, especially since it has finally started to converge towards
> a state that can be called stable ...

  As I noted, the VM changes which are going in without objection are more
likely to be a cause of problems caused by word length, memory
organization, etc. And they work fine, at least for Intel and SPARC. O(1)
has been as tested as any feature can be, certainly -ac kernels are run by
more people than 2.5 kernels, and running the best process is less likely
to be hardware dependent. There is a big win with this scheduler, it keeps
the system running far better on mixed loads, and does it without hours of
playing with nice() to get things balanced.
 
> > [...] I know there are people who don't believe in the preempt patch,
> > but the new scheduler seems to work better under both desktop and server
> > load.
> 
> well, the preempt patch is rather for RT-type workloads where milliseconds
> matter, which improvements are not a matter of belief, but a matter of
> hard latencies. Mere mortals should hardly notice its effects under normal
> loads - perhaps a bit more 'snappiness'. But such effects do accumulate
> up, and people are seeing visible improvements with combo-patches of
> lowlat-lockbreak+preempt+O(1).

Last time I tried that, I used all but lockbreak, and the only place I saw
anything for my loads was slightly lower latency for a slow machine
playing router. But I'm running news and dns servers, and O(1) seems to
drop the load average by about 15% (as much as you can measure on a
machine with 400% swings in the demand ;-)

Thanks for the input, I just don't see that there will ever be a better
time to put it in, the 2.5 kernel is very lightly used and tested, and has
enough other things happening to mask anything short of a disaster. And
2.6 will be another stable kernel, at least numerically, initially with
much less testing. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

