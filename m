Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288592AbSADKfN>; Fri, 4 Jan 2002 05:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288589AbSADKfF>; Fri, 4 Jan 2002 05:35:05 -0500
Received: from [213.38.169.194] ([213.38.169.194]:50959 "EHLO
	proxy.herefordshire.gov.uk") by vger.kernel.org with ESMTP
	id <S288587AbSADKez>; Fri, 4 Jan 2002 05:34:55 -0500
Message-ID: <AFE36742FF57D411862500508BDE8DD001995305@mail.herefordshire.gov.uk>
From: "Randal, Phil" <prandal@herefordshire.gov.uk>
To: linux-kernel@vger.kernel.org
Subject: RE: kernel patch support large fat partitions
Date: Fri, 4 Jan 2002 10:40:49 -0000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is now up to Version 1.03

  http://www.microsoft.com/hwdev/hardware/fatgen.asp

Phil

---------------------------------------------
Phil Randal
Network Engineer
Herefordshire Council
Hereford, UK 

> -----Original Message-----
> From: CJ [mailto:cj@cjcj.com]
> Sent: 04 January 2002 02:49
> To: Vijay Kumar
> Cc: Alan.Cox@linux.org; linux-kernel@vger.kernel.org
> Subject: Re: kernel patch support large fat partitions
> 
> 
> FAT32 stores 28 bit cluster numbers.  You need to increase 
> cluster size
> instead of the 28 bits to stay FAT32.  The spec is  
> fatgen102.pdf:, I'll
> mail it to you.
> 
> Hardware White Paper Hardware White Paper
> FAT: General Overview of On-Disk Format
> Version 1.02, May 5, 1999
> Microsoft Corporation
> 
> Vijay Kumar wrote:
> 
> > Alan,
> >
> > This is regarding a change I had to make to the kernel 2.2.17-14 to 
> > support really large drives. In our project we deal with 
> huge drives, 
> > sometimes drives larger than 128GB. The file system is 
> FAT32 and only 
> > one partition is create on any drive. During our testing we 
> realized 
> > that linux fat implementation doesn't support partitions 
> larger than 
> > 128GB(actually 64GB because of a bug in fat implementation).
> >
> > This limitation is imposed by the data structures used by the linux 
> > fat implementation to read/write directory entries. A 
> 'long' data type 
> > is used to access directory entries on the disk, of which 
> only 28 bits 
> > are used to identify the sector that contains the directory 
> entry and 
> > the rest 4 bits are used to specify offset of the directory entry 
> > inside the sector. Using 28 bits to identify a sector means 
> we cannot 
> > access sectors beyond 128GB (2^28*512), thus limiting us 
> from creating 
> > partitions larger than 128GB on large disk drives.
> >
> > I have made changes to fat, vfat and msdos file system 
> implementations 
> > in the kernel to use larger data types, thus allowing us to create 
> > larger partitions. As per the GPL I would like to make the patch 
> > available to everyone and also in case somebody has run 
> into the same 
> > problem(who cares about fat in the linux world). The patch has been 
> > fairly well tested only on our systems(p3, 700MHz with FC). I truly 
> > appreciate if you & anybody in the kernel mailing list have any 
> > feedback about the changes.
> >
> > The patch is applicable to only 2.2.17-14 kernel and may require 
> > changes to use with other kernel versions. As far as I know none of 
> > the kernel versions provide any fix for this problem.
> >
> > Thanks,
> > - Vijay
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
