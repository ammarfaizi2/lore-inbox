Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVG0RZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVG0RZz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVG0RZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:25:54 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:37102 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262050AbVG0RZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:25:52 -0400
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.OSF.4.05.10507271852030.3210-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10507271852030.3210-100000@da410.phys.au.dk>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 27 Jul 2005 13:25:37 -0400
Message-Id: <1122485137.29823.109.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 19:01 +0200, Esben Nielsen wrote:
> 
> What for? Why can't you use FIFO at the same priorities for some of your
> tasks? I pretty much quess you have a very few tasks which have some high
> requirements. The rest of you "RT" task could easily share the lowest RT
> priority. FIFO would also be more effective as you will have context
> switches.
> 
> This about multiple priorities probably comes from an ordering of tasks:
> You have a lot of task. You have a feeling about which one ought to be
> more important than the other. Thus you end of with an ordered list of
> tasks. BUT when you boil it down to what RT is all about, namely
> meeting your deadlines, it doesn't matter after the 5-10 priorities
> because the 5-10 priorities have introduced a lot of jitter to the rest
> of the tasks anyway. You can just as well just put them at the same
> priority.

Nope, I wouldn't agree with you here.  If you have tasks that will run
periodically, at different frequencies, you need to order them. And each
task would probably need a different priority. FIFO is very dangerous
since it doesn't release a task until that task voluntarily sleeps.

A colleague of mine, well actually the VP of my company of the time,
Doug Locke, gave me a perfect example.  If you have a program that runs
a nuclear power plant that needs to wake up and run 4 seconds every 10
seconds, and on that same computer you have a program running a washing
machine that needs to wake up every 3 seconds and run for one second
(I'm using seconds just to make the example simple). Which process gets
the higher priority?  The answer is the washing machine.

Rational:  If the power plant was higher priority, the washing machine
would fail almost every time, since the power plant program would run
for 4 seconds, and since the cycle of the washing machine is 3 seconds,
it would fail everytime the nuclear power plant program ran.  Now if you
have the washing machine run in it's cycle, the nuclear power plant can
easily make the 4 seconds ever 10 seconds, even when it is interrupted
by the washing machine.

Doug also mentioned that you really want to have every task with a
different priority, so it makes sense to have a lot of priorities.  I
can't remember why he said this, but I'm sure you and I can find out by
searching through his papers.

-- Steve



