Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265579AbSKACdO>; Thu, 31 Oct 2002 21:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265650AbSKACdO>; Thu, 31 Oct 2002 21:33:14 -0500
Received: from fmr06.intel.com ([134.134.136.7]:31977 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S265579AbSKACdG>; Thu, 31 Oct 2002 21:33:06 -0500
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFF6C@orsmsx102.jf.intel.com>
From: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: RFC: bare pci configuration access functions ?
Date: Thu, 31 Oct 2002 18:39:26 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > > > Will it be desirable to have bare global pci config access
> > > > functions as seen in i386/ia64 pci codes ? It's clean and needs
> > > > just what it takes - seg, bus, dev, func, where, value, 
> and size.
> > > 
> > > No, I do not think so.  I think the way 2.5 does this is 
> the correct
> > > way.  
> > 
> > From PCI's own context, it's perfectly right since this way 
> encapsulate
> > access method to the object(pci, pci-express, ...) ala 
> we're in that object
> > context.
> > But with the same object concept, mandating pci_bus struct 
> for any pci
> > config access seems cruel, because others could be affected 
> on changes in
> > pci objects as we are seeing between 2.4 and 2.5.
> 
> Almost no-one in the kernel should be directly accessing pci config
> space without having a pci_bus structure at the minimum.The 
> exceptions
> are the pci core, and the pci hotplug code.  Now, if we move the
> majority of the pci hotplug resource code into the pci core, then only
> one place would need it.  Then there would not be a need to have these
> types of functions exported at all.  ACPI is a arch specific way of
> setting up the pci space, so it too needs to be able to do 
> this a little
> bit (not a lot, like it currently does.)

Platform management, early console access, acpi, hotplug io-node w/ root,...
pci_bus based access is useless before pci driver is initialized.
All exceptions will be forced to use fake structs...
Sounds we need to be ready to live with all exceptions here too :)
Or just to make them all happy with that simple bare functions.

> 
> So yes, it is cruel to not have this ability, but it is cruel for a
> reason :)
> 
> > > We could just force every arch to export the same 
> functions that i386
> > > and ia64 does, that shouldn't be a big deal.  
> > 
> > Right. It becomes just a matter of unifying APIs if other 
> architecture have
> > own low level bare pci config access functions.
> 
> Ok, mind trying to make up a patch for 2.4 that does this to see how
> feasible it really is?

OK, if simple and pure pci config access is not possible in Linux land,
let pci driver fake itself, not everyone else :)
Just export the two APIs like pci_config_{read|write}(s,b,d,f,s,v),
or the ones in acpi driver. Hide the fake pci_bus manipulation in them. 
This way is way better than having everyone fake pci driver ;-)

Thanks,
J.I.
