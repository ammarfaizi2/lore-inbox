Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288427AbSADAev>; Thu, 3 Jan 2002 19:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288424AbSADAel>; Thu, 3 Jan 2002 19:34:41 -0500
Received: from smtphost.qualcomm.com ([129.46.64.124]:24523 "EHLO
	strange.qualcomm.com") by vger.kernel.org with ESMTP
	id <S288425AbSADAec>; Thu, 3 Jan 2002 19:34:32 -0500
Message-Id: <5.1.0.14.0.20020103162736.039f9c50@mage.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 03 Jan 2002 16:34:21 -0800
To: Andreas Dilger <adilger@turbolabs.com>, Vijay Kumar <jkumar@qualcomm.com>
From: Vijay Kumar <jkumar@qualcomm.com>
Subject: Re: kernel patch support large fat partitions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020103172436.I12868@lynx.no>
In-Reply-To: <5.1.0.14.0.20020103152205.039f2008@mage.qualcomm.com>
 <5.1.0.14.0.20020103152205.039f2008@mage.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:24 PM 1/3/2002 -0700, Andreas Dilger wrote:
>On Jan 03, 2002  15:42 -0800, Vijay Kumar wrote:
> > This limitation is imposed by the data structures used by the linux fat
> > implementation to read/write directory entries. A 'long' data type is used
> > to access directory entries on the disk, of which only 28 bits are used to
> > identify the sector that contains the directory entry and the rest 4 bits
> > are used to specify offset of the directory entry inside the sector. Using
> > 28 bits to identify a sector means we cannot access sectors beyond 128GB
> > (2^28*512), thus limiting us from creating partitions larger than 128GB on
> > large disk drives.
>
>Some minor notes on your patch:
>1) It appears you are running an editor with 4-space tabs, and as a result
>    it has broken the indentation of some of your changes.  This is easily
>    seen when looking at the patch.

Well, I could fix it with little effort.

>2) It is almost certainly wrong to use "loff_t" for an inode number.  Maybe
>    you could use "u64" instead?  I also think that using "long long"
>    explicitly is frowned upon.

I guess its using u64 verses using loff_t. I have chosen the later because 
its actually an offset. For fat implementations inode number is nothing but 
offset of the directory entry on the disk. So I thought it makes more sense 
to use loff_t.

> > I have made changes to fat, vfat and msdos file system implementations in
> > the kernel to use larger data types, thus allowing us to create larger
> > partitions. As per the GPL I would like to make the patch available to
> > everyone and also in case somebody has run into the same problem(who cares
> > about fat in the linux world). The patch has been fairly well tested only
> > on our systems(p3, 700MHz with FC). I truly appreciate if you & anybody in
> > the kernel mailing list have any feedback about the changes.
>
>Does this change the on-disk format for FAT at all, or is it merely a
>kernel filesystem code issue?  I think only the latter, but best to check.

Doesn't change on disk format, only fixes implementation.

Thanks,
- Vijay

>Cheers, Andreas
>--
>Andreas Dilger
>http://sourceforge.net/projects/ext2resize/
>http://www-mddsp.enel.ucalgary.ca/People/adilger/

