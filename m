Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129768AbRBAItz>; Thu, 1 Feb 2001 03:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129414AbRBAItg>; Thu, 1 Feb 2001 03:49:36 -0500
Received: from 13dyn174.delft.casema.net ([212.64.76.174]:9232 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129768AbRBAItY>; Thu, 1 Feb 2001 03:49:24 -0500
Message-Id: <200102010848.JAA05529@cave.bitwizard.nl>
Subject: Re: mount dos-partition bug
In-Reply-To: <20010201003912.A25518@cwi.nl> from Andries Brouwer at "Feb 1, 2001
 00:39:12 am"
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Date: Thu, 1 Feb 2001 09:48:45 +0100 (MET)
CC: Andreas Huppert <Huppert@philosys.de>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> Andreas Huppert wrote:
> 
> > > I have been trying to mount the dos-partition /dev/hdb1 on /dos/d for
> > > three years and it fails:
> 
> Yes. It has 805998 data sectors, which require 50374 clusters,
> but the fat16 has room only to describe 39168 clusters.
> The kernel mount code considers this an error.
> 
> You can remove the check in linux/fs/fat/inode.c
> and write something like
> 
>                 error = !sbi->fats || (sbi->dir_entries & (MSDOS_DPS-1))
> #if 0
>                         || sbi->clusters+2 > fat_clusters+ MSDOS_MAX_EXTRA
> #endif
>                         || (logical_sector_size & (SECTOR_SIZE-1))
>                         || !b->secs_track || !b->heads;
> 
> (the current layout is somewhat uglier).
> I would expect that afterwards things work.
> 
> If you use this under Windows, do you get over 400 MB on this disk?
> Or was part of this partition effectively lost?

I'd expect that IF you try to use more than 39k clusters, your
filesystem will be toast. Even if Windows doesn't have the "sanity
check" that Linux has.

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
