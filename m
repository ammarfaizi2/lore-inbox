Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031233AbWI0XNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031233AbWI0XNS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031234AbWI0XNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:13:18 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:45710 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1031233AbWI0XNQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:13:16 -0400
Subject: Re: [RFC] exponential update_wall_time
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609280031550.6761@scrub.home>
References: <1159385734.29040.9.camel@localhost>
	 <Pine.LNX.4.64.0609280031550.6761@scrub.home>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 16:13:12 -0700
Message-Id: <1159398793.7297.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-28 at 01:04 +0200, Roman Zippel wrote:
> On Wed, 27 Sep 2006, john stultz wrote:
> 
> > Accumulate time in update_wall_time exponentially. 
> > This avoids long running loops seen with the dynticks patch
> > as well as the problematic hang" seen on systems with broken 
> > clocksources.
> 
> This is the wrong approach, second_overflow() should be called every HZ
> increment steps and your patch breaks this.

First, forgive me, since I've got a bit of a head cold, so I'm even
slower then usual. I just don't see how this patch changes the behavior.
Every second we will call second_overflow. But in the case where we
skipped 100 ticks, we don't loop 100 times. Could you explain this a bit
more?


> There are other approaches oo accommodate dyntick. 
> 1. You could make HZ in ntp_update_frequency() dynamic and thus reduce the 
> frequency with which update_wall_time() needs to be called (Note that 
> other clock variables like cycle_interval have to be adjusted as well). 

I'm not sure how this is functionally different from what this patch
does.


> 2. If dynticks stops the timer interrupt for a long time, it could 
> precalculate a few things, e.g. it could complete the second and then 
> advance the time in full seconds.

Not following this one at all.

Again, sorry for being so thick.
-john


