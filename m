Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285065AbRL0DIc>; Wed, 26 Dec 2001 22:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285073AbRL0DIW>; Wed, 26 Dec 2001 22:08:22 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:19462 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S285065AbRL0DIT>;
	Wed, 26 Dec 2001 22:08:19 -0500
Date: Wed, 26 Dec 2001 20:01:25 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>, Mike Kravetz <kravetz@us.ibm.com>,
        Momchil Velikov <velco@fadata.bg>, george anzinger <george@mvista.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
Message-ID: <20011226200124.A566@hq2>
In-Reply-To: <20011223223348.A20895@hq2> <Pine.LNX.4.40.0112241023310.1517-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0112241023310.1517-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2001 at 10:52:46AM -0800, Davide Libenzi wrote:
> I know what you're saying but my goal now is to fix the scheduler not the
> overall RT latency ( at least not the one that does not depend on the

my bias is to fix the cause of the problem, but go ahead.


> scheduler ). Just take for example your 17us for your 800MHz machine, in
> my dual PIII 733 MHz with an rqlen of 4 the scheduler latency ( with that
> std scheduler ) is about 0.9us ( real one, not lat_ctx ). That means the
> the scheduler responsibility in your 17us is about 5%, and the remaining
> 95% is due "external" kernel paths. With an rqlen of 16 ( std scheduler )

No: we've measured. The time in our system, which does not follow any
Linux kernel paths, is dominated by motherboard bus delays.

> the latency peaks up to ~2.4us going to ~14-15% of scheduler responsibility.
> I've coded this simple app :
> 
> http://www.xmailserver.org/linux-patches/lnxsched.html#RtLats
> 
> and i use it with the cpuhog ( hi-tech software that is available inside
> the same link ) to load the run queue. I'm going to plot the measured
> latency versus the runqueue length. Thanks to OSDLAB i'll have an 8 way
> machine to make some test on these big SMPs. I'll code even the simple
> app you're proposing but the real problem is how to load the system. The
> cpuhog load is a runqueue load and is "neutral", that means that is the
> same on all the systems. Loading the system with other kind of loads can
> introduce a device-driver/hw dependency on the measure ( much or less run
> time with irq disabled for example ).

Try
	ping -f  localhost&
	ping -f  onsamelocalnet &
	dd if=/dev/hda1 of=/dev/null &
	make clean; make bzImage;


as a simple start

> 
> 
> 
> 
> 
> - Davide
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
