Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263302AbREWWVp>; Wed, 23 May 2001 18:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263294AbREWWVf>; Wed, 23 May 2001 18:21:35 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33529 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263295AbREWWVZ>;
	Wed, 23 May 2001 18:21:25 -0400
Date: Wed, 23 May 2001 18:21:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Maciek Nowacki <maciek@Voyager.powersurfr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Busy on BLKFLSBUF w/initrd
In-Reply-To: <20010523161149.A701@Voyager.powersurfr.com>
Message-ID: <Pine.GSO.4.21.0105231813490.20269-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 May 2001, Maciek Nowacki wrote:

> > If you want to keep it until later (i.e. want to destiry it by hands)
> > mkdir /initrd on your final root and old one will be remounted there.
> > Again, "Trying to unmount old root ... okay" means that it already got
> > an equivalent of BKLFLSBUF
> 
> Ah, okay.. I assumed this behavior had been removed. I will try this as well.

change_root() in 2.4.4 gives you explicit destroy_buffers(). In 2.4.5-pre5
it simply does BLKFLSBUF - calls ioctl_by_bdev(). And BLKFLSBUF boils
down to destroy_buffers().

I would really like to hear details re survival of the initrd contents.
I've looked at the way rd.c "protects" the data and it seems to be
b0rken - playing games with igrab() is not a good idea for driver...

