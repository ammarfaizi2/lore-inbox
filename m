Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283876AbSADSwg>; Fri, 4 Jan 2002 13:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288675AbSADSw0>; Fri, 4 Jan 2002 13:52:26 -0500
Received: from smtphost.qualcomm.com ([129.46.64.223]:25299 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S283876AbSADSwW>; Fri, 4 Jan 2002 13:52:22 -0500
Message-Id: <5.1.0.14.0.20020104104826.03a15978@mage.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 04 Jan 2002 10:52:04 -0800
To: CJ <cj@cjcj.com>, Vijay Kumar <jkumar@qualcomm.com>
From: Vijay Kumar <jkumar@qualcomm.com>
Subject: Re: kernel patch support large fat partitions
Cc: Alan.Cox@linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <3C3517FF.20704@cjcj.com>
In-Reply-To: <5.1.0.14.0.20020103152205.039f2008@mage.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using 28bit cluster numbers and 65536 cluster size I could go upto 16TB 
which is lot more than what I wanted. So right now I have no problem with 
the on-disk format of a fat partition. Nevertheless with hard drives prices 
going down dramatically it may not be too long before we hit the limit.

Regards,
- Vijay

At 06:48 PM 1/3/2002 -0800, CJ wrote:
>FAT32 stores 28 bit cluster numbers.  You need to increase cluster size
>instead of the 28 bits to stay FAT32.  The spec is  fatgen102.pdf:, I'll
>mail it to you.
>
>Hardware White Paper Hardware White Paper
>FAT: General Overview of On-Disk Format
>Version 1.02, May 5, 1999
>Microsoft Corporation
>
>Vijay Kumar wrote:
>
>>Alan,
>>
>>This is regarding a change I had to make to the kernel 2.2.17-14 to 
>>support really large drives. In our project we deal with huge drives, 
>>sometimes drives larger than 128GB. The file system is FAT32 and only one 
>>partition is create on any drive. During our testing we realized that 
>>linux fat implementation doesn't support partitions larger than 
>>128GB(actually 64GB because of a bug in fat implementation).
>>
>>This limitation is imposed by the data structures used by the linux fat 
>>implementation to read/write directory entries. A 'long' data type is 
>>used to access directory entries on the disk, of which only 28 bits are 
>>used to identify the sector that contains the directory entry and the 
>>rest 4 bits are used to specify offset of the directory entry inside the 
>>sector. Using 28 bits to identify a sector means we cannot access sectors 
>>beyond 128GB (2^28*512), thus limiting us from creating partitions larger 
>>than 128GB on large disk drives.
>>
>>I have made changes to fat, vfat and msdos file system implementations in 
>>the kernel to use larger data types, thus allowing us to create larger 
>>partitions. As per the GPL I would like to make the patch available to 
>>everyone and also in case somebody has run into the same problem(who 
>>cares about fat in the linux world). The patch has been fairly well 
>>tested only on our systems(p3, 700MHz with FC). I truly appreciate if you 
>>& anybody in the kernel mailing list have any feedback about the changes.
>>
>>The patch is applicable to only 2.2.17-14 kernel and may require changes 
>>to use with other kernel versions. As far as I know none of the kernel 
>>versions provide any fix for this problem.
>>
>>Thanks,
>>- Vijay
>
>
>

