Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288420AbSADAZB>; Thu, 3 Jan 2002 19:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288421AbSADAYv>; Thu, 3 Jan 2002 19:24:51 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:31225 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S288420AbSADAYq>;
	Thu, 3 Jan 2002 19:24:46 -0500
Date: Thu, 3 Jan 2002 17:24:36 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Vijay Kumar <jkumar@qualcomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel patch support large fat partitions
Message-ID: <20020103172436.I12868@lynx.no>
Mail-Followup-To: Vijay Kumar <jkumar@qualcomm.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.0.20020103152205.039f2008@mage.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <5.1.0.14.0.20020103152205.039f2008@mage.qualcomm.com>; from jkumar@qualcomm.com on Thu, Jan 03, 2002 at 03:42:20PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 03, 2002  15:42 -0800, Vijay Kumar wrote:
> This limitation is imposed by the data structures used by the linux fat 
> implementation to read/write directory entries. A 'long' data type is used 
> to access directory entries on the disk, of which only 28 bits are used to 
> identify the sector that contains the directory entry and the rest 4 bits 
> are used to specify offset of the directory entry inside the sector. Using 
> 28 bits to identify a sector means we cannot access sectors beyond 128GB 
> (2^28*512), thus limiting us from creating partitions larger than 128GB on 
> large disk drives.

Some minor notes on your patch:
1) It appears you are running an editor with 4-space tabs, and as a result
   it has broken the indentation of some of your changes.  This is easily
   seen when looking at the patch.
2) It is almost certainly wrong to use "loff_t" for an inode number.  Maybe
   you could use "u64" instead?  I also think that using "long long"
   explicitly is frowned upon.

> I have made changes to fat, vfat and msdos file system implementations in 
> the kernel to use larger data types, thus allowing us to create larger 
> partitions. As per the GPL I would like to make the patch available to 
> everyone and also in case somebody has run into the same problem(who cares 
> about fat in the linux world). The patch has been fairly well tested only 
> on our systems(p3, 700MHz with FC). I truly appreciate if you & anybody in 
> the kernel mailing list have any feedback about the changes.

Does this change the on-disk format for FAT at all, or is it merely a
kernel filesystem code issue?  I think only the latter, but best to check.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

