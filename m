Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269129AbUJERe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269129AbUJERe4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269113AbUJERcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:32:19 -0400
Received: from fmr03.intel.com ([143.183.121.5]:51145 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S269104AbUJERbX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:31:23 -0400
Message-Id: <200410051730.i95HUf627852@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@redhat.com>, "Con Kolivas" <kernel@kolivas.org>
Cc: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: RE: bug in sched.c:activate_task()
Date: Tue, 5 Oct 2004 10:30:48 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSqqlUPkAET7YFcTcq+xCQd+9VXJwAVfgPw
In-Reply-To: <Pine.LNX.4.58.0410050303280.7299@devserv.devel.redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Con Kolivas wrote:
> We used to compare jiffy difference in can_migrate_task by comparing it
> to cache_decay_ticks. Somewhere in the merging of sched_domains it was
> changed to task_hot which uses timestamp.


On Tuesday, October 05, 2004 12:10 AM, Ingo Molnar wrote:
> yep, that's fishy. Kenneth, could you try the simple patch below? It gets
> rid of task_hot() in essence. If this works out we could try it - it gets
> rid of some more code from sched.c too. Perhaps SD_WAKE_AFFINE is enough
> control.
>
> --- kernel/sched.c.orig	2004-10-05 08:28:42.295395160 +0200
> +++ kernel/sched.c	2004-10-05 09:07:44.081389576 +0200
> @@ -180,7 +180,7 @@ static unsigned int task_timeslice(task_
>  	else
>  		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
>  }
> -#define task_hot(p, now, sd) ((now) - (p)->timestamp < (sd)->cache_hot_time)
> +#define task_hot(p, now, sd) 0
>
>  enum idle_type
>  {

We have experimented with similar thing, via bumping up sd->cache_hot_time to
a very large number, like 1 sec.  What we measured was a equally low throughput.
But that was because of not enough load balancing, we are seeing is large amount
of idle time.

- Ken


