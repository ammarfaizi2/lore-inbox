Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbTC1Ke3>; Fri, 28 Mar 2003 05:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbTC1Ke3>; Fri, 28 Mar 2003 05:34:29 -0500
Received: from mx1.elte.hu ([157.181.1.137]:8639 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262875AbTC1Ke2>;
	Fri, 28 Mar 2003 05:34:28 -0500
Date: Fri, 28 Mar 2003 11:45:10 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@digeo.com>
Cc: Ed Tomlinson <tomlins@cam.org>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.66-mm1
In-Reply-To: <20030327205912.753c6d53.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303281139500.6678-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Mar 2003, Andrew Morton wrote:

> That longer Code: line is really handy.
> 
> You died in schedule()->deactivate_task()->dequeue_task().
> 
> static inline void dequeue_task(struct task_struct *p, prio_array_t *array)
> {
> 	array->nr_active--;
> 
> `array' is zero.
> 
> I'm going to Cc Ingo and run away.  Ed uses preempt.

hm, this is an 'impossible' scenario from the scheduler code POV. Whenever
we deactivate a task, we remove it from the runqueue and set p->array to
NULL. Whenever we activate a task again, we set p->array to non-NULL. A
double-deactivate is not possible. I tried to reproduce it with various
scheduler workloads, but didnt succeed.

Mike, do you have a backtrace of the crash you saw?

	Ingo

