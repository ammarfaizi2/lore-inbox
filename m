Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314476AbSDSCbL>; Thu, 18 Apr 2002 22:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314515AbSDSCbK>; Thu, 18 Apr 2002 22:31:10 -0400
Received: from holomorphy.com ([66.224.33.161]:7072 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314476AbSDSCbH>;
	Thu, 18 Apr 2002 22:31:07 -0400
Date: Thu, 18 Apr 2002 19:30:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Erich Focht <focht@ess.nec.de>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>,
        Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>, torvalds@transmeta.com
Subject: Re: [PATCH] migration thread fix
Message-ID: <20020419023015.GQ23767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Erich Focht <focht@ess.nec.de>, Robert Love <rml@tech9.net>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>,
	torvalds@transmeta.com
In-Reply-To: <20020418232753.GP23767@holomorphy.com> <Pine.LNX.4.44.0204190201570.3004-100000@beast.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> It does keep the original philosophy, and it's not too complicated:
> [...]
>> It's really a very conservative algorithm.

On Fri, Apr 19, 2002 at 03:51:29AM +0200, Erich Focht wrote:
> thanks for the explanations. Usually I'm also conservative with changes.

Perhaps I was especially so, as I really have only one goal in mind,
that is, getting it to boot. I have, of course, no intention of
interfering with the development of new functionality.


On Fri, Apr 19, 2002 at 03:51:29AM +0200, Erich Focht wrote:
> I'm currently working on a node affine scheduler extension for NUMA
> machines and the load balancer behaves a bit different from the original.
> So after a few boot failures with those slowly booting 16 CPU IA64
> machines I thought there must be a simpler solution than synchronizing and
> waiting for the load balancer: just let migration_CPU0 do what it is
> designed for. So my proposal is:

I've seen a few posts of yours on the subject, though I'm sorry to say I
haven't followed it closely, as there is quite a bit of interesting work
going on these days in the scheduler. My main interests are elsewhere.


On Fri, Apr 19, 2002 at 03:51:29AM +0200, Erich Focht wrote:
> I first posted this to LKML on March 6th (BTW, the fix #1, too) and since
> then it was tested on several big NUMA platforms: 16 CPU NEC AzusA (IA64)
> (also known as HP rx....), up to 32 CPU SGI IA64, 16 CPU IBM NUMA-Q
> (IA32). No more lock-ups at boot since then. So I consider it working.

Sounds fairly thoroughly tested; this is actually more systems than I
myself have access to. Just to sort of doublecheck the references, is
there a mailing list archive where I can find reports of this problem
and/or successes of others using it?


On Fri, Apr 19, 2002 at 03:51:29AM +0200, Erich Focht wrote:
> There is another good reason for this approach: the integration of the CPU
> hotplug patch with the new scheduler becomes easier. One just needs to
> create the new migration thread, it will move itself to the right CPU
> without any additional magic (which you otherwise need because of the
> synchronizations which won't be there at hotplug). Kimi Suganuma in the
> neighboring cube is fiddling this out currently.

Given that it's been tested quite a bit, on a superset even of
platforms I'm explicitly trying to keep working I don't have any qualms
left. The code is correct from my review of it, it's been tested on my
machines, and he's trying to get something done that could make use of
some of the properties of the algorithm (the hotplug stuff).

Looks good to me.


Cheers,
Bill
