Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUJHUSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUJHUSs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUJHUSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:18:47 -0400
Received: from peabody.ximian.com ([130.57.169.10]:3720 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S264386AbUJHUQO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:16:14 -0400
Subject: Re: wait_event and preemption in 2.6
From: Robert Love <rml@novell.com>
To: michael_soulier@mitel.com
Cc: linux-kernel@vger.kernel.org, john_fodor@mitel.com
In-Reply-To: <20041008174510.GJ30977@e-smith.com>
References: <20041008174510.GJ30977@e-smith.com>
Content-Type: text/plain
Date: Fri, 08 Oct 2004 16:14:38 -0400
Message-Id: <1097266478.8686.10.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 13:45 -0400, michael_soulier@mitel.com wrote:

> I'm writing a device driver for PPC Linux and I'm using wait_event. It
> seems to me that there is a potential race condition in wait_event when
> preemption is turned on (2.6 kernel).
> 
> The scenario goes something like this: After the waiting process is
> woken up and returns from schedule it goes to the top of the loop and
> prepares to wait again (despite the condition being true). Then it will
> check the condition and break out of the loop. But what if in-kernel
> preemption occurs while it's doing that and another process is
> immediately scheduled to run? Does the process sleep forever? Assume
> that the event (say interrupt) that caused the original wakeup is a one
> shot.

See the PREEMPT_ACTIVE logic.

If a task is preempted it is marked PREEMPT_ACTIVE and it skips the
runqueue removal logic in schedule().  So even if it is !TASK_RUNNING it
will run again.

You can see this in schedule() and preempt_schedule(), both in
kernel/sched.c.

	Robert Love


