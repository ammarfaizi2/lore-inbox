Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVBRUjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVBRUjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVBRUjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:39:52 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:21194 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261482AbVBRUjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:39:45 -0500
Date: Fri, 18 Feb 2005 21:40:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: dtor_core@ameritech.net, Oliver Neukum <oliver@neukum.org>,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218204018.GA2760@ucw.cz>
References: <047401c515bb$437b5130$0f01a8c0@max> <20050218132651.GA1813@elf.ucw.cz> <200502181436.01943.oliver@neukum.org> <20050218160153.GC12434@elf.ucw.cz> <20050218170036.GA1672@ucw.cz> <d120d50005021810195f16ac0d@mail.gmail.com> <20050218183936.GA2242@ucw.cz> <d120d5000502181120392a9a0f@mail.gmail.com> <20050218200502.GA2556@ucw.cz> <20050218202443.GB1403@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218202443.GB1403@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 09:24:43PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > > But input layer shoudl not be used as a generic transport. I mean
> > > > > battery low, docking requests, etc has nothing to do with input.
> > > > 
> > > > Well, plugging in a power cord is a physical user action much like
> > > > closing the lid is, much like pressing the power button is, much like
> > > > pressing a key is.
> > > 
> > > What about power dying and my UPS switing on? I think it is out of
> > > input layer,
> > 
> > Yes, I was thinking about this, too. An UPS is pretty much the same
> > thing to a desktop as a battery is to a notebook. And I also got to the
> > conclusion that this is a bad idea.
> 
> Well, I'm not sure if input layer is suitable for batteries... Modern
> battery has quite a lot of parameters. It can tell you current
> voltage, current capacity (either mAh or mWh), design capacity, last
> capacity at full charge, current current, battery's estimate of run
> time (which may be better than system's estimate), ... But some
> batteries only know percentage of energy left, and some batteries only
> know current voltage (you can estimate %left from that). I'm not sure
> if input system can handle all that complexity...

I wouldn't want to pass all the battery info (UPSes can be even more
complex, able to switch on/off individual sockets, etc) through input,
just the basic events:

	AC power on/off
	battery full/normal/low/critical/(fail)

Then the other power-related events

	Lid open/closed
	Power button
	Sleep button

I think that's all you need to trigger actions. You don't need the exact
percentage of the battery, and you don't need the exact AC voltage at
input. 

Nice graphics battery monitors in X can gather their information from
the platform specific sources, since they'll need it all in the greatest
detail.

PS.

full = not charging
normal = OK state, charging if AC
low = better shutdown if you don't want to stress the battery
      (namely LiIon batteries prefer not to be discharged too much)
critical = last chance to shutdown cleanly
fail = battery present, but doesn't work.

A server, while booting should wait for battery going at least to 'low'
before mounting system read/write, otherwise subsequent power failures
might cause damage.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
