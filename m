Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281772AbSABJ16>; Wed, 2 Jan 2002 04:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282511AbSABJ1q>; Wed, 2 Jan 2002 04:27:46 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:35953 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S281772AbSABJ1b>; Wed, 2 Jan 2002 04:27:31 -0500
Date: Wed, 2 Jan 2002 10:27:11 +0100 (MET)
From: <Oliver.Neukum@lrz.uni-muenchen.de>
X-X-Sender: <ui222bq@sun2.lrz-muenchen.de>
To: David Brownell <david-b@pacbell.net>
cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>,
        <linux-usb-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: highmem and usb [was:"sr: unalignedtransfer" in 2.5.2-pre1]
In-Reply-To: <06df01c1934f$ee4e68a0$6800000a@brownell.org>
Message-Id: <Pine.SOL.4.33.0201021018550.4555-100000@sun2.lrz-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I presume there is some overhead in bouncing to lowmem?  I imagine that
> > highmem support for the HCDs wouldn't be that difficult -- they are just
> > PCI devices, after all.
>
> I'm unclear on what "bouncing to lowmem" involves, but I'd rather avoid
> teaching all three HCDs a second model for addressing transfer buffers.

AFAIK bouncing means a plain, physical copy.
Either the HCDs can do 64bit DMA or they can't.
Do you really expect there to be a significant number of 32bit machines
whose HCD can do 64bit DMA ?
If not, it's IMHO not worth doing it as you'd have either two kinds of
urbs or overhead in the common case.

On 64Bit machines we might have to deal with HCDs who can do 32Bit DMA
only. Perhaps there should be a gfp field in the usb_device struct
to export knowledge about the memory the HCD can cope with.

> > I'd rather eliminate as much overhead as possible -- I already get
> > complaints from performance fanatics about the inability of usb-storage to
> > get past 92% bus saturation (sustained), and the problem will only get
> > worse on USB 2.0
>
> Well then you'll  be glad to see a patch from me, soonish, that teaches
> the usb-storage "transport" code to use bulk queueing.  That'll get the
> bandwidth utilization up as high as it can get.  It won't address any of
> these highmem issues though.

And there's the overhead of sleeping and waking a kernel thread. Larger io
requests might help, but I am not sure.

	Regards
		Oliver


