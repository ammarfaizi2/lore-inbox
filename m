Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUHDHov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUHDHov (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 03:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUHDHov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 03:44:51 -0400
Received: from holomorphy.com ([207.189.100.168]:2746 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267304AbUHDHot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 03:44:49 -0400
Date: Wed, 4 Aug 2004 00:44:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
Message-ID: <20040804074440.GL2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Williams <pwil3058@bigpond.net.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
References: <20040802134257.GE2334@holomorphy.com> <410EDD60.8040406@bigpond.net.au> <20040803020345.GU2334@holomorphy.com> <410F08D6.5050200@bigpond.net.au> <20040803104912.GW2334@holomorphy.com> <41102FE5.9010507@bigpond.net.au> <20040804005034.GE2334@holomorphy.com> <41103DBB.6090100@bigpond.net.au> <20040804015115.GF2334@holomorphy.com> <41104C8F.9080603@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41104C8F.9080603@bigpond.net.au>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> One may either demote to evict MAX_RT_PRIO immediately prior to
>> rotation or rely on timeslice expiry to evict MAX_RT_PRIO. Forcibly
>> evicting MAX_RT_PRIO undesirably accumulates tasks at the fencepost.

On Wed, Aug 04, 2004 at 12:40:15PM +1000, Peter Williams wrote:
> It's starting to get almost as complex as the current scheme :-)

Compare it to the background scan of the queue if several (potentially
numerous) events whose handling has been deferred are to be processed
when timer device interrupts are delivered at irregular intervals, or
not at all.


William Lee Irwin III wrote:
>> This is an alternative to scheduler accounting in context switches.
>> Periodicity often loses power conservation benefits.

On Wed, Aug 04, 2004 at 12:40:15PM +1000, Peter Williams wrote:
> The timer would be deactivated whenever the number of runnable tasks for 
> the runqueue goes below 2.  The whole thing could be managed from the 
> enqueue and dequeue functions i.e.
> dequeue - if the number running is now less than two cancel the timer 
> and otherwise decrease the expiry time to maintain the linear 
> relationship of the interval with the number of runnable tasks
> enqueue - if the number of runnable tasks is now 2 then start the time 
> with a single interval setting and if the number is greater than two 
> then increase the timer interval to maintain the linear relationship.
> I'm assuming here that add_timer(), del_timer() and (especially) 
> mod_timer() are relatively cheap.  If mod_timer() is too expensive some 
> alternative method could be devised to maintain the linear relationship.

Naive schemes reprogram the timer device too frequently. Software
constructs are less of a concern. This also presumes that taking timer
interrupts when cpu-intensive workloads voluntarily yield often enough
is necessary or desirable. This is not so in virtualized environments,
and unnecessary interruption of userspace also degrades performance.


-- wli
