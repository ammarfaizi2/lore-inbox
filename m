Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266442AbUFQKLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266442AbUFQKLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 06:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUFQKLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 06:11:41 -0400
Received: from witte.sonytel.be ([80.88.33.193]:59280 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266444AbUFQKKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 06:10:33 -0400
Date: Thu, 17 Jun 2004 12:10:23 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Nuno Monteiro <nuno@itsari.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: rwsem-spinlock error (was: Re: Linux 2.4.27-pre6)
In-Reply-To: <20040616183343.GA9940@logos.cnet>
Message-ID: <Pine.GSO.4.58.0406171206470.22919@waterleaf.sonytel.be>
References: <20040616183343.GA9940@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004, Marcelo Tosatti wrote:
> <nickpiggin:yahoo.com.au>:
>   o rwsem race fixes backported from 2.6

> Nuno Monteiro:
>   o Fix rwsem-fix typo
>   o Complete rwsem typo fix

| rwsem-spinlock.c: In function `__rwsem_wake_one_writer':
| rwsem-spinlock.c:111: `tsk' undeclared (first use in this function)
| rwsem-spinlock.c:111: (Each undeclared identifier is reported only once
| rwsem-spinlock.c:111: for each function it appears in.)

How can this ever compile on any architecture?

| static inline struct rw_semaphore *__rwsem_wake_one_writer(struct rw_semaphore *sem)
| {
| 	struct rwsem_waiter *waiter;
|
| 	sem->activity = -1;
|
| 	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
| 	list_del(&waiter->list);
|
| 	tsk = waiter->task;
| 	mb();
| 	waiter->task = NULL;
| 	wake_up_process(tsk);
| 	free_task_struct(tsk);
| 	return sem;
| }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
