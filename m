Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSGQMuD>; Wed, 17 Jul 2002 08:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSGQMuC>; Wed, 17 Jul 2002 08:50:02 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59458 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313202AbSGQMuB>; Wed, 17 Jul 2002 08:50:01 -0400
To: Patrick Mochel <mochel@osdl.org>
Cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Removal of pci_find_* in 2.5
References: <Pine.LNX.4.33.0207161025230.14360-100000@geena.pdx.osdl.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Jul 2002 06:41:23 -0600
In-Reply-To: <Pine.LNX.4.33.0207161025230.14360-100000@geena.pdx.osdl.net>
Message-ID: <m1it3eo7bg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@osdl.org> writes:

> On 16 Jul 2002, Eric W. Biederman wrote:
> 
> > Greg KH <greg@kroah.com> writes:
> > 
> > > I don't think there is a good way for you to convert over to
> > > _register_driver(), that's the main reason I'm keeping the pci_find_*
> > > functions around, they are quite useful for lots of situations.
> > > 
> > > It doesn't sound like you are worrying about your device working in a
> > > pci hotplug system, and you would probably be willing do any pci device
> > > conversion work to the new driver model yourself, right?  :)
> > 
> > Assuming I can actually fit in better with the new driver model.  As
> > far as hot-plug.  It is an abuse but I regularly hot-swap my rom chips
> > in my development system.
> 
> No, but you do do firmware, and you have a desire to tell the kernel about 
> which devices are in the system from the firmware. The code path once you 
> discover the device is exactly the same as if you were to actually plug 
> in the device, or probe for it natively.

A clarification here.  I am thinking of drivers/mtd/maps/ich2rom.c, or
drivers/mtd/maps/amd766rom.c.  (Should be in 2.4.19).  What the driver
do is find a pci bridge device behind which rom chips are usually
found, and then it probes for a rom chip, behind the bridge.  

Despite being LPC/ISA, there is a moderately standard way of getting a
chip id from a rom chip (see drivers/mtd/chips/jedec_probe.c).  Armed
with the chip id I dynamically select the chip driver.  

In practice my driver really is a driver for a subset of the bridge
chip, allowing access to the rom chip.  Besides giving a clue which
addresses to probe the map driver also enables writes to the rom chip.

>From the firmware side it is easy to tell the kernel there is a rom
chip at address xxx for yyy bytes behind zzz.  The challenging part is
what structure the driver should really take.  And for that I am
asking for advice, or at least some ideas.

> > In any case I would like to have code that fits in nicely with the
> > new driver system.  I can take about one change in kernel API.  For
> > the most part the drivers are trivial, and having non-trivial
> > maintenance for trivial code is less than ideal.
> 
> We don't want to make things difficult. It's a PITA right now, since the 
> documentation is lacking and not all the infrastructure is in place to 
> really start plowing ahead. But, it will get better..

Well I want to keep the reminders coming of weird things that are
actually supportable right now, and to ask for help in finding better
ways to construct the drivers.  If I could just do firmware my job
would be so much easier :)

Eric
