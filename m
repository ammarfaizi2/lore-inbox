Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286902AbSABJdg>; Wed, 2 Jan 2002 04:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286842AbSABJdT>; Wed, 2 Jan 2002 04:33:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35855 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286815AbSABJdB>;
	Wed, 2 Jan 2002 04:33:01 -0500
Date: Wed, 2 Jan 2002 10:32:52 +0100
From: Jens Axboe <axboe@suse.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        Matthew Dharm <mdharm@one-eyed-alien.net>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: highmem and usb [was "sr: unaligned transfer" in 2.5.2-pre1]
Message-ID: <20020102103252.B28530@suse.de>
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> <20011223112249.B4493@kroah.com> <m23d1trr4w.fsf@pengo.localdomain> <20011230122756.L1821@suse.de> <20011230212700.B652@one-eyed-alien.net> <20011231125157.D1246@suse.de> <20011231145455.C6465@one-eyed-alien.net> <065e01c192fd$fe066e20$6800000a@brownell.org> <20020101233423.I16092@suse.de> <06c801c1934e$1fc01a20$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c801c1934e$1fc01a20$6800000a@brownell.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01 2002, David Brownell wrote:
> > > Not that I've seen a writeup about highmem (linux/Documentation
> > > doesn't seem to have one anyway) but if I infer correctly from that
> > > DMA-mapping.txt writeup, URBs don't support it because there's no way
> > > to specify buffers as a "struct page *" or an array of "struct
> > > scatterlist".  That's the only way that document identifies to access
> > > "highmem memory".
> > 
> > What kind of mapping does URBs require? A virtual mapping?
> 
> Each URB points to one transfer buffer, address plus length, where
> the USB device drivers directly read/write those addresses.   The
> requirement for drivers is that the transfer buffers can be passed to
> pci_map_single() calls by the Host Controller Drivers (HCDs).  The
> device drivers, and URBs, don't expose such mappings, they only
> require that they can be created/destroyed.

.. which is the requirement that you want to change to use pci_map_page
or pci_map_sg

> I'd be inclined to say transfer buffers must not be "virtual" mappings,
> but since terminology can differ I'll let you draw your conclusion.

They must not be, currently they are.

> Standard HC hardware (EHCI, OHCI, UHCI) can use 32bit addresses
> for their PCI DMA.  EHCI can also, in some implementations, handle 64bit
> addresses.

Good

> > > (And making all the "single" mapping calls in the HCDs use page
> > > mappings.)
> > 
> > exactly
> 
> So you're saying that pci_map_page() is not necessary?  And that
> highmem buffers (page+offset, or scatterlist thereof) can be turned
> into the form needed by URBs using some other mechanism?

Sorry if I wasn't clear, no that's not what I meant. See above.
pci_map_single requires a virtual mapping so it simply cannot support
highmem.

-- 
Jens Axboe

