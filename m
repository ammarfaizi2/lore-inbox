Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272442AbTHEFQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 01:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272443AbTHEFQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 01:16:21 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:16540
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272442AbTHEFQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 01:16:14 -0400
Message-ID: <1060060568.3f2f3d989683f@kolivas.org>
Date: Tue,  5 Aug 2003 15:16:08 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <200308051220.04779.kernel@kolivas.org> <3F2F149F.1020201@cyberone.com.au> <200308051318.47464.kernel@kolivas.org> <3F2F2517.7080507@cyberone.com.au> <1060059844.3f2f3ac46e2f2@kolivas.org> <3F2F3CC6.2060307@cyberone.com.au>
In-Reply-To: <3F2F3CC6.2060307@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Piggin <piggin@cyberone.com.au>:

> Con Kolivas wrote:
> 
> >Quoting Nick Piggin <piggin@cyberone.com.au>:
> >
> >
> >>
> >>Con Kolivas wrote:
> >>
> >>
> >>>On Tue, 5 Aug 2003 12:21, Nick Piggin wrote:
> >>>
> >>>
> >>>>No, this still special-cases the uninterruptible sleep. Why is this
> >>>>needed? What is being worked around? There is probably a way to
> >>>>attack the cause of the problem.
> >>>>
> >>>>
> >>>Footnote: I was thinking of using this to also _elevate_ the dynamic
> >>>
> >>priority 
> >>
> >>>of tasks waking from interruptible sleep as well which may help
> throughput.
> >>>
> >>>
> >>Con, an uninterruptible sleep is one which is not be woken by a signal,
> >>an interruptible sleep is one which is. There is no other connotation.
> >>What happens when read/write syscalls are changed to be interruptible?
> >>I'm not saying this will happen... but come to think of it, NFS probably
> >>has interruptible read/write.
> >>
> >>In short: make the same policy for an interruptible and an uninterruptible
> >>sleep.
> >>
> >
> >That's the policy that has always existed...
> >
> >Interesting that I have only seen the desired effect and haven't noticed any
> 
> >side effect from this change so far. I'll keep experimenting as much as 
> >possible (as if I wasn't going to) and see what the testers find as well.
> >
> 
> Oh, I'm not saying that your change is outright wrong, on the contrary I'd
> say you have a better feel for what is needed than I do, but if you are 
> finding
> that the uninterruptible sleep case needs some tweaking then the same tweak
> should be applied to all sleep cases. If there really is a difference, 
> then its
> just a fluke that the sleep paths in question use the type of sleep you are
> testing for, and nothing more profound than that.

Ah I see. It was from my observations of the behaviour of tasks in D that 
found it was the period spent in D that was leading to unfairness. The same 
tweak can't be applied to the rest of the sleeps because that inactivates 
everything. So it is a fluke that the thing I'm trying to penalise is what 
tasks in uninterruptible sleep do, but it is by backward observation of D 
tasks, not random chance.

Con
