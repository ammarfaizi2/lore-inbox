Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317534AbSFRSOk>; Tue, 18 Jun 2002 14:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317535AbSFRSOj>; Tue, 18 Jun 2002 14:14:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39932 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317534AbSFRSOi>;
	Tue, 18 Jun 2002 14:14:38 -0400
Message-ID: <3D0F7874.7F2B0A67@mvista.com>
Date: Tue, 18 Jun 2002 11:14:12 -0700
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
> 
> If you had deleted TIMER_BH you would have noticed this breakage.
> 
> Also, aren't there some dependencies on HI_SOFTIRQ being first in
> that enumeration?  This needs to be answered before going further
> with this patch.

HI_SOFTIRQ, if I understand it right, runs the old BH code.  Since most (all)
of this is going away, it would appear just the place to put the timer stuff.
TIMER_BH was first before and is still first.  


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
