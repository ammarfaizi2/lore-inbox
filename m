Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVCaS1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVCaS1I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 13:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVCaS1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 13:27:07 -0500
Received: from digitalimplant.org ([64.62.235.95]:54926 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261685AbVCaS0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 13:26:50 -0500
Date: Thu, 31 Mar 2005 10:26:36 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: David Brownell <david-b@pacbell.net>
cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <200503311018.02135.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.50.0503311021040.7249-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503311054410.1510-100000@ida.rowland.org>
 <Pine.LNX.4.50.0503310947180.7249-100000@monsoon.he.net>
 <200503311018.02135.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Mar 2005, David Brownell wrote:

> On Thursday 31 March 2005 9:59 am, Patrick Mochel wrote:
> > On Thu, 31 Mar 2005, Alan Stern wrote:
> > > On Wed, 30 Mar 2005, Patrick Mochel wrote:
> >
> > > > In fact, we probably want to add a counter to every device for all "open
> > > > connections" so the device doesn't try to automatically sleep while a
> > > > device node is open. Once it reaches 0, we can have it enter a
> > > > pre-configured state, which should save us a bit of power for very little
> > > > pain.
> > >
> > > By "open connections", do you mean something more than unsuspended
> > > children?
> >
> > Yes, I mean anything that requires the device be awake and functional.
>
> So for example a device that's suspended and enabled for wakeup could be
> "open" ... which fights against your "doesn't try to sleep" policy.

I don't understand what you mean. Even if a device is suspended, be it
automatically after some amount of inactivity or as directed explicitly by
a user, we want to be able to open the device and have it work.

Conversely, we only want to automatically suspend the device, or allow the
device to be explicitly put to sleep, if the device is not being used.

For the majority of devices, that seems like a basic, simple, intuitive
rule. I'm sure there will be exceptions (there always are), but I expect
those to be rare and subsystem (if not platform) specific.

> > This would include open device nodes for many devices, open network
> > connections for network devices, active children for bridges and
> > controllers, etc.
>
> Same thing applies.  Many devices can be suspended but wake up on demand.
> And even pass the wakeup events up the hardware connectivity tree.  In
> fact, being able to do that is a requirement to support that "USB mouse
> on Centrino laptop" example:  USB mouse suspended, ditto the USB host
> controller, then the CPU can enter C3 state and save a few more Watts.
> Move mouse, wakeup the USB controller, CPU leaves C3.
>
> In general, good power management will _want_ to leverage such modes.
>
> Worth noting:  it's very similar to what modern CPUs do internally,
> powering parts off until they're needed.  The same model can apply
> to other chips; and to boards that integrate those chips...

I agree.


	Pat
