Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVKWP4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVKWP4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVKWP43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:56:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23561 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751185AbVKWP41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:56:27 -0500
Date: Wed, 23 Nov 2005 15:56:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Vojtech Pavlik <vojtech@suse.cz>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123155616.GF15449@flint.arm.linux.org.uk>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <438488A0.8050104@drzeus.cx> <20051123152950.GC15449@flint.arm.linux.org.uk> <9e4733910511230749l67722bd3q736ed10c3e0639a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910511230749l67722bd3q736ed10c3e0639a8@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 10:49:35AM -0500, Jon Smirl wrote:
> On 11/23/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Wed, Nov 23, 2005 at 04:20:00PM +0100, Pierre Ossman wrote:
> > > But if no hardware is connected to those devices, then where does the
> > > driver route the setserial stuff?
> >
> > setserial /dev/ttyS2 port 0x200 irq 5 autoconfig
> >
> > and you might then end up with another serial port detected.  If
> > /dev/ttyS2 and above do not exist, you can't do that.  That would
> > in turn effectively prevent folk with some serial cards using them
> > with Linux without editing and rebuilding their kernel.
> 
> If my box has two serial ports and I use setserial to change the port,
> I still only have two serial ports.  Shouldn't this behave as a
> hotplug remove/add when the port address is changed?

Maybe, but that's not how it's historically been designed to work.
I'd rather not swipe the port from beneath setserial, especially
when it may want to do more than one IOCTL to configure the port.
What you suggest would again breaking existing setups.

> > As for the rest of the "setserial stuff" it gets recorded against
> > the port and remembered for when the hardware turns up, which it
> > may do if it's your PCMCIA modem card.
> 
> This is definitely not in the current spirit of hotplug. The PCMCIA
> card should generate a hotplug add event and then the script for the
> event can do the setserial equivalent.

These comments are misplaced given my corrected response.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
