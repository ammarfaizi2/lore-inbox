Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275473AbTHJGhJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 02:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275474AbTHJGhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 02:37:09 -0400
Received: from pop.gmx.de ([213.165.64.20]:33967 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S275473AbTHJGhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 02:37:06 -0400
Message-Id: <5.2.1.1.2.20030810080748.019cb090@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 10 Aug 2003 08:41:18 +0200
To: Daniel Phillips <phillips@arcor.de>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy 
  ...
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308100141.13074.phillips@arcor.de>
References: <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
 <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com>
 <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:41 AM 8/10/2003 +0100, Daniel Phillips wrote:
>On Saturday 09 August 2003 18:47, Mike Galbraith wrote:
> > > But the patch has a much bigger problem: there is no way a SOFTRR 
> task can
> > > be realtime as long as higher priority non-realtime tasks can preempt it.
> > > The new dynamic priority adjustment makes it certain that we will
> > > regularly see normal tasks with priority elevated above so-called
> > > realtime tasks.  Even without dynamic priority adjustment, any higher
> > > priority system task can unwttingly make a mockery of realtime schedules.
> >
> > Not so.
>
>Yes so.  A SCHED_NORMAL task with priority n can execute even when a
>SCHED_FIFO/RR/SOFTRR task of priority n-1 is ready.  In the case of FIFO and
>RR we don't care because they're already unusable by normal users but in the
>case of SOFTRR it defeats the intended realtime gaurantee.

No, _not_ so.  How is the SCHED_NORMAL (didn't that used to be called 
SCHED_OTHER?) task ever going to receive the cpu when a realtime task is 
runnable given that 1. task selection is done via sched_find_first_bit(), 
and 2. realtime queues reside at the top of the array?

> > Dynamic priority adjustment will not put a SCHED_OTHER task above
> > SCHED_RR, SCHED_FIFO or SCHED_SOFTRR, so they won't preempt.
>
>Are you sure?  I suppose that depends on the particular flavor of dynamic
>priority adjustment.  The last I saw, dynamic priority can adjust the task
>priority by 5 up or down.  If I'm wrong, please show me why and hopefully
>point at specific code.

See the definition of rt_task() in sched.c, and the comments in sched.h 
beginning at line 266.

         -Mike 

