Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266317AbRGPTNq>; Mon, 16 Jul 2001 15:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbRGPTNg>; Mon, 16 Jul 2001 15:13:36 -0400
Received: from stine.vestdata.no ([195.204.68.10]:35084 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S266317AbRGPTNZ>; Mon, 16 Jul 2001 15:13:25 -0400
Date: Mon, 16 Jul 2001 21:13:08 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Paul Jakma <paulj@alphyra.ie>
Cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010716211308.C14564@vestdata.no>
In-Reply-To: <Pine.LNX.4.33.0107141325460.1063-100000@rossi.itg.ie> <200107161853.f6GIrxdQ002885@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5i
In-Reply-To: <200107161853.f6GIrxdQ002885@webber.adilger.int>; from Andreas Dilger on Mon, Jul 16, 2001 at 12:53:59PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cheers, Andreas
> ---------------
> *) For ext3, you need enough extra space for the superblock, group descriptors,
>    one block and inode bitmap, the first inode table, (and lost+found if
>    you don't want to do extra work deleting lost+found before creating the
>    journal, and re-creating it afterwards).  The output from "dumpe2fs"
>    will tell you the number of inode blocks and group descriptor blocks.
>    For reiserfs it is hard to tell exactly where the file will go, but if
>    you had, say, a 64MB NVRAM device and a new filesystem, you could expect
>    the journal to be put entirely on the NVRAM device.

You can use the LVM tools to see what extents are written the most times
- I'm sure that after having used the filesystem a little bit it will be
clear wich extents hold the journal. (and then you can move them to
NVRAM).

For reiserfs, I believe you can no specify a seperate device for your
journal and don't need lvm. Not sure if this code entered the kernel yet
though - maybe you need a patch.


When doing you testing, you should be aware that the results will be
very much dependent on the device you use for the filesystem. One thing
is that if you use a slow ide-drive, then the NVRAM/disk performance
will be higher than if you used a fast scsi-drive. But more importantly,
if you use a highend RAID, it will include NVRAM of it's own. So if you
really want to know if seperate NVRAM makes sense for you highend
server - don't test this on a regular disk and assume the results will
be the same.




-- 
Ragnar Kjorstad
Big Storage
