Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281180AbRLDV1U>; Tue, 4 Dec 2001 16:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283510AbRLDV1D>; Tue, 4 Dec 2001 16:27:03 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:19189 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S283499AbRLDV0n>; Tue, 4 Dec 2001 16:26:43 -0500
Message-ID: <3C0D3F54.8DE05CAB@mvista.com>
Date: Tue, 04 Dec 2001 13:25:40 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] improve spinlock debugging
In-Reply-To: <3C0BDC33.6E18C815@colorfullife.com> 
		<3C0D3283.4DA4DD2B@mvista.com> <1007499102.1303.24.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Tue, 2001-12-04 at 15:30, george anzinger wrote:
> 
> > spin_lockirq
> >
> > spin_unlock
> >
> > restore_irq
> 
> Given this order, couldn't we _always_ not touch the preempt count since
> irq's are off?
> 
> Further, since I doubt we ever see:
> 
>         spin_lock_irq
>         restore_irq
>         spin_unlock
> 
> and the common use is:
> 
>         spin_lock_irq
>         spin_unlock_irq
> 
> Isn't it safe to have spin_lock_irq *never* touch the preempt count?
> 
NO.  The problem is the first example above.  The spin_unlock will down
count, but the spin_lockirq did NOT do the paired up count (been there,
done that).  This is where we need the spin_unlock_no_irq_restore.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
