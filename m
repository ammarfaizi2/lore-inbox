Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265202AbSJRQHp>; Fri, 18 Oct 2002 12:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265216AbSJRQHp>; Fri, 18 Oct 2002 12:07:45 -0400
Received: from air-2.osdl.org ([65.172.181.6]:30899 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265202AbSJRQHo>;
	Fri, 18 Oct 2002 12:07:44 -0400
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021018111442.GH16501@dualathlon.random>
References: <1034915132.1681.144.camel@cog> 
	<20021018111442.GH16501@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2002 09:13:39 -0700
Message-Id: <1034957619.5401.8.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One reason gettimeofday ends up being important is that several
databases call it a lot. They use it to build up a transaction id. Under
big transaction loads, even the fast linux syscall path ends up being a
bottleneck. Also, on NUMA machines the data used for time of day (xtime)
ends up being a significant portion of the cache traffic.

It would be great to rework the whole TSC time of day stuff to work with
per cpu data and allow unsychronized TSC's like NUMA. The problem is
that for fast user level access, there would need to be some way to find
out the current CPU and avoid preemption/migration for a short period.
It seems like the LDT stuff for per-thread data could provide the
current cpu (and maybe current pid) somehow.  And it would be possible
to avoid  preemption while in a vsyscall text page, some other Unix
variants do this to implement portions of the thread library in kernel
provided user text pages.

