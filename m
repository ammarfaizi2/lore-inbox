Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287694AbSAAACA>; Mon, 31 Dec 2001 19:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287695AbSAAABt>; Mon, 31 Dec 2001 19:01:49 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:9993 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S287694AbSAAABh>; Mon, 31 Dec 2001 19:01:37 -0500
Date: Mon, 31 Dec 2001 15:59:10 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: "sr: unaligned transfer" in 2.5.2-pre1
In-Reply-To: <20011231145455.C6465@one-eyed-alien.net>
Message-ID: <Pine.LNX.4.10.10112311523040.4780-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matt,

This was a point I tried to make but failed.
Not all SCB/SRB's are highmem tested but OEM's claim support.
This I tried to have BIO change to do highmen drop to the lowmem window
upon entry of the request and this would have prevent most form breaking,
but this did not seem to get warm acceptance.

Regards,

Andre Hedrick
Linux ATA Development

On Mon, 31 Dec 2001, Matthew Dharm wrote:

> Jens --
> 
> Thanks for the info.  It may have been discussed 'here' (tho, this is
> crosposted to two different lists), but I've been focused on 2.4 bugs (one
> more left!) and hadn't seen this item.
> 
> I think for the first 2.5 kernels, we'll o with your 'vaddr' line, but I
> think that being able to set highmem_io is a worthwhile thing.  Which leads
> me to two questions:
> (1) Do the USB HCDs support highmem?  I seem to recall they do, but I'm not
> certain.
> (2) How do I pass a highmem address to the HCDs?  The URB structures we use
> don't seem particularly well-suited for this.
> 
> Matt
> 
> On Mon, Dec 31, 2001 at 12:51:57PM +0100, Jens Axboe wrote:
> > On Sun, Dec 30 2001, Matthew Dharm wrote:
> > > If it shouldn't be used, it should be removed from the structure to force
> > > people to change.
> > 
> > It will be soonish. Davem has practically finished this already.
> > 
> > > This is probably why usb-storage broke, and it wasn't obvious to me what
> > > went wrong.
> > 
> > It's been discussed here before, both wrt 2.5 and 2.4 with the block
> > highmem patches.
> > 
> > > So now I guess I need to either (a) compute the address for the USB layer,
> > > or (b) figure out how to pass the memory parameters directly, so we can use
> > > highmem.
> > 
> > If you don't set highmem_io in the scsi host structure, then you can
> > always do
> > 
> > 	vaddr = page_address(sg->page) + sg->offset;
> > 
> > -- 
> > Jens Axboe
> > 
> > 
> > _______________________________________________
> > linux-usb-devel@lists.sourceforge.net
> > To unsubscribe, use the last form field at:
> > https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
> 
> -- 
> Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.net 
> Maintainer, Linux USB Mass Storage Driver
> 
> My mother not mind to die for stoppink Windows NT!  She is rememberink 
> Stalin!
> 					-- Pitr
> User Friendly, 9/6/1998
> 


