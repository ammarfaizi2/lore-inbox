Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292666AbSC0UHV>; Wed, 27 Mar 2002 15:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292971AbSC0UHL>; Wed, 27 Mar 2002 15:07:11 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:51717
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292666AbSC0UHD>; Wed, 27 Mar 2002 15:07:03 -0500
Date: Wed, 27 Mar 2002 12:06:42 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: linux-kernel@vger.kernel.org,
        Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re: [PATCH] linux-2.5.7.fix2.patch
In-Reply-To: <5.1.0.14.2.20020327154219.05069c30@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.10.10203271205450.3389-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DRAT!

That means something else has changed beyound the code base because that
is almost a copy of what runs perfect in 2.4.

Lemme look again.

Cheer,

On Wed, 27 Mar 2002, Anton Altaparmakov wrote:

> Hi Andre,
> 
> I tried this patch on my laptop to see if it would make my atapi cdrom data 
> underrun problems go away.
> 
> Unfortunately booting 2.5.7 + your patch causes hda: lost interrupt 
> messages to appear. It still manages to progress through the boot scripts 
> ok for a while, albeit very, very slowly, but eventually after several lost 
> interrupt messages the kernel crashes.
> 
> Vanilla 2.5.7 boots fine but the cdrom doesn't work due to the data/buffer 
> underruns...
> 
> I am quite happy to help debug this, let me know what info you would like 
> to see... Can I enable debugging somewhere to get more interesting messages 
> or should I try anything?
> 
> Cheers,
> 
> Anton
> 
> At 22:53 23/03/02, Andre Hedrick wrote:
> 
> >Martin et al.
> >
> >This is the next step in stablizing the transport layer.
> >I have not booted but it will compile, and it is nearly identical to what
> >I generated for 2.4 to be released soon.
> >
> >The comments are harsh on the interface but it functionally correct.
> >If you get an device error in PIO, bad things can happen to the data.
> >This is no different in the stock 2.4.0->2.4.18->19x.
> >
> >Of of all the transport data handlers.
> >
> >CLEAN and SAFE:
> >         DMA read/write is safe and has always been.
> >         Single sector PIO WRITING is clean and safe.
> >
> >DIRTY but operational (error events in the hardware will cause data problems)
> >         Single sector PIO READING can corrupt a single sector if there
> >                 is a device error.
> >         Multi-Read/Write will corrupt and misreport data only on an error.
> >
> >What is still lacking in block is the much needed in proccess bio walker.
> >Once I can finish coding this fix into BLOCK, then I can complete the
> >transport layer and slap it on a bus analyzer and force articial errors on
> >the buss to see if the driver behaves correctly.  If this passes, we are
> >good to run like the wind.
> >
> >Regards,
> >
> >Andre Hedrick
> >LAD Storage Consulting Group
> 
> -- 
>    "I've not lost my mind. It's backed up on tape somewhere." - Unknown
> -- 
> Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
> ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
> 

Andre Hedrick
LAD Storage Consulting Group

