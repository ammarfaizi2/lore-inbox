Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287876AbSABSja>; Wed, 2 Jan 2002 13:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287890AbSABSjU>; Wed, 2 Jan 2002 13:39:20 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:57060 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S287876AbSABSjK>; Wed, 2 Jan 2002 13:39:10 -0500
Date: Wed, 02 Jan 2002 10:37:41 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: highmem and usb [was
 "sr: unaligned transfer" in 2.5.2-pre1]
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        Matthew Dharm <mdharm@one-eyed-alien.net>, Greg KH <greg@kroah.com>
Message-id: <07c401c193bc$90ad5d60$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> <20011223112249.B4493@kroah.com>
 <m23d1trr4w.fsf@pengo.localdomain> <20011230122756.L1821@suse.de>
 <20011230212700.B652@one-eyed-alien.net> <20011231125157.D1246@suse.de>
 <20011231145455.C6465@one-eyed-alien.net>
 <065e01c192fd$fe066e20$6800000a@brownell.org> <20020101233423.I16092@suse.de>
 <06c801c1934e$1fc01a20$6800000a@brownell.org> <20020102103252.B28530@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > requirement for drivers is that the transfer buffers can be passed to
> > pci_map_single() calls by the Host Controller Drivers (HCDs).  The
> > device drivers, and URBs, don't expose such mappings, they only
> > require that they can be created/destroyed.
> 
> .. which is the requirement that you want to change to use pci_map_page
> or pci_map_sg

OK, I think I'm clear on this much then:  in 2.5, to support block drivers
over USB (usb-storage only, for now) there needs to be an addition to
the buffer addressing model in usbcore, as exposed by URBs.

  - Current "transfer_buffer" + "transfer_buffer_length" mode needs to
    stay, since most drivers aren't block drivers.

  - Add some kind of "page + offset" addressing model.

Discussion of details can be taken off LKML, it'd seem.  Though I'm
curious when the scatterlist->address field will vanish, making these
changes a requirement.  Is that a 2.5.2 thing?

Also, I noticed that include/asm-sparc/pci.h doesn't include the
standard pci_map_page() call ... what's up with that?  That surely
causes portability problems.

- Dave


    




