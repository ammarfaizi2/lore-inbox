Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317817AbSHHSw2>; Thu, 8 Aug 2002 14:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSHHSw2>; Thu, 8 Aug 2002 14:52:28 -0400
Received: from [63.204.6.12] ([63.204.6.12]:698 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S317817AbSHHSw1>;
	Thu, 8 Aug 2002 14:52:27 -0400
Date: Thu, 8 Aug 2002 14:56:06 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: PCI hotplug resource reservation
In-Reply-To: <20020808181931.GA22209@kroah.com>
Message-ID: <Pine.LNX.4.33.0208081423550.26999-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Greg KH wrote:

> On Thu, Aug 08, 2002 at 01:36:35PM -0400, Scott Murray wrote:
> >
> > Are you interested in this reservation code as a seperate patch for 2.4,
> > or should I just send you all of my cPCI stuff to look at in one go?  I
> > was going to cut it up into 3-4 patches before sending it to
> > pcihpd-discuss sometime later today, but I can do whatever you want.
>
> I'd prefer it for 2.5 right now.  But if the cPCI stuff doesn't touch
> anything else, I'd be interested in that for 2.4.
>
> I don't want to really touch the core PCI code in 2.4 right now, unless
> we _really_ have to :)

I do have some other core PCI changes, but they're nothing major:
- exporting a few more things (e.g. pci_scan_bridge, pci_setup_bridge)
- changing some things from __init to __devinit
- adding new functions pci_find_bus, pci_do_max_busnr, and pci_max_busnr

Probably the most "interesting" code is a change I made to
arch/i386/kernel/pci-irq.c to have pci_lookup_irq try to recursively
find the parent slot in the IRQ routing table, via a new helper
function pirq_get_parent_info.  This allows the IRQ assignment driven
by pci_enable_device to work with devices behind bridges on cPCI
peripheral cards.  This new code is currently conditional under
CONFIG_HOTPLUG_PCI (probably _CPCI once I get my config changes done).

I can totally understand not wanting to destabilise 2.4, and I can
live with having my own 2.4 cPCI tree up on bkbits if you don't want
to pull these changes in.  Unfortunately, I'm not in a position to
do any serious testing on 2.5, since I'm under the gun to deliver
cPCI hotswap as part of a complete 2.4 based production system in
another couple months.

> > Done.  I'd considered doing that right off, but it didn't seem to match
> > the style of the rest of the PCI code, for example the proc and pm stuff.
> > If you want, I can work on a patch to clean those up as well.
>
> For 2.5, I'd love a patch to do that.  As I said above, I don't really
> care about that for 2.4.

Okay, I might start pick at this on my vacation if I can get my hands on
a half-decent laptop.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

