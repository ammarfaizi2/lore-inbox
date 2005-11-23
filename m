Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVKWPwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVKWPwB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVKWPwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:52:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22025 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751173AbVKWPvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:51:52 -0500
Date: Wed, 23 Nov 2005 15:51:44 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Jon Smirl <jonsmirl@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123155143.GE15449@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Jon Smirl <jonsmirl@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>,
	Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <438488A0.8050104@drzeus.cx> <20051123152950.GC15449@flint.arm.linux.org.uk> <43848D37.4080007@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43848D37.4080007@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 04:39:35PM +0100, Pierre Ossman wrote:
> Russell King wrote:
> >On Wed, Nov 23, 2005 at 04:20:00PM +0100, Pierre Ossman wrote:
> >  
> >>But if no hardware is connected to those devices, then where does the 
> >>driver route the setserial stuff?
> >>    
> >
> >setserial /dev/ttyS2 port 0x200 irq 5 autoconfig
> >
> >and you might then end up with another serial port detected.  If
> >/dev/ttyS2 and above do not exist, you can't do that.  That would
> >in turn effectively prevent folk with some serial cards using them
> >with Linux without editing and rebuilding their kernel.
> 
> Ah. But why is this not done through module parameters? That would be 
> more consistent with how you specify resources for other drivers.

Take a moment to consider how you would supply a large number of ports
via this method - eg, 16 ports, where a port IO and IRQ configuration
takes about 10 characters ("0x1234,11"), and then what about the baud
base, probe flags (auto_irq, skip_test) ?

Also consider that ttyS0 might be your serial console for your headless
box, so you're unable to build 8250 as a module in the first place.

It really isn't simple.  Serial _is_ special - and that is why it keeps
sprouting new and wonderful initialisation paths.  I'd rather not add
yet another gods greatest invention initialisation path on top of those
we already have.

> >As for the rest of the "setserial stuff" it gets recorded against
> >the port and remembered for when the hardware turns up, which it
> >may do if it's your PCMCIA modem card.
> 
> This could be a bit more questionable. Setting the initial state of 
> hardware is better done (IMHO) by reacting to some hotplug event. E.g. 
> fedora uses an 'install' line in modprobe.conf to restore mixer state 
> for sound cards.

Actually, my example was slightly flawed - when the hardware turns up
it gets reset back to something sane.  So the settings are merely
remembered while the hardware doesn't exist.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
