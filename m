Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVEaPKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVEaPKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 11:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVEaPJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 11:09:34 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:30091 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261890AbVEaPIo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 11:08:44 -0400
Date: Tue, 31 May 2005 17:07:45 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: James Bruce <bruce@andrew.cmu.edu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <20050531143051.GL5413@g5.random>
Message-Id: <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2005, Andrea Arcangeli wrote:

> On Tue, May 31, 2005 at 06:48:50AM -0400, James Bruce wrote:
> > orthogonal, because *if* preempt-RT patch becomes guaranteed hard-RT, it 
> 
> I don't see how can preempt-RT ever become hard-RT when a simple lock
> hangs it. 

There is no "simple lock" as spinlock (or very very few). All locks are
mutexes - with priority inheritance! Ofcourse, hitting a lock which can be
held for a non-deterministic amount of time destroyes your RT - but so it
does in any  RTOS. 
The whole point of PREEMPT_RT is that what _other_, lower priority threads
are doing isn't going to affect you. They are _not_ disabling preemption
or locking you away. Ofcourse, as soon as you start to share resources
with other threads you have to be carefull. But priority inheritance
even makes that deterministic - provided that all code used under the lock
is deterministic. Same as for any RTOS.

> As soon as you call kernel code, you'll eventually hang,
> kmalloc will have to allocate memory and pageout other stuff no matter
> what.

Please, tell me why you think mlockall() doesn't protect my RT thread
against that problem. In the testcode I have made and run I have no
problems in practise, but I have not verified it by going through all the
mm-code. You know that code a whole lot better than I.

> 
> I really hope embedded developers knows better and they don't get the
> idea of using preempt-RT where hard-RT is required.

I hope people will stop making such broad statements and reallize that
Linux can become a hard-RT OS (if not by "proof", at least by
meassurement). There is no conflict between a timesharing system scaling
to a lot of CPUs and a hard-RT system just because they are catogarized as
different in the text-books.

Esben

