Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290070AbSBSU4V>; Tue, 19 Feb 2002 15:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290047AbSBSU4L>; Tue, 19 Feb 2002 15:56:11 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:20217 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S290070AbSBSUz4>; Tue, 19 Feb 2002 15:55:56 -0500
Message-ID: <3C72BBBA.FB79F6D0@mvista.com>
Date: Tue, 19 Feb 2002 12:55:22 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Ben Greear <greearb@candelatech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: jiffies rollover, uptime etc.
In-Reply-To: <Pine.LNX.3.96.1020218191149.14047A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> On Mon, 18 Feb 2002, Ben Greear wrote:
> 
> > I wonder, is it more expensive to write all drivers to handle the
> > wraps than to take the long long increment hit?  The increment is
> > once every 10 miliseconds, right?  That is not too often, all things
> > considered...
> 
>   If you are willing to code in assembler instead of C you can do better,
> at least on x86. You just need to do a 32 bit increment on the LS word,
> and if you get a carry you can incr the MS word.
> 
> > Maybe the non-atomicity of the long long increment is the problem?
> 
>   I doubt it, the problem is that the software which expects jiffies is
> not all going to work well 64 bit. I think that's more the issue, and why
> Alan et al are fixing it piecemeal, I don't think there's some magic fix
> they're missing.
> 
> > Does this problem still exist on 64-bit machines?
> 
> Absolutely. But not as often ;-)

Actually you will have a VERY hard time getting it to roll over.  Issues
of your life time, not to mention the hardware's life time.  64 bits
makes a VERY large number and you are counting in 427 day increments. 
Remember we have been counting seconds since 1970 in 32 bits and
rollover is still, most likely, beyond the capability of any machine
running today to get to.  Now consider counting in 427 day increments
instead of seconds.
> 
> --
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
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
