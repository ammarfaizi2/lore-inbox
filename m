Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311424AbSDDUEg>; Thu, 4 Apr 2002 15:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311418AbSDDUER>; Thu, 4 Apr 2002 15:04:17 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:53486 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S311424AbSDDUEE>;
	Thu, 4 Apr 2002 15:04:04 -0500
Message-ID: <3CACB166.F2E60ABE@mvista.com>
Date: Thu, 04 Apr 2002 12:02:46 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Robert Love <rml@tech9.net>, Linus Torvalds <torvalds@transmeta.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() atboot 
 time
In-Reply-To: <Pine.LNX.4.33.0204041113410.12895-100000@penguin.transmeta.com> <1017948383.22303.537.camel@phantasy> <3CACAC7A.4040209@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> Robert Love wrote:
> >       tsk->exit_code = code;
> >       exit_notify();
> > +     preempt_enable_no_resched();
>        * PREEMPT HERE *
> >       schedule();
> >       BUG();
> 
> Isn't there still a race here?  A preempt CAN happen after you reenable,
> right?  Admittedly, its a small window, but it _is_ a window.

Right, eliminate this line.  Since the task is going away it doesn't
matter.  Actually it doesn't matter even if schedule() returns (i.e. for
other than ZOMBIE) as long as preempt is enabled after the schedule()
call, somewhere.  It is designed to work this way for a reason, this
being one of them.

-g
> 
> --
> Dave Hansen
> haveblue@us.ibm.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
