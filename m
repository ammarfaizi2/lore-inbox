Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262320AbSJDVty>; Fri, 4 Oct 2002 17:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262321AbSJDVty>; Fri, 4 Oct 2002 17:49:54 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:49423 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262320AbSJDVtx>;
	Fri, 4 Oct 2002 17:49:53 -0400
Date: Fri, 4 Oct 2002 14:52:22 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
Message-ID: <20021004215222.GA8843@kroah.com>
References: <20021003224011.GA2289@kroah.com> <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com> <20021004165955.GC6978@kroah.com> <20021004205121.GA8346@kroah.com> <20021004205222.GB8346@kroah.com> <20021004205305.GC8346@kroah.com> <20021004205410.GD8346@kroah.com> <3D9E0970.70903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9E0970.70903@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 05:34:40PM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >@@ -1563,13 +1562,11 @@
> > 
> >     if (pci_present()) {
> 
> an example of pci_present() that can be eliminated, as I described earlier

I agree I could have done more invasive work on these drivers, they sure
need it :)

But I was going for a minimal set of patches to remove the pcibios_*
functions and still let things work.

> > 	for (i = 0; i < NPCI_CHIP_IDS; ++i) 
> >-	    for (pci_index = 0;
> >-		!pcibios_find_device (PCI_VENDOR_ID_NCR, 
> >-		    pci_chip_ids[i].pci_device_id, pci_index, &pci_bus, 
> >-		    &pci_device_fn); 
> >-    		++pci_index)
> >+	    while ((pdev = pci_find_device (PCI_VENDOR_ID_NCR,
> >+					    pci_chip_ids[i].pci_device_id,
> >+					    pdev)))
> > 		if (!ncr_pci_init (tpnt, BOARD_GENERIC, 
> > 		pci_chip_ids[i].chip, -		    pci_bus, pci_device_fn, /* no 
> >options */ 0))
> >+		    pdev->bus->number, pdev->devfn, /* no options */ 0))
> 
> 
> can you eliminate the need of ncr_pci_init to have number/devfn args?

No, it wouldn't be that easy, as that function is called from other
places.  That driver needs some major work, as it still is not converted
over to the proper DMA fixes that went into the tree a long time ago.

thanks,

greg k-h
