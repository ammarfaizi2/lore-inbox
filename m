Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbVKSHpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbVKSHpR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 02:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbVKSHpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 02:45:17 -0500
Received: from styx.suse.cz ([82.119.242.94]:23997 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750945AbVKSHpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 02:45:15 -0500
Date: Sat, 19 Nov 2005 08:45:03 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: George Anzinger <george@mvista.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: 2.6.14-rt13
Message-ID: <20051119074503.GA12551@midnight.suse.cz>
References: <20051115090827.GA20411@elte.hu> <1132336954.20672.11.camel@cmn3.stanford.edu> <1132350882.6874.23.camel@mindpipe> <1132351533.4735.37.camel@cmn3.stanford.edu> <1132351984.6874.29.camel@mindpipe> <20051118223233.GA7794@midnight.suse.cz> <437E8DC8.4070101@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437E8DC8.4070101@mvista.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 06:28:24PM -0800, George Anzinger wrote:

> >There are many mechanisms to keep time:
> >
> >1) RTC: 0.5 sec resolution, interrupts
> >2) PIT: takes ages to read, overflows at each timer interrupt
> >3) PMTMR: takes ages to read, overflows in approx 4 seconds, no interrupt
> 
> The PMTMR can be read from user space (if you can find it).  See the 
> "iopl" man page.  It is an I/O access and so is slow, but you can read 
> it.

Yes, however this must be limited to a small number of privileged
applications - iopl() is only available to CAP_SYS_RAWIO IIRC,
and thus it's not suitable for general use.

> Finding it is another matter.  It does not have a fixed address (i.e. 
> it differs from machine to machine, but is constant on any given 
> machine).  The boot code roots it out of an info block put in memory 
> by the BIOS.  I suppose one could put a printk in the boot code to 
> disclose it...

There is really no reason to do that, since the time to read it (~1200
ns) is much less than the time to enter the kernel (less than 200 ns),
so gettimeofday() is definitely easier to use and also doesn't overflow.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
