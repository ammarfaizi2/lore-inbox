Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSHIVJK>; Fri, 9 Aug 2002 17:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSHIVJJ>; Fri, 9 Aug 2002 17:09:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24518 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315923AbSHIVJJ>;
	Fri, 9 Aug 2002 17:09:09 -0400
Subject: Re: [PATCH] tsc-disable_B9
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D540ED3.58F200F6@mvista.com>
References: <1028771615.22918.188.camel@cog> 
	<1028812663.28883.32.camel@irongate.swansea.linux.org.uk> 
	<1028860246.1117.34.camel@cog> 
	<1028884665.28882.173.camel@irongate.swansea.linux.org.uk>
	<1028915214.1117.46.camel@cog>  <3D540ED3.58F200F6@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Aug 2002 13:58:01 -0700
Message-Id: <1028926681.1118.64.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 11:49, george anzinger wrote:

> An interesting approach, however, could you take a look at
> the high-res-timers patch (see signature).  In that code (in

I skimmed the patch, and I like alot of the cleanups and tweaks you have
make to arch/i386/kernel/time.c. As the number of time sources are
growing with the TSC, PIT, and now the cyclone counter and ACPI timer
(also, doesn't MS have some sort of high res performance counter
standard they're pushing for in hardware?), I'm thinking of rearranging
and renaming some of the code to better allow these changes. The current
do_slow/fast_gettimeoffset plus in-function 'if(use_tsc)' switches are
getting to be messy with the new additions. 

However, this may be a 2.5 issue, so before I take my 2.4 fixes and port
them to a new infrastructure, I'd like it if someone chimed in and said
"do it" or "skip it" for 2.4.


> the TSC version), we use the TSC to update jiffies and
> _sub_jiffie (which is TSC counts into the next jiffie).  We
> also want to be able to "grab" a new TSC and figure the time
> quickly, without updating either jiffies or _sub_jiffie. 
> Your approach would, I think, mean that both jiffies and
> _sub_jiffie would be per cpu values, not impossible, but,
> well, hard.

I need to look over you code a bit more. It looks interesting though. 

 
> On the other hand, the high-res-timers patch also allows one
> to use the ACPI pm timer, and ignore TSC completely :)

Yea, having another source of time is always nice, as long as it works
reliably. After all this time related work I'm not sure if I'm going to
start wearing 3-4 watches or just screw it and wear none. :)

thank for the pointer and feedback.
-john

 

