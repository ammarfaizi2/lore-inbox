Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269009AbRHBPPV>; Thu, 2 Aug 2001 11:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269005AbRHBPPL>; Thu, 2 Aug 2001 11:15:11 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:15375 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269001AbRHBPPE>; Thu, 2 Aug 2001 11:15:04 -0400
Date: Thu, 2 Aug 2001 09:03:41 -0600
Message-Id: <200108021503.f72F3fN18632@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Karcaw <Karcaw@rocketmail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFT] Support for ~2144 SCSI discs
In-Reply-To: <20010802140639.24652.qmail@web12503.mail.yahoo.com>
In-Reply-To: <200107310030.f6V0UeJ13558@mobilix.ras.ucalgary.ca>
	<20010802140639.24652.qmail@web12503.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karcaw@rocketmail.com writes:
> I am pleased to see this, I recently expanded the majors number
> range on my system from 8 majors to 32 by just pushing the secondary
> range from 65-71 to 65-95, This solution Stomped on other majors,
> COMPAQ SMART array and IDE6-9, etc. I did not think this was a
> viable solution to the mainstream kernel so I have only been using
> it here.  I am glad someone with more experience is fixing this one.
> I am currently working with linux on a the HP VA7100 that can
> support up to 1024 LUNS (limited by fibre Channel HBAs to 256 or
> 128) on a single device, so I am using up disks very quickly with
> only 128 availible.

Yeah, you're not the only one. I've fielded questions from various
people along the lines of "why does Linux only see the first 128
SDs?".

> One questions I have on the patch:
> -in drivers/char/sysrq.c:is_local_disk(...) references the SCSI major
> numbers, should it change for this patch?

It's not essential. The is_local_disk() function is used to first sync
standard local discs and then "experimental" block devices. So the
extra SDs will get synced regardless. I also note that is_local_disk()
doesn't yet know about extra IDE discs either. Oh, well.

> I wrote a patch for the Scsi Generic Driver that uses devfs to
> extend the numbers of genric devices beyond the 256 minor limit.  It
> will use as many major/minor numbers that it can get from devfs for
> generic scsi drivers.  it can be found on the official sg web site
> at: http://gear.torque.net/sg/ as an experimental driver(sg3120df).

Yes, Doug talked to me about it at OLS. Unfortunately you've added
another search loop in a BH handler. Not your fault, really, since the
SCSI midlayer doesn't have a pointer from the SCSI request structure
to the upper-level driver instance structure. I urged Doug to send in
a patch to Linus that does this.

BTW: if you're going to use my patch, use the second draft I sent out
last night. The first one didn't quite work :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
