Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317388AbSGITrF>; Tue, 9 Jul 2002 15:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317389AbSGITrE>; Tue, 9 Jul 2002 15:47:04 -0400
Received: from mx1.elte.hu ([157.181.1.137]:5082 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317388AbSGITrD>;
	Tue, 9 Jul 2002 15:47:03 -0400
Date: Wed, 10 Jul 2002 21:46:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: oleg@tv-sign.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.5.24-D3, batch/idle priority scheduling,
 SCHED_BATCH
In-Reply-To: <Pine.LNX.4.44.0207102134010.16481-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207102143400.16734-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > And users of __KERNEL_SYSCALLS__ and kernel_thread() should not
> > have policy == SCHED_BATCH.
> 
> yep. And even if they do they should be aware of the consequences.

well, there's one security consequence here - module loading
(request_module()), which spawns a kernel thread must not run as
SCHED_BATCH. I think the right solution for that path is to set the policy
to SCHED_OTHER upon entry, and restore it to the previous one afterwards -
this way the helper thread has SCHED_OTHER priority.

	Ingo

