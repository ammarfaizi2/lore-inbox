Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbSJRTYv>; Fri, 18 Oct 2002 15:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265209AbSJRTYv>; Fri, 18 Oct 2002 15:24:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4852 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265196AbSJRTYu>;
	Fri, 18 Oct 2002 15:24:50 -0400
Message-ID: <3DB0613C.D07A0913@mvista.com>
Date: Fri, 18 Oct 2002 12:30:04 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrea Arcangeli <andrea@suse.de>, Stephen Hemminger <shemminger@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
References: <Pine.LNX.4.44.0210181018070.21302-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 18 Oct 2002, Andrea Arcangeli wrote:
> 
> > On Fri, Oct 18, 2002 at 09:45:41AM -0700, george anzinger wrote:
> > > Stephen Hemminger wrote:
> > > > current cpu (and maybe current pid) somehow.  And it would be possible
> > > > to avoid  preemption while in a vsyscall text page, some other Unix
> > > > variants do this to implement portions of the thread library in kernel
> > > > provided user text pages.
> > > >
> > > Now there is an idea!  Lock preemption in user space if and
> >
> > sounds not good to me, you would miss a wakeup and you would delay the
> > schedule of 1/HZ in the worst (close to the common) case.
> 
> That's not the real problem.
> 
> The real problem is that somebody can jump into the middle of a function
> (or even into the middle of an instruction), causing the function to do
> something totally different from the intended effect.
> 
> In particular, it can cause the function to loop forever.
> 
> If you disable preemption of user space, you now killed the machine.
> 
> In short - others may do it, but it's a total _DISASTER_ from a security
> and stability standpoint. Don't go there.

Oops, hadn't thought of that.  Back out, undo, etc. :)

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
