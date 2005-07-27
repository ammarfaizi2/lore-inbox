Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVG0OxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVG0OxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVG0OxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:53:21 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:22431 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262097AbVG0OxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:53:20 -0400
Date: Wed, 27 Jul 2005 16:53:04 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
In-Reply-To: <20050727143318.GA26303@elte.hu>
Message-Id: <Pine.OSF.4.05.10507271645210.24769-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005, Ingo Molnar wrote:

> 
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Perfectly understood.  I've had two customers ask me to increase the 
> > priorities for them, but those where custom kernels, and a config 
> > option wasn't necessary. But since I've had customers asking, I 
> > thought that this might be something that others want.  But I deal 
> > with a niche market, and what my customers want might not be what 
> > everyone wants. (hence the RFC in the subject).
> > 
> > So if there are others out there that would prefer to change their 
> > priority ranges, speak now otherwise this patch will go by the waste 
> > side.
> 
> i'm not excluding that this will become necessary in the future. We 
> should also add the safety check to sched.h - all i'm suggesting is to 
> not make it a .config option just now, because that tends to be fiddled 
> with.
> 
Isn't there a way to mark it "warning! warning! dangerous!" ?

Anyway: I think 100 RT priorities is way overkill - and slowing things
down by making the scheduler checking more empty slots in the runqueue.
Default ought to be 10. In practise it will be very hard to have
a task at the lower RT priority behaving real-time with 99 higher
priority tasks around. I find it hard to believe that somebody has an RT
app needing more than 10 priorities and can't do with RR or FIFO
scheduling within a fewer number of prorities.

Esben

> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

