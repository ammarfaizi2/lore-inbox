Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262245AbSJFW17>; Sun, 6 Oct 2002 18:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262246AbSJFW16>; Sun, 6 Oct 2002 18:27:58 -0400
Received: from packet.digeo.com ([12.110.80.53]:49049 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262245AbSJFW1z>;
	Sun, 6 Oct 2002 18:27:55 -0400
Message-ID: <3DA0BA33.5B295A46@digeo.com>
Date: Sun, 06 Oct 2002 15:33:23 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Dave Hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: 2.5.40-mm2
References: <3DA0B422.C23B23D4@digeo.com> <1033943021.27093.29.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2002 22:33:26.0693 (UTC) FILETIME=[6330FD50:01C26D88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Sun, 2002-10-06 at 18:07, Andrew Morton wrote:
> 
> > > -                       while (base->running_timer == timer) {
> > > +                       while (base->running_timer == timer)
> > >                                 cpu_relax();
> > > -                               preempt_disable();
> > > -                               preempt_enable();
> 
> I am confused as to why Ingo would put these here.  He knows very well
> what he is doing... surely he had a reason.
> 
> If he intended to force a preemption point here, then the lines needs to
> be reversed.  This assumes, of course, preemption is disabled here.  But
> I do not think it is.
> 
> If he just wanted to check for preemption, we have a
> preempt_check_resched() which does just that (I even think he wrote
> it).  Note as long as interrupts are enabled this probably does not
> achieve much anyhow.
> 

I think it's a way of doing "cond_resched() if cond_resched() is
a legal thing to do right now".

I'm sure David isn't using preempt though.
