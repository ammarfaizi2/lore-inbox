Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbUCRUGV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbUCRUGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:06:21 -0500
Received: from peabody.ximian.com ([130.57.169.10]:14572 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262908AbUCRUGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:06:19 -0500
Subject: Re: use of PREEMPT_ACTIVE ?
From: Robert Love <rml@ximian.com>
To: Julien.Soula@lifl.fr
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040318195130.GA26321@foudroyante.lifl.fr>
References: <20040318195130.GA26321@foudroyante.lifl.fr>
Content-Type: text/plain
Message-Id: <1079640373.6363.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Thu, 18 Mar 2004 15:06:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 14:51, Julien.Soula@lifl.fr wrote:

> the PREEMPT_ACTIVE flag set by preempt_schedule() or during return of
> interrupt / exception / syscall. And it's tested in schedule() to
> avoid some operations like deactivate_task().
> 
> Our purpose is to force deactivation of the task. So we planned to set
> task state to TASK_INTERRUPTIBLE value and then to call
> schedule(). However the PREEMPT_ACTIVE flag can prevent it.
> 
> So what is the significance of the PREEMPT_ACTIVE flag and the test in
> schedule() ?

It lets a task be preempted when state != TASK_RUNNING.  By preventing
the task from being deactivated, it can be rescheduled correctly. 
Otherwise, a task that was, say, TASK_INTERRUPTIBLE could be preempted
before it put itself on a wait queue.

Marking the task that is preempted is a simple solution to the race.

If you want to force the deactivation of the task, there is really no
difference.  Set it to TASK_INTERRUPTIBLE, do whatever you need to do,
and call schedule().

PREEMPT_ACTIVE is unrelated to what you want to do.

	Robert Love


