Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267509AbRGMRGc>; Fri, 13 Jul 2001 13:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267512AbRGMRGY>; Fri, 13 Jul 2001 13:06:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:40075 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267509AbRGMRGD>; Fri, 13 Jul 2001 13:06:03 -0400
Date: Fri, 13 Jul 2001 10:05:21 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, lse-tech@lists.sourceforge.net,
        Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: CPU affinity & IPI latency
Message-ID: <20010713100521.D1137@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20010712164017.C1150@w-mikek2.des.beaverton.ibm.com> <XFMail.20010712172255.davidel@xmailserver.org> <20010712173641.C11719@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010712173641.C11719@work.bitmover.com>; from lm@bitmover.com on Thu, Jul 12, 2001 at 05:36:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 05:36:41PM -0700, Larry McVoy wrote:
> Be careful tuning for LMbench (says the author :-)
> 
> Especially this benchmark.  It's certainly possible to get dramatically better
> SMP numbers by pinning all the lat_ctx processes to a single CPU, because 
> the benchmark is single threaded.  In other words, if we have 5 processes,
> call them A, B, C, D, and E, then the benchmark is passing a token from
> A to B to C to D to E and around again.  
> 
> If the amount of data/instructions needed by all 5 processes fits in the 
> cache and you pin all the processes to the same CPU you'll get much 
> better performance than simply letting them float.
> 
> But making the system do that naively is a bad idea.

I agree, and can't imagine the system ever attempting to take this
into account and leave these 5 tasks on the same CPU.

At the other extreme is my observation that 2 tasks on an 8 CPU
system are 'round robined' among all 8 CPUs.  I think having the
2 tasks stay on 2 of the 8 CPUs would be an improvement with respect
to CPU affinity.  Actually, the scheduler does 'try' to do this.

It is clear that the behavior of lat_ctx bypasses almost all of
the scheduler's attempts at CPU affinity.  The real question is,
"How often in running 'real workloads' are the schduler's attempts
at CPU affinity bypassed?".

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
