Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264168AbUEDQvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264168AbUEDQvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 12:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264514AbUEDQvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 12:51:41 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:43687 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S264168AbUEDQvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 12:51:03 -0400
Date: Tue, 4 May 2004 18:50:22 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: john stultz <johnstul@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, george@mvista.com,
       kaukasoi@elektroni.ee.tut.fi, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
In-Reply-To: <1083682764.4324.33.camel@leatherman>
Message-ID: <Pine.LNX.4.53.0405041837210.7101@gockel.physik3.uni-rostock.de>
References: <403D0F63.3050101@mvista.com>  <1077760348.2857.129.camel@cog.beaverton.ibm.com>
  <403E7BEE.9040203@mvista.com>  <1077837016.2857.171.camel@cog.beaverton.ibm.com>
  <403E8D5B.9040707@mvista.com>  <1081895880.4705.57.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.53.0404141353450.21779@gockel.physik3.uni-rostock.de> 
 <1081967295.4705.96.camel@cog.beaverton.ibm.com>  <20040415103711.GA320@elektroni.ee.tut.fi>
  <Pine.LNX.4.53.0404151302140.28278@gockel.physik3.uni-rostock.de> 
 <20040415161436.GA21613@elektroni.ee.tut.fi> 
 <Pine.LNX.4.53.0405011540390.25435@gockel.physik3.uni-rostock.de> 
 <20040501184105.2cd1c784.akpm@osdl.org>  <Pine.LNX.4.53.0405020352480.26994@gockel.physik3.uni-rostock.de>
  <1083638458.9664.134.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.53.0405040804180.2215@gockel.physik3.uni-rostock.de>
 <1083682764.4324.33.camel@leatherman>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2004, john stultz wrote:

> On Mon, 2004-05-03 at 23:12, Tim Schmielau wrote:
> > 
> > I wonder whether it's conceptually correct to use jiffies for accurate 
> > long-time measurements at all. ntpd is there for a reason. Using both
> > corrected, accurate and freely running clocks IMHO is calling for trouble. 
> > This might be something to think about for 2.7.
> 
> Indeed. Moving away from jiffies as a time counter and more of an
> interrupt counter is important. That allows for implementations of
> variable HZ and other things the high-res timer folks want without
> affecting the time keeping code. 
> 
> Roughly, I'd like to see the time code for all arches in 2.7 to look
> like:

[simple, well thought-out proposal snipped]

> time_interrupt_hook(): 
>         updates system_time.


> Of course, with this approach, we actually have to be able to trust the
> hardware 100%. With the current state of i386 hw having serious problems
> w/ reliable timesources, this may be difficult. 

Well, with some configurable plausibility checks in time_interrupt_hook()
it shouldn't be worse than what we have now...

> I've got a bigger proposal (with proper credits to Keith Mannthey and
> George Anzinger for reviews and corrections) that I wrote up awhile
> back, and I'll likely send it out if this sketch gathers any interest.  

Yes, that sounds interesting. It's just that I won't have any spare time 
to spend in the next two weeks.

Tim
