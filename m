Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUJFDee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUJFDee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 23:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUJFDee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 23:34:34 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:30037 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266821AbUJFDeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 23:34:31 -0400
Message-ID: <416367BC.4090302@yahoo.com.au>
Date: Wed, 06 Oct 2004 13:34:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Robert Love <rml@novell.com>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost> <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au> <20041006020734.GA29383@havoc.gtf.org> <20041006031726.GK26820@dualathlon.random>
In-Reply-To: <20041006031726.GK26820@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> The one argument I've against preempt is that the claim that preempt
> doesn't spread cond_resched all over the place is false. It can spread
> even more of them as implicit ones. They're not visible to the developer
> but they're visible to the cpu. So disabling preempt and putting
> finegriend cond_resched should allow us to optimize the code better, and
> actually _reduce_ the number of cond_resched (cond_resched as the ones
> visible to the cpu, not the ones visible to the kernel developer).
> 

You are right. Sort of :)

But 1, we *want* them to be less visible to the kernel developer,
so this is still a plus.

2, delimiting critical sections with the checks (as preempt does)
rigorously defines scheduling latency as the minimum possible (ie.
critical section latency).

3, all of the overhead is removed if you don't care about latency
and thus turn off preempt.

> I wonder if anybody ever counted the number of implicit cond_resched
> placed by preempt and compared them to the number of explicit
> cond_resched needed without preempt.
> 

There is no denying that there is a performance penalty with preempt
Actually it has to pay double because the bkl means it can't optimise
cond_resched away entirely (would be nice to kill the bkl one day).

But I think that the impact is small enough so that nobody who wants
sub-ms latency will care.
