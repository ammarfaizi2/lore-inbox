Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317902AbSGPRbw>; Tue, 16 Jul 2002 13:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317906AbSGPRbv>; Tue, 16 Jul 2002 13:31:51 -0400
Received: from air-2.osdl.org ([65.172.181.6]:64141 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317902AbSGPRbt>;
	Tue, 16 Jul 2002 13:31:49 -0400
Date: Tue, 16 Jul 2002 10:33:14 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Removal of pci_find_* in 2.5
In-Reply-To: <m1ofd8ndoq.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0207161025230.14360-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Jul 2002, Eric W. Biederman wrote:

> Greg KH <greg@kroah.com> writes:
> 
> > On Sun, Jul 14, 2002 at 02:07:01PM -0600, Eric W. Biederman wrote:
> > > 
> > > The driver is a mtd map driver.  It knows there is a rom chip behind 
> > > a pci->isa bridge.  And it needs to find the pci->isa bridge to
> > > properly set it up to access the rom chip (enable writes and the
> > > like).  
> > > 
> > > It isn't a driver for the pci->isa bridge, (I'm not even certain we
> > > have a good model for that).  So it does not use pci_register_driver.
> > > 
> > > If you can give me a good proposal for how to accomplish that kind of
> > > functionality I would be happy to use the appropriate
> > > xxx_register_driver.
> > 
> > I don't think there is a good way for you to convert over to
> > _register_driver(), that's the main reason I'm keeping the pci_find_*
> > functions around, they are quite useful for lots of situations.
> > 
> > It doesn't sound like you are worrying about your device working in a
> > pci hotplug system, and you would probably be willing do any pci device
> > conversion work to the new driver model yourself, right?  :)
> 
> Assuming I can actually fit in better with the new driver model.  As
> far as hot-plug.  It is an abuse but I regularly hot-swap my rom chips
> in my development system.

No, but you do do firmware, and you have a desire to tell the kernel about 
which devices are in the system from the firmware. The code path once you 
discover the device is exactly the same as if you were to actually plug 
in the device, or probe for it natively.

Though making legacy drivers hotpluggable seems absurd, the capability is 
actually a requirement for supporting many firmwares. 

> I am probably looking at this from the wrong angle but my problem with
> current code base seems to be that I can only have one driver per pci
> device.

Don't most people? :)

> In any case I would like to have code that fits in nicely with the
> new driver system.  I can take about one change in kernel API.  For
> the most part the drivers are trivial, and having non-trivial
> maintenance for trivial code is less than ideal.

We don't want to make things difficult. It's a PITA right now, since the 
documentation is lacking and not all the infrastructure is in place to 
really start plowing ahead. But, it will get better..

	-pat

