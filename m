Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269746AbUINTcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269746AbUINTcy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269703AbUINT3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:29:45 -0400
Received: from peabody.ximian.com ([130.57.169.10]:65209 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269333AbUINT1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:27:40 -0400
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
From: Robert Love <rml@ximian.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040914192104.GB9106@holomorphy.com>
References: <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au>
	 <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au>
	 <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au>
	 <20040914150316.GN4180@dualathlon.random>
	 <1095185103.23385.1.camel@betsy.boston.ximian.com>
	 <20040914185212.GY9106@holomorphy.com>
	 <1095188569.23385.11.camel@betsy.boston.ximian.com>
	 <20040914192104.GB9106@holomorphy.com>
Content-Type: text/plain
Date: Tue, 14 Sep 2004 15:26:42 -0400
Message-Id: <1095190002.23385.27.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 12:21 -0700, William Lee Irwin III wrote:

> Far from "just throw away" -- this is hard work! Very hard work, and a
> number of people have already tried and failed.

That is my point.

> The "safely call schedule() while holding it" needs quite a bit of
> qualification; it's implicitly dropped during voluntary context
> switches and reacquired when rescheduled, but it's not valid to force
> such a task into an involuntary context switch and calling schedule()
> implies dropping the lock, so it has to be done at the proper times.
> This is a complex semantic that likely trips up numerous callers (as
> well as attempts to explain it, though surely you know these things,
> and merely wanted a shorter line for the bullet point).

Right.  I meant safe against deadlocks.  It obviously is not "safe" to
reschedule in the middle of your critical region.

> I'd actually like to go the opposite direction from Ingo: I'd like to
> remove uses of the sleeping characteristic first, as in my mind that is
> the most pernicious and causes the most subtleties. Afterward, the
> recursion. Except it's unclear that I have the time/etc. resources to
> address it apart from taking on small pieces of whatever auditing work
> or sweeps others care to devolve to me, so I'll largely be using
> whatever tactic whoever cares to drive all this (probably Alan) prefers.

This, too, is exactly what I am saying.

I want to remove the sleep characteristic.

One way to do that is start special casing it.  Document it with the
code, e.g. make an explicit cond_resched_bkl().

	Robert Love


