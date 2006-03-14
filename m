Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWCNWA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWCNWA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWCNWA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:00:28 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:38815
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964782AbWCNWA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:00:26 -0500
Subject: Re: 2.6.16-rc6-rt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0603141756500.1291-100000@lifa01.phys.au.dk>
References: <Pine.LNX.4.44L0.0603141756500.1291-100000@lifa01.phys.au.dk>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 23:00:58 +0100
Message-Id: <1142373658.19916.655.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 21:40 +0100, Esben Nielsen wrote:
> The trick is: Maintain the unittest along with the code you are testing.
> Unfortunately a lot of people haven't discovered that yet. As I said
> before, the Linux kernel sould should have a tests/ directory in the main
> directory and a "make tests". For any patch to be accepted, should "make
> tests" should "build". Patches ofcouse include changes to the kernel code
> and the tests/ directory as it is one distribution.  Notice the tests are
> run _without_ running the kernel!
> That is how I do it at work: I have it all in one source repository and
> the "tests" target is the first dependency of "all:" in the makefile.

I did not say that a unittester is bad. It just does not help much when
it only works on your workstation.

> > The deadlock detection is done, when requested. So you _have_ to do it
> > by following the lock chain. When the task goes to sleep, then there is
> > no postmortem. When a futex requests deadlock detection you have to do
>                               --------
> > it in the locking path, as you have to return that information to
> > userspace.
> >
> > http://www.opengroup.org/onlinepubs/009695399/functions/pthread_mutex_lock.html
> >
> The point is that when deadlock detection isn't requested it ought not to
> be forced on the application.

It is not forced. We break out of the loop, when it is not requested.
This is just combined PI / deadlock detection code. And we do the check
in the boosting path anyway to avoid deadlocking there. Given it
works :)

> It happens before getting into that loop

Grmbl, you are right. Fix follows.

	tglx


