Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315555AbSEHXZw>; Wed, 8 May 2002 19:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315556AbSEHXZv>; Wed, 8 May 2002 19:25:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:16374 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S315555AbSEHXZu>;
	Wed, 8 May 2002 19:25:50 -0400
Message-ID: <3CD9B324.F3251957@mvista.com>
Date: Wed, 08 May 2002 16:22:12 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Der Herr Hofrat <der.herr@mail.hofr.at>
CC: Simon Butcher <pickle@alien.net.au>,
        "Serguei I. Ivantsov" <admin@gsc-game.kiev.ua>,
        linux-gcc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Measure time
In-Reply-To: <200205081658.g48GwmV06862@hofr.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Der Herr Hofrat wrote:
> 
> >
> > Hi,
> >
> > ftime() will return milliseconds, but it's considered an obsolete function.
> > You could use gettimeofday() (as Richard Johnson suggested) to get
> > microseconds and divide them to get milliseconds, although I don't know how
> > time critical your routines are.
> >
> > If you're still looking for nanoseconds, I'm told you can use
> > clock_gettime() but it's still quite unavailable (I've never seen it myself,
> > yet).. however even if it was available you possibly wouldn't get a very
> > high resolution from it with current systems..
> >
> clock_gettime() is available in the hard realtime extensions like RTLinux .
> The clock resolution is limited to 32ns though - and atleast on X86 I don't
> think there is a way to get below that.

The high-res-timers patch provides clock_gettime() with resolution to
the TSC increment.  But you need to understand that this is a system
call which can take on the order of 1000 or these units.  Add in a
little cach hit/ miss and interrupt randomness and well...

Still, there it is.  Check out the web site below.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
