Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275351AbTHSFRn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 01:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275340AbTHSFRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 01:17:43 -0400
Received: from waste.org ([209.173.204.2]:4785 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S275351AbTHSFQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 01:16:03 -0400
Date: Tue, 19 Aug 2003 00:15:33 -0500
From: Matt Mackall <mpm@selenic.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] new scheduler policy
Message-ID: <20030819051533.GL16387@waste.org>
References: <3F4182FD.3040900@cyberone.com.au> <20030819023536.GZ32488@holomorphy.com> <3F418F7A.7090007@cyberone.com.au> <3F4192AD.1020305@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4192AD.1020305@cyberone.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 12:59:57PM +1000, Nick Piggin wrote:
> 
> 
> Nick Piggin wrote:
> 
> >
> >
> >William Lee Irwin III wrote:
> >
> >>On Tue, Aug 19, 2003 at 11:53:01AM +1000, Nick Piggin wrote:
> >>
> >>>As per the latest trend these days, I've done some tinkering with
> >>>the cpu scheduler. I have gone in the opposite direction of most
> >>>of the recent stuff and come out with something that can be nearly
> >>>as good interactivity wise (for me).
> >>>I haven't run many tests on it - my mind blanked when I tried to
> >>>remember the scores of scheduler "exploits" thrown around. So if
> >>>anyone would like to suggest some, or better still, run some,
> >>>please do so. And be nice, this isn't my type of scheduler :P
> >>>It still does have a few things that need fixing but I thought
> >>>I'd get my first hack a bit of exercise.
> >>>Its against 2.6.0-test3-mm1
> >>>
> >>
> >>Say, any chance you could spray out a brief explanation of your new
> >>heuristics?
> >>
> >
> >Oh alright. BTW, this one's not for your big boxes yet! It does funny
> >things with timeslices. But they will be (pending free time) made much
> >more dynamic, so it should _hopefully_ context switch even less than
> >the normal scheduler in a compute intensive load.
> >
> >OK. timeslices: they are now dynamic. Full priority tasks will get
> >100ms, minimum priority tasks 10ms (this is what needs fixing, but
> >should be OK to test "interactiveness")
> >
> >interactivity estimator is gone: grep -i interactiv sched.c | wc -l
> >gives 0.
> >
> >priorities are much the same, although processes are supposed to be
> >able to change priority much more quickly.
> >
> >backboost is back. that is what (hopefully) prevents X from starving
> >due to the quickly changing priorities thing.
> 
>  And lack of interactivity estimator.

You forgot to mention fork() splitting its timeslice 2/3 to 1/3 parent
to child.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
