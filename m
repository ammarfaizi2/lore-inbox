Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317496AbSFRRCB>; Tue, 18 Jun 2002 13:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317497AbSFRRCA>; Tue, 18 Jun 2002 13:02:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26863 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317496AbSFRRB7>;
	Tue, 18 Jun 2002 13:01:59 -0400
Message-ID: <3D0F675F.54B87C38@mvista.com>
Date: Tue, 18 Jun 2002 10:01:19 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: willy@debian.org, rml@mvista.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
References: <3D0EACCA.3290139@mvista.com> <20020617.211548.63484157.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: george anzinger <george@mvista.com>
>    Date: Mon, 17 Jun 2002 20:45:14 -0700
> 
>    This patch replaces the timer_bh with a tasklet.
> 
> This is going to break a lot of stuff.
> 
> For one thing, the net/core/dev.c:deliver_to_old_ones() code to
> disable timers no longer will work.

Could you elaborate on the reason for the above bit of
code?  Is it to cover some thing from the past or is this an
on going issue?  I.e. will this disappear soon?  Is its
usage dependent on a particular driver?

Mostly I am interested in this because it may be at the
bottom of a VERY elusive bug (4 systems, heavy network load,
crash at 22 hours into the test).  Please help.

-g
> 
> If you had deleted TIMER_BH you would have noticed this breakage.
> 
> Also, aren't there some dependencies on HI_SOFTIRQ being first in
> that enumeration?  This needs to be answered before going further
> with this patch.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
