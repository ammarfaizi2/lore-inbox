Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVLFKuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVLFKuu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 05:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbVLFKuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 05:50:50 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:52609 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751485AbVLFKut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 05:50:49 -0500
Date: Tue, 6 Dec 2005 11:50:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/13] Time: Reduced NTP Rework (part 2)
Message-ID: <20051206105054.GA29002@elte.hu>
References: <4390E48E.4020005@mvista.com> <4395475C.21877.29399CFE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <20051206072708.GA25129@elte.hu> <Pine.LNX.4.61.0512061130410.1609@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512061130410.1609@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> On Tue, 6 Dec 2005, Ingo Molnar wrote:
> 
> > > > I'm thinking about moving the leap second handling to a timer, with the 
> > > > new timer system it would be easy to set a timer for e.g. 23:59.59 and 
> > > > then set the time. This way it would be gone from the common path and it 
> > > > wouldn't matter that much anymore whether it's used or not.
> > > 
> > > Will the timer solution guarantee consistent and exact updates?
> > 
> > it would still be dependent on system-load situations.
> 
> Interrupt-load, actually.

yeah. To a smaller degree it would be dependent on generic system-load 
too. E.g. if some code keeps interrupts disabled for too long. But the 
main delay potential is from other interrupts, or from having too many 
timers to process.

> > It's an 
> > interesting idea to use a timer for that, but there is no strict 
> > synchronization between "get time of day" and "timer execution", so any 
> > timer-based leap-second handling would be fundamentally asynchronous. I 
> > dont think we want that, leap second handling should be a synchronous 
> > property of 'time'.
> 
> I'm not really sure what you're talking about. [...]

doh, it was too early in the morning. Of course xtime is driven by 
interrupts just as much, so time updates are already 'asynchronous' and 
subject to interrupt delays. So your idea is perfectly fine.

	Ingo
