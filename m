Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVHKF4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVHKF4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 01:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVHKF4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 01:56:12 -0400
Received: from florence.buici.com ([206.124.142.26]:20627 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S964784AbVHKF4L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 01:56:11 -0400
Date: Wed, 10 Aug 2005 22:56:09 -0700
From: Marc Singer <elf@buici.com>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: hirofumi@mail.parknet.co.jp,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: The Linux FAT issue on SD Cards.. maintainer support please
Message-ID: <20050811055609.GA24027@buici.com>
References: <C349E772C72290419567CFD84C26E01709FFF9@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C349E772C72290419567CFD84C26E01709FFF9@mail.esn.co.in>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 10:57:14AM +0530, Mukund JB. wrote:
> Dear all,
> 
> I am Linux driver programmer. 
> 
> I have a FAT12 issue on my SD cards. I have got these addresses from the
> fs-lists as the maintainer support mail IDs for FAT-FS.
> 
> I am using the 2.6.10 kernel, X86 like systems.
> 
> I am NOT able to mount the Camera formatted FAT12 filesystem on my linux
> BOX. SD card is of size 16MB. At the same time I am able to mount the SD
> cards formatted in windows & linux.
> 
> I have identified fat_fill_super() in fs/fat/inode.c file as the
> function that reads the super block of as MS-DOS FS.
> 
> To debug, I have rebuilt my kernel 2.6.10 inserting some debug messages
> in the FS sub-system to know what data is coming into "struct
> fat_boot_sector *b" structure in fs/fat/inode.c file after sb_bread()
> call.
> 
> I believe that this data in the "struct fat_boot_sector *b" should be
> FAT12 information.
> 
> On the camera formatted SD that is NOT mounting I have found this
> structure to be all '0' till total_sectors variable (relevant till here
> on - FAT12).
> 
> Will you please verify if there & tell me if the problem is in the FAT
> sub-system.

Alternatively, you can dump the first block of the device/partition.
>From that, you can determine if there is a partition table.  In any
case, you can read the first block of the partition (or whole device)
and get the filesystem parameter block.

It should be easy from there to determine if the data can be
recognized as FAT.

