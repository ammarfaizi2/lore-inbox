Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVE2PP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVE2PP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 11:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVE2PP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 11:15:56 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:16103 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261340AbVE2PPp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 11:15:45 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: manoj.sharma@wipro.com
Subject: Re: Is wake_up safe on 2.4?
Date: Sun, 29 May 2005 11:15:54 -0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <689F43A6CF84E541A721C5C3FD5ADECC030B5354@blr-m3-msg.wipro.com>
In-Reply-To: <689F43A6CF84E541A721C5C3FD5ADECC030B5354@blr-m3-msg.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505291115.54370.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 May 2005 10:28, manoj.sharma@wipro.com wrote:
> Is it safe to use wake_up() in 2.4 inside an interrupt handler or in a
> spin lock region?
>
> wake_up() uses reshedule_idle() to find an idle cpu for the woken up
> task. If it doesn't find any, it checks the current running tasks on all
> CPUs and uses goodness value to pick up the best cpu to schedule the
> woken up task.  Isn't possible to preempt the current task where
> reschedule_idle() is running?
>
> There are plenty of instances in the kernel (2.4) where wake_up() is
> being used inside interrupt handler or after taking spin locks. If it
> can preempt the task calling wake_up(), how safe is it to use then?

Looking at the code - On SMP, the woken up task will be always scheduled on a 
CPU other than the one executing the caller, in which case caller of 
wake_up() is not pre-empted. On UP, it just sets need_resched (different than 
calling schedule() ) in which case the caller of wake_up() will be 
rescheduled only when appropriate, when it is safe to preempt it.
