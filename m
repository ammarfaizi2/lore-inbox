Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbTAUCoK>; Mon, 20 Jan 2003 21:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbTAUCoK>; Mon, 20 Jan 2003 21:44:10 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:29145 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266955AbTAUCoJ>;
	Mon, 20 Jan 2003 21:44:09 -0500
Subject: Re: [PATCH][2.5] hangcheck-timer
From: john stultz <johnstul@us.ibm.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030121020015.GQ20972@ca-server1.us.oracle.com>
References: <200301210135.h0L1ZFa06867@eng2.beaverton.ibm.com>
	 <1043113336.32478.97.camel@w-jstultz2.beaverton.ibm.com>
	 <20030121020015.GQ20972@ca-server1.us.oracle.com>
Content-Type: text/plain
Organization: 
Message-Id: <1043117157.32472.116.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 20 Jan 2003 18:45:57 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-20 at 18:00, Joel Becker wrote:
> On Mon, Jan 20, 2003 at 05:42:16PM -0800, john stultz wrote:
> > get_cycles() is a poor method for determining "real time". 
> > Please use do_gettimeofday().
> 
> 	Does do_gettimeofday() exist on all platforms?  Does it indeed
> give actual wall clock time, instead of the inaccurate time jiffies can
> give?

Yep, do_gettimeofday is called from generic code in sys_gettimeofday()
(kernel/time.c). It returns the same value userspace code would see
calling gettimeofday(). 

> > >  +      if (tsc_diff > hangcheck_tsc_margin) {
> > 
> > but now we're using it to compare cycles!  180sec != 180 cycles
> 
> 	Look at the calculations.  I'm comparing cycles to cycles,
> calculated from the original seconds.

Ah! Ok, I missed the conversion in hangcheck_init. Even so, the default
initializer is misleading. Yea, that's it... :)

> > Additionally, this code doesn't take systems that have unsync'ed TSCs,
> > or systems that change cpu frequency into account. Again, please use
> > do_gettimeofday(). Then you can then talk about the values returned in
> > secs and usecs, and I believe things will be much more clear. 
> 
> 	I'll look into it, but it must absolutely be in terms of wall
> clock time as measured from outside the system.

Completely understandable. do_gettimeofday will give you just that (w/o
the conversion muck w/ HZ and loops_per_jiffy). 

thanks
-john

