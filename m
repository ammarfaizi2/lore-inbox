Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbTAUBvW>; Mon, 20 Jan 2003 20:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbTAUBvW>; Mon, 20 Jan 2003 20:51:22 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:28380 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S266938AbTAUBvU>; Mon, 20 Jan 2003 20:51:20 -0500
Date: Mon, 20 Jan 2003 18:00:16 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] hangcheck-timer
Message-ID: <20030121020015.GQ20972@ca-server1.us.oracle.com>
References: <200301210135.h0L1ZFa06867@eng2.beaverton.ibm.com> <1043113336.32478.97.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043113336.32478.97.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 05:42:16PM -0800, john stultz wrote:
> get_cycles() is a poor method for determining "real time". 
> Please use do_gettimeofday().

	Does do_gettimeofday() exist on all platforms?  Does it indeed
give actual wall clock time, instead of the inaccurate time jiffies can
give?

> I believe you mean "udelay for 60 micro-seconds"

	No, I mean 60 *seconds*.  There have been drivers and such that
do pause the entire box that long.

> Wait, so 180 seconds is the margin of error?

	Yup, for the default.  I'm not beholden to these specific
defaults.  They're just the defaults we use in our environment.

> >  +      if (tsc_diff > hangcheck_tsc_margin) {
> 
> but now we're using it to compare cycles!  180sec != 180 cycles

	Look at the calculations.  I'm comparing cycles to cycles,
calculated from the original seconds.

> Additionally, this code doesn't take systems that have unsync'ed TSCs,
> or systems that change cpu frequency into account. Again, please use
> do_gettimeofday(). Then you can then talk about the values returned in
> secs and usecs, and I believe things will be much more clear. 

	I'll look into it, but it must absolutely be in terms of wall
clock time as measured from outside the system.

Joel

-- 

Life's Little Instruction Book #99

	"Think big thoughts, but relish small pleasures."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
