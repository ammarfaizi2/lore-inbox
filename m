Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266126AbUGJD6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbUGJD6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 23:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUGJD6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 23:58:14 -0400
Received: from ultra1.eskimo.com ([204.122.16.64]:62982 "EHLO
	ultra1.eskimo.com") by vger.kernel.org with ESMTP id S266126AbUGJD6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 23:58:13 -0400
Date: Fri, 9 Jul 2004 20:57:37 -0700
From: Elladan <elladan@eskimo.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Likelihood of rt_tasks
Message-ID: <20040710035737.GA7552@eskimo.com>
References: <40EE6CC2.8070001@kolivas.org> <40EF2FF2.6000001@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EF2FF2.6000001@bigpond.net.au>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 09:53:22AM +1000, Peter Williams wrote:
> Con Kolivas wrote:
>
> >While rt tasks are normally unlikely, what happens in the case when you 
> >are scheduling one or many running rt_tasks and the majority of your 
> >scheduling is rt? Would it be such a good idea in this setting that it 
> >is always hitting the slow path of branching all the time?
> 
> Even when this isn't the case you don't want to make all rt_task() 
> checks "unlikely".  In particular, during "wake up" using "unlikely" 
> around rt_task() will increase the time that it takes for SCHED_FIFO 
> tasks to get onto the CPU when they wake which will be bad for latency 
> (which is generally important to these tasks as evidenced by several 
> threads on the topic).

Average wall speed of RT task wakeup isn't really an issue - the issue
is deterministic worst-case latency.  Adding a hundred cycles every time
won't cause someone to miss a deadline.  The deadlines need to be based
on the worst case, where the cache is 100% cold and you're at the
beginning of a long-held mutex section etc.

An unlikely branch won't have any measurable effect on worst-case wakeup
latency, but will reduce the average impact of the test on the common
fast path for normal processes.

I don't see how this is anything but a good idea.

-J
