Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291041AbSBRSir>; Mon, 18 Feb 2002 13:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287769AbSBRSav>; Mon, 18 Feb 2002 13:30:51 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:25562 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S290595AbSBRR4u>; Mon, 18 Feb 2002 12:56:50 -0500
Date: Mon, 18 Feb 2002 10:56:46 -0700
Message-Id: <200202181756.g1IHukh32273@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Carsten Otte" <COTTE@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux-2.417 devfs 64bit portablility issue
In-Reply-To: <OF88983DCC.7DF28A38-ONC1256B64.0036063F@de.ibm.com>
In-Reply-To: <OF88983DCC.7DF28A38-ONC1256B64.0036063F@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Otte writes:
> 
> Hi Richard!
> 
> >BTW: please don't send attachments. Send patches inline instead.
> Sorry for sending the patch as attachment, but Notes messes
> up whitespace so the patch would'nt apply if I include it directly.
> 
> >Sorry, but I find your approach grotesque. Apart from basic warts such
> >as not declaring code+data as __init, the approach of populating the
> >bitfield from yet another list doesn't appeal to me. I'd much rather
> >see an approach which preserved the initialisation using bitmasks.
>
> I do not think this patch is very nice either & it does not work at
> all (the initialisation of the array is only called in error case).

Now you've confused me. Your patch seems to unconditionally initialise
the bitfields at startup. I didn't see logic for restricting that
initialisation to an error path.

> I find the overall thing for registering/deregistering devices &
> allocating majors very inconsistent.
> devfs_alloc_major and devfs_register_*dev do hold the information
> about which majors are allocated in two different places without
> knowing about each other (bdops field and this private bitfield).
> A good solution would be if *dev_register would never return a major
> being statically allocated when called with major 0. If this is the
> case, I do not see what alloc_major and dealloc_major are useful
> for.

Except that devfs_register_???dev() (which are in fact minor
variations on the register_???dev() calls) *do not* avoid assigned
majors. That is why I wrote devfs_alloc_major() in the first place.

And while I do think that register_???dev() should in fact do just
what devfs_alloc_major() does, that's not a battle I care to fight. By
writing devfs_alloc_major(), this functionality is optional, and I can
avoid a whole pile of stupid flaming.

Hey, hey! It looks like vger is sending emails again!

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
