Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129375AbRATM7C>; Sat, 20 Jan 2001 07:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRATM6x>; Sat, 20 Jan 2001 07:58:53 -0500
Received: from medusa.sparta.lu.se ([194.47.250.193]:16983 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S129375AbRATM6p>; Sat, 20 Jan 2001 07:58:45 -0500
Date: Sat, 20 Jan 2001 12:39:20 +0100 (MET)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Martin MaD Douda <martin@douda.net>
cc: Michael Lindner <mikel@att.net>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data  available
In-Reply-To: <Pine.LNX.4.21.0101201322110.839-100000@madness.madness.mad>
Message-ID: <Pine.LNX.3.96.1010120122014.28993A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2001, Martin MaD Douda wrote:
> On Fri, 19 Jan 2001, Michael Lindner wrote:
> > data is generated as a result of data received via a select(),
> > the next delivery occurs a clock tick later, with the machine
> > mostly idle.
> 
> The machine is in fact not idle - there is a task running - idle task.
> Could the problem be that scheduler does not preempt this task to run
> something more useful?

Normally, the "idle task" (task[0]) does this pseudo-code:

   while(1) { 
      if(need_resched)
         schedule();
   }

to minimize latency out of idle so if that actually is running it should
not be a problem (unless need_resched is not set by the wakeup calls)

Perhaps the kapm-idled kernel thread is killing your latency, you could
try disabling APM and APM-making-idle-calls especially. Also check ps aux
and see if anything else is taking your idle CPU %.

-BW

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
