Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130493AbRDJRtm>; Tue, 10 Apr 2001 13:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130487AbRDJRtc>; Tue, 10 Apr 2001 13:49:32 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:44043 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S130493AbRDJRtU>;
	Tue, 10 Apr 2001 13:49:20 -0400
Date: Tue, 10 Apr 2001 11:51:33 -0600
From: yodaiken@fsmlabs.com
To: David Schleef <ds@schleef.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Mark Salisbury <mbs@mc.com>, Jeff Dike <jdike@karaya.com>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410115133.B21319@hq.fsmlabs.com>
In-Reply-To: <Pine.LNX.3.96.1010410002852.4212A-100000@artax.karlin.mff.cuni.cz> <E14mkGA-000341-00@the-village.bc.nu> <20010410044336.A1934@stm.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010410044336.A1934@stm.lbl.gov>; from ds@schleef.org on Tue, Apr 10, 2001 at 04:43:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 04:43:36AM -0700, David Schleef wrote:
> However, on machines without a monotonically increasing counter,
> i.e., the TSC, you have to use 8254 timer 0 as both the timebase
> and the interval counter -- you end up slowly losing time because
> of the race condition between reading the timer and writing a
> new interval.  RTAI's solution is to disable kd_mksound and
> use timer 2 as a poor man's TSC.  If either of those is too big
> of a price, it may suffice to report that the timer granularity
> on 486's is 10 ms.

Just for the record, Michael Barabanov did this in RTLinux from before
kd_mksound was a function pointer in 1995. Michael had an optimization
attempt using channel 1 for a while, but on very slow machines this 
was not sufficient and he went back to channel 2. Of course, the 
fundamental problem is that board designers keep putting an 1920s
part in machines built in 2001. 

Here's the comment from the RTLinux 0.5 patch -- all available on the archives
on rtlinux.com.

+/* The main procedure; resets the 8254 timer to generate an interrupt.  The
+ * tricky part is to keep the global time while reprogramming it.  We latch
+ * counters 0 and 2 atomically before and after reprogramming to figure it out.
+ */


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

