Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262272AbSJGAzl>; Sun, 6 Oct 2002 20:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262274AbSJGAzl>; Sun, 6 Oct 2002 20:55:41 -0400
Received: from franka.aracnet.com ([216.99.193.44]:33423 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262272AbSJGAzj>; Sun, 6 Oct 2002 20:55:39 -0400
Date: Sun, 06 Oct 2002 17:58:53 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] NUMA schedulers benchmark results
Message-ID: <1315762666.1033927133@[10.10.2.3]>
In-Reply-To: <200210061851.45401.efocht@ess.nec.de>
References: <200210061851.45401.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As I'm rewriting the node affine scheduler to be more modular, I'll
> redo the tests for cases D, E, F on top of 2.5.X kernels soon.

It's really hard to see anything comparing 2.4 vs 2.5 results,
so when you have results for everything across the same kernel,
it'll be a lot easier to decipher ...

For the record, I really don't care whose code gets accepted, I'm 
just interested in having a scheduler that works well for me ;-) 

However, I think it would be a good idea to run some other benchmarks 
on these, that are a little more general ... dbench, kernel compile, 
sdet, whatever, as *well* as your own benchmark ... I think we're 
working on that.

> Average user time (U) and total user time (TU). Minimum per row should
> be considered.
> ----------------------------------------------------------------------
> Scheduler:      A       B       C       D       E       F
> N=4     U       28.12   30.77   33.00   -       27.20   30.29
> N=8     U       30.47   31.39   31.65   30.76   28.67   30.08
> N=16    U       36.42   33.64   32.18   32.27   31.50   32.83
> N=32    U       38.69   34.83   34.05   33.76   33.89   34.11
> N=64    U       39.73   34.73   34.23   -       (33.32) 34.98

So lower numbers are better, right? So Michael's stuff seems to
work fine at the higher end, but poorly at the lower end - I think
this may be due to a bug he found on Friday, if that gets fixed, it
might make a difference.

> The results are summarized in the tables below. A set of outputs 
> (for N=8, 16, 32) is attached. They show clearly why the node affine
> scheduler beats them all

It would be a lot clearer if you baselines weren't different.
Now maybe I'm just totally misreading your results (tell us if so)
but I presume it's more valid to compare:

1. difference between A and C (2.5 virgin vs 2.5 + Michael's stuff)
vs
2. difference between E and B (2.4 virgin vs 2.4 + your stuff)

rather than across 2.4 vs 2.5, which seems meaningless.

N=32 (E) .... C vs A 80.34 vs 88.60 (about 10% improvement)
              E vs B 76.84 vs 79.92 (about 5% improvement)
N=32 (H) .... C vs A 2.85 vs 6.29 (over 50% improvement)
              E vs B 5.29 vs 5.23 (about 1% impromement)

Which actually makes C better than E on both measures, surely? 
Obviously Michael's stuff is worse at the low end, but to say 
"They show clearly why the node affine scheduler beats them all"
seems a little optimistic ;-) 

I'm not trying to say you're wrong, or one scheduler is better than
the other ... I'm just saying I can't really draw any clear-cut 
conclusion from your results other than that Michael's stuff looks 
borked for low numbers of tasks ...

I'll run your tests on the NUMA-Q comparing 2.5.40 vs Michael's stuff. 
If you send me a cleaned up version (ie without the ia64 stuff in
generic code) of your stuff against 2.5.40 (or ideally 2.5.40-mm2), 
I'll run that too ... (if you're putting the latencies into arch code,
you can set i386 (well NUMA-Q) for 20:1 if you think that'll help).

M.

PS. the wierd "this one was run without hackbench" thing makes the
results even harder to read ...

PPS. Does Kimio's discontigmem patch work for you on 2.5?

