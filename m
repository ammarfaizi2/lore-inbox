Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269456AbUICS6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269456AbUICS6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269743AbUICS6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:58:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32015 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269456AbUICS4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:56:01 -0400
Date: Fri, 3 Sep 2004 19:55:55 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: John Lenz <lenz@cs.wisc.edu>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
Message-ID: <20040903195555.D15620@flint.arm.linux.org.uk>
Mail-Followup-To: John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org
References: <1094157190l.4235l.2l@hydra> <20040903135103.GA982@elf.ucw.cz> <1094236686l.7429l.0l@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1094236686l.7429l.0l@hydra>; from lenz@cs.wisc.edu on Fri, Sep 03, 2004 at 06:38:06PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 06:38:06PM +0000, John Lenz wrote:
> On 09/03/04 08:51:03, Pavel Machek wrote:
> > > function : a read/write attribute that sets the current function of
> > > this led.  The available options are
> > >
> > >  timer : the led blinks on and off on a timer
> > >  idle : the led turns off when the system is idle and on when not idle
> > >  power : the led represents the current power state
> > >  user : the led is controlled by user space
> > 
> > I'm afraid this is really good idea. It seems quite overengineered to
> > me (and I'd be afraid that idle part slows machine). Perhaps having
> > only "user" mode is better idea?
> 
> I was only mimicing the support currently in the arm led code.
> After thinking about it from a broader perspective of including GPIOs,
> we should probably get rid of this function thing entirely.  Just let user  
> space do everything... userspace can monitor sysfs and hotplug and have the  
> led represent power or idle or whatever.

Bear in mind that my _original_ reason for implementing some of this
was to tell what's going on with the kernel on my machines.  I'm fairly
opposed to shifting it to userspace just because someone wants a bloated
sysfs interface to drive some tiddly little LEDs and then having to
losing the benefits of the existing implementation.

> The led class does not really inforce any policy, it just passes this
> number along to the actual driver that is registered.  So say you had
> a led that could be red, green, or both red and green at the same time
> (not sure how that would work hardware wise, but ok).

See Netwinders.  They have a bi-colour LED which has independent red
and green LEDs in the same package.  When they're both on it's yellow.

It's _VERY_ useful to see the green LED flashing and know that the
headless machine is running, or that the red LED being on means that
either it hasn't booted a kernel yet or the system has successfully
shut down.

It means I don't have to fsck around with monitor cables before pulling
the power.

And no, doing that from userspace won't work because userspace is dead
_before_ the system has finished shutting down (see drive cache
flushing on shutdown.)

It's also _VERY_ useful to know whether the kernel has managed to get
far enough through the boot that the heartbeat LED is flashing but
maybe not sufficiently to bring up the serial console as well -
again another thing that a userspace implementation will never be
able to support.

So sorry... I'm definitely opposed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
