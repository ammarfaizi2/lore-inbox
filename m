Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161240AbWF1Jvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161240AbWF1Jvt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 05:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbWF1Jvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 05:51:49 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:18604 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030499AbWF1Jvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 05:51:48 -0400
Date: Wed, 28 Jun 2006 05:51:46 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Brian Hsu <brianhsu.hsu@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to switch to another process at schedule() ?
In-Reply-To: <615cd8d10606272220w1cfe00b2u62a68d4689b6960d@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0606280547310.32286@gandalf.stny.rr.com>
References: <615cd8d10606272220w1cfe00b2u62a68d4689b6960d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Jun 2006, Brian Hsu wrote:

> Hi, I'm here again.
>
> I'm trying to do a homework which teacher ask us impelement a simple
> EDF scheduling policy.

Since this is really homework, you really should ask these questions
to your teacher or a teachers assistant.

>
> Following is the code I tried to get it work, but faild.
>
> ================ Code ========================
>         next = list_entry(queue->next, task_t, run_list);
>
>         if ( next->policy == SCHED_EDF ) {
>
>             struct task_struct * task = list_entry( edf_queue.next, task_t,
>                                                     edf_node );
>
>             if ( task != next ) {
>                 printk ( "Active EDF[%d]\n", task->pid );
>                 printk ( "Deactive EDF[%d]\n", next->pid );
>
>                 // Works Fine.
>                 // But how can I get next back to run queue?
>                 dequeue_task ( task, array );
>                 set_tsk_need_resched ( next );
> 		enqueue_task_head (task, array);

enqueue_task_head only puts the task at the front of it's prio queue.
If next is higher in priority than task (as it probably is since it was
picked) than next will be queued again.

>
>                 // It will hang up if I let the former process stay in queue.

It hangs because you keep scheduling next (it's has the highest prio)
but you keep setting need_resched, and thus it goes into the scheduler
an infinit amount of times.

>                 /*
>                 //dequeue_task ( task, array );
>                 //set_tsk_need_resched (next );
>        		enqueue_task_head (task, array);
>                 rq->nr_running++;
>                 */
>                 next = task;
>             }
>         }


-- Steve

