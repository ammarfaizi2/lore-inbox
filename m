Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVBYE0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVBYE0Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 23:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVBYE0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 23:26:23 -0500
Received: from imap.gmx.net ([213.165.64.20]:13544 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262432AbVBYE0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 23:26:17 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20050225042226.00c3eea0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 25 Feb 2005 05:25:18 +0100
To: "Chad N. Tindel" <chad@tindel.net>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Xterm Hangs - Possible scheduler defect?
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050224175331.GA18723@calma.pair.com>
References: <30111.1109237503@www1.gmx.net>
 <20050224075756.GA18639@calma.pair.com>
 <30111.1109237503@www1.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0507-4, 02/18/2005), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:53 PM 2/24/2005 -0500, Chad N. Tindel wrote:
> > > Hmmm... Are you suggesting it is OK for a kernel to get nearly completely
> > > hosed and for not fully utilize all the processors in the system because
> > > of one SCHED_FIFO thread?
> >
> > Sure.  You specifically directed the scheduler to run your thread at a
> > higher priority than anything else.  The way I see it, you used root's
> > perogative to shoot himself in the foot.  You could also have used root's
> > perogative to don steel toed shoes(set important kernel threads to a higher
> > priority) before pulling the trigger.
>
>No, I specifically directed the scheduler to run my thread at a higher
>priority than any other userspace application.  The fact that I wrote it
>in userspace and not in kernel space implies that I am OK with the kernel
>stopping me sometimes when _it_ has work to do.  If I wanted something
>higher priority than the kernel I would have written something in kernel
>space instead.

Nope.  You may have _thought_ you told it that, but the reality is as I 
described it.

> >   SCHED_FIFO thread are supposed to preempt
> > > all other userspace threads... not the kernel itself.
> >
> > Not so.  The scheduler makes do distinction between user and kernel threads
> > of execution.
>
>That is SOOOO broken it isn't even funny.

I heartily disagree.  I call it flexible/powerful.

> > If you think that's broken, you'll _love_ Ingo's IRQ threads...
>
>Yeah, thats broken too.

(You're not noticing the added power it gives you.)

>Perhaps I don't understand this philosophy you have where the kernel
>isn't more important than everything else.  It seems to me like there needs
>to be a rigid hierarchy for scheduling, lest you get into deadlock problems:

Some kernel thread flushing buffers should be more important than my 
userland trigger-pacemaker thread?

>Under no circumstances should any single CPU-bound userspace thread 
>completely
>hose a 64-way SMP box.

I can certainly agree that any service which is required across processor 
borders wants to be very high priority indeed, and I can further agree that 
this crossing of borders would not exist in a perfect world.

         -Mike 

