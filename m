Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267529AbRGMTOk>; Fri, 13 Jul 2001 15:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267530AbRGMTOU>; Fri, 13 Jul 2001 15:14:20 -0400
Received: from sncgw.nai.com ([161.69.248.229]:6139 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S267529AbRGMTOS>;
	Fri, 13 Jul 2001 15:14:18 -0400
Message-ID: <XFMail.20010713121737.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010713103144.E1137@w-mikek2.des.beaverton.ibm.com>
Date: Fri, 13 Jul 2001 12:17:37 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Mike Kravetz <mkravetz@sequent.com>
Subject: Re: CPU affinity & IPI latency
Cc: lse-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13-Jul-2001 Mike Kravetz wrote:
> On Fri, Jul 13, 2001 at 09:41:44AM -0700, Davide Libenzi wrote:
>> 
>> I personally think that a standard scheduler/cpu is the way to go for SMP.
>> I saw the one IBM guys did and I think that the wrong catch there is trying
>> always to grab the best task to run over all CPUs.
> 
> That was me/us.  Most of the reason for making 'global scheduling'
> decisions was an attempt to maintain the same behavior as the existing
> scheduler.  We are trying to see how well we can make this scheduler
> scale, while maintaining this global behavior.  Thought is that if
> there was ever any hope of someone adopting this scheduler, they would
> be more likely to do so if it attempted to maintain existing behavior.

The problem, IMHO, is that we're trying to extend what is a correct behaviour on
the UP scheduler ( pickup the best task to run ) to SMP machines.
Global scheduling decisions should be triggered in response of load unbalancing
and not at each schedule() run otherwise we're going to introduce a common lock
that will limit the overall scalability.
My idea about the future of the scheduler is to have a config options users can
chose depending upon the machine use.
By trying to keep a unique scheduler for both UP and MP is like going to give
the same answer to different problems and the scaling factor ( of the scheduler
itself ) on SMP will never improve.
The code inside kernel/sched.c should be reorganized ( it contains even not
scheduler code ) so that the various CONFIG_SCHED* will not introduce any messy
inside the code ( possibly by having the code in separate files
kernel/sched*.c ).




- Davide

