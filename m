Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVCaSSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVCaSSU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 13:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVCaSSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 13:18:20 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:12965 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261611AbVCaSSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 13:18:04 -0500
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
To: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: klists and struct device semaphores
Date: Thu, 31 Mar 2005 10:18:01 -0800
User-Agent: KMail/1.7.1
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0503311054410.1510-100000@ida.rowland.org> <Pine.LNX.4.50.0503310947180.7249-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0503310947180.7249-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503311018.02135.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 March 2005 9:59 am, Patrick Mochel wrote:
> On Thu, 31 Mar 2005, Alan Stern wrote:
> > On Wed, 30 Mar 2005, Patrick Mochel wrote:
> 
> > > In fact, we probably want to add a counter to every device for all "open
> > > connections" so the device doesn't try to automatically sleep while a
> > > device node is open. Once it reaches 0, we can have it enter a
> > > pre-configured state, which should save us a bit of power for very little
> > > pain.
> >
> > By "open connections", do you mean something more than unsuspended
> > children?
> 
> Yes, I mean anything that requires the device be awake and functional.

So for example a device that's suspended and enabled for wakeup could be
"open" ... which fights against your "doesn't try to sleep" policy.

Maybe you mean "don't power-off" rather than "don't sleep"?  Or are
you maybe assuming PC-style PCI, where nothing (on current Linux)
seems to process PME# wakeup events outside of system sleep states?
(Even when "lspci" shows PME# as active for a device ...)


> This would include open device nodes for many devices, open network
> connections for network devices, active children for bridges and
> controllers, etc.

Same thing applies.  Many devices can be suspended but wake up on demand.
And even pass the wakeup events up the hardware connectivity tree.  In
fact, being able to do that is a requirement to support that "USB mouse
on Centrino laptop" example:  USB mouse suspended, ditto the USB host
controller, then the CPU can enter C3 state and save a few more Watts.
Move mouse, wakeup the USB controller, CPU leaves C3.

In general, good power management will _want_ to leverage such modes.

Worth noting:  it's very similar to what modern CPUs do internally,
powering parts off until they're needed.  The same model can apply
to other chips; and to boards that integrate those chips...

- Dave

