Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVG0RGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVG0RGp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVG0REQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:04:16 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:41899 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262314AbVG0RCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:02:10 -0400
Date: Wed, 27 Jul 2005 19:01:42 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
In-Reply-To: <42E7B1A4.2070900@cybsft.com>
Message-Id: <Pine.OSF.4.05.10507271852030.3210-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005, K.R. Foley wrote:

> Esben Nielsen wrote:
> > On Wed, 27 Jul 2005, Ingo Molnar wrote:
> > 
> > 
> >>* Steven Rostedt <rostedt@goodmis.org> wrote:
> >>
> >>
> >>>Perfectly understood.  I've had two customers ask me to increase the 
> >>>priorities for them, but those where custom kernels, and a config 
> >>>option wasn't necessary. But since I've had customers asking, I 
> >>>thought that this might be something that others want.  But I deal 
> >>>with a niche market, and what my customers want might not be what 
> >>>everyone wants. (hence the RFC in the subject).
> >>>
> >>>So if there are others out there that would prefer to change their 
> >>>priority ranges, speak now otherwise this patch will go by the waste 
> >>>side.
> >>
> >>i'm not excluding that this will become necessary in the future. We 
> >>should also add the safety check to sched.h - all i'm suggesting is to 
> >>not make it a .config option just now, because that tends to be fiddled 
> >>with.
> >>
> > 
> > Isn't there a way to mark it "warning! warning! dangerous!" ?
> > 
> > Anyway: I think 100 RT priorities is way overkill - and slowing things
> > down by making the scheduler checking more empty slots in the runqueue.
> > Default ought to be 10. In practise it will be very hard to have
> > a task at the lower RT priority behaving real-time with 99 higher
> > priority tasks around. I find it hard to believe that somebody has an RT
> > app needing more than 10 priorities and can't do with RR or FIFO
> > scheduling within a fewer number of prorities.
> > 
> > Esben
> > 
> 
> Actually, is it really that slow to search a bitmap for a slot that 
> needs processing? 
No, it is ultra fast - but done very often.

> I work on real-time test stands which are less of an 
> embedded system and more of a real Unix system that require determinism. 
> It is very nice in some cases to have more than 10 RT priorities to work 
> with.

What for? Why can't you use FIFO at the same priorities for some of your
tasks? I pretty much quess you have a very few tasks which have some high
requirements. The rest of you "RT" task could easily share the lowest RT
priority. FIFO would also be more effective as you will have context
switches.

This about multiple priorities probably comes from an ordering of tasks:
You have a lot of task. You have a feeling about which one ought to be
more important than the other. Thus you end of with an ordered list of
tasks. BUT when you boil it down to what RT is all about, namely
meeting your deadlines, it doesn't matter after the 5-10 priorities
because the 5-10 priorities have introduced a lot of jitter to the rest
of the tasks anyway. You can just as well just put them at the same
priority.

Esben

> 
> -- 
>     kr
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

