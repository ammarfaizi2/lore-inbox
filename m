Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287205AbSALWAR>; Sat, 12 Jan 2002 17:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287572AbSALWAG>; Sat, 12 Jan 2002 17:00:06 -0500
Received: from mail.zmailer.org ([194.252.70.162]:11152 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S287205AbSALV7s>;
	Sat, 12 Jan 2002 16:59:48 -0500
Date: Sat, 12 Jan 2002 23:59:45 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "James C. Owens" <owensjc@bellatlantic.net>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler ver H6 - more straightforward timeslice macros
Message-ID: <20020112235945.G1914@mea-ext.zmailer.org>
In-Reply-To: <3C408B78.6050102@bellatlantic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C408B78.6050102@bellatlantic.net>; from owensjc@bellatlantic.net on Sat, Jan 12, 2002 at 02:16:08PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 02:16:08PM -0500, James C. Owens wrote:
> Ingo,
> 
> I like the new scheduler. It seems like the timeslice macros in sched.h 
> could be more straighforward - i.e. instead of

   (I quote too much, but to illustriate the point...)

> #define PRIO_TO_TIMESLICE(p) \
>   ((( (MAX_USER_PRIO-1-USER_PRIO(p))*(MAX_TIMESLICE-MIN_TIMESLICE) + \
>      MAX_USER_PRIO-1) / MAX_USER_PRIO) + MIN_TIMESLICE)
> 
> #define RT_PRIO_TO_TIMESLICE(p) \
>   ((( (MAX_RT_PRIO-(p)-1)*(MAX_TIMESLICE-MIN_TIMESLICE) + \
>      MAX_RT_PRIO-1) / MAX_RT_PRIO) + MIN_TIMESLICE)
> 
> why not
> 
> #define PRIO_TO_TIMESLICE(p) \
>   (MAX_TIMESLICE - 
>    (USER_PRIO(p)/(MAX_USER_PRIO-1))*(MAX_TIMESLICE-MIN_TIMESLICE))
> 
> #define RT_PRIO_TO_TIMESLICE(p) \
>   (MAX_TIMESLICE - (p/(MAX_RT_PRIO-1))*(MAX_TIMESLICE-MIN_TIMESLICE))
> 
> 
> The second way seems simpler to me, and really illustrates what you are 
> doing in a more straightforward manner.

   Except that the math is INTEGER, not floating-point,
   which means that this way you loose precission.

   You HAVE TO do multiplications first, only then (finally) the division.

   Depending the value-spaces, small-enough value-spaces might be
   turnable into table mappings.  However that has lots of dependencies
   in hardware architecture, e.g. memory access speeds, cache pollution,
   speed of multiply/divide operations, etc.

   If dividers/multipliers are constants, and powers of two, the math
   can happen with constant shifts, which are fast at all systems.
   If not, things get rather complicated.   (And thus a careless -1,
   or lack of one, may be costly.)

> I also cleaned up some of the comments. The sched.h diff between the H6 
> version of the scheduler applied to 2.4.18-pre3 and vanilla 2.4.18-pre3 
> follows: (Note that I changed the min and max timeslices to 20 and 100 
> for my own use.)
...

  "uni-diff please, use '-u' option for the diff"

> To lkml - please cc me on any response, as I do not subscribe to the 
> lkml - I read it via a news gateway.
> 
> 
> Jim Owens

/Matti Aarnio
