Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSAAWe6>; Tue, 1 Jan 2002 17:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285632AbSAAWes>; Tue, 1 Jan 2002 17:34:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25612 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286325AbSAAWep>;
	Tue, 1 Jan 2002 17:34:45 -0500
Date: Tue, 1 Jan 2002 23:34:23 +0100
From: Jens Axboe <axboe@suse.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        Matthew Dharm <mdharm@one-eyed-alien.net>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: "sr: unaligned transfer" in 2.5.2-pre1
Message-ID: <20020101233423.I16092@suse.de>
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> <20011223112249.B4493@kroah.com> <m23d1trr4w.fsf@pengo.localdomain> <20011230122756.L1821@suse.de> <20011230212700.B652@one-eyed-alien.net> <20011231125157.D1246@suse.de> <20011231145455.C6465@one-eyed-alien.net> <065e01c192fd$fe066e20$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <065e01c192fd$fe066e20$6800000a@brownell.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01 2002, David Brownell wrote:
> Not that I've seen a writeup about highmem (linux/Documentation
> doesn't seem to have one anyway) but if I infer correctly from that
> DMA-mapping.txt writeup, URBs don't support it because there's no way
> to specify buffers as a "struct page *" or an array of "struct
> scatterlist".  That's the only way that document identifies to access
> "highmem memory".

What kind of mapping does URBs require? A virtual mapping?

> > (1) Do the USB HCDs support highmem?  I seem to recall they do, but
> > I'm not certain.
> 
> If URBs can't describe highmem, the HCD's won't support them per se;
> you'd have to turn highmem to "lowmem" or whatever it's called, and
> then let the HCDs manage the lowmem-to-dma_addr_t mappings.
> 
> Alternatively, in 2.5 we might add "highmem" support to USB.  Now that
> I've looked at it a few minutes, I suspect we must -- just to support
> block devices (usb-storage) fully.  Is there more to it than adding

No, you can always ask to get pages low mem bounced. Highmem is no
requirement, and if your device really can't support it there's no point
in attempting to support it.

> page+offset as an alternative way to describe the transfer_buffer?

no

> (And making all the "single" mapping calls in the HCDs use page
> mappings.)

exactly

-- 
Jens Axboe

