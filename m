Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTLOKMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 05:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbTLOKMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 05:12:10 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:5835
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263487AbTLOKMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 05:12:03 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nathan Fredrickson <8nrf@qlink.queensu.ca>
Subject: Re: HT schedulers' performance on single HT processor
Date: Mon, 15 Dec 2003 21:11:52 +1100
User-Agent: KMail/1.5.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>, Ingo Molnar <mingo@elte.hu>,
       Adam Kropelin <akropel1@rochester.rr.com>
References: <200312130157.36843.kernel@kolivas.org> <1071431363.19011.64.camel@rocky>
In-Reply-To: <1071431363.19011.64.camel@rocky>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312152111.52949.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003 06:49, Nathan Fredrickson wrote:
> On Fri, 2003-12-12 at 09:57, Con Kolivas wrote:
> > I set out to find how the hyper-thread schedulers would affect the all
> > important kernel compile benchmark on machines that most of us are likely
> > to encounter soon. The single processor HT machine.
>
> I ran some further tests since I have access to some SMP systems with HT
> (1, 2 and 4 physical processors).

> I can also run the same on four physical processors if there is
> interest.

>              j =  1     2     3     4     8
> 1phys (uniproc)  1.00  1.00  1.00  1.00  1.00
> 1phys w/HT       1.02  1.02  0.87  0.87  0.87
> 1phys w/HT (w26) 1.02  1.02  0.87  0.87  0.88
> 1phys w/HT (C1)  1.03  1.02  0.88  0.88  0.88
> 2phys            1.00  1.00  0.53  0.53  0.53
> 2phys w/HT       1.01  1.01  0.64  0.50  0.48
> 2phys w/HT (w26) 1.02  1.01  0.55  0.49  0.47
> 2phys w/HT (C1)  1.02  1.01  0.53  0.50  0.48

The specific HT scheduler benefits only start appearing with more physical 
cpus which is to be expected. Just for demonstration the four processor run 
would be nice (and obviously take you less time to do ;). I think it will 
demonstrate it even more. It would be nice to help the most common case of 
one HT cpu, though, instead of hindering it.

Adam already pointed out that you -j2 didn't really get you 2 jobs. I was 
using a 2.4 kernel tree for the benchmarks and j2 was giving me two jobs 
although perhaps something about the C1 patch was preventing the second job 
from ever taking off which is why the result is the same as one job in my 
benches. Curious.

> > Conclusion?
> > If you run nothing but kernel compiles all day on a P4 HT, make sure you
> > compile it for SMP ;-)
>
> And make sure you compile with the -jX option with X >= logical_procs+1

Of course. For now on the uniprocessor HT setup I'd recommend the unmodified 
scheduler in SMP mode.

Con

