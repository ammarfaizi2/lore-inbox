Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265942AbUAKRXc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 12:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUAKRXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 12:23:32 -0500
Received: from chello212017098056.surfer.at ([212.17.98.56]:15122 "EHLO
	hofr.at") by vger.kernel.org with ESMTP id S265942AbUAKRXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 12:23:21 -0500
From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200401101722.i0AHM3l17594@hofr.at>
Subject: Re: 2.6.0 schedule_tick question
In-Reply-To: <Pine.LNX.4.44.0401110855420.19685-100000@bigblue.dev.mdolabs.com>
 from Davide Libenzi at "Jan 11, 2004 08:57:28 am"
To: Davide Libenzi <davidel@xmailserver.org>
Date: Sat, 10 Jan 2004 18:22:03 +0100 (CET)
CC: Der Herr Hofrat <der.herr@hofr.at>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >  in 2.6.0 kernel/sched.c scheduler_tick currently the 
> >  case of rt_tasks for SCHED_RR is doing
> > 
> > 	if ((p->policy == SCHED_RR) && !--p->time_slice) {
> > 			...
> >                         dequeue_task(p, rq->active);
> >                         enqueue_task(p, rq->active);
> > 
> >  which is:
> > 
> > static inline void dequeue_task(struct task_struct *p, prio_array_t *array)
> > {
> >         array->nr_active--;
> >         list_del(&p->run_list);
> >         if (list_empty(array->queue + p->prio))
> >                 __clear_bit(p->prio, array->bitmap);
> > }
> > 
> > static inline void enqueue_task(struct task_struct *p, prio_array_t *array)
> > {
> >         list_add_tail(&p->run_list, array->queue + p->prio);
> >         __set_bit(p->prio, array->bitmap);
> >         array->nr_active++;
> >         p->array = array;
> > }
> > 
> >  looking at these two functions this looks like quite some overhead as it
> >  actually could be reduced to:
> > 
> >         list_del(&p->run_list);
> > 	list_add_tail(&p->run_list, array->queue + p->prio);
> > 
> >  for the rest I don't see any effect it would have ?
> 
> Yes, we could have a rotate_task() function but the impact is basically 
> zero because of the little overhead compared to the frequency of the 
> operation.
>
ok - well maby someone wants to drop it in any way as its
trivial and actually it would be easier to read if the function name
were rotate_task and not dequeue/enqueu to implement RR behavior.

thx !
hofrat
 
