Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272454AbTHEGLJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 02:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272455AbTHEGLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 02:11:09 -0400
Received: from anumail3.anu.edu.au ([150.203.2.43]:6324 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S272454AbTHEGLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 02:11:05 -0400
Message-ID: <3F2F4076.1030009@cyberone.com.au>
Date: Tue, 05 Aug 2003 15:28:22 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.2.1) Gecko/20021217
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <200308051220.04779.kernel@kolivas.org> <3F2F149F.1020201@cyberone.com.au> <200308051318.47464.kernel@kolivas.org> <3F2F2517.7080507@cyberone.com.au> <1060059844.3f2f3ac46e2f2@kolivas.org> <3F2F3CC6.2060307@cyberone.com.au> <1060060568.3f2f3d989683f@kolivas.org>
In-Reply-To: <1060060568.3f2f3d989683f@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-2.8)
X-Spam-Tests: DATE_IN_PAST_06_12,EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,SPAM_PHRASE_02_03,USER_AGENT,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>Quoting Nick Piggin <piggin@cyberone.com.au>:
>

snip

>
>>Oh, I'm not saying that your change is outright wrong, on the contrary I'd
>>say you have a better feel for what is needed than I do, but if you are 
>>finding
>>that the uninterruptible sleep case needs some tweaking then the same tweak
>>should be applied to all sleep cases. If there really is a difference, 
>>then its
>>just a fluke that the sleep paths in question use the type of sleep you are
>>testing for, and nothing more profound than that.
>>
>
>Ah I see. It was from my observations of the behaviour of tasks in D that 
>found it was the period spent in D that was leading to unfairness. The same 
>tweak can't be applied to the rest of the sleeps because that inactivates 
>everything. So it is a fluke that the thing I'm trying to penalise is what 
>tasks in uninterruptible sleep do, but it is by backward observation of D 
>tasks, not random chance.
>

Yes yes, but we come to the same conclusion no matter why you have decided
to make the change ;) namely that you're only papering over a flaw in the
scheduler!

What happens in the same sort of workload that is using interruptible 
sleeps?
Say the same make -j NFS mounted interrruptible (I think?).

I didn't really understand your answer a few emails ago... please just
reiterate: if the problem is that processes sleeping too long on IO get
too high a priority, then give all processes the same boost after they
have slept for half a second?

Also, why is this a problem exactly? Is there a difference between a
process that would be a CPU hog but for its limited disk bandwidth, and
a process that isn't a CPU hog? Disk IO aside, they are exactly the same
thing to the CPU scheduler, aren't they?

_wants_ to be a CPU hog, but can't due to disk

