Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVBRUJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVBRUJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVBRUJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:09:33 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:34472 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261468AbVBRUE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:04:29 -0500
Date: Fri, 18 Feb 2005 21:05:02 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Pavel Machek <pavel@suse.cz>, Oliver Neukum <oliver@neukum.org>,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218200502.GA2556@ucw.cz>
References: <20050213004729.GA3256@stusta.de> <047401c515bb$437b5130$0f01a8c0@max> <20050218132651.GA1813@elf.ucw.cz> <200502181436.01943.oliver@neukum.org> <20050218160153.GC12434@elf.ucw.cz> <20050218170036.GA1672@ucw.cz> <d120d50005021810195f16ac0d@mail.gmail.com> <20050218183936.GA2242@ucw.cz> <d120d5000502181120392a9a0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000502181120392a9a0f@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 02:20:13PM -0500, Dmitry Torokhov wrote:

> > > But input layer shoudl not be used as a generic transport. I mean
> > > battery low, docking requests, etc has nothing to do with input.
> > 
> > Well, plugging in a power cord is a physical user action much like
> > closing the lid is, much like pressing the power button is, much like
> > pressing a key is.
> 
> What about power dying and my UPS switing on? I think it is out of
> input layer,

Yes, I was thinking about this, too. An UPS is pretty much the same
thing to a desktop as a battery is to a notebook. And I also got to the
conclusion that this is a bad idea.

But now that you are talking about this, I think there is some merit to
that way.

UPSes are usually handled by userspace daemons, either through serial
ports or via USB over hiddev (which is another driver that should be
redone from scratch). 

So we may need a way to loop these events through the kernel to make
them available to the power event handling software. uinput would be a
rather straightforward solution here ...

> we need PM/system state messaging layer. It can be based
> on acpi events and acpid or maybe kevents (but I don't like the idea
> of needing kobjects for that).

ACPI is too platform specific. We really need some platform independent
way to be able to have a simple software solution.

> Still power.c seems like the good place to hide all the ugliness and
> glue between that new (or old) layer and input layer.

Yes, it's a reasonable way. But the other way around (passing most power
related events through input) also is quite compelling.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
