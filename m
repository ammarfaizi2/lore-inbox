Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265319AbSKABtA>; Thu, 31 Oct 2002 20:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265324AbSKABtA>; Thu, 31 Oct 2002 20:49:00 -0500
Received: from fmr01.intel.com ([192.55.52.18]:59862 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265319AbSKABs6>;
	Thu, 31 Oct 2002 20:48:58 -0500
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFF6B@orsmsx102.jf.intel.com>
From: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: RFC: bare pci configuration access functions ?
Date: Thu, 31 Oct 2002 17:55:23 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wait, first off, are we talking about 2.4, or 2.5 here?  

About both and beyond :)

> For 2.5 I think
> everything is covered, right?

Right.

> > Will it be desirable to have bare global pci config access 
> functions as seen
> > in i386/ia64 pci codes ? It's clean and needs just what it 
> takes - seg, bus,
> > dev, func, where, value, and size.
> 
> No, I do not think so.  I think the way 2.5 does this is the correct
> way.  

>From PCI's own context, it's perfectly right since this way encapsulate
access method to the object(pci, pci-express, ...) ala we're in that object
context.
But with the same object concept, mandating pci_bus struct for any pci
config access seems cruel, because others could be affected on changes in
pci objects as we are seeing between 2.4 and 2.5.

Tome, pci config access is simply about PCI/PCI-Express specs, and hence
access should be made with just what it takes - seg, bus, dev, ..., w/o any
implementation dependencies.

> But as I did that patch, I might be a bit biased :)
> 
> We could just force every arch to export the same functions that i386
> and ia64 does, that shouldn't be a big deal.  

Right. It becomes just a matter of unifying APIs if other architecture have
own low level bare pci config access functions.

> I think this would solve
> the problem on 2.4 for pci hotplug, as ACPI is already "cheating" and
> doing this right now...
> 
> thanks,
> 
> greg k-h
> 
