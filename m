Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbRGPBAn>; Sun, 15 Jul 2001 21:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbRGPBAd>; Sun, 15 Jul 2001 21:00:33 -0400
Received: from e23.nc.us.ibm.com ([32.97.136.229]:21488 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267184AbRGPBAT>; Sun, 15 Jul 2001 21:00:19 -0400
Date: Sun, 15 Jul 2001 17:58:56 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Andi Kleen <ak@suse.de>, Mike Kravetz <mkravetz@sequent.com>,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency
Message-ID: <20010715175856.A25299@w-mikek.des.beaverton.ibm.com>
In-Reply-To: <20010712164017.C1150@w-mikek2.des.beaverton.ibm.com> <20010715024255.F3965@altus.drgw.net> <20010715110543.A9981@gruyere.muc.suse.de> <20010715120037.I3965@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010715120037.I3965@altus.drgw.net>; from hozer@drgw.net on Sun, Jul 15, 2001 at 12:00:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 12:00:38PM -0500, Troy Benjegerdes wrote:
> 
> The next very interesting thing I found was that if I run something like 
> 'while true; do true; done' to load the other CPU while gzip is running, 
> gzip runs faster. The time change isn't very large, and appears to be just 
> barely detectable above the noise, but it definetly appears that gzip is 
> bouncing back and forth between cpus if both are idle.
> 
> I'm tempted to try the somewhat brute-force approach of increasing
> PROC_CHANGE_PENALTY, which is currently set to 20 (on ppc) to something
> like 100. Would this be an adequate 'short-term' solution util there is 
> some sort of multi-queue scheduler that everyone Linus likes? What are the 
> drawbacks of increasing PROC_CHANGE_PENALTY?

I'm pretty sure changing the value of PROC_CHANGE_PENALTY will not help
in this case.  PROC_CHANGE_PENALTY becomes increasingly important as
the number of running tasks is increased.  In the case of simply running
one task (like gzip) on your 2 CPU system, I don't think it will make
any difference.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
