Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUCIG6u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 01:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUCIG6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 01:58:50 -0500
Received: from fmr99.intel.com ([192.55.52.32]:10953 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S261479AbUCIG6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 01:58:48 -0500
Subject: Re: fsb of older cpu
From: Len Brown <len.brown@intel.com>
To: Bjoern Schmidt <lucky21@uni-paderborn.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F47CB@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F47CB@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1078815523.2342.535.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 Mar 2004 01:58:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C-states should be called Idle-states -- they're entered when the
processor is idle.  No instructions are executed when in a C-state > 0.

C1 is supported by all processors automatically with some carefully
placed insructions inside the idle loop.  Not all processors suport
higher C-states with more power savings in idle.  You'll be able to tell
what is supported and what is used by looking in /proc/acpi/CPU0/power. 
I'm not sure we update the counter to reflect entering C1...

Then there are P-states -- performance states.  These are used by the
various cpufreq drivers such as speed-step(tm;-).  These can modulate
both voltage and Mhz at the same time depending on load and are thus the
most effective and most desireable way to save cpu power w/ minimal
performance impact.

Thermal throttling is  something else.  This is invoked as the
passive-colling method of last resort when the processor is very hot
(busy).  The actual clock to the processor is modulated so that it slows
down and thus power is saved in proportion to how much it is slowed
down.  Throttling will noticeably slow down your system when you want it
fast the most -- heavy load.

Of course, then there is active cooling -- fan control...

cheers,
-Len

On Mon, 2004-03-08 at 16:53, Bjoern Schmidt wrote:
> Stefan Smietanowski schrieb:
> > I'm no expert on the subject but as I recall the processor sets the
> > internal clock (derived from fsb+multiplier) on startup so no matter
> > what you do do the running cpu it won't change it.
> 
> I think there must be a way. In the BIOS there ist an option "half
> processor
> clock it is in idle". One time i have seen in /proc/cpuinfo" that the
> clock
> was at ~118MHz, but that is 6 Month ago and i have this never seen
> again...
> The problem is that with activated acpi the passive cooling does not
> seem to 
> work although the cpu is very often in C2 and throttling mode is at 8.
> C1 is 
> called extrem rarely (~1000 times per day), even if the system is
> under heavy
> load for a long time. I believe that C2 is not really supported by the
> cpu.
> 
> -- 
> Greetings
> Bjoern Schmidt
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

