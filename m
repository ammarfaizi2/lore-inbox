Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVKMLJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVKMLJd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 06:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVKMLJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 06:09:32 -0500
Received: from mx1.suse.de ([195.135.220.2]:13280 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932465AbVKMLJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 06:09:32 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
Date: Sun, 13 Nov 2005 11:53:24 +0100
User-Agent: KMail/1.8.2
Cc: john stultz <johnstul@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com> <p73lkzt49wr.fsf@verdi.suse.de> <20051113073228.GA31468@elte.hu>
In-Reply-To: <20051113073228.GA31468@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511131153.25978.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 November 2005 08:32, Ingo Molnar wrote:

> there are 3 "generic" components needed right now to clean up all time 
> related stuff: GTOD, ktimers and clockevents. [you know the first two, 
> and clockevents is new code from Thomas Gleixner that generalizes timer 
> interrupts and introduces one compact notion for 'clock chips'.]

Both noidletick and the per cpu gettimeofday change significantly
how timer interrupts work. I hope your generalizations will be still
compatible to that. It's a bit dangerous to generalize
before things have their final shape. 

Also vsyscalls make it all more difficult, because they don't map
very well to any kind of "timer drivers". 
 
> what is the point? Ontop of these, a previously difficult feature, High 
> Resolution Timers became _massively_ simpler. All of these patches exist 
> together in the -rt tree, so it's not handwaving. The same will be the 
> case for idle ticks / dynamic ticks [we started with HRT because it is 
> so much harder than idle ticks]. So i do agree with you that GTOD needs 
> more work, but it also makes time related features all that much easier.
> 
> right now it's GTOD that needs the most work before it can be merged 
> upstream, so you picked the right one to criticise :-)

My point was basically that there is a lot of feature work going on
on x86-64 in this area, and that has priority over  any "cleanups" like this 
from my side. If it has settled again later maybe it can be generalized,
or maybe not. I will only do it if it truly makes the code cleaner in the end,
just lots of indirect pointers by itself isn't necessarily something
that does this.

-Andi
