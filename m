Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268077AbRHAUT1>; Wed, 1 Aug 2001 16:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268078AbRHAUTS>; Wed, 1 Aug 2001 16:19:18 -0400
Received: from iris.mc.com ([192.233.16.119]:65270 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S268077AbRHAUTF>;
	Wed, 1 Aug 2001 16:19:05 -0400
From: Mark Salisbury <mbs@mc.com>
To: root@chaos.analogic.com, "Richard B. Johnson" <root@chaos.analogic.com>,
        Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: No 100 HZ timer !
Date: Wed, 1 Aug 2001 16:08:09 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1010801154207.1042A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1010801154207.1042A-100000@chaos.analogic.com>
MIME-Version: 1.0
Message-Id: <01080116163003.12001@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you are misunderstanding what is meant by tickless.

tickless means that instead of having a clock interruptevery 10 ms whether
there are any timed events pending or not, a tickeless system only generates an
interrupt when there is a pending timed event.

timed events are such things as:

	process quanta expiration, 
	POSIX timers
	alarm()
etc.

jiffies, as such, don't need to be updated as a tickless system relies on a
decrementer and a (usually 64-bit) wall clock. a jiffie then is just the
wallclock count. (or more likely, wall clock >> a few bits)

the tickless system is intended to take advantage of some of the more modern
features of newer CPU's (such as useful counters and decrementers)

the fixed interval, ticked system is a reasonable lowest common denominator
solution.  but when hardware is capable of supporting a more flexible, modern
system, it should be an available option.



On Wed, 01 Aug 2001, Richard B. Johnson wrote:
> > george anzinger wrote:
> > 
> > > The testing I have done seems to indicate a lower overhead on a lightly
> > > loaded system, about the same overhead with some load, and much more
> > > overhead with a heavy load.  To me this seems like the wrong thing to
> > 
> 
> Doesn't the "tick-less" system presume that somebody, somewhere, will
> be sleeping sometime during the 1/HZ interval so that the scheduler
> gets control?
> 
> If everybody's doing:
> 
> 	for(;;)
>           number_crunch();
> 
> And no I/O is pending, how does the jiffy count get bumped?
> 
> I think the "tick-less" system relies upon a side-effect of
> interactive use that can't be relied upon for design criteria.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
> 
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  Thanks to all who sponsored me for the        **
**  Multiple Sclerosis Great Mass Getaway!!       **
**  Robert, Michele and I raised $10,000 and the  **
**  raised over $1,000,000 ride as a whole.  The  **
**  ride was great, and we didn't get rained on!  **
**  Thanks again to all of you who made this      **
**  possible!!                                    **
**------------------------------------------------*/

