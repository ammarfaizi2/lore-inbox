Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266819AbUBRAF1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUBRAF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:05:26 -0500
Received: from bhhdoa.org.au ([216.17.101.199]:40203 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S266815AbUBRAEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:04:43 -0500
Message-ID: <1077063941.4032b105b4906@vds.kolivas.org>
Date: Wed, 18 Feb 2004 11:25:41 +1100
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.6.3-rc2 v 2.6.3-rc3-mm1 kernbench
References: <Pine.LNX.3.96.1040217110549.8209A-100000@gatekeeper.tmr.com> <4032452F.2090001@cyberone.com.au>
In-Reply-To: <4032452F.2090001@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Piggin <piggin@cyberone.com.au>:
> Bill Davidsen wrote:
> >On Tue, 17 Feb 2004, Nick Piggin wrote:
> >>Con hasn't tried HT off AFAIK because we couldn't work out how to
> >>turn it off at boot time! :(
> >The curse of the brain-dead BIOS :-(

Err not quite; it's an X440 that is 10000 miles away so I cant really access the
bios easily :P

> >So does CONFIG_SCHED_SMT turned off mean not using more than one sibling
> >per package, or just going back to using them poorly? Yes, I should go
> >root through the code.
> 
> It just goes back to treating them the same as physical CPUs.
> The option will be eventually removed.
> 
> >Clearly it would be good to get one more data point with HT off in BIOS,
> >but from this data it looks as if the SMT stuff really helps little when
> >the system is very heavily loaded (Nproc>=Nsibs), and does best when the
> >load is around Nproc==Ncpu. At least as I read the data. 

Actually that machine is 8 packages, 16 logical cpus and kernbench half load by
default is set to cpus / 2. The idea behind that load is to minimise wasted
idle time so this is where good tuning should show the most bonus as it does.

The really
> >interesting data would be the -j64 load without HT, using both schedulers.
> 
> The biggest problems with SMT happen when 1 < Nproc < Nsibs,
> because every two processes that end up on one physical CPU
> leaves one physical CPU idle, and the non HT scheduler can't
> detect or correct this.
> 
> At higher numbers of processes, you fill all virtual CPUs,
> so physical CPUs don't become idle. You can still be smarter
> about cache and migration costs though.
> 
> >I just got done looking at a mail server with HT, kept the load avg 40-70
> >for a week. Speaks highly for the stability of RHEL-3.0, but I wouldn't
> >mind a little more performance for free.
> 
> Not sure if they have any sort of HT aware scheduler or not.
> If they do it is probably a shared runqueues type which is
> much the same as sched domains in terms of functionality.
> I don't think it would help much here though.

I think any bonus on the optimal and max loads on kernbench is remarkable since
it's usually easy to keep all cpus busy when the load is 4xnum_cpus or higher.
The fact that sched_domains shows a decent percentage bonus even with these
loads speaks volumes about the effectiveness of this patch.

Con
