Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267541AbTAaBNh>; Thu, 30 Jan 2003 20:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbTAaBNg>; Thu, 30 Jan 2003 20:13:36 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:12763 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267541AbTAaBNg>; Thu, 30 Jan 2003 20:13:36 -0500
Subject: Re: [RFC][PATCH] linux-2.4.21-pre4_tsc-lost-tick_A0
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3E39CC85.D9A339D0@mvista.com>
References: <1043972238.19049.27.camel@w-jstultz2.beaverton.ibm.com>
	 <3E39CC85.D9A339D0@mvista.com>
Content-Type: text/plain
Organization: 
Message-Id: <1043976173.19558.12.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 30 Jan 2003 17:22:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-30 at 17:08, george anzinger wrote:
> john stultz wrote:
> > I'm already somewhat cautious that loops_per_jiffy isn't going to cut it
> > with this patch (I'm thinking fast_gettimeoffset_quotient would probably
> > be better). So please let me know if you find any issues with this
> > patch.
> 
> I think you are wondering about the "/", as am I.  Possibly
> a while loop, or, something like
> fast_gettimeoffset_quotient, but scaled to do jiffies
> instead of micro seconds.  Still you SHOULD be doing this so
> seldom that one wonders if the "/" is all that bad.

Yea, I'm assuming it would be rare enough that the div won't be too much
of a performance drop and would make the code more clear. Although if it
is a concern I'm not opposed to speeding it up. 

> Another thing, possibly not so easily fixed given the
> division between "arch" code and common code, but I would
> like to see jiffies updated in only ONE place.  With this
> patch it is updated in .../kernel/timer.c AND in
> .../arch/kernel/time.c.  In the high-res-timers patch I made
> the jiffies update an inline in an "arch" header file so I
> could have the best of both worlds, i.e. update from common
> code using arch resources (TSC, etc).

Yea, I'm not psyched about that as well (not only is it updated twice,
but three times: arch independent, tsc and cyclone). The inline bit
sounds interesting, are you planning on pushing that in?

thanks
-john


