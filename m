Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbVKOKVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbVKOKVm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 05:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbVKOKVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 05:21:41 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:60566 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750752AbVKOKVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 05:21:41 -0500
From: Con Kolivas <kernel@kolivas.org>
To: liyu@ccoss.com.cn
Subject: Re: [Question]How to restrict some kind of task?
Date: Tue, 15 Nov 2005 21:21:29 +1100
User-Agent: KMail/1.8.3
Cc: LKML <linux-kernel@vger.kernel.org>
References: <4379B5EB.40709@ccoss.com.cn>
In-Reply-To: <4379B5EB.40709@ccoss.com.cn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb18030"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511152121.30107.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2005 21:18, liyu wrote:
> Hi, All.
>
>     I want to restrict some kind of task.
>
>     For example, for some task have one schedule policy SCHED_XYZ, when
> it reach beyond
> 40% CPU time, we force it yield CPU.
>
>     I inserted some code in scheduler_tick(), like this:
> >         if (check_task_overload(rq)) {
> >                 if (xyz_task(p) && yield_cpu(p, rq)) {
> >                         set_tsk_need_resched(p);
> >                         p->prio = effective_prio(p);
> >                         p->time_slice = task_timeslice(p);
> >                         p->first_time_slice = 0;
> >                         goto out_unlock;
> >                 }
> >         }
>
>     Of course, before these code, we hold our rq->lock first, so we should
> go to 'out_unlock'.
>     The function xyz_task(p) just is macro (p->policy == SCHED_XYZ), and
> yield_cpu() also is simple, it just move the task to expired array,
>
> int yield_cpu(task_t *p, runqueue_t *rq)
> {
>     dequeue_task(p, p->array);
>     requeue_task(p, rq->expired);
>     return 1;
> }

Don't requeue after dequeue. You enqueue after dequeue.

Con
