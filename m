Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbTJ3Xr7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 18:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTJ3Xr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 18:47:59 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:55535 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262898AbTJ3Xr5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 18:47:57 -0500
Message-ID: <3FA1A327.2000606@mvista.com>
Date: Thu, 30 Oct 2003 15:47:51 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peter@chubb.wattle.id.au>
CC: root@chaos.analogic.com, Stephen Hemminger <shemminger@osdl.org>,
       Gabriel Paubert <paubert@iram.es>, john stultz <johnstul@us.ibm.com>,
       Joe Korty <joe.korty@ccur.com>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: gettimeofday resolution seriously degraded in test9
References: <20031027234447.GA7417@rudolph.ccur.com>	<1067300966.1118.378.camel@cog.beaverton.ibm.com>	<20031027171738.1f962565.shemminger@osdl.org>	<20031028115558.GA20482@iram.es>	<20031028102120.01987aa4.shemminger@osdl.org>	<20031029100745.GA6674@iram.es>	<20031029113850.047282c4.shemminger@osdl.org>	<16288.17470.778408.883304@wombat.chubb.wattle.id.au>	<3FA1838C.3060909@mvista.com>	<Pine.LNX.4.53.0310301645170.16005@chaos> <16289.39801.239846.9369@wombat.chubb.wattle.id.au>
In-Reply-To: <16289.39801.239846.9369@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:
>>>>>>"Richard" == Richard B Johnson <root@chaos.analogic.com> writes:
> 
> 
> Richard> There isn't any magic that can solve this problem. It turns
> Richard> out that with later Intel CPUs, one can get CPU-clock
> Richard> resolution from rdtsc. However, this is hardware-specific. If
> Richard> somebody modifies the gettimeofday() and the POSIX clock
> Richard> routines to use rdtsc when available, a lot of problems will
> Richard> go away.
> 
> gettimofday() and the posix clock routines (which use gettimeofday())
> *do* use rdtsc if the processor has a reliable one --- do_gettimeofday() calls
> cur_timer->get_offset(), which is essentially a scaled rdtsc if you're
> using timers_tsc.c.
> 
> But when you have power management turned on, TSC doesn't run at a
> constant rate.   If it gets *too* slow, the timer switches to use the
> PIT instead, and one loses the cycle-resolution one would otherwise have.
> 
IF (and that is a big IF) the cpu knows about the change, there is code in 2.6 
to change the scaling of the TSC to match what the hardware is doing.

If you really want stability on the x86 grab the HRT patch (see sig below) and 
set it up to use the pm-timer.  This is rock solid, but does add time to the 
gettimeofday() and friends as it requires an I/O cycle to read it.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

