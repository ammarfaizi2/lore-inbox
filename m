Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTKDXq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 18:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTKDXq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 18:46:57 -0500
Received: from smtp-4.hut.fi ([130.233.228.94]:2465 "EHLO smtp-4.hut.fi")
	by vger.kernel.org with ESMTP id S262092AbTKDXqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 18:46:55 -0500
Date: Wed, 5 Nov 2003 01:46:40 +0200
From: Pasi Savolainen <pasi.savolainen@hut.fi>
To: Tony Lindgren <tony@atomide.com>
Cc: Charles Lepple <clepple@ghz.cc>, lkml <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 cleanup
Message-ID: <20031104234640.GC408936@kosh.hut.fi>
References: <20031104200517.GD1042@atomide.com> <9F0055D6-0F17-11D8-A943-003065DC6B50@ghz.cc> <20031104231157.GI1042@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031104231157.GI1042@atomide.com>
User-Agent: Mutt/1.4i
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (smtp-4.hut.fi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [031105 01:12]:
> * Charles Lepple <clepple@ghz.cc> [031104 14:40]:
> > On Tuesday, November 4, 2003, at 03:05 PM, Tony Lindgren wrote:
> > 
> > >* Charles Lepple <clepple@ghz.cc> [031104 11:45]:
> > >>On Tuesday 04 November 2003 02:15 pm, Tony Lindgren wrote:
> > >>>I've heard of timing problems if it's compiled in, but supposedly 
> > >>>they
> > >>>don't happen when loaded as module.

> > >>I did, however, manage to keep ntpd happy by reducing HZ to 100. Even 
> > >>raising
> > >>HZ to 200 is enough to throw off its PLL. The machine is idle for 90% 
> > >>of the
> > >>day, though, so I don't know if the PLL is adapting to the fact that 
> > >>the
> > >>system is idling, but the values for tick look reasonable.
> > >
> > >Interesting, sounds like the idling causes missed timer interrupts? 
> > >Can you
> > >briefly describe what's the easiest way to reproduce the timer 
> > >problem, just
> > >change HZ to 200 and look at the system time?

AFAIK the problem was that TSC's got desynchronized and the
gettimeofday didn't produce monotonic dates at that.

You could make problem go away either by setting HZ=100 or compiling
without TSC support. (kerneloption notsc didn't have the effect).

> > Weird. On -test9-bk at HZ=1000, with amd76x_pm loaded as a module 
> > (lazy_idle=800, the default), the system clock is running fast.

I'm making mrtg graphs of
/sys/devices/pci0000\:00/0000\:00\:00.0/C2_cnt , and it looks like
-test9 is calling it at a rate of 1100Hz, compared to ~1000Hz on
previous (HZ=1000) kernels.
Of course these numbers are not under mutex and increased by both
processors.

With ntpd I'm getting following:
Nov  5 00:26:32 tienel ntpd[501]: time reset -7.151071 s
Nov  5 00:26:32 tienel ntpd[501]: synchronisation lost
Nov  5 00:41:35 tienel ntpd[501]: time reset -7.150284 s
Nov  5 00:41:35 tienel ntpd[501]: synchronisation lost

So drift is about 10min / 24h (unless I botched the math, it seems to
happen after a dose of modula-3)


-- 
Psi -- <http://www.iki.fi/pasi.savolainen>
