Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314935AbSDVXPx>; Mon, 22 Apr 2002 19:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314934AbSDVXPw>; Mon, 22 Apr 2002 19:15:52 -0400
Received: from zero.tech9.net ([209.61.188.187]:41228 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314925AbSDVXPs>;
	Mon, 22 Apr 2002 19:15:48 -0400
Subject: Re: in_interrupt race
From: Robert Love <rml@tech9.net>
To: paulus@samba.org
Cc: george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <15556.38775.439624.762586@argo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 22 Apr 2002 19:15:52 -0400
Message-Id: <1019517352.1469.19.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-22 at 19:06, Paul Mackerras wrote:

> > If (b) we are preemptible, and then it does not matter what happens
> > during this check, since we are not preemptible and the check won't
> > return a false true.
> 
> Huh?  First you say we are preemptible, then you say we are not, in
> the same sentence?

Sorry - yes, we are preemptible.  I meant to say even if we do preempt,
we still end up returning false, which is all we care about.

> No.  The point is that in_interrupt() asks two separate questions:
> (1) which cpu are we on?  (2) is that cpu in interrupt context?
> If we switch cpus between (1) and (2) then we can get a false positive
> from in_interrupt().

How can we get a false positive?  Positive => we are in an interrupt. 
If we are in an interrupt, we can't preempt, so this is not an issue.

Negative => we are not in an interrupt.  Even if we do preempt, we
preempt to a CPU where we are _also_ not in an interrupt, so we get the
same answer.  In other words, if we preempt, no matter where we were or
where we end up, in_interrupt is (correctly) false.

> > This says nothing of the CPU you may of been on, but then who cares
> > about it?
> 
> We don't care about any cpu, what we want to know is whether the
> current thread of execution is in process context or not.  Which is
> why it is bogus for in_interrupt to need to ask which cpu we are on,
> and why the local_bh_count and local_irq_count should go in the
> thread_info struct IMHO.  I am working on that now. :)

Right, but I don't see a flaw (as noted previously) in the current
scheme... if preemption is a problem, then we are certainly in process
context so it is a non-issue!

	Robert Love

