Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSGIThf>; Tue, 9 Jul 2002 15:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSGIThe>; Tue, 9 Jul 2002 15:37:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:50597 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317427AbSGIThc>;
	Tue, 9 Jul 2002 15:37:32 -0400
Date: Wed, 10 Jul 2002 21:38:45 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: oleg@tv-sign.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.5.24-D3, batch/idle priority scheduling,
 SCHED_BATCH
In-Reply-To: <3D27347C.29DC9014@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0207102134010.16481-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 6 Jul 2002 oleg@tv-sign.ru wrote:

> Hello.
> 
> I beleive this patch against entry.S should be sufficient:
> 
> --- entry.S~    Sat Jul  6 21:01:16 2002
> +++ entry.S     Sat Jul  6 21:06:14 2002
> @@ -255,7 +255,7 @@
>         testb $_TIF_NEED_RESCHED, %cl
>         jz work_notifysig
>  work_resched:
> -       call schedule
> +       call schedule_userspace
>         cli                             # make sure we don't miss an
> interrupt
>                                         # setting need_resched or
> sigpending
>                                         # between sampling and the iret
> 
> Both calls to schedule() at resume_kernel: and work_pending:
> have clear kernel/user return path.

agreed, good catch. This greatly simplifies things.

> And users of __KERNEL_SYSCALLS__ and kernel_thread() should not
> have policy == SCHED_BATCH.

yep. And even if they do they should be aware of the consequences.

	Ingo

