Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287894AbSABSoa>; Wed, 2 Jan 2002 13:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287891AbSABSoU>; Wed, 2 Jan 2002 13:44:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7182 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287890AbSABSoP>;
	Wed, 2 Jan 2002 13:44:15 -0500
Date: Wed, 2 Jan 2002 19:44:04 +0100
From: Jens Axboe <axboe@suse.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        Matthew Dharm <mdharm@one-eyed-alien.net>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: highmem and usb [was "sr: unaligned transfer" in 2.5.2-pre1]
Message-ID: <20020102194404.A482@suse.de>
In-Reply-To: <m23d1trr4w.fsf@pengo.localdomain> <20011230122756.L1821@suse.de> <20011230212700.B652@one-eyed-alien.net> <20011231125157.D1246@suse.de> <20011231145455.C6465@one-eyed-alien.net> <065e01c192fd$fe066e20$6800000a@brownell.org> <20020101233423.I16092@suse.de> <06c801c1934e$1fc01a20$6800000a@brownell.org> <20020102103252.B28530@suse.de> <07c401c193bc$90ad5d60$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c401c193bc$90ad5d60$6800000a@brownell.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02 2002, David Brownell wrote:
> > > requirement for drivers is that the transfer buffers can be passed to
> > > pci_map_single() calls by the Host Controller Drivers (HCDs).  The
> > > device drivers, and URBs, don't expose such mappings, they only
> > > require that they can be created/destroyed.
> > 
> > .. which is the requirement that you want to change to use pci_map_page
> > or pci_map_sg
> 
> OK, I think I'm clear on this much then:  in 2.5, to support block drivers
> over USB (usb-storage only, for now) there needs to be an addition to
> the buffer addressing model in usbcore, as exposed by URBs.
> 
>   - Current "transfer_buffer" + "transfer_buffer_length" mode needs to
>     stay, since most drivers aren't block drivers.

Why? Surely USB block drivers are not the only ones that want to support
highmem.

>   - Add some kind of "page + offset" addressing model.

Yes

> Discussion of details can be taken off LKML, it'd seem.  Though I'm
> curious when the scatterlist->address field will vanish, making these
> changes a requirement.  Is that a 2.5.2 thing?

Maybe 2.5.3, dunno for sure.

> Also, I noticed that include/asm-sparc/pci.h doesn't include the
> standard pci_map_page() call ... what's up with that?  That surely
> causes portability problems.

It probably isn't up to snuff yet.

-- 
Jens Axboe

