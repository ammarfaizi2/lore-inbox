Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVCALWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVCALWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 06:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVCALWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 06:22:11 -0500
Received: from smtp3.libero.it ([193.70.192.127]:63628 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S261876AbVCALVv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 06:21:51 -0500
Date: Tue,  1 Mar 2005 12:15:08 +0100
Message-Id: <ICO798$7147FD507322434BDC6EFA7B4F2FD6FC@libero.it>
Subject: Re: sched_yield behavior
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: "gtusa\@inwind\.it" <gtusa@inwind.it>
To: "rlrevell" <rlrevell@joe-job.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 4.1 (B27pl2)
X-type: 0
X-SenderIP: 213.156.59.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, thanks to all for the helpful replies.
I have simplified my example, because I was only interested in understanding if there was particular behavior performed by the new scheduler after a sched_yield() call. 
Anyway, I try to explain better my requirements. I have to implement a task which splits its job into two different blocks: the first concerns operations which must be performed within a limited time interval, so a very fast response is required; the second one concerns operations which can be a little delayed without problems. For some other reasons, the two blocks cannot be implemented in two different tasks. Therefore, because of the presence of the real-time block, an high real-time priority must be assigned to the whole task. On the other hand, if it uses the resources for a long time interval, it should sched_yield on behalf of other tasks (of course only after the real-time block operations have been completed).  

Giovanni
    
---------- Initial Header -----------

>From      : linux-kernel-owner@vger.kernel.org
To          : "Giovanni Tusa" gtusa@inwind.it
Cc          : linux-kernel@vger.kernel.org
Date      : Sun, 27 Feb 2005 12:02:13 -0500
Subject : Re: sched_yield behavior

> On Sun, 2005-02-27 at 11:58 +0100, Giovanni Tusa wrote:
> > Hi all,
> > I have a question about the sched_yield behavior of Linux O(1) scheduler,
> > for RT tasks.
> > By reading some documentation, I found that " ....real-time tasks are a
> > special case, because
> > when they want to explicitly yield the processor to other waiting processes,
> > they are merely
> > moved to the end of their priority list (and not inserted into the expired
> > array, like conventional
> > processes)."
> > I have to implement an RT task with the highest priority in the system (it
> > is also the only task within the
> > priority list for such priority level). Moreover, it has to be a SCHED_FIFO
> > task,  so that it can preempt
> > SCHED_RR ones, because of its strong real-time requirements. However,
> > sometimes it should relinquish the
> > CPU, to give to other tasks a chance to run.
> > Now, what happen if it gives up the CPU by means of the sched_yield() system
> > call?
> > If  I am not wrong, the scheduler will choose it again (it will be still the
> > higher priority task, and the only of its priority list).
> > I have to add an explicit sleep to effectively relinquish the CPU for some
> > time, or the scheduler can deal with such a
> > situation in another way?
> 
> What exactly are you trying to do?  I don't understand how the task
> could have "strong real-time requirements" if it's CPU bound.  What is
> the exact nature of the real time constraint?
> 
> Lee
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



____________________________________________________________
6X velocizzare la tua navigazione a 56k? 6X Web Accelerator di Libero!
Scaricalo su INTERNET GRATIS 6X http://www.libero.it


