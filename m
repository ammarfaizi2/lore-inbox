Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSG1VeV>; Sun, 28 Jul 2002 17:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSG1VeV>; Sun, 28 Jul 2002 17:34:21 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:15110 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317427AbSG1VeU>; Sun, 28 Jul 2002 17:34:20 -0400
Date: Sun, 28 Jul 2002 18:36:58 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: inlines in kernel/sched.c
In-Reply-To: <Pine.LNX.4.44.0207282309430.5116-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L.0207281833310.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2002, Ingo Molnar wrote:
> On Sun, 28 Jul 2002, Andrew Morton wrote:
>
> > Ingo, could you please review the use of inlines in the
> > scheduler sometime?  They seem to be excessive.
> >
> > For example, this patch reduces the sched.d icache footprint
> > by 1.5 kilobytes.
>
> the patch also hurts context-switch latencies - it went
> from 1.35 usecs to 1.42 usecs - a 5% drop.

That's 140 cpu cycles on a 2 GHz CPU, probably less time than
what a single cache miss would cost for non-scheduler-intensive
workloads.

This would mean that for a workload which is doing real work,
and pushes the scheduler out of the L1 cache, the slowdown
would be a lot more simply due to the extra cache misses the
extra inlines generate.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

