Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132698AbRDNBaY>; Fri, 13 Apr 2001 21:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132701AbRDNBaO>; Fri, 13 Apr 2001 21:30:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17575 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132698AbRDNB37>;
	Fri, 13 Apr 2001 21:29:59 -0400
Date: Fri, 13 Apr 2001 21:29:43 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org,
        Linus Torvalds <torvalds@transmeta.com>, Linux390@de.ibm.com
Subject: Re: EXPORT_SYMBOL for chrdev_open 2.4.3
In-Reply-To: <20010413183810.A14604@vger.timpanogas.org>
Message-ID: <Pine.GSO.4.21.0104132125180.24992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Apr 2001, Jeff V. Merkey wrote:

> How are folks supposed to open disk and tape devices from kernel modules
> without these?  Not everything should be done in user space Al.  If you 

Normally - filp_open(). If all you want is ioctl on block device -
blkdev_get() + ioctl_by_bdev() + blkdev_put(). If you want it by
device _number_ - use bdget().

> remove blkdev_open I will not be able to properly increment the use 
> count an a disk device I may be reading or writing to.  

	Yes, you will. And I would _really_ advice you to do that by
name instead of device number - that way you will avoid a lot of pain
couple of years down the road.

