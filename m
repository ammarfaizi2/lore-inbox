Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267886AbTB1NhH>; Fri, 28 Feb 2003 08:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267892AbTB1NhH>; Fri, 28 Feb 2003 08:37:07 -0500
Received: from adsl-66-140-130-38.dsl.hstntx.swbell.net ([66.140.130.38]:24055
	"EHLO adsl-66-140-130-116.dsl.hstntx.swbell.net") by vger.kernel.org
	with ESMTP id <S267886AbTB1NhF>; Fri, 28 Feb 2003 08:37:05 -0500
Date: Fri, 28 Feb 2003 07:47:00 -0600
From: Robert Redelmeier <redelm@ev1.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: wyleus <coyote1@cytanet.com.cy>, linux-kernel@vger.kernel.org
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
Message-ID: <20030228134700.GA15589@adsl-66-140-130-38.dsl.hstntx.swbell.net>
References: <20030226041214.71e1ddc7.coyote1@cytanet.com.cy> <200302261151.h1QBp2s23777@Port.imtp.ilyichevsk.odessa.ua> <20030227082312.1a56684b.coyote1@cytanet.com.cy> <200302280645.h1S6ims00404@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302280645.h1S6ims00404@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 08:41:41AM +0200, Denis Vlasenko wrote:
> On 27 February 2003 15:23, wyleus wrote:
> > Thanks for taking the time to reply time, Dennis.  I ran cpuburn as
> > you suggested.  Specifically, I ran the burnK6 binary for about an
> > hour (from an xterm, and I also had other stuff like galeon running
> > simultaneously) and didn't get any hiccups.  Monitoring with top, I
> > saw that I had 0% free cpu during the test.
> >
> > However I also later ran the burnMMX binary, and that one would quit
> > after running a few minutes without printing any error messages to
> > the screen - nor did it leave any messages in /var/log/*.  Dunno if
> > that's normal?  Shouldn't it keep running until I kill it?

No, it's not normal.  `burnMMX` should keep running.  If it quits,
an `echo $?` will get  the return code.  burnMMX is as more than
an MMX math tester, it also uses MMX to test the RAM controller
and busses.  It is specifically designed to induce crosstalk and
catch slow state transitions.

What has happened is that burnMMX has provoked a memory error
and quit.  This is not surprising.  Many K6s were not capable of
100 MHz bus operation, and even more motherboards could not run at
100 stably.  Not to mention the slews of expensive sub-spec RAM
of the era and small AT power supplies.

You have bad hardware.  You must expect trouble.  Linux runs hardware
pretty hard.  Correctness then Performance appears to be Linus'
philosophy. If you are lucky, you can down-clock your bus.  If you
are _very_ lucky, a kernel without any K6 optimizations [compiled for
a 386] in the `bzero` and `bcopy` routines might reduce your error
frequency.  But if X detects and uses K6 routines, you're hosed.

-- Robert  author `cpuburn`  http://users.ev1.net/~redelm

