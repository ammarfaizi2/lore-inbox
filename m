Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262803AbSKDV1L>; Mon, 4 Nov 2002 16:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbSKDV1L>; Mon, 4 Nov 2002 16:27:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:13 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262803AbSKDV1K>;
	Mon, 4 Nov 2002 16:27:10 -0500
Date: Mon, 4 Nov 2002 13:30:02 -0800
From: Greg KH <greg@kroah.com>
To: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: RFC: bare pci configuration access functions ?
Message-ID: <20021104213001.GA8334@kroah.com>
References: <72B3FD82E303D611BD0100508BB29735046DFF75@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFF75@orsmsx102.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 12:17:45PM -0800, Lee, Jung-Ik wrote:
> Hi Greg,
> 
> > What's wrong with the _existing_ pci_config_read() and
> > pci_config_write() function pointers that ia64 and i386 have? 
> >  Can't you
> > just look into if the other archs can set them to the proper 
> > function in
> > their pci init functions too?
> 
> Other architectures' PCI config access methods vary and require their own
> address mappings, etc.

Ah, so exporting those types of functions is not pratical?  Oh well...

> There could be two ways to achieve bare pci config accesses for all
> architectures.

<snip>

Wait, again I'm confused.  Let's go over the main points here:

 - for 2.5 everyone uses the pci_bus_read_config* and
   pci_bus_write_config* functions and is happy.  Well ACPI isn't happy,
   but the code there currently works, so let's leave it at that.

 - for 2.4 we don't have the pci_bus* functions, so we need to do
   something.  I originally wanted to look into exporting the
   pci_config_* function pointers, but you said that doesn't look
   possible based on the different arch specific implementation.
   
 - Because of this, you just proposed a patch, yet your patch uses the
   pci_bus_* functions which are not present on 2.4.  If they were,
   everyone would be happy again, and not need such a patch, right?

Confused,

greg k-h
