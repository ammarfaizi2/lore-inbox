Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264762AbUFHF0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbUFHF0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 01:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbUFHFZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 01:25:59 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:57864 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S264762AbUFHFZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 01:25:54 -0400
Message-ID: <1086663751.40c52c4753872@vds.kolivas.org>
Date: Tue,  8 Jun 2004 13:02:31 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca, wli@holomorphy.com
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
References: <200406080712.44759.kernel@kolivas.org> <20040607214034.27475.qmail@web51807.mail.yahoo.com> <20040607195011.34f8e84e.akpm@osdl.org>
In-Reply-To: <20040607195011.34f8e84e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@osdl.org>:

> Phy Prabab <phyprabab@yahoo.com> wrote:
> >
> > Also please note the degredation between
> >  2.6.7-rc2-bk8-s63:
> > 
> >  A:  35.57user 38.18system 1:20.28elapsed 91%CPU
> >  B:  35.54user 38.40system 1:19.48elapsed 93%CPU
> >  C:  35.48user 38.28system 1:20.94elapsed 91%CPU
> > 
> >  Interesting how much more time is spent in both user
> >  and kernel space between the two kernels.  Also note
> >  that 2.4.x exhibits even greater delta:
> > 
> >  A:  28.32user 29.51system 1:01.17elapsed 93%CPU
> >  B:  28.54user 29.40system 1:01.48elapsed 92%CPU
> >  B:  28.23user 28.80system 1:00.21elapsed 94%CPU
> > 
> >  Could anyone suggest a way to understand why the
> >  difference between the 2.6 kernels and the 2.4
> >  kernels?
> 
> This is very very bad.
> 
> It's a uniprocessor machine, yes?
> 
> Could you describe the workload a bit more?  Is it something which others
> can get their hands on?
> 
> It spends a lot of time in the kernel for a build system.  I wonder why.
> 
> At a guess I'd say either a) you're hitting some path in the kernel which
> is going for a giant and bogus romp through memory, trashing CPU caches or
> b) your workload really dislikes run-child-first-after-fork or c) the page
> allocator is serving up pages which your access pattern dislikes or d)
> something else.
> 
> It's certainly interesting.

Ordinary kernbench on 8x OSDL hardware fails to show anything like this:
Summary:
time in seconds for optimal run:
2.6.7-rc2: 129.948
2.6.7-rc2-s6.3: 129.528
2.6.7-rc2-s6.3compute: 127.63

Detailed:
kernel: patch-2.6.7-rc2
plmid: 2987
Host: stp8-002
Average Optimal -j 32 Load Run:
Elapsed Time 129.948
User Time 873.302
System Time 86.318
Percent CPU 738
Context Switches 39853.4
Sleeps 29045.8
Average Maximal -j Load Run:
Elapsed Time 128.362
User Time 866.274
System Time 84.352
Percent CPU 740
Context Switches 25742.6
Sleeps 20615.8
Average Half Load -j 4 Run:
Elapsed Time 231.04
User Time 833.69
System Time 72.94
Percent CPU 392
Context Switches 12672.2
Sleeps 22267.2


kernel: staircase6.2
plmid: 3002
Host: stp8-002
Average Optimal -j 32 Load Run:
Elapsed Time 129.528
User Time 873.866
System Time 85.372
Percent CPU 740.2
Context Switches 38286.6
Sleeps 28331
Average Maximal -j Load Run:
Elapsed Time 128.074
User Time 862.728
System Time 85.842
Percent CPU 740.2
Context Switches 20894
Sleeps 22189.2
Average Half Load -j 4 Run:
Elapsed Time 230.942
User Time 833.03
System Time 71.126
Percent CPU 391
Context Switches 3467
Sleeps 22389.2


kernel: crunchah6.3
plmid: 3008
Host: stp8-002
Average Optimal -j 32 Load Run:
Elapsed Time 127.63
User Time 861.668
System Time 83.078
Percent CPU 739.6
Context Switches 19818.4
Sleeps 28442.6
Average Maximal -j Load Run:
Elapsed Time 127.354
User Time 856.632
System Time 82.952
Percent CPU 737
Context Switches 12389.2
Sleeps 21788.6
Average Half Load -j 4 Run:
Elapsed Time 230.8
User Time 833.378
System Time 71.304
Percent CPU 391.6
Context Switches 3738.4
Sleeps 22288.6


Con

