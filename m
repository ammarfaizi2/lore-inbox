Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVKMHce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVKMHce (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 02:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVKMHce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 02:32:34 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:53446 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932133AbVKMHce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 02:32:34 -0500
Date: Sun, 13 Nov 2005 08:32:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
Message-ID: <20051113073228.GA31468@elte.hu>
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com> <p73lkzt49wr.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73lkzt49wr.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> At least on x86-64 there is currently so much other timer related 
> development going on (per CPU TSC timers, no idle tick, 64bit HPET 
> etc.)  that I don't want any x86-64 bits of that merged for the next 
> time. The other stuff needs to settle first.
> 
> I haven't read the patchset in full detail, but from a quick look it's 
> also not obvious too me in which way it is easier and cleaner than the 
> old setup. While the old code was quirky in parts the new one seems to 
> fall more in the overmodularization/too many indirect callbacks trap.

there are 3 "generic" components needed right now to clean up all time 
related stuff: GTOD, ktimers and clockevents. [you know the first two, 
and clockevents is new code from Thomas Gleixner that generalizes timer 
interrupts and introduces one compact notion for 'clock chips'.]

what is the point? Ontop of these, a previously difficult feature, High 
Resolution Timers became _massively_ simpler. All of these patches exist 
together in the -rt tree, so it's not handwaving. The same will be the 
case for idle ticks / dynamic ticks [we started with HRT because it is 
so much harder than idle ticks]. So i do agree with you that GTOD needs 
more work, but it also makes time related features all that much easier.

right now it's GTOD that needs the most work before it can be merged 
upstream, so you picked the right one to criticise :-)

	Ingo
