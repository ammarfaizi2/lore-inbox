Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSFEILL>; Wed, 5 Jun 2002 04:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSFEILK>; Wed, 5 Jun 2002 04:11:10 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:43273 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S313558AbSFEILJ>; Wed, 5 Jun 2002 04:11:09 -0400
Message-ID: <3CFDC796.C05FC7E2@aitel.hist.no>
Date: Wed, 05 Jun 2002 10:11:02 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.20-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scheduler hints
In-Reply-To: <1023206034.912.89.camel@sinai>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
[...]
> Basically, scheduler hints are a way for a program to give a "hint" to
> the scheduler about its present behavior in the hopes of the scheduler
> subsequently making better scheduling decisions.  After all, who knows
> better than the application what it is about to do?
> 
> For example, consider a group of SCHED_RR threads that share a
> semaphore.  Before one of the threads were to acquire the semaphore, it
> could give a "hint" to the scheduler to increase its remaining timeslice
> in order to ensure it could complete its work and drop the semaphore
> before being preempted.  Since, if it were preempted, it would just end
> up being rescheduled as the other real-time threads would eventually
> block on the held semaphore.
> 
Seems to me this particular case is covered by increasing
priority when grabbing the semaphore and normalizing
priority when releasing.  

Only root can do that - but only root does real-time
anyway. And I guess only rood should be able to increase 
its timeslice too...

> Other hints could be "I am interactive" 
Already shows up as a thread who always ends its timeslice
blocking for io.  Such threads do get an priority
boost for the next timeslice.

> or "I am a batch (i.e. cpu hog)
shows up as a thread who spends its entire timeslice - these
don't get the above mentioned boost as it is assumed it gets
"enough cpu" while the interactive threads blocks.

> task" or "I am cache hot: try to keep me on this CPU".
Perhaps that might be useful.

> The scheduler tries hard to figure out the three qualities and it is
> usually right, although perhaps it can react quicker to these hints than
> it can figure things out on its own.  If nothing else, this serves as a
> useful tool for determining just how accurate our O(1) scheduler is.

Well, hog/interactive is determined in one timeslice already...

The problem is that this may be abused.  Someone nasty could
write a cpu hog that drops a lot of hints about being
interactive, starving real interactive programs.

Generally, it degenerates into application programmers
using _all_ the hints to get performance, so they
can beat some competitor in benchmarks.  And all
other programs just get penalized.

Helge Hafting
