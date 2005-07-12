Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVGLOAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVGLOAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVGLOAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:00:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21262 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261337AbVGLOAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:00:46 -0400
Date: Tue, 12 Jul 2005 15:00:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-git] 8250 tweaks
Message-ID: <20050712150040.B30358@flint.arm.linux.org.uk>
Mail-Followup-To: david-b@pacbell.net, linux-kernel@vger.kernel.org
References: <200507111922.04800.david-b@pacbell.net> <20050712081943.B25543@flint.arm.linux.org.uk> <20050712102512.A7F30BF3C9@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <20050712120825.E28413@flint.arm.linux.org.uk> <20050712113212.0C90EBF3D5@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <20050712130119.A30358@flint.arm.linux.org.uk> <20050712133043.976AC85E6C@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050712133043.976AC85E6C@adsl-69-107-32-110.dsl.pltn13.pacbell.net>; from david-b@pacbell.net on Tue, Jul 12, 2005 at 06:30:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 06:30:43AM -0700, david-b@pacbell.net wrote:
> > > ISTR that having NR_UARTS bigger just produced different messages...
> >
> > Which were?
> 
> Error code 22 instead of 28, as I recall.  And as I said, the
> appearance of any (bogus error) message is a "recent" change.
> Two months ago, there were no messages at all.

We now have multiple 8250 platform devices.  I'm sure folk would
want to know if one of their serial ports fails to register.  Hence
the message.  It's not bogus!

22 is EINVAL, which will occur if uartclk is zero, or if the port was
trying to be registered was already registered (not possible.)

So, you're asking the driver to register a port with zero MMIO, IO and
clock values...  Ok, you're asking the driver to do something that is
invalid.  Sounds like its the platform code which is doing the bogus
things.

I don't see why you can't just pass those that you want and no more.
Either build the table dynamically with just the ports that you want
listed and the rest completely zeroed, or register several platform
devices, one for each port.

You don't need any special hacks in the 8250 driver to "support" this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
