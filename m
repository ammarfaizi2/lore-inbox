Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTFDDok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 23:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbTFDDok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 23:44:40 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28175 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262720AbTFDDoj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 23:44:39 -0400
Date: Tue, 3 Jun 2003 23:52:02 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Mike Galbraith <efault@gmx.de>
cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
In-Reply-To: <5.2.0.9.2.20030529062657.01fcaa50@pop.gmx.net>
Message-ID: <Pine.LNX.3.96.1030603234616.16495B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 May 2003, Mike Galbraith wrote:

> That would still suck rocks for mutex usage... as it must with any 
> implementation of sched_yield() in the presence of peer threads who are not 
> playing with the mutex.  Actually, using sched_yield() makes no sense what 
> so ever to me, other than what Arjan said.  It refers to yielding your 
> turn, but from userland "your turn" has no determinate meaning.  There is 
> exactly one case where it has a useable value, and that is  when you're the 
> _only_ runnable thread... at which time it means precisely zero. (blech)

No, it works usefully without threads at all, with processes sharing a
spinlock in shared memory. If the lock is closed process does a
sched_yeild() to allow whoever has the lock to run. Yes to all comments
WRT order of running, if you care you don't do this, clearly. But in the
case where a process forks to a feeder and consumer it's faster than
semaphores, signal, etc.

All that's needed is to put the yeild process on the end of the
appropriate run queue and reschedule. Doing anything else results in bad
performance and no gain to anything else.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

