Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266706AbRHBRBb>; Thu, 2 Aug 2001 13:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266723AbRHBRBW>; Thu, 2 Aug 2001 13:01:22 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:40207 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S266673AbRHBRBC>; Thu, 2 Aug 2001 13:01:02 -0400
Date: Thu, 2 Aug 2001 11:00:14 -0600
Message-Id: <200108021700.f72H0E119628@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: adilger@turbolinux.com (Andreas Dilger), linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [RFT] #2 Support for ~2144 SCSI discs
In-Reply-To: <E15SLQQ-00011K-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15SLQQ-00011K-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > That said, in 2.5 I want to see us move away from using device numbers
> > as the fundamental device handle and move to device instance
> > structures. That's a lot cleaner, and BTW is devfs-neutral
> > (i.e. doesn't need devfs to work). Exposing a 32 bit dev_t to
> > user-space is acceptable, but internally it should be shunned.
> 
> You need it internally otherwise you are screwed the moment you have
> 65536 volumes mounted - because you run out of unique device
> identifiers for stat.

I consider that "external" use. The kernel doesn't need it, it just
provides unique numbers for user-space. The kernel just happens to
carry along the information so that user-space can get it as needed.

Aside: the idea of mounting >65536 volumes frightens me. Accidentally
do a "df" and go away for a coffee while your machine hammers away.

> Fortunately 32bit dev_t (not kdev_t .. which I think is what you are
> talking about and will I assume go pointer to struct) is only one
> syscall change

Looks like we agree. And as long as you have <65536 volumes, then
libc5 will continue to work just fine. Which is also good.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
