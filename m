Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267667AbTAaBce>; Thu, 30 Jan 2003 20:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267668AbTAaBce>; Thu, 30 Jan 2003 20:32:34 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:31741 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267667AbTAaBcd>;
	Thu, 30 Jan 2003 20:32:33 -0500
Message-ID: <3E39D44A.95862534@mvista.com>
Date: Thu, 30 Jan 2003 17:41:30 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-14smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.4.21-pre4_tsc-lost-tick_A0
References: <1043972238.19049.27.camel@w-jstultz2.beaverton.ibm.com>
		 <3E39CC85.D9A339D0@mvista.com> <1043976173.19558.12.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> 
> On Thu, 2003-01-30 at 17:08, george anzinger wrote:
> > john stultz wrote:
> > > I'm already somewhat cautious that loops_per_jiffy isn't going to cut it
> > > with this patch (I'm thinking fast_gettimeoffset_quotient would probably
> > > be better). So please let me know if you find any issues with this
> > > patch.
> >
> > I think you are wondering about the "/", as am I.  Possibly
> > a while loop, or, something like
> > fast_gettimeoffset_quotient, but scaled to do jiffies
> > instead of micro seconds.  Still you SHOULD be doing this so
> > seldom that one wonders if the "/" is all that bad.
> 
> Yea, I'm assuming it would be rare enough that the div won't be too much
> of a performance drop and would make the code more clear. Although if it
> is a concern I'm not opposed to speeding it up.
> 
> > Another thing, possibly not so easily fixed given the
> > division between "arch" code and common code, but I would
> > like to see jiffies updated in only ONE place.  With this
> > patch it is updated in .../kernel/timer.c AND in
> > .../arch/kernel/time.c.  In the high-res-timers patch I made
> > the jiffies update an inline in an "arch" header file so I
> > could have the best of both worlds, i.e. update from common
> > code using arch resources (TSC, etc).
> 
> Yea, I'm not psyched about that as well (not only is it updated twice,
> but three times: arch independent, tsc and cyclone). The inline bit
> sounds interesting, are you planning on pushing that in?

I am a bit discouraged on that front.  I was hoping to get
the POSIX clocks & timers patch in, but it is long past
Halloween and, while he said he might, he didn't.  I don't
know if he is finished as yet, but...  The jiffies update
was part of the core patch to do the high res timers which
he said he would not take.  I would like to try parting it
out and pushing in some stuff, such as scmath.h which makes
things like fast_gettimeoffset_quotient not only
understandable but easy.  Folks in the cpu frequency area
would like that.  Still, my boss has other plans...

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
