Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVHKPdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVHKPdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVHKPdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:33:36 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:62896 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751093AbVHKPdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:33:36 -0400
Date: Thu, 11 Aug 2005 11:33:35 -0400
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: hirofumi@mail.parknet.co.jp,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: The Linux FAT issue on SD Cards.. maintainer support please
Message-ID: <20050811153335.GI31019@csclub.uwaterloo.ca>
References: <C349E772C72290419567CFD84C26E01709FFF9@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C349E772C72290419567CFD84C26E01709FFF9@mail.esn.co.in>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 10:57:14AM +0530, Mukund JB. wrote:
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

A few things I would try:

Stick the SD card in a generic cheap USB media reader, and see what the
kernel thinks of the cards then.  Do both work?

If the answer is still no, then it really seems the card is formated
incorrectly, or linux has a bug in the fat driver.

If both work fine that way, then there is a problem in the driver for
the sd reader you are using that needs to be resolved.

Using a known to work for people in general driver (usb-storage) with
a standard usb card reader sure does seem like a good start until you
know if the card is formated properly or not.

You could also use that do dd the first few blocks from the card to see
what the partition table and fat tables look like, in case your SD
driver is somehow messing that part up.  By having a copy you can
compare more easily.

Len Sorensen
