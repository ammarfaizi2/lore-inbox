Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317494AbSGJHOL>; Wed, 10 Jul 2002 03:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317495AbSGJHOK>; Wed, 10 Jul 2002 03:14:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:50384 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317494AbSGJHOJ>;
	Wed, 10 Jul 2002 03:14:09 -0400
Date: Thu, 11 Jul 2002 09:15:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: oleg@tv-sign.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.5.24-D3, batch/idle priority scheduling,
 SCHED_BATCH
In-Reply-To: <Pine.LNX.4.44.0207102143400.16734-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207110913030.4489-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > And users of __KERNEL_SYSCALLS__ and kernel_thread() should not
> > > have policy == SCHED_BATCH.
> 
> well, there's one security consequence here - module loading
> (request_module()), which spawns a kernel thread must not run as
> SCHED_BATCH. I think the right solution for that path is to set the
> policy to SCHED_OTHER upon entry, and restore it to the previous one
> afterwards - this way the helper thread has SCHED_OTHER priority.

i've solved this problem by making kernel_thread() spawned threads drop
back to SCHED_NORMAL:

	http://redhat.com/~mingo/O(1)-scheduler/sched-2.5.25-A7

I believe this is the secure way of doing it - independently of
SCHED_BATCH - a RT task should not spawn a RT kernel thread 'unwillingly'.

	Ingo

