Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292942AbSCRLQj>; Mon, 18 Mar 2002 06:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292968AbSCRLQa>; Mon, 18 Mar 2002 06:16:30 -0500
Received: from cpe.atm0-0-0-122182.0x3ef30264.bynxx2.customer.tele.dk ([62.243.2.100]:52563
	"EHLO fugmann.dhs.org") by vger.kernel.org with ESMTP
	id <S292942AbSCRLQO>; Mon, 18 Mar 2002 06:16:14 -0500
Message-ID: <3C95CC7D.8070101@fugmann.dhs.org>
Date: Mon, 18 Mar 2002 12:16:13 +0100
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020315
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Q: 2.4 Scheduler 
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have some specific questions concering the implementation of the 
scheduler in 2.4.18, which I hope you would please answer for me.

Question #1:
Has anyone documented the functionality of the current scheduler? It
seems that the algorithm used is very sparse explained (although very
easy to understand by looking at the code), and the comments in the
code does not always what the purpose of a function is, but rather how
it works.

Question #2:
In the schedule function, a 'goodness' value is calculated for all
processes, and the maximum is remembered. If this value is zero, tasks
gets a new quantum. The question here is which tasks. Take a look at the
code below. (shed.c, 617)

/* Do we need to re-calculate counters? */
if (unlikely(!c)) {
	struct task_struct *p;

	spin_unlock_irq(&runqueue_lock);
	read_lock(&tasklist_lock);
	for_each_task(p)
		p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
	read_unlock(&tasklist_lock);
	spin_lock_irq(&runqueue_lock);
	goto repeat_schedule;
}

What I do not understand here is the 'for_all_tasks'. Its defined in
sched.h, line 870:

#define for_each_task(p) \
	for (p = &init_task ; (p = p->next_task) != &init_task ; )

Would someone please explain the structure of this - Its very hard to
see what this list consists of. Also if anyone has the time to give some 
more general information on 'struct task' I would be happy - It's a big 
structure, and it's hard to track down where the structure is modified, 
and why.


Question #3:
What is the main purpose of 'reschedule_idle.'? In the UP case, its
all about removing the current task from the CPU, but a more detailed
explanation would be nice. Of course I'm interested in the SMP case.

I hope that some of you would be so kind as to spend some time to
answer these questions.  The reason for me asking is, that I'm trying
to document the scheduler (from a theoretical point of view). I also
plan to describe the works of Ingo's O(1) scheduler in 2.5, but I
haven't started looking at that yet.

Thanks in advance
Anders Fugmann

