Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbTCUUBh>; Fri, 21 Mar 2003 15:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263859AbTCUTch>; Fri, 21 Mar 2003 14:32:37 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:48796 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S263842AbTCUTcV>; Fri, 21 Mar 2003 14:32:21 -0500
Date: Fri, 21 Mar 2003 11:43:00 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: george anzinger <george@mvista.com>
Cc: john stultz <johnstul@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Clock monotonic  a suggestion
Message-ID: <20030321194300.GB31586@ca-server1.us.oracle.com>
References: <3E7A59CD.8040700@mvista.com> <20030321025045.GX2835@ca-server1.us.oracle.com> <3E7AC6C9.5000401@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7AC6C9.5000401@mvista.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 12:01:13AM -0800, george anzinger wrote:
> To carry this to the absurd, it also precludes most anything other 
> than a GPS or WWV based clock.  If we are to have any clock that is 

	No, cycle counters do just fine.
 
> >1    gettimeofday = 1000000000
> >2    driver delays 10s
> >3    gettimeofday = 1000000000
> >4    timer notices lag and adjusts
> 
> Uh, how is this done?  At this time there IS correction for delays up 
> to about a second built into the gettimeofday() code.  You seem to be 
> assuming that we can do better than this with clock monotonic.  Given 
> the right hardware, this may even be possible, but why not correct 
> gettimeofday in the same way?

	monotonic_clock as proposed uses a hardware clock.
Specifically, the TSC on vanilla intel, the Cyclone timer on x440, and
associated clocks on S/390 (to speak of platforms I've visited
recently).  Right now, the hangcheck-timer accesses the hardware counter
directly.  monotonic_clock is intended as a portable and consistent
accessor instead.
	The current gettimeofday() corrects for ~1s.  Even if we found a
way to correct for ~1000s or more, there would still be a race between
when the caller reads and when the correction happens.  A clock that
reads a hardware counter doesn't have this problem.
	If code doesn't need this accuracy, it can just use
gettimeofday().

Joel

-- 

"Glory is fleeting, but obscurity is forever."  
         - Napoleon Bonaparte

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
