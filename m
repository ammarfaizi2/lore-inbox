Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315785AbSFESIk>; Wed, 5 Jun 2002 14:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSFESIj>; Wed, 5 Jun 2002 14:08:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:29943 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S315785AbSFESHT>;
	Wed, 5 Jun 2002 14:07:19 -0400
Message-ID: <3CFE52D8.1A36682F@mvista.com>
Date: Wed, 05 Jun 2002 11:05:12 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Ian Collinson <icollinson@imerge.co.uk>,
        "'Andrew Morton'" <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
        Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
        andrea@suse.de
Subject: Re: realtime scheduling problems with 2.4 linux kernel >= 2.4.10
In-Reply-To: <C0D45ABB3F45D5118BBC00508BC292DB09C99A@imgserv04> <20020605141755.A1410@averell>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Wed, Jun 05, 2002 at 01:53:06PM +0200, Ian Collinson wrote:
> 
> >
> > Are there any potentially negative consequences of this fix, apart from
> > those already mentioned?
> 
> I don't think so.
> 
> It could still fail when you install a prio=99, SCHED_FIFO process.
> 
> > I certainly vote for this feature being preserved, as it is extremely useful
> > for debugging realtime priority apps.  FYI, we narrowed it down to breaking
> > in either 2.4.10-pre11 or pre12.
> 
> That was when the low latency console changes went in. Before that console
> switches could interrupt scheduling for a long time, causing problems
> for other realtime people. The change was to move the expensive parts
> of the console switch to keventd.

So that means that, with the above change to prio 99, we
reintroduce the latency problem, only now it is in a task
(keventd) and not an interrupt?  (I know, I know, the work
has to be done somewhere.  At least this way we can control
what priority level it is done at.  I.e. this is a step in
the right direction.  I just what folks to be aware of the
latency issue and where it is.)

For what its worth, you can change the priority of keventd
AFTER a system is up.  Robert Love's real time tools contain
a program (rt I think) that will do this for you.  Just
follow the URL for preemption in my sig. file and look
around.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
