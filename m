Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTGBACh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 20:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTGBACg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 20:02:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60146 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S264095AbTGBACb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 20:02:31 -0400
Subject: Re: scheduling with spinlocks held ?
From: Robert Love <rml@tech9.net>
To: Muthian Sivathanu <muthian_s@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030702001001.28996.qmail@web40607.mail.yahoo.com>
References: <20030702001001.28996.qmail@web40607.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1057105149.1988.3381.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 01 Jul 2003 17:19:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-01 at 17:10, Muthian Sivathanu wrote:

> Is it safe to assume that the kernel will not preempt
> a process when its holding a spinlock ?  I know most
> parts of the code make sure they dont yield the cpu
> when they are holding spinlocks, but I was just
> curious if there is any place that does that.

Correct.

> Basically, the context is, I need to change the
> scheduler a bit to implement "perfect nice -19"
> semantics, i.e. give cpu to nice 19 process only if no
> other normal process is ready to run.  I am wondering
> if there is a possibility of priority inversion if the
> nice-d process happens to yield the cpu and then never
> get scheduled because a normal process is spinning on
> the lock.

You will hit priority inversion... not with spinlocks but with
semaphores (and possibly more subtle issues).

The only safe way to do this safely is to boost the task's priority out
of the "idle" class when the task is inside the kernel.

It is nontrivial to juggle user vs. kernel returns such as that. Google
for Ingo Molnar's SCHED_BATCH addition to the O(1) scheduler.

	Robert Love


