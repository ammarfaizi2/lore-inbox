Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSGOKxQ>; Mon, 15 Jul 2002 06:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317429AbSGOKxP>; Mon, 15 Jul 2002 06:53:15 -0400
Received: from [195.39.17.254] ([195.39.17.254]:44928 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317427AbSGOKxP>;
	Mon, 15 Jul 2002 06:53:15 -0400
Date: Sun, 14 Jul 2002 14:29:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.5.24-D3, batch/idle priority scheduling, SCHED_BATCH
Message-ID: <20020714122911.GA179@elf.ucw.cz>
References: <Pine.LNX.4.44.0207102143400.16734-100000@localhost.localdomain> <Pine.LNX.4.44.0207110913030.4489-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207110913030.4489-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > And users of __KERNEL_SYSCALLS__ and kernel_thread() should not
> > > > have policy == SCHED_BATCH.
> > 
> > well, there's one security consequence here - module loading
> > (request_module()), which spawns a kernel thread must not run as
> > SCHED_BATCH. I think the right solution for that path is to set the
> > policy to SCHED_OTHER upon entry, and restore it to the previous one
> > afterwards - this way the helper thread has SCHED_OTHER priority.
> 
> i've solved this problem by making kernel_thread() spawned threads drop
> back to SCHED_NORMAL:

Does it mean that we now have working scheduler class that only
schedules jobs when no other thread wants to run (as long as
SCHED_BATCH task does not enter the kernel)?
									Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
