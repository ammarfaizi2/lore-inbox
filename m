Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287913AbSABTcA>; Wed, 2 Jan 2002 14:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287919AbSABTby>; Wed, 2 Jan 2002 14:31:54 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:26577 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S287913AbSABTbp>; Wed, 2 Jan 2002 14:31:45 -0500
Date: Wed, 2 Jan 2002 12:31:01 -0700
Message-Id: <200201021931.g02JV1R27294@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: nahshon@actcom.co.il, linux-kernel@vger.kernel.org
Subject: Re: SCSI host numbers?
In-Reply-To: <E16LjdE-0003m4-00@the-village.bc.nu>
In-Reply-To: <200201020119.g021JoK32730@lmail.actcom.co.il>
	<E16LjdE-0003m4-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > Under some scenarios Linux assigns the same
> > host_no to more than one scsi device.
> > 
> > Can someone tell me what is the intended behavior?
> 
> A number should never be reissued.
> 
> > The problem is that a newly registered device gets
> > its host_no from max_scsi_host. max_scsi_host is
> > decremented when a device driver is unregistered
> > (see drivers/scsi/host.c) allowing a second new
> > host to reuse the same host_no.
> 
> I guess it needs to either only decrement the count if we are the
> highest one (trivial hack) or scan for a free number/keep a free
> bitmap. The devfs code has a handy little unique_id function for
> that

Yeah, I was going to get around to submitting a patch to change the
SCSI host allocation code to use devfs_alloc_unique_number(), but
right now that function is only functional if CONFIG_DEVFS_FS=y
(otherwise you get a stub function which returns -1). So really this
should be turned into a generic function, which was my plan all along,
but I didn't want to fight that battle back then. Now that it's in
the tree, I can look at doing this.

Comments? Got a suggestion for which file the generic function should
go into? I figure on stripping the leading "devfs_" part of the
function names.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
