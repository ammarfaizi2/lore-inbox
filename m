Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272568AbTHEHtv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 03:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272574AbTHEHtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 03:49:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:11990 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272568AbTHEHtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 03:49:50 -0400
Message-Id: <5.2.1.1.2.20030805094944.01a00708@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 05 Aug 2003 09:53:45 +0200
To: Andrew Morton <akpm@osdl.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O13int for interactivity
Cc: Con Kolivas <kernel@kolivas.org>, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       felipe_alfaro@linuxmail.org
In-Reply-To: <20030804230337.703de772.akpm@osdl.org>
References: <1060059844.3f2f3ac46e2f2@kolivas.org>
 <200308050207.18096.kernel@kolivas.org>
 <200308051220.04779.kernel@kolivas.org>
 <3F2F149F.1020201@cyberone.com.au>
 <200308051318.47464.kernel@kolivas.org>
 <3F2F2517.7080507@cyberone.com.au>
 <1060059844.3f2f3ac46e2f2@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:03 PM 8/4/2003 -0700, Andrew Morton wrote:
>Con Kolivas <kernel@kolivas.org> wrote:
> >
> > > In short: make the same policy for an interruptible and an 
> uninterruptible
> >  > sleep.
> >
> >  That's the policy that has always existed...
> >
> >  Interesting that I have only seen the desired effect and haven't 
> noticed any
> >  side effect from this change so far. I'll keep experimenting as much as
> >  possible (as if I wasn't going to) and see what the testers find as well.
>
>We do prefer that TASK_UNINTERRUPTIBLE processes are woken promptly so they
>can submit more IO and go back to sleep.  Remember that we are artificially
>leaving the disk head idle in the expectation that the task will submit
>more I/O.  It's pretty sad if the CPU scheduler leaves the anticipated task
>in the doldrums for five milliseconds.

It's actually (potentially) _much_ more than that isn't it?  Wakeups don't 
consider the last time a task has run... the awakened task is always placed 
at the back of the pack regardless of whether the tasks in front of it have 
been receiving heavy doses of cpu and the awakened task has not.

         -Mike 

