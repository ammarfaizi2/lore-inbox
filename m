Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268447AbUHQVBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268447AbUHQVBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 17:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268439AbUHQVAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 17:00:46 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:56802 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268438AbUHQU7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:59:36 -0400
Subject: Re: boot time, process start time, and NOW time
From: john stultz <johnstul@us.ibm.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Andrew Morton OSDL <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       tim@physik3.uni-rostock.de, george anzinger <george@mvista.com>,
       david+powerix@blue-labs.org
In-Reply-To: <1092764462.5761.1553.camel@cube>
References: <1087948634.9831.1154.camel@cube>
	 <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>  <1092698648.2301.1250.camel@cube>
	 <1092769231.2429.115.camel@cog.beaverton.ibm.com>
	 <1092764462.5761.1553.camel@cube>
Content-Type: text/plain
Message-Id: <1092776323.2429.223.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 17 Aug 2004 13:58:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 10:41, Albert Cahalan wrote:
> On Tue, 2004-08-17 at 15:00, john stultz wrote:
> > What about 1001? That looks reasonably accurate.
> 
> Sure. (it's 10x worse, but the crystals aren't good
> enough to tell the difference) Supposing that a
> choice near 1000 HZ is good, here are some more:
> 
> wrongness_%   HZ_diff   PIT_#   HZ     actual_HZ   
> -0.00217900  -0.021703   1198   996   995.978297
> -0.00083809  -0.008389   1192  1001  1000.991611
> -0.00050285  -0.006376    941  1268  1267.993624
> +0.00050286  +0.005396   1112  1073  1073.005396
> +0.00150859  +0.014950   1204   991   991.014950
> 
> I think it's better to drop down a bit, because people
> have also been suffering problems with lost ticks.
> The BIOS can grab the CPU for too long.

Well, the move to HZ=1000 from HZ=100 was wanted to improve latency
requirements, so I don't know if folks would go for something like
HZ=519. The lost tick issue is a problem, but the real solution there is
to move the time subsystem away from depending on timer interrupts to
keep accurate time. See the proposal I just sent out for more details.
That way timer interrupts just become scheduler preemption points and
lost ticks become just an issue for folks with latency requirements. 

> I'd really rather just run everything off the RTC or HPET,
> with an arbitrary rate interrupt source, and just call into
> the regular jiffies handling code as needed to catch up.
> This would allow steering the jiffies tick to an exact
> integer HZ. High-precision timers could be fired off of
> the RTC or HPET interrupt if that is running faster.

Indeed, having alternate or multiple timer interrupt sources would be
nice. Hopefully once the time of day subsystem is untangled from the
timer subsystem, using alternate interrupt sources will be much easier
(and cleaner!). 

thanks
-john


