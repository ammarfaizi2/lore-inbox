Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265597AbSKACIE>; Thu, 31 Oct 2002 21:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265598AbSKACIE>; Thu, 31 Oct 2002 21:08:04 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:4612 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265597AbSKACIC>;
	Thu, 31 Oct 2002 21:08:02 -0500
Date: Thu, 31 Oct 2002 18:11:29 -0800
From: Greg KH <greg@kroah.com>
To: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RFC: bare pci configuration access functions ?
Message-ID: <20021101021129.GB13031@kroah.com>
References: <20021101010241.GE12405@kroah.com> <72B3FD82E303D611BD0100508BB29735046DFF6B@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFF6B@orsmsx102.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 05:55:23PM -0800, Lee, Jung-Ik wrote:
> > Wait, first off, are we talking about 2.4, or 2.5 here?  
> 
> About both and beyond :)
> 
> > For 2.5 I think everything is covered, right?
> 
> Right.

Then "beyond" is already covered :)

> > > Will it be desirable to have bare global pci config access
> > > functions as seen in i386/ia64 pci codes ? It's clean and needs
> > > just what it takes - seg, bus, dev, func, where, value, and size.
> > 
> > No, I do not think so.  I think the way 2.5 does this is the correct
> > way.  
> 
> From PCI's own context, it's perfectly right since this way encapsulate
> access method to the object(pci, pci-express, ...) ala we're in that object
> context.
> But with the same object concept, mandating pci_bus struct for any pci
> config access seems cruel, because others could be affected on changes in
> pci objects as we are seeing between 2.4 and 2.5.

Almost no-one in the kernel should be directly accessing pci config
space without having a pci_bus structure at the minimum.  The exceptions
are the pci core, and the pci hotplug code.  Now, if we move the
majority of the pci hotplug resource code into the pci core, then only
one place would need it.  Then there would not be a need to have these
types of functions exported at all.  ACPI is a arch specific way of
setting up the pci space, so it too needs to be able to do this a little
bit (not a lot, like it currently does.)

So yes, it is cruel to not have this ability, but it is cruel for a
reason :)

> > We could just force every arch to export the same functions that i386
> > and ia64 does, that shouldn't be a big deal.  
> 
> Right. It becomes just a matter of unifying APIs if other architecture have
> own low level bare pci config access functions.

Ok, mind trying to make up a patch for 2.4 that does this to see how
feasible it really is?

thanks,

greg k-h
