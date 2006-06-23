Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932842AbWFWG1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932842AbWFWG1U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 02:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932843AbWFWG1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 02:27:20 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:37876 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932842AbWFWG1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 02:27:20 -0400
Date: Fri, 23 Jun 2006 02:27:01 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Esben Nielsen <nielsen.esben@googlemail.com>
cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2/3] rtmutex: Propagate priority settings into PI lock
 chains
In-Reply-To: <Pine.LNX.4.64.0606221853550.10511@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0606230218480.30422@gandalf.stny.rr.com>
References: <20060622082758.669511000@cruncher.tec.linutronix.de>
 <20060622082812.607857000@cruncher.tec.linutronix.de>
 <Pine.LNX.4.58.0606220959490.15236@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0606221853550.10511@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jun 2006, Esben Nielsen wrote:

> > The above means that you cant ever call sched_setscheduler from a
> > interrupt handler (or softirq).  The rt_mutex_adjust_prio_chain since that
> > grabs wait_lock which is not for interrupt use.
>
> Worse in RT context: It makes it unhealthy to call from a RT task as it
> doesn't have predictable runtime unless you know that the target task is
> not blocked on a deep locking tree.
>
> I know this is very unlikely to happen very often in real life and this
> thread isn't about preempt-realtime, but I'll say it anyway: Hard realtime

Esben, you are right. This is not about RT so it does _not_ belong in this
thread.  Please keep the topic in this thread about -mm.  We already have
a RT thread to discuss this in.

My comments here where about a fact that setscheduler when from interrupt
context friendly to interrupt context unfriendly and I thought it would
be good to document that fact.  I like Andrews answer better.  Document it
with a BUG_ON(in_interrupt).

-- Steve

> is about avoiding surprisingly long execution times - especially those
> which are  extremely unlikely to happen, but nevertheless are possible,
> because you are not very likely to see those situations in any tests, and
> therefore you can suddenly miss deadlines in the field without a clue what
> is happening.
>
