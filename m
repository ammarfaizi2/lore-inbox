Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVCXMGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVCXMGl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 07:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbVCXMGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 07:06:41 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:13263 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261258AbVCXMGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 07:06:11 -0500
Date: Thu, 24 Mar 2005 13:06:06 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: sounak chakraborty <sounakrin@yahoo.co.in>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched.c  function
In-Reply-To: <20050324110321.83788.qmail@web53308.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0503241244341.27454@yvahk01.tjqt.qr>
References: <20050324110321.83788.qmail@web53308.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>So you want to say that only one task could be running
>at a single time 

per processor, yes.

>but how to know which one 

The kernel is not a separate task. If you call read() for example, you change 
from user to kernel space, so there can be multiple threads being in kernel 
space at the same time (on SMP+) -- there is no process that is _always_ in 
kernelspace.

task_t *current;
is a pointer to the, well, current process (remember that the kernel is not a 
separate proc!)

>is there any way without traversing the task list
>previously i thought of for_each_process(p)
>                        if(p->state==running)

Good idea.

>but without this how to find which process is
>currently running and other are sleeping 
>may it is through "current"

p->state == TASK_RUNNING is (AFAI understand) something different than the 
process that _is_ actually running at this very moment.

>since the current->pid is only running

Usually yes. You probably mix 'running' up with "running in the sense of a 
user, not a kernel developer".

>i want to develop a task manager for threads.
>the application reads properly the process information
>and the thread information but not able to refresh the
>thread information as i am building my own proc file
>where only threads are there 
>i am distinguishing between process and thread at
>fork.c
>with clone_vm set..

A process is the set of all threads with the same
TGID (thread group identifier).

>therefore i need to know which thread is currently
>running or not 

task_t *current;
That one is running.
For SMP, you need a little different variables.

>i want to distinguish between thread and process and
>after distinguishing between user thread and kernel
>thread 

I think there are only kernel threads.

>but i am unable to find any condition which will be
>true for kernel level thread during creation and false
>for user level thread 
>can you help me in this also
>thanks 
>sounak


Jan Engelhardt
-- 
