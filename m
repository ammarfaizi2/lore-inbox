Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSKDWYe>; Mon, 4 Nov 2002 17:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSKDWYe>; Mon, 4 Nov 2002 17:24:34 -0500
Received: from momus.sc.intel.com ([143.183.152.8]:57545 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S262812AbSKDWYc>; Mon, 4 Nov 2002 17:24:32 -0500
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFF77@orsmsx102.jf.intel.com>
From: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: RFC: bare pci configuration access functions ?
Date: Mon, 4 Nov 2002 14:30:25 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ah, so exporting those types of functions is not practical?  Oh well...

It simply needs changes to every arch codes in architecture specific way, as
I explained in #2. This is practical, or not depending on how we view :)
Better not go on with this since there's lighter, better known solution.

> > There could be two ways to achieve bare pci config accesses for all
> > architectures.
> 
> <snip>
> 
> Wait, again I'm confused.  Let's go over the main points here:
> 
>  - for 2.5 everyone uses the pci_bus_read_config* and
>    pci_bus_write_config* functions and is happy.  Well ACPI 
> isn't happy,
>    but the code there currently works, so let's leave it at that.

See how each and every php drivers in 2.5 manage this differently only to
fake pci driver for non-existing pci_bus w/ own overhead. It's ugly.

> 
>  - for 2.4 we don't have the pci_bus* functions, so we need to do
>    something.  I originally wanted to look into exporting the
>    pci_config_* function pointers, but you said that doesn't look
>    possible based on the different arch specific implementation.

The simplest, sound way of exporting bare pci config access function is what
I proposed as #1. It doesn't need any change on arch pci codes.
More specifically, pci_bus_read_config_##size(pci_bus, ...) is simply
replaced with
pci_read_config_##size(pci_dev, ...).

>    
>  - Because of this, you just proposed a patch, yet your patch uses the
>    pci_bus_* functions which are not present on 2.4.  If they were,
>    everyone would be happy again, and not need such a patch, right?

I proposed pure PCI config access method required by some kernel components,
not just to get around the absence of pci_bus in 2.4, but also to address
the ugliness of having everyone fake pci driver w/ individual's overhead.
The #1 proposed is the solution for all architectures w/o any change in
existing arch pci codes, while the concept has already been proved.

Below is copied from previous email thread.
-------------------------------
>> OK, if simple and pure pci config access is not possible in Linux land,
>> let pci driver fake itself, not everyone else :)
>> Just export the two APIs like pci_config_{read|write}(s,b,d,f,s,v),
>> or the ones in acpi driver. Hide the fake pci_bus manipulation in them. 
>> This way is way better than having everyone fake pci driver ;-)

>I agree.  But can we do this for all archs?  I don't know, and look
>forward to your patch proving this will work.  Without all arch support
>of this, I can't justify only exporting the functions for i386 and ia64.
------------------------------

Thanks,
J.I.

