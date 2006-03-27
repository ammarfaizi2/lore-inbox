Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWC0AL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWC0AL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 19:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWC0AL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 19:11:29 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:17801 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S932234AbWC0AL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 19:11:29 -0500
Date: Mon, 27 Mar 2006 01:11:19 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: Re: PI patch against 2.6.16-rt9
In-Reply-To: <Pine.LNX.4.44L0.0603270055090.2708-100000@lifa01.phys.au.dk>
Message-ID: <Pine.LNX.4.44L0.0603270108380.2708-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Mar 2006, Esben Nielsen wrote:

> On Mon, 27 Mar 2006, Ingo Molnar wrote:
>
> >
> > * Esben Nielsen <simlo@phys.au.dk> wrote:
> >
> > > Hi,
> > >  I got the patch I mentioned earlier to run. It passes my userspace
> > > testscripts as well as all the scripts for Thomas's rtmutex-tester on a UP
> > > machine.
> > >
> > > The idea is to avoid the deadlocks by releasing all locks before going
> > > to the next lock in the chain. I use get_/put_task_struct to avoid the
> > > task disappearing during the iteration.
> >
> > but we lose reliable deadlock detection ...
> >
> > how do you guarantee that some other CPU doesnt send us on some
> > goose-chase?
> >
>
> How should another CPU suddenly be able to insert stuff into a lock chain?
> Only the tasks themselves can do that and they are blocked on some lock -
> at least when we tested in some previous iteration. Ofcourse, they can
> have been signalled or timed out since, such they are already unblocked
> when the deadlock is reported. But that is not an error since the locks at
> some point actually were in a deadlock situation.

I might add: That can in principle happen for any deadlock detector:

1) Your task detects a deadlock.
2) Your task releases the last spinlock.
3) It gets preempted.
4) Some of the deadlocked tasks is signalled.
5) Your tasks returns from the kernel and reports a deadlock which is no
longer there.

Esben

>
> I do put in a limit of 100 (can be changed with sysctl) iterations. But
> that is to avoid looping forever when a new task blocks on a lock already
> part of a deadlock.
>
> > 	Ingo
> >
>
> Esben
>
>

