Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286750AbSAFBog>; Sat, 5 Jan 2002 20:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286759AbSAFBo1>; Sat, 5 Jan 2002 20:44:27 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:58786 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S286750AbSAFBoR>; Sat, 5 Jan 2002 20:44:17 -0500
Date: Sat, 5 Jan 2002 18:44:09 -0700
Message-Id: <200201060144.g061i9E09115@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: nahshon@actcom.co.il
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: SCSI host numbers?
In-Reply-To: <200201022335.g02NZaj10253@lmail.actcom.co.il>
In-Reply-To: <E16LjdE-0003m4-00@the-village.bc.nu>
	<200201022335.g02NZaj10253@lmail.actcom.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itai Nahshon writes:
> On Wednesday 02 January 2002 01:32 pm, Alan Cox wrote:
> > > Under some scenarios Linux assigns the same
> > > host_no to more than one scsi device.
> > >
> > > Can someone tell me what is the intended behavior?
> >
> > A number should never be reissued.
> >
> > > The problem is that a newly registered device gets
> > > its host_no from max_scsi_host. max_scsi_host is
> > > decremented when a device driver is unregistered
> > > (see drivers/scsi/host.c) allowing a second new
> > > host to reuse the same host_no.
> >
> > I guess it needs to either only decrement the count if we are the highest
> 
> I'll argue that it should never decrement. The host that was just
> unregisrtered already has its host_id reserved and if we decrement,
> this number will be reasigned to the next new scsi host.
> 
> Unless if the code for reservation that causes the conflicts
> is removed (but I guess it has a reason).
> 
> > one (trivial hack) or scan for a free number/keep a free bitmap. The devfs
> > code has a handy little unique_id function for that
> 
> That would not solve it. The problem is that one piece of code
> tries to allocate unique numbers (and get them back to the pool
> when they are not in use), another piece of code remembers the
> old number that a scsi host had and whan it re-registers gives
> it back its old host_no regardless if this number was re-assigned
> to a new host.

Where exactly is the host_id for an unregistered host being
remembered?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
