Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319169AbSHTPtD>; Tue, 20 Aug 2002 11:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319170AbSHTPtD>; Tue, 20 Aug 2002 11:49:03 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59571 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319169AbSHTPtC>;
	Tue, 20 Aug 2002 11:49:02 -0400
Date: Tue, 20 Aug 2002 17:54:24 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Mohamed Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Ingo Scheduler
In-Reply-To: <5F0021EEA434D511BE7300D0B7B6AB5303C7874E@mail2.ggn.hcltech.com>
Message-ID: <Pine.LNX.4.44.0208201749330.3884-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Aug 2002, Mohamed Ghouse , Gurgaon wrote:

>  When the process A (from active queue) has completed its Quantum,
> Scheduler moves process A to the expired queue. & when the active queue
> is empty, the expired queue becomes the active queue & the active queue
> becomes the expired

yes, this is called the 'array switch'. [the unit switched is not a queue,
but an array of queues.]

> The active queue (expired queue) has accumulated the process. It is
> almost similar to the previous active queue. How does the Introduction
> of the expired queue reduce the Time Complexity from O(n) to O(1).

the queue arrays themselves are indexed by priority.

> as my understanding goest that the scheduler needs to produce "process's
> goodness", so the time complexity remains the same.

the new scheduler is not 100% equivalent to the old one - but the concepts
are pretty close. The changes that were done are:  different [better]
cache affinity logic, different [better] interactivity detection, better
yield() implementation, different timeslice lengths.

> Another point of non-understanding is Why does the scheduler need to
> know the scheduling class to produce process's goodness?

an RT task needs to be scheduled before any other task.

in the new scheduler RT tasks are in essence just tasks with higher
priority.

	Ingo

