Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317171AbSG3XIr>; Tue, 30 Jul 2002 19:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317367AbSG3XIr>; Tue, 30 Jul 2002 19:08:47 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:45960 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317171AbSG3XIq>; Tue, 30 Jul 2002 19:08:46 -0400
Date: Tue, 30 Jul 2002 17:12:07 -0600
Message-Id: <200207302312.g6UNC7Z10529@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Greg KH <greg@kroah.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
In-Reply-To: <20020730225359.GA17826@kroah.com>
References: <20020730225359.GA17826@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:
> Hi,
> 
> When devfs came alone, it created devfs_[un]register_chrdev and
> devfs_[un]register_blkdev, which required that all drivers be changed to
> be compatible with devfs. This change has been bothering a lot of people
> for quite some time :)
> 
> These two small changesets (patches to follow this email) fix that
> problem by removing these functions, and having the original
> [un]register_chrdev and [un]register_blkdev ask devfs if the operation
> should be performed _if_ devfs is currently compiled into the kernel.
> No functionality is changed, but the kernel code base is reduced, and we
> are back to a common API.

Your patch misses the reason why I created those functions: some
drivers had to always register with the major table. With your
"fixups", those drivers will break when "devfs=only" is passed in. If
you first fix the drivers so that they work without an entry in the
major table, then your patch is safe to apply.

> Linus, please pull from:
> 	bk://linuxusb.bkbits.net/devfs-2.5

Linus, please don't.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
