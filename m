Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290376AbSAPHD6>; Wed, 16 Jan 2002 02:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290375AbSAPHDr>; Wed, 16 Jan 2002 02:03:47 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:42432 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S290376AbSAPHDf>; Wed, 16 Jan 2002 02:03:35 -0500
Date: Wed, 16 Jan 2002 00:03:28 -0700
Message-Id: <200201160703.g0G73Sr27779@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: nahshon@actcom.co.il
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: SCSI host numbers?
In-Reply-To: <200201151219.g0FCJUD15091@lmail.actcom.co.il>
In-Reply-To: <E16LjdE-0003m4-00@the-village.bc.nu>
	<200201132041.g0DKfeg30866@lmail.actcom.co.il>
	<200201140636.g0E6a4b16527@vindaloo.ras.ucalgary.ca>
	<200201151219.g0FCJUD15091@lmail.actcom.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itai Nahshon writes:
> On Monday 14 January 2002 08:36 am, Richard Gooch wrote:
> > So how about in scsi_host_no_init() we call alloc_unique_number() N
> > times until we've allocated the required number of host numbers for
> > manual control. These will never be freed. Then all other host
> > allocations can be done dynamically. We would just need a flag in the
> > host structure to disable deallocation of the number if it's one of
> > the reserved numbers.
> 
> See that dynamic hosts are also added to the list and *never* removed
> from it (even when the host is unregistered). With that behaviour your
> unique number functions would be an overkill because we must never
> free host nubers.
> 
> I suggest these changes:
>     max_scsi_host initialized in scsi_host_no_init.
>     max_scsi_host never decremented.
> That would fix the problem that I reported.

But if you load, unload and reload a host driver, and it's not listed
in scsihosts=, then won't it get a different host number each time?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
