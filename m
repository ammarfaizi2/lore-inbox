Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSGCK2i>; Wed, 3 Jul 2002 06:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316992AbSGCK2h>; Wed, 3 Jul 2002 06:28:37 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:31763 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316887AbSGCK2g>; Wed, 3 Jul 2002 06:28:36 -0400
Message-Id: <5.1.0.14.2.20020703112759.02291aa0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 03 Jul 2002 11:34:00 +0100
To: Paul Menage <pmenage@ensim.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] Shift BKL into ->statfs()
Cc: Alexander Viro <viro@math.psu.edu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0207030208080.6472-100000@weyl.math.psu.edu>
References: <E17PYtv-0004Fd-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:25 03/07/02, Alexander Viro wrote:
>         2) ext2, shmem, FAT, minix and sysv ->statfs() don't need BKL.
>
>         3) efs and vxfs are read-only.

Just to chime in: NTFS doesn't need BKL either as it is read-only.

Also it uses its own locking, so once read-write is enabled only a minor 
modification will be needed (read mft_ino->i_size under protection of 
mftbmp_lock semaphore) to make it race free without the BKL, too. But no 
need to worry about that change, I will take care of that later...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

