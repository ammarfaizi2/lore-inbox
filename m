Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVGLNeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVGLNeR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVGLNcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:32:20 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:47801 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261425AbVGLNap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:30:45 -0400
X-ORBL: [69.107.32.110]
Date: Tue, 12 Jul 2005 06:30:43 -0700
From: david-b@pacbell.net
To: rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 2.6.13-git] 8250 tweaks
Cc: linux-kernel@vger.kernel.org
References: <200507111922.04800.david-b@pacbell.net>
 <20050712081943.B25543@flint.arm.linux.org.uk>
 <20050712102512.A7F30BF3C9@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <20050712120825.E28413@flint.arm.linux.org.uk>
 <20050712113212.0C90EBF3D5@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <20050712130119.A30358@flint.arm.linux.org.uk>
In-Reply-To: <20050712130119.A30358@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050712133043.976AC85E6C@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The idea is _not_ to register them on boards that only have a
> > single RS232 connector.  The fix was just having the 8250 code
> > understand that it should only register ports that are real.
>
> The tty code doesn't work like that.  You must know how many ports
> you want right from the start.

That ** IS ** the start ... the messages came out as the 8250
driver was registering and binding to the platform device.


>	You can't dynamically add new ports
> to an already registered driver without first unregistering all the
> existing ports, unregistering the driver, adjusting the number of
> ports, reregistering the driver and all the ports.

... so I have no idea why you think there's any dynamic addition
of new ports, or that the driver was already registered, or that
the number of ports is being changed, or any of that.


> If you've got one already open, your only option in that case is to
> ignore any attempt to add new ports.
>
> Obviously this is not acceptable.

Good thing none of that is being tried, then!!


>	So please don't try to dictate
> what serial should do.

In no way am _I_ trying to "dictate" anything.


>	It does things the way it does them to work
> around other bits of the kernel which are lacking in various ways.

I understand working around, of course.  But I fail to see how
emitting error messages for non-error cases does anyone any good.


> > > If you wish to have three ports in an plat_serial8250_port array, you'll
> > > need to ensure that CONFIG_SERIAL_8250_NR_UARTS is set to at least 3.
> > 
> > That is, there's no third way which (a) doesn't waste that memory,
> > and (b) doesn't produce annoying messages about non-error cases?
>
> Correct.

That doesn't seem necessary, given the simple "don't try to register
ports unless they're enabled" patch you saw.  Or desirable.


> > ISTR that having NR_UARTS bigger just produced different messages...
>
> Which were?

Error code 22 instead of 28, as I recall.  And as I said, the
appearance of any (bogus error) message is a "recent" change.
Two months ago, there were no messages at all.


> It works for me on my platforms here, and everyone else on x86.  I
> even had a situation where I had NR_UARTS set to 64 but only one
> registered... which also worked fine with no extraneous kernel
> messages.

But it was certainly wasting the memory for 63 ports.

- Dave

