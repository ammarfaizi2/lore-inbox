Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310211AbSCFW0I>; Wed, 6 Mar 2002 17:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310241AbSCFWZ6>; Wed, 6 Mar 2002 17:25:58 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:23289 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S310211AbSCFWZs>;
	Wed, 6 Mar 2002 17:25:48 -0500
Message-ID: <3C86973E.C029095F@mvista.com>
Date: Wed, 06 Mar 2002 14:25:02 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Ball <chris@void.printf.net>
CC: dean gaudet <dean-list-linux-kernel@arctic.org>,
        Ben Greear <greearb@candelatech.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: a faster way to gettimeofday?
In-Reply-To: <Pine.LNX.4.33.0203061238380.17114-100000@twinlark.arctic.org> <87bse14c4h.fsf@lexis.house.pkl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ball wrote:
> 
> >>>>> "dean" == dean gaudet <dean-list-linux-kernel@arctic.org> writes:
> 
>     dean> ingo started the proper work for this, for example, see:
>     dean> <http://people.redhat.com/mingo/vsyscall-patches/vsyscall-2.3.32-F4>
>     dean> (there's a documentation file near the bottom of the patch)
>     dean> but it doesn't appear to support gettimeofday via rdtsc yet.
> 
> Interesting patch; when last I looked, vsyscalls were only being
> implemented on the new 64-bit architectures.
> 
> Does this patch break binary compatibility?  I seem to recall that being
> Andrea's reason for not running vsyscalls on standard x86 back in August
> last year.
>
In keeping with the subject, the gettimeofday call in this patch does
NOT get the current timeofday, but the time it was last updated, which
is usually every 1/HZ.  The REAL gettimeofday adds a converted delta of
the TSC to get the time to NOW with a resolution of 1 micro second. 
(Oh, and by the way, it does not update xtime in the process of doing
this.)

As a wonder, just how long is your system taking to do a gettimeofday. 
Mine does it in under one micro second (800 MHZ PIII).

-g
 
> - Chris.
> --
> $a="printf.net"; Chris Ball | chris@void.$a | www.$a | finger: chris@$a
>          "In the beginning there was nothing, which exploded."
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
