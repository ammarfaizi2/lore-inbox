Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVLICLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVLICLZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 21:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVLICLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 21:11:25 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:12227 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751118AbVLICLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 21:11:24 -0500
Subject: Re: 2.6.14-rt21: slow-running clock
From: john stultz <johnstul@us.ibm.com>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512090019.jB90JSZ5030763@auster.physics.adelaide.edu.au>
References: <200512090019.jB90JSZ5030763@auster.physics.adelaide.edu.au>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 18:11:20 -0800
Message-Id: <1134094281.27601.11.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 10:49 +1030, Jonathan Woithe wrote:
> John
> 
> > > > > I'm also wondering whether this might be related to one other thing I
> > > > > noticed a week or so back (also reported to the list, but thus far no
> > > > > followups). If I enabled the (new) "High resolution timers" feature (as
> > > > > distinct from HPET), things like /usr/bin/sleep run for far longer than
> > > > > they should irrespective of machine load.  For example, "sleep 1" from bash
> > > > > actually delays 38 seconds, not 1 second as expected.
> > > > 
> > > > Does disabling the "High resolution timers" feature change the behavior
> > > > all?
> > > 
> > > I should clarify.  Everything I've given you thus far has been with the
> > > "high resolution timers" feature disabled.  Two or so weeks ago I tried
> > > enabling it and that's when "sleep 1" took 38 seconds to complete. 
> > > Disabling "high resoltion timers" at least made "sleep 1" behave somewhat
> > > saner.  I don't know if having the high res timers enabled affects the
> > > accuracy of the system clock however.  I'll test this tonight.
> 
> Some further information.  Today I enabled the Hi res timer option in
> 2.6.14-rt21 with a resolution of 10000ns and did a full recompile.  Under
> this kernel "sleep 1" did the right thing.  The slowdown in the c3tsc
> clocksource and its selection ahead of more capable timers was still the
> same in this kernel - in other words, enabling the hi res timer does not
> change things.
> 
> I then changed the resolution to 1000ns (the default) and recompiled.  This
> is the setting I used previously, but this time around "sleep 1" behaved
> itself (c3tsc still ran slow though).  Thus for the moment it seems that the
> sleep misbehaviour may have been due to some transient problem with the
> configure system.  I'll test again once we've sorted out the c3tsc thing,
> but it seems possible at this stage that the long "sleep" thing is not a bug
> as such.

Ok, I went digging further and found the c3tsc selection is correct on
your hardware. I'm just too used to my own laptop where the TSC varies
with cpu speed and we lower the rating value. So that should be ok.

I'm now working on why we mis-compensate the c3tsc clocksource in the
-RT tree. 

As for the "sleep 1" bit, I'm not sure yet. This behavior does not
change with the clocksources does it?

thanks
-john

