Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264642AbSIQV5W>; Tue, 17 Sep 2002 17:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264651AbSIQV5W>; Tue, 17 Sep 2002 17:57:22 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:59332 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264642AbSIQV5U> convert rfc822-to-8bit; Tue, 17 Sep 2002 17:57:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
Date: Tue, 17 Sep 2002 15:02:04 -0700
User-Agent: KMail/1.4.1
Cc: ak@suse.de, linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       anton.wilson@camotion.com
References: <p73vg54tjpl.fsf@oldwotan.suse.de> <1032298092.20498.21.camel@irongate.swansea.linux.org.uk> <20020917.141806.49377410.davem@redhat.com>
In-Reply-To: <20020917.141806.49377410.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209171502.04524.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 September 2002 02:18 pm, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 17 Sep 2002 22:28:12 +0100
>
>    A bus clock - but things like the x440 have more than one bus clock. Its
>    NUMA. Also the bus clock and rdtsc clock are different - rdtsc is
>    dependant on the multiplier. Shove a celeron 300 and a celeron 450 in a
>    BP6 board with tsc on and enjoy
>
> That's mostly my point.
>
> If the bus clocks differ, then great create some system wide crystal
> oscillator.  That's a detail, the important bit is that you don't need
> to go out to the system bus to read the tick value, it must be cpu
> local to be effective and without serious performance impact.
> -

It's more than just a detail.  Sequent's last NUMA system (_not_ the NUMA-Q;  
never released) did exactly what you suggest.  The midplane card generated 
the bus clock for all quad modules.  We had requested this feature because it 
was such a pain dealing with clock drift between nodes in the OS.

The HW guys were able to give us synchronized bus clocks on a 16-way box, but 
warned us that it would not be practical on the 256-way.  Too much clock skew 
at those speeds, or something like that.  I suppose you could trade off 
interconnect rate for clock sync, but then performance would suffer.

I don't know how Sun and SGI manage with their larger systems.  Either they 
don't do clock sync, or they may have to make expensive tradeoffs.

Interestingly, Intel's IA64 manual does not guarantee that the CPU clock (and 
thus its TSC register) has anything to do with the bus clock rate.  Maybe 
they want to dabble with asynchronous logic or multiple clock domains in 
future CPUs.

Trivia:  NUMA-Q systems running Dynix/PTX can contain quads running at very 
different CPU speeds.  This made locating some race conditions quite easy.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

