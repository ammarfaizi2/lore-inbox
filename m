Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262997AbRFJWEF>; Sun, 10 Jun 2001 18:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262988AbRFJWDz>; Sun, 10 Jun 2001 18:03:55 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:43229 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262934AbRFJWDq>; Sun, 10 Jun 2001 18:03:46 -0400
Date: Sun, 10 Jun 2001 18:03:42 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-usb-devel@lists.sourceforge.net
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] usb.c: USB device not accepting new address=4 (error=-110)
Message-ID: <20010610180342.A11232@devserv.devel.redhat.com>
In-Reply-To: <20010609064123.V11815@nightmaster.csn.tu-chemnitz.de> <0ab501c0f0ac$10532720$cc07aace@brownell.org> <20010609091919.W11815@nightmaster.csn.tu-chemnitz.de> <0ae201c0f0e6$1b59fb00$cc07aace@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0ae201c0f0e6$1b59fb00$cc07aace@brownell.org>; from david-b@pacbell.net on Sat, Jun 09, 2001 at 06:14:24AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had difficulties making it all work on ServerWorks III LE
based machines, most notably 2450 & 6450.

Dell fixed 2450 eventually, BIOS needs upgrade to level A11.

> >  30:          0          0   IO-APIC-level  usb-ohci

The line above says that MP table contained the device.
This is the situarion with 6450 - they have the MP entry,
but there is no way to make it work. I am working with their
BIOS and hw engineers on a fix.

For the moment the workaround is to run the whole thing
with "noapic". Try it, perhaps it helps the machine in question.

-- Pete

> From: David Brownell <david-b@pacbell.net>
> To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
> Cc: linux-usb-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
> Reply-To: linux-usb-devel@lists.sourceforge.net
> Date: Sat, 09 Jun 2001 06:14:24 -0700

> Then whatever sets up your ServerWorks ServerSet III LE chipset
> needs its PCI IRQ setup fixed ... I'm not sure how to do this.
> 
> Perhaps someone who's familiar with arch/i386/kernel/pci-*.c
> irq setup can suggest the right patch for this problem.  I think
> the "dmesg" output in your original post probably had the info
> needed to figure that out.
> 
> - Dave
> 
> > From: "Ingo Oeser" <ingo.oeser@informatik.tu-chemnitz.de>
> > Sent: Saturday, June 09, 2001 12:19 AM
> >
> > > David Brownell wrote:
> > > Can you verify, using /proc/interrupts, that you're actually
> > > getting interrupts on irq #30 when these timeouts happen?
> >  
> > I get none:
> >  30:          0          0   IO-APIC-level  usb-ohci
> >  
> > > One possibility:  the timeout happens because the HCD
> > > is not getting the interrupts it expects.  That would imply
> > > that the PCI IRQ setup for this device isn't quite right.
> > > Such problems have been seen before.
> > 
> > This seems to be my problem. How can I solve this?
> > 
> > My BIOS cannot set a specific IRQ for USB like other BIOSes do.
> > 
> > And now that you say^W it, I remember sth. like this on
> > linux-kernel... I just didn't know the messages...
> > 
> > Thanks and Regards
> > 
> > Ingo Oeser
