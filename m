Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129039AbRAaXjc>; Wed, 31 Jan 2001 18:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129085AbRAaXjX>; Wed, 31 Jan 2001 18:39:23 -0500
Received: from hera.cwi.nl ([192.16.191.8]:65182 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129039AbRAaXjP>;
	Wed, 31 Jan 2001 18:39:15 -0500
Date: Thu, 1 Feb 2001 00:39:12 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Andreas Huppert <Huppert@philosys.de>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: mount dos-partition bug
Message-ID: <20010201003912.A25518@cwi.nl>
In-Reply-To: <3A788CDE.D3D53194@philosys.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A788CDE.D3D53194@philosys.de>; from Huppert@philosys.de on Wed, Jan 31, 2001 at 11:08:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Huppert wrote:

> > I have been trying to mount the dos-partition /dev/hdb1 on /dos/d for
> > three years and it fails:

Yes. It has 805998 data sectors, which require 50374 clusters,
but the fat16 has room only to describe 39168 clusters.
The kernel mount code considers this an error.

You can remove the check in linux/fs/fat/inode.c
and write something like

                error = !sbi->fats || (sbi->dir_entries & (MSDOS_DPS-1))
#if 0
                        || sbi->clusters+2 > fat_clusters+ MSDOS_MAX_EXTRA
#endif
                        || (logical_sector_size & (SECTOR_SIZE-1))
                        || !b->secs_track || !b->heads;

(the current layout is somewhat uglier).
I would expect that afterwards things work.

If you use this under Windows, do you get over 400 MB on this disk?
Or was part of this partition effectively lost?

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
