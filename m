Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316606AbSFUOEx>; Fri, 21 Jun 2002 10:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSFUOEw>; Fri, 21 Jun 2002 10:04:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:6910 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S316606AbSFUOEt>;
	Fri, 21 Jun 2002 10:04:49 -0400
Message-ID: <3D13326C.E2383356@mvista.com>
Date: Fri, 21 Jun 2002 07:04:28 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: rml@tech9.net, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
References: <1024539334.917.110.camel@sinai>
		<20020619.192342.128398093.davem@redhat.com>
		<3D126B28.16C88E2B@mvista.com> <20020620.180358.33292945.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: george anzinger <george@mvista.com>
>    Date: Thu, 20 Jun 2002 16:54:16 -0700
> 
>    Is the only network issue?  Is it possible that the network code
>    uses bh_locking to protect against timers?  Moveing timers to
>    softirqs would invalidate this sort of protection.  Is this an
>    issue?
> 
> It is the whole issue.  We have to stop all timers while we run the
> non-SMP safe protocol code.

Thanks.  I think this can be done much the same way it is now.  I will modify the patch accordingly.

At the same time, I must say that stoping the timers is, IMNSHO, NOT a good thing for the kernel.  It can cause unexpected timer latencies which can impact most any task on the system.  (But you already knew this :)  I understand that it is not seldom used, but still... 
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
