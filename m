Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbVHULdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVHULdK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 07:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbVHULdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 07:33:10 -0400
Received: from [80.71.243.242] ([80.71.243.242]:14314 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S1750959AbVHULdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 07:33:09 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17160.26222.678122.362194@gargle.gargle.HOWL>
Date: Sun, 21 Aug 2005 15:33:02 +0400
To: Howard Chu <hyc@symas.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched_yield() makes OpenLDAP slow
Newsgroups: gmane.linux.kernel
In-Reply-To: <43079FA9.700@symas.com>
References: <4D8eT-4rg-31@gated-at.bofh.it>
	<4306A176.3090907@shaw.ca>
	<4306AF26.3030106@yahoo.com.au>
	<4307788E.1040209@symas.com>
	<1124571437.2115.3.camel@mindpipe>
	<43079FA9.700@symas.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu writes:
 > Lee Revell wrote:
 > >  On Sat, 2005-08-20 at 11:38 -0700, Howard Chu wrote:
 > > > But I also found that I needed to add a new yield(), to work around
 > > > yet another unexpected issue on this system - we have a number of
 > > > threads waiting on a condition variable, and the thread holding the
 > > > mutex signals the var, unlocks the mutex, and then immediately
 > > > relocks it. The expectation here is that upon unlocking the mutex,
 > > > the calling thread would block while some waiting thread (that just
 > > > got signaled) would get to run. In fact what happened is that the
 > > > calling thread unlocked and relocked the mutex without allowing any
 > > > of the waiting threads to run. In this case the only solution was
 > > > to insert a yield() after the mutex_unlock().
 > >
 > >  That's exactly the behavior I would expect.  Why would you expect
 > >  unlocking a mutex to cause a reschedule, if the calling thread still
 > >  has timeslice left?
 >
 > That's beside the point. Folks are making an assertion that
 > sched_yield() is meaningless; this example demonstrates that there are
 > cases where sched_yield() is essential.

It is not essential, it is non-portable.

Code you described is based on non-portable "expectations" about thread
scheduling. Linux implementation of pthreads fails to satisfy
them. Perfectly reasonable. Code is then "fixed" by adding sched_yield()
calls and introducing more non-portable assumptions. Again, there is no
guarantee this would work on any compliant implementation.

While "intuitive" semantics of sched_yield() is to yield CPU and to give
other runnable threads their chance to run, this is _not_ what standard
prescribes (for non-RT threads).

 >
 > --
 >   -- Howard Chu

Nikita.
