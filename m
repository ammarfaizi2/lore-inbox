Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265937AbSKBLQX>; Sat, 2 Nov 2002 06:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265938AbSKBLQX>; Sat, 2 Nov 2002 06:16:23 -0500
Received: from kunde0179.tromso.alfanett.no ([62.16.128.179]:44044 "EHLO
	shogun.thule.no") by vger.kernel.org with ESMTP id <S265937AbSKBLQW>;
	Sat, 2 Nov 2002 06:16:22 -0500
From: "Troels Walsted Hansen" <troels@thule.no>
To: "'Andrew Morton'" <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [announce] swap mini-howto
Date: Sat, 2 Nov 2002 12:22:45 +0100
Message-ID: <003401c28262$2d280ac0$0300000a@samurai>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <3DC3207A.450402B3@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Something I'd like to point out here:  in 2.4 and earlier, swapfiles
> are less robust than swap devices - the need to go and read metadata
> from the filesystem made them prone to oom deadlocks allocating pages
> and buffer_heads with which to perform the swapout.
> 
> That has changed in 2.5.  Swapping onto a regular file has no
> disadvantage wrt swapping onto a block device.  The kernel does
> not need to allocate any memory at all to get a swapcache page
> onto disk.
> 
> Which is interesting.  Because swapfiles are much easier to 
> administer,
> and much easier to stripe.  Adding, removing and resizing is 
> simplified.
> Distributors of 2.6-based kernels could consider doing away with
> swapdevs altogether.

Additionally, using a swapfile allows you to share swapspace with other
OSes.

This can be rather handy on a multibooting laptop with a small
harddrive.

I've done this successfully on a laptop multibooting RedHat 8.0 and
Windows XP. The procedure is quite simple:
 - Set up the Windows swapfile on a FAT32 partition, it will preallocate
the file as pagefile.sys (up to the minimum size that you specify).

 - Make sure the FAT32 partition gets mounted in /etc/fstab.

 - mkswap the pagefile.sys file in the Linux bootscripts before
swapfiles are turned on (Windows will trash the Linux swap signature).

 - Fortunately Windows will gladly use a swapfile trashed by Linux, so
there's no need to backup and restore any Windows swapfile headers.

One unfortunate disadvantage is that Windows hibernation to disk cannot
be used, since it assumes the contents of the pagefile are unmodified
when you resume.

Does anyone know if NTFS-TNG in 2.5 is robust enough to mount Windows XP
partitions and allow overwriting of existing files such as pagefile.sys?
If that is the case, the procedure is even easier because you can
eliminate the FAT32 partition and simply mount the main Windows XP
installation partition.

Troels

