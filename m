Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbSI3TDP>; Mon, 30 Sep 2002 15:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSI3TDP>; Mon, 30 Sep 2002 15:03:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5130 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261288AbSI3TDN>;
	Mon, 30 Sep 2002 15:03:13 -0400
Message-ID: <3D98A113.8010502@pobox.com>
Date: Mon, 30 Sep 2002 15:08:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] generic work queue handling, workqueue-2.5.39-D6
References: <Pine.LNX.4.44.0209301747560.13521-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> the attached patch (against BK-curr) cleans up the impact of the removal
> of task-queue support. It merges kernel/context.c (keventd) and the old
> task-queue concept into a unified 'work queue' concept. The basic
> primitives are:
> 
>  extern workqueue_t *create_workqueue(const char *name);
>  extern void destroy_workqueue(workqueue_t *wq);
>  extern int queue_work(work_t *work, workqueue_t *wq);
>  extern void flush_workqueue(workqueue_t *wq);
> 
> there is one 'default' workqueue, the events queue, which is analogous to
> the old keventd code, with very similar semantics:
> 
>  extern int schedule_work(work_t *work);
>  extern void flush_scheduled_work(void);


Two things:
* queue_work has its arguments reversed
* you need to add queue_work_delayed

