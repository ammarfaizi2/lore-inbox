Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267533AbRGMTlX>; Fri, 13 Jul 2001 15:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbRGMTlN>; Fri, 13 Jul 2001 15:41:13 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:30873 "EHLO
	e33.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267533AbRGMTlC>; Fri, 13 Jul 2001 15:41:02 -0400
Message-Id: <200107131939.f6DJdb921665@eng2.sequent.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net,
        Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        Larry McVoy <lm@bitmover.com>
Reply-To: Gerrit Huizenga <gerrit@us.ibm.com>
From: Gerrit Huizenga <gerrit@us.ibm.com>
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency 
In-Reply-To: Your message of Fri, 13 Jul 2001 12:17:37 PDT.
             <XFMail.20010713121737.davidel@xmailserver.org> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21660.995053177.1@eng2.sequent.com>
Date: Fri, 13 Jul 2001 12:39:37 PDT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 13 Jul 2001 12:17:37 PDT, Davide Libenzi wrote:
> 
> The problem, IMHO, is that we're trying to extend what is a correct
> behaviour on the UP scheduler ( pickup the best task to run ) to SMP
> machines.  Global scheduling decisions should be triggered in response
> of load unbalancing and not at each schedule() run otherwise we're
> going to introduce a common lock that will limit the overall
> scalability.  My idea about the future of the scheduler is to have a
> config options users can chose depending upon the machine use.
> 
> By trying to keep a unique scheduler for both UP and MP is like going
> to give the same answer to different problems and the scaling factor
> (of the scheduler itself) on SMP will never improve.  The code inside
> kernel/sched.c should be reorganized ( it contains even not scheduler
> code ) so that the various CONFIG_SCHED* will not introduce any messy
> inside the code ( possibly by having the code in separate files
> kernel/sched*.c ).
> 
> - Davide

In a lot of cases, UP is just a simplified, degenerate case of SMP (which
is itself often a degenerate case of NUMA).  Wouldn't it make a lot of
sense to have a single scheduler which 1) was relively simple, 2) was as
good as the current scheduler (or better) on UP, and 3) scaled well on SMP (and
NUMA)?  I think the current lse scheduler meets all of those goals pretty
well.

Config options means the user has to choose, I have too many important
choices to make already when building a kernel.

Others have proposed loadable scheduler modules, but the overhead doesn't
seem to justify the separation.  Config options mean more testing, more
stable APIs for low level scheduling (or more times when one or the other
is broken).

gerrit
