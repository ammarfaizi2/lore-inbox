Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968277AbWLEPIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968277AbWLEPIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968279AbWLEPIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:08:16 -0500
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:63057 "EHLO
	fest.stud.feec.vutbr.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968277AbWLEPIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:08:15 -0500
Message-ID: <45758B57.6040107@stud.feec.vutbr.cz>
Date: Tue, 05 Dec 2006 16:08:07 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Jaswinder Singh <jaswinderrajput@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PREEMPT is messing with everyone
References: <aa5953d60612050610l1f2657c3ie073467a2b2a7126@mail.gmail.com>
In-Reply-To: <aa5953d60612050610l1f2657c3ie073467a2b2a7126@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.177 () FROM_ENDS_IN_NUMS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaswinder Singh wrote:
> Hi,
> 
> preempt stuff SHOULD only stay in #ifdef CONFIG_PREEMP_* , but it is
> messing with everyone even though not defined.
> 
> e.g.
> 
> 1. linux-2.6.19/kernel/spinlock.c
> 
> Line 18: #include <linux/preempt.h>
> 
> Line 26:  preempt_disable();
> 
> Line 32:  preempt_disable();
> 
> and so on .

Don't worry. These compile into "do { } while (0)" (i.e. nothing) when 
CONFIG_PREEMPT is not set.

> 
> 2. linux-2.6.19/kernel/sched.c
> 
> Line 1096:  int preempted;
> 
> Line 1104:   preempted = !task_running(rq, p);
> 
> Line 1106:   if (preempted)
> 
> Line 2059:  if (TASK_PREEMPTS_CURR(p, this_rq))

Linux always does preemptive multitasking of user tasks. These have 
nothing to do with CONFIG_PREEMPT.

> Line 3355:    current->comm, preempt_count(), current->pid);
> 
> Line 3342:  preempt_disable();
> 
> Line 3375:  if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {

preempt_count() is useful in !CONFIG_PREEMPT kernels too. It stores 
information about the current context (hardirq, softirq, ...).

> [...]
> 
> 70 to 80 % of this code is removed when compiled.
> 
> but 20 to 30 % code left in binary kernel image.
> 
> Why Linux kernel is wasting its resources which is not defined at all.

I don't think that's the case.

> Any solution ?
> 
> Thank you,
> 
> Best Regards,
> 
> Jaswinder Singh.

Michal
