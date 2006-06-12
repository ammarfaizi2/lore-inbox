Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWFLUQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWFLUQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbWFLUQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:16:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:57004 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751294AbWFLUQS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:16:18 -0400
Date: Mon, 12 Jun 2006 13:12:45 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Darren Hart <dvhltc@us.ibm.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH -rt] Priority preemption latency
Message-ID: <20060612201245.GA16771@w-mikek2.ibm.com>
References: <200606091701.55185.dvhltc@us.ibm.com> <20060610064850.GA11002@elte.hu> <200606102249.26063.dvhltc@us.ibm.com> <200606102324.58932.dvhltc@us.ibm.com> <20060611073609.GA12456@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060611073609.GA12456@elte.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2006 at 09:36:09AM +0200, Ingo Molnar wrote:
> ok - could you try the patch from today (re-attached below)? Maybe that 
> theoretical scenario i mentioned is only theoretical in theory ;-)

Thanks for the patch!

I just started looking at the RT scheduling code and am trying to
get a good understanding of what is happening.

In the case where the task on the current CPU can not be preempted,
we send IPIs to all other CPUs and they end up running the
balance_rt_tasks() routine to try and schedule the task.  Is
that correct?  If the newly awakened task can preempt more than one
currently running RT task, then is it possible for tasks to 'bounce
around' a bit before we end up running the top N priority RT tasks
(where N is the number of CPUs)?

In the case where the newly awakened task can preempt the task on the
current CPU, shouldn't we also trigger reschedules on other CPUs?
Perhaps we do somewhere and I am missing it.  I am thinking of the
case where the current CPU was running a RT task with lower priority
than the awakened task.  But, another CPU is running an even lower
priority RT task.  In this case, we really want the newly awakened task
to preempt the lower priority task on the remote CPU.

Thanks,
-- 
Mike
