Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932787AbVLIARv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbVLIARv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 19:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932772AbVLIARu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 19:17:50 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:6082 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S932787AbVLIARt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 19:17:49 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200512090019.jB90JSZ5030763@auster.physics.adelaide.edu.au>
Subject: Re: 2.6.14-rt21: slow-running clock
To: johnstul@us.ibm.com (john stultz)
Date: Fri, 9 Dec 2005 10:49:27 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org
In-Reply-To: <1134012141.10613.81.camel@cog.beaverton.ibm.com> from "john stultz" at Dec 07, 2005 07:22:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John

> > > > I'm also wondering whether this might be related to one other thing I
> > > > noticed a week or so back (also reported to the list, but thus far no
> > > > followups). If I enabled the (new) "High resolution timers" feature (as
> > > > distinct from HPET), things like /usr/bin/sleep run for far longer than
> > > > they should irrespective of machine load.  For example, "sleep 1" from bash
> > > > actually delays 38 seconds, not 1 second as expected.
> > > 
> > > Does disabling the "High resolution timers" feature change the behavior
> > > all?
> > 
> > I should clarify.  Everything I've given you thus far has been with the
> > "high resolution timers" feature disabled.  Two or so weeks ago I tried
> > enabling it and that's when "sleep 1" took 38 seconds to complete. 
> > Disabling "high resoltion timers" at least made "sleep 1" behave somewhat
> > saner.  I don't know if having the high res timers enabled affects the
> > accuracy of the system clock however.  I'll test this tonight.

Some further information.  Today I enabled the Hi res timer option in
2.6.14-rt21 with a resolution of 10000ns and did a full recompile.  Under
this kernel "sleep 1" did the right thing.  The slowdown in the c3tsc
clocksource and its selection ahead of more capable timers was still the
same in this kernel - in other words, enabling the hi res timer does not
change things.

I then changed the resolution to 1000ns (the default) and recompiled.  This
is the setting I used previously, but this time around "sleep 1" behaved
itself (c3tsc still ran slow though).  Thus for the moment it seems that the
sleep misbehaviour may have been due to some transient problem with the
configure system.  I'll test again once we've sorted out the c3tsc thing,
but it seems possible at this stage that the long "sleep" thing is not a bug
as such.

Regards
  jonathan
