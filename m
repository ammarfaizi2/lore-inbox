Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUJFDQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUJFDQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 23:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266805AbUJFDQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 23:16:37 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:46044 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S266802AbUJFDQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 23:16:35 -0400
Date: Wed, 6 Oct 2004 05:17:26 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Robert Love <rml@novell.com>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata, VIA SATA))
Message-ID: <20041006031726.GK26820@dualathlon.random>
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost> <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au> <20041006020734.GA29383@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006020734.GA29383@havoc.gtf.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 05, 2004 at 10:07:34PM -0400, Jeff Garzik wrote:
> Hiding that stuff means that users and developers won't see code paths
> that need fixing.  If users and developers aren't aware of code paths

with any decent profiler places where we're wasting cpus will showup
immediatatly, one obvious example that I can recall is the pte_chains
rmap code, that wasn't necessairly high latency but still it was very
wasteful in terms of cpu, was always at the top of the profiling.

So I disagree with your claim that preempt risks to hide inefficient
code, there are many other (probably easier) ways to detect inefficient
code than to check the latencies.

The one argument I've against preempt is that the claim that preempt
doesn't spread cond_resched all over the place is false. It can spread
even more of them as implicit ones. They're not visible to the developer
but they're visible to the cpu. So disabling preempt and putting
finegriend cond_resched should allow us to optimize the code better, and
actually _reduce_ the number of cond_resched (cond_resched as the ones
visible to the cpu, not the ones visible to the kernel developer).

I wonder if anybody ever counted the number of implicit cond_resched
placed by preempt and compared them to the number of explicit
cond_resched needed without preempt.
