Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132465AbRDNAOL>; Fri, 13 Apr 2001 20:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132508AbRDNAOA>; Fri, 13 Apr 2001 20:14:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:58553 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132465AbRDNANx>;
	Fri, 13 Apr 2001 20:13:53 -0400
Date: Fri, 13 Apr 2001 20:13:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org,
        Linus Torvalds <torvalds@transmeta.com>, Linux390@de.ibm.com
Subject: Re: EXPORT_SYMBOL for chrdev_open 2.4.3
In-Reply-To: <20010413173256.A14267@vger.timpanogas.org>
Message-ID: <Pine.GSO.4.21.0104132004320.24992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Apr 2001, Jeff V. Merkey wrote:

> It would be nice if chrdev_open were added to ksyms.c along with
> blkdev_open since tape devices seem are always registered as character
> rather than block devices.  
> 
> I am finding that kernel modules that need to open and close a tape 
> drive have to export chrdev_open manually on 2.4.3.  Can this get 
> exported as well?  Closing is not a problem since the method of 
> calling (->release) seems to work OK with SCSI tape devices.

They don't need it. Moreover, blkdev_open shouldn't be exported too -
the only potentially modular piece of code that refers to it is
drivers/block/rd.c and it's in initrd loading, so it isn't even
compiled when we do rd as a module.

BTW, Linus, could we remove blkdev_open() from the export list?
I don't see any legitimate reason to export it - certainly not in
the official tree.

BTW, fs/partitions/ibm.c also doesn't need blkdev_open() - it should
use ioctl_by_bdev() and be done with that.
							Al

