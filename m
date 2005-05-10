Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVEJIW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVEJIW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 04:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVEJIW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 04:22:29 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:49213 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261579AbVEJIWX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 04:22:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NDP6Ev1fzqSTMD6iqVmI3Q4zypEhvUzLzT+uvRHl2zD6NOf6J0iajaOu6umkCvJ3wv4XK0a3h4mIrqxr5E/X8mve8o7FiDwPLCSznpIru4PtQ8l6A8zYtnT4f/ic5ji3lUf5JKJgknX/r92qml5q0gD/sFgi2eRXlL07/MQci4c=
Message-ID: <2cd57c90050510012225be9923@mail.gmail.com>
Date: Tue, 10 May 2005 16:22:23 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Haoqiang Zheng <haoqiang@gmail.com>
Subject: Re: [RFC PATCH] swap-sched: schedule with dynamic dependency detection (2.6.12-rc3)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d6e6e6dd050507231174d99fb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d6e6e6dd050507231174d99fb0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/05, Haoqiang Zheng <haoqiang@gmail.com> wrote:
> swap-sched is a patch that solves dynamic priority inversion problem.
> 
> Run X at normal priority (nice 0) and keep the system really busy by
> running a lot of interactive jobs (with dynamic priority at 115), or
> simply run some CPU bound tasks at nice -10. Then start a mpeg player
> at a high priority (nice -20). What would you expect? In my machine,
> the mpeg player runs at poorly 4 frm/s. Why the tasks running at
> dynamic priorities of 115 can have such dramatic impact on the
> performance of mpeg player running at nice -20? What happens is the
> mpeg player often blocks to wait the normal priority X to render the
> frames. Without knowing such dependency between mpeg player and X, the
> existing Linux scheduler would select other tasks to run and thus
> results in poor video playback quality. This problem is generally
> known as priority inversion.
> 
> Certainly, this very problem can be solved by setting the priority of
> X to nice -10 (like what Redhat etc. does). However, inter-process
> communication mechanisms like pipe, socket and signal etc. are widely
> used in modern applications, and thus the inter-process dependencies
> are everywhere in today's computer systems. It's not possible for a
> system administrator to find out all the dependencies and set the
> priorities properly. Obviously, we need a system that can dynamically
> detects the dependencies among the tasks and take the dependency
> information into account when scheduling. swap-sched is such a system.
> 
> swap-sched consists of two components: the automatic dependency
> detection component and the dependency based scheduling
> component. swap-sched detects the dependency among tasks by
> monitoring/instrumenting the inter-process
> communication/synchronization related system calls. Since all the
> inter-process communications/synchronizations (except shared-memory)
> are done via system calls, the dynamic dependencies can be effectively
> detected by instrumenting these system calls.
> 
> In a conventional CPU scheduler, a task is removed from the runqueue
> once it's blocked. This is a PROBLEM since a high priority task's
> request is ignored once it's blocked, even though it's blocked because
> of waiting for the execution of another task. Based on this
> observation, swap-sched solves the priority inversion problem by make
> two simple changes to the existing CPU scheduler. First, it keeps all
> the tasks that are blocked but depends on some other tasks that are
> runnable in runqueue. (We call such tasks are virtual runnable
> tasks). Second, the existing CPU scheduler is called as usual. But since the
> virtual runnable tasks are in runqueue, they may be scheduled. In this
> case the swap scheduler is called to choose one of the providers of
> the task (the task that the virtual runnable task depends on) to run.
> 
>  Our results show that SWAP has low overhead, effectively solves the
> priority inversion problem and can provide substantial improvements in
> system performance in scheduling processes with dependencies. For the
> mpeg player + X scenario discussed above, mpeg player can play at 23
> frm/s with swap-sched enabled!!!
> 
> Please visit our swap-sched project homepage at
> http://swap-sched.sourceforge.net/ for details and latest
> patches. Suggestions/Comments are welcomed.
> 
> Haoqiang


It is such a misleading name, but it's been in use for a rather long time ...



-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
