Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSHWUl1>; Fri, 23 Aug 2002 16:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSHWUl1>; Fri, 23 Aug 2002 16:41:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:16118 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S310190AbSHWUl0>;
	Fri, 23 Aug 2002 16:41:26 -0400
Message-ID: <3D669ED1.402D1432@mvista.com>
Date: Fri, 23 Aug 2002 13:45:05 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: root@chaos.analogic.com, sanket rathi <sanket@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: interrupt handler
References: <Pine.LNX.3.95.1020823123854.2797A-100000@chaos.analogic.com> <1030121541.1935.3684.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Fri, 2002-08-23 at 12:45, Richard B. Johnson wrote:
> 
> > On 23 Aug 2002, Robert Love wrote:
> > > Only the current interrupt handler is disabled... interrupts are
> > > normally ON.
> >
> > No. Check out irq.c, line 446. The interrupts are turned back on
> > only if the flag did not have SA_INTERRUPT set. Certainly most
> > requests for interrupt services within drivers have SA_INTERRUPT
> > set.
> 
> Sigh... SA_INTERRUPT is used only for fast interrupts.  Certainly most
> drivers do not have it (and most that do are probably from the way old
> days when we went through great pains to distinguish between fast and
> slow interrupt handlers).
> 
> Today, very few things should run with all interrupts disabled.  That is
> just dumb.  In fact, on this system, it seems only the timer interrupt
> sets SA_INTERRUPT...
> 
And THAT makes sense as most of the timer interrupt is
processed holding the write_lock() on xtime which would need
to be an irq lock otherwise.  If they were turned on the
system would have an additional interrupts on/off overhead.

>         Robert Love
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
