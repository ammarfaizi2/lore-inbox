Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268758AbRHBFOK>; Thu, 2 Aug 2001 01:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268763AbRHBFN7>; Thu, 2 Aug 2001 01:13:59 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:28172 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S268758AbRHBFNr>; Thu, 2 Aug 2001 01:13:47 -0400
Date: Wed, 1 Aug 2001 23:13:40 -0600
Message-Id: <200108020513.f725De514057@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFT] Support for ~2144 SCSI discs
In-Reply-To: <3B6755E7.B63FA6D5@torque.net>
In-Reply-To: <200107310030.f6V0UeJ13558@mobilix.ras.ucalgary.ca>
	<rgooch@ras.ucalgary.ca>
	<10107310041.ZM233282@classic.engr.sgi.com>
	<200107311225.f6VCPj003249@mobilix.ras.ucalgary.ca>
	<20010731125926.B10914@us.ibm.com>
	<200108010048.f710miA05150@mobilix.ras.ucalgary.ca>
	<3B6755E7.B63FA6D5@torque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert writes:
> Richard Gooch wrote:
> > 
> > Mike Anderson writes:
> > > In previous experiments trying to connect up to 512 devices we
> > > switched to vmalloc because the static nature of sd.c's allocation
> > > exceeds 128k which I assumed was the max for kmalloc YMMV.
> > 
> > Yes, I figure on switching to vmalloc() and putting in an
> > in_interrupt() test in sd_init() to make sure the vmalloc() is safe.
> > 
> > Eric: do you happen to know why there are these GFP_ATOMIC flags?
> > To my knowledge, nothing calls sd_init() outside of process context.
> 
> I've seen GFP_KERNEL take 10 minutes in lk 2.4.6 . The 
> mm gets tweaked pretty often so it is difficult to know 
> exactly how it will react when memory is tight. A time 
> bound would be useful on GFP_KERNEL.
> 
> <opinion> It is best to find out quickly there is 
> not enough memory and have some alternate strategy 
> to cope with that problem. GFP_KERNEL in its current 
> form should be taken out and shot. </opinion>

Perhaps. But I don't think we should use GFP_ATOMIC just because
GFP_KERNEL might be slow! That's just sweeping the problem under the
carpet. If there are MM problems, then waiting 10 minutes for the SCSI
driver to load might provide encouragement for people to fix the
bloody thing.

In any case, using GFP_ATOMIC just means that it will fail, which is
probably worse than trying hard. Not being able to use my SCSI drive
is pretty disastrous on some of my machines. Also, sd_init() is
usually called very early on in the boot process. If memory is tight
at that point, we have more to worry about.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
