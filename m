Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279500AbRJXJHv>; Wed, 24 Oct 2001 05:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279504AbRJXJHk>; Wed, 24 Oct 2001 05:07:40 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:11 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S279502AbRJXJHe>; Wed, 24 Oct 2001 05:07:34 -0400
Message-ID: <3BD684C7.6BF5442B@idb.hist.no>
Date: Wed, 24 Oct 2001 11:07:19 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: time tells all about kernel VM's
In-Reply-To: <3BD51F02.92B9B7F3@idb.hist.no> <uzjB7.3848$MX4.655317120@newssvr17.news.prodigy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
[...]
> | And what app to kill in such a situation?
> | You had a single memory pig, but it aint necessarily so.
> 
> I think the problem is not killing the wrong thing, but not killing
> anything... 

The OOM killer never ever kills anything when the machine _isn't_ OOM.
That is not its job.  The OOM killer is there fix one particular 
crisis:  When memory is needed for further processing but none
at all exists.  It kills a process when the alternative is
a kernel crash.

The OOM killer is not there to make your machine perform
reasonably, it is not a load control measure.

> We can argue any old factors for selection, but I would
> first argue that the real problem is that nothing was killed because the
> problem was not noticed.

What I am saying is that you need another killer.  The machine wasn't
OOM,
so of course the OOM killer didn't notice.  It was merely using
its memory in a stupid way, causing extremely bad performance.  It isn't
OOM when there's 600M in buffers - all those may be freed.

Fixing this case would be nice.  But overload scenarios are
still possible, so what you want is probably an overload killer.

> One possible way to recognize the problem is to identify the ratio of
> page faults to time slice used and assume there is trouble in River City
> if that gets high and stays high. I leave it to the VM gurus to define
> "high," but processes which continually block for page fault as opposed
> to i/o of some kind are an indication of problems, and likely to be a
> factor in deciding what to kill.

Note that it is possible to have a machine that perform excellent
even if one process is trashing to hell (and spending weeks on
a 5-minute task due to trashing.)

How?  This is possible if the process isn't allowed to use more
than some reasonable fraction of RAM.  It can swap a lot if it
needs more, but other, more reasonable processes will run
at full speed and not swap and get enough cache for file io.
(You definitely want
swap on a separate spindle in this case, or you loose IO
performance for the other processes.)

I believe som os'es, like VMS, can do this.
The problem with this approach is administration.  There is no
automatic way to estimate how much RAM is reasonable for a process.

A big simulation with no IO can reasonably use 99% of the memory on
a dedicated machine.  But doing that would kill both desktop
and server machines.  So administrators would have to set memory
quotas for every process, which is a lot of work.  

And you may have to set quotas for every run - so you can't
just stick it in a script.  Gcc is one example - I have memory
enough to run several in parallel for a kernel compile,
but I run only one for a big C++ compile.

Helge Hafting
