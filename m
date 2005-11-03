Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbVKCQBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbVKCQBj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbVKCQBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:01:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57617 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030363AbVKCQBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:01:38 -0500
Date: Thu, 3 Nov 2005 16:01:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@suse.cz>, John Lenz <lenz@cs.wisc.edu>,
       Robert Schwebel <robert@schwebel.de>,
       Robert Schwebel <r.schwebel@pengutronix.de>, rpurdie@rpsys.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: best way to handle LEDs
Message-ID: <20051103160123.GI28038@flint.arm.linux.org.uk>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Pavel Machek <pavel@suse.cz>, John Lenz <lenz@cs.wisc.edu>,
	Robert Schwebel <robert@schwebel.de>,
	Robert Schwebel <r.schwebel@pengutronix.de>, rpurdie@rpsys.net,
	kernel list <linux-kernel@vger.kernel.org>
References: <20051101234459.GA443@elf.ucw.cz> <20051102202622.GN23316@pengutronix.de> <20051102211334.GH23943@elf.ucw.cz> <20051102213354.GO23316@pengutronix.de> <38523.192.168.0.12.1130986361.squirrel@192.168.0.2> <20051103081522.GA21663@flint.arm.linux.org.uk> <20051103095725.GA703@openzaurus.ucw.cz> <20051103144904.GG28038@flint.arm.linux.org.uk> <20051103153445.GA3530@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103153445.GA3530@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 04:34:45PM +0100, Vojtech Pavlik wrote:
> On Thu, Nov 03, 2005 at 02:49:04PM +0000, Russell King wrote:
> > On Thu, Nov 03, 2005 at 10:57:26AM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > Except the led code that is being proposed CAN sit on top of a generic
> > > > > GPIO layer.
> > > > 
> > > > I also have issues with a generic GPIO layer.  As I mentioned in the
> > > > past, there's serious locking issues with any generic abstraction of
> > > > GPIOs.
> > > > 
> > > > 1. You want to be able to change GPIO state from interrupts.  This
> > > >    implies you can not sleep in GPIO state changing functions.
> > > > 
> > > > 2. Some GPIOs are implemented on I2C devices.  This means that to
> > > >    change state, you must sleep.
> > > 
> > > Can't you just busywait? Yes, it is ugly in general, but perhaps it
> > > is better than alternatives...
> > 
> > Does the i2c layer support busy waiting or are you suggesting something
> > else?
> 
> It usually doesn't support anything else. At least on the controllers
> I've seen the drivers for.

I think you misunderstand me.  Please read:

  http://dictionary.reference.com/search?q=busywait

Since the i2c transfer functions allow drivers to sleep (and some do)
you can't "just busywait" without modifying the i2c layer to tell
drivers to busy wait instead of sleeping.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
