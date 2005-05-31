Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVEaVYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVEaVYq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVEaVY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:24:27 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:57041 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261500AbVEaVYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:24:15 -0400
Subject: Re: RT patch acceptance
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>
In-Reply-To: <20050531205424.GV5413@g5.random>
References: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk>
	 <1117556283.2569.26.camel@localhost.localdomain>
	 <20050531171143.GS5413@g5.random>
	 <1117561379.2569.57.camel@localhost.localdomain>
	 <20050531175152.GT5413@g5.random>
	 <1117564192.2569.83.camel@localhost.localdomain>
	 <20050531205424.GV5413@g5.random>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 31 May 2005 17:22:31 -0400
Message-Id: <1117574551.5511.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 22:54 +0200, Andrea Arcangeli wrote:

> One thing we should be careful: if syscalls aren't needed in the app and
> all the MMIO space can be mmapped by the device driver and the app can
> run fully in userland and be invoked from irqs, then going with the
> "diamond hard" is not more complicated than going with the weak
> solutions. The "diamond hard" will work in userland too, and it won't be
> substantially different from a soft-RT "metal hard" approach like
> preempt-RT. So it'd be very bad if people would choose preempt-RT if
> they could equally easily go with RTAI or other "diamond hard" solutions
> that are order of magnitude simpler and safer.
> 

The question is, it is really simpler?  Programming for the -RT patch
would work with just Linux as well. You just miss your deadlines, but
the application will still run, or at least easy to test.  I haven't
used the RTAI approach so I'm not familiar with the difficulties of
using it. But one would still need to make the effort in incorporating
it.  If the -RT patch is merged, then all that would be needed is a
CONFIG option set.

> As you said what I've always meant with hard-RT is the "diamond hard"
> thing. After all in linux everything that called hard-RT (RTAI, RTLinux,
> nanokernel) was "diamond hard" so far, preempt-RT is the first time in
> linux where I see the word "hard-RT" combined with something not
> "diamond hard".


I wouldn't call RTAI, RTLinux or a nano-kernel (embedded with Linux)
"Diamond" hard.  Maybe "Ruby" hard, but not diamond.  Remember, I use to
test code that was running airplane engines, and none of those mentioned
would qualify to run that.  I wouldn't want to be in an airplane that
had one of those as the main OS unless someone really stripped them down
or did the real work to verify them.

How much guarantee can the RTAI projects give on latencies?  And how
well does an application running on Linux (non-RT) communicate to an
application running as RT?  You don't need to answer, I guess I could
read up on it when I get the time.

So, time may tell. Ingo's patch may one day get to Ruby level, but right
now I believe 90% of all RT applications are satisfied with the "Metal"
level.

-- Steve


