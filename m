Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288466AbSADCtc>; Thu, 3 Jan 2002 21:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288467AbSADCtX>; Thu, 3 Jan 2002 21:49:23 -0500
Received: from conx.aracnet.com ([216.99.200.135]:35297 "HELO cj90.in.cjcj.com")
	by vger.kernel.org with SMTP id <S288466AbSADCtN>;
	Thu, 3 Jan 2002 21:49:13 -0500
Message-ID: <3C3517FF.20704@cjcj.com>
Date: Thu, 03 Jan 2002 18:48:31 -0800
From: CJ <cj@cjcj.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Vijay Kumar <jkumar@qualcomm.com>
CC: Alan.Cox@linux.org, linux-kernel@vger.kernel.org
Subject: Re: kernel patch support large fat partitions
In-Reply-To: <5.1.0.14.0.20020103152205.039f2008@mage.qualcomm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FAT32 stores 28 bit cluster numbers.  You need to increase cluster size
instead of the 28 bits to stay FAT32.  The spec is  fatgen102.pdf:, I'll
mail it to you.

Hardware White Paper Hardware White Paper
FAT: General Overview of On-Disk Format
Version 1.02, May 5, 1999
Microsoft Corporation

Vijay Kumar wrote:

> Alan,
>
> This is regarding a change I had to make to the kernel 2.2.17-14 to 
> support really large drives. In our project we deal with huge drives, 
> sometimes drives larger than 128GB. The file system is FAT32 and only 
> one partition is create on any drive. During our testing we realized 
> that linux fat implementation doesn't support partitions larger than 
> 128GB(actually 64GB because of a bug in fat implementation).
>
> This limitation is imposed by the data structures used by the linux 
> fat implementation to read/write directory entries. A 'long' data type 
> is used to access directory entries on the disk, of which only 28 bits 
> are used to identify the sector that contains the directory entry and 
> the rest 4 bits are used to specify offset of the directory entry 
> inside the sector. Using 28 bits to identify a sector means we cannot 
> access sectors beyond 128GB (2^28*512), thus limiting us from creating 
> partitions larger than 128GB on large disk drives.
>
> I have made changes to fat, vfat and msdos file system implementations 
> in the kernel to use larger data types, thus allowing us to create 
> larger partitions. As per the GPL I would like to make the patch 
> available to everyone and also in case somebody has run into the same 
> problem(who cares about fat in the linux world). The patch has been 
> fairly well tested only on our systems(p3, 700MHz with FC). I truly 
> appreciate if you & anybody in the kernel mailing list have any 
> feedback about the changes.
>
> The patch is applicable to only 2.2.17-14 kernel and may require 
> changes to use with other kernel versions. As far as I know none of 
> the kernel versions provide any fix for this problem.
>
> Thanks,
> - Vijay



