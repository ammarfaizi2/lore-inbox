Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVBRSjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVBRSjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 13:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVBRSjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 13:39:31 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:30090 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261436AbVBRSjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 13:39:06 -0500
Date: Fri, 18 Feb 2005 19:39:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Pavel Machek <pavel@suse.cz>, Oliver Neukum <oliver@neukum.org>,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218183936.GA2242@ucw.cz>
References: <20050213004729.GA3256@stusta.de> <047401c515bb$437b5130$0f01a8c0@max> <20050218132651.GA1813@elf.ucw.cz> <200502181436.01943.oliver@neukum.org> <20050218160153.GC12434@elf.ucw.cz> <20050218170036.GA1672@ucw.cz> <d120d50005021810195f16ac0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005021810195f16ac0d@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 01:19:08PM -0500, Dmitry Torokhov wrote:
> On Fri, 18 Feb 2005 18:00:36 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Fri, Feb 18, 2005 at 05:01:53PM +0100, Pavel Machek wrote:
> > 
> > > > > It has quite a lot of #ifdefs for CONFIG_APM/CONFIG_ARM/CONFIG_ACPI,
> > > > > and it will not work on i386/APM, anyway. I still believe right
> > > > > solution is to add input interface to ACPI. /proc/acpi/events needs to
> > > > > die, being replaced by input subsystem.
> > > >
> > > > But aren't there power events (battery low, etc) which are not
> > > > input events?
> > >
> > > Yes, there are. They can probably stay... Or we can get "battery low"
> > > key.
> > 
> > We even have an event class for that, EV_PWR in the input subsystem.
> 
> I really really think this is wrong. Power management should be
> possible without input layer. EV_PWR is fine for telling input devices
> to do something, like enter lower power mode

Definitely not for this. The request to go to low power mode should come
from the other side - the bus the device lives on.

> and for sending _some_ requests to the PM system.

I don't think input devices themselves should be sending any requests to
the PM system at all, they should just pass the events to the userspace
and have that decide what to do with it.

Maybe a simple event handler like power.c for transforming key events to
power change requests for embedded systems makes sense, but normally
many more variables need to be taken into account, and thus userspace
needs to decide.

> But input layer shoudl not be used as a generic transport. I mean
> battery low, docking requests, etc has nothing to do with input.
 
Well, plugging in a power cord is a physical user action much like
closing the lid is, much like pressing the power button is, much like
pressing a key is.

I definitely wouldn't want to see input to be a generic trasport layer -
it is not. But I wouldn't be opposed to pass some of the user induced
events through it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
