Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275016AbTHQFrl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 01:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275021AbTHQFrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 01:47:41 -0400
Received: from pop.gmx.net ([213.165.64.20]:43167 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S275016AbTHQFrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 01:47:40 -0400
Message-Id: <5.2.1.1.2.20030817072115.0198f398@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 17 Aug 2003 07:51:47 +0200
To: Jamie Lokier <jamie@shareable.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Scheduler activations (IIRC) question
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>
In-Reply-To: <20030816141851.GD23646@mail.jlokier.co.uk>
References: <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net>
 <20030815235431.GT1027@matchmail.com>
 <200308160149.29834.kernel@kolivas.org>
 <20030815230312.GD19707@mail.jlokier.co.uk>
 <20030815235431.GT1027@matchmail.com>
 <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:18 PM 8/16/2003 +0100, Jamie Lokier wrote:
>Mike Galbraith wrote:
> > At 01:54 AM 8/16/2003 +0100, Jamie Lokier wrote:
> > [...]
> >
> > >None of these will work well if "wakee" tasks are able to run
> > >immediately after being woken, before "waker" tasks get a chance to
> > >either block or put the wakees back to sleep.
> >
> > Sounds like another scheduler class (SCHED_NOPREEMPT) would be required.
>
>If something special were to be added, it should be a way for a task
>to say "If I call schedule() and block, don't do a schedule, just
>continue my timeslice in task X".
>
>The point of the mechanism is to submit system calls in an
>asynchronous fashion, after all.  A proper task scheduling is
>inappropriate when all we'd like to do is initiate the syscall and
>continue processing, just as if it were an async I/O request.

Ok, so you'd want a class where you could register an "exception handler" 
prior to submitting a system call, and any subsequent schedule would be 
treated as an exception?  (they'd have to be nestable exceptions too 
right?... <imagines stack explosions> egad:)

>The interesting part is what to do when the original task (the one
>that went to sleep) wakes up.

Yeah.

         -Mike 

