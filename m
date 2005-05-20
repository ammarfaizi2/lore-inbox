Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVETNm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVETNm7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 09:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVETNm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:42:57 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:37266 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261431AbVETNlt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:41:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tcT3+L6zucyPpn1FlN2wEKktjVzk31H7m7OCQ9XaTV0YXrwGTQN91/8SpCuRFWVtXJl4aXLWaE4pqf/UuEOeJTiA5gAX9tZwlpndmA6okVMncICFMTaT1lFJO0KdTKrZvBMVm5rJXDgR28+jUf7mu9sQIvOJsXzNGYOAozuRl4w=
Message-ID: <855e4e460505200641423b24c9@mail.gmail.com>
Date: Fri, 20 May 2005 06:41:46 -0700
From: chen Shang <shangcs@gmail.com>
Reply-To: chen Shang <shangcs@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       rml@tech9.net
In-Reply-To: <200505201736.02664.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <855e4e4605051909561f47351@mail.gmail.com>
	 <855e4e46050520001215be7cde@mail.gmail.com>
	 <428D8FEE.8030303@yahoo.com.au>
	 <200505201736.02664.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the statistics data to support requeue_task() inline  with the
counter on sched_cnt at the same period. In brief, every 10 schedule()
will trigger recalc_task_prio() a little more than 4 times.

CPU0: priority_changed (669 times), priority_unchanged(335,138 times),
schedule_cnt(787,085 times)
CPU1: priority_changed (784 times), priority_unchanged(342,419 times),
schedule_cnt(784,873 times)
CPU2: priority_changed (782 times), priority_unchanged(283,494 times),
schedule_cnt(681,917 times)
CPU3: priority_changed (872 times), priority_unchanged(365,865 times),
schedule_cnt(809,624 times)

On 5/20/05, Con Kolivas <kernel@kolivas.org> wrote:
> On Fri, 20 May 2005 17:21, Nick Piggin wrote:
> > chen Shang wrote:
> > >I minimized my patch and against to 2.6.12-rc4 this time, see below.
> > >
> > >The new schedstat fields are for the test propose only, so I removed
> > >them completedly from patch. Theoritically, requeue_task() is always
> > >cheaper than dequeue_task() followed by enqueue_task(). So, if 99% of
> > >priority recalculation trigger requeue_task(), it will save.
> > >
> > >In addition, my load is to build the kernel, which took around 30
> > >minutes with around 30% CPU usage on 2x2 processors (duel processors
> > >with HT enable).
> > >Here is the statistics:
> > >
> > >CPU0: priority_changed (669 times), priority_unchanged(335,138 times)
> > >CPU1: priority_changed (784 times), priority_unchanged(342,419 times)
> > >CPU2: priority_changed (782 times), priority_unchanged(283,494 times)
> > >CPU3: priority_changed (872 times), priority_unchanged(365,865 times)
> >
> > OK that gives you a good grounds to look at the patch, but _performance_
> > improvement is what is needed to get it included.
> 
> If you end up using requeue_task() in the fast path and it is hit frequently
> with your code you'll need to modify requeue_task to be inline as well.
> Currently it is hit only via sched_yield and once every 10 scheduler ticks
> which is why it is not inline. The performance hit will be demonstrable if it
> is hit in every schedule()
> 
> Cheers,
> Con
> 
> 
>
