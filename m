Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293527AbSCATAN>; Fri, 1 Mar 2002 14:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293601AbSCATAI>; Fri, 1 Mar 2002 14:00:08 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:39664 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S293527AbSCAS77>;
	Fri, 1 Mar 2002 13:59:59 -0500
Date: Fri, 1 Mar 2002 11:59:32 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Wayne Whitney <whitney@math.berkeley.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: Re: [OOPS 2.5.5-dj2] ext3 BUG in do_get_write_access()
Message-ID: <20020301115932.T22608@lynx.adilger.int>
Mail-Followup-To: Wayne Whitney <whitney@math.berkeley.edu>,
	LKML <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44.0202281703130.4893-100000@mf1.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0202281703130.4893-100000@mf1.private>; from whitney@math.berkeley.edu on Thu, Feb 28, 2002 at 05:19:44PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 28, 2002  17:19 -0800, Wayne Whitney wrote:
> I managed to generate the oops below on 2.5.5-dj2 by doing the following:
>   cp -ax / /mnt &
>   <some delay, don't know if it matters>
>   tune2fs -L root /dev/hdc5 
> 
> tune2fs -L should be safe on a mounted filesystem, non?

Maybe.  It used to be that the superblock was not journaled, but I think
that recently changed.  This means that if tune2fs modified the superblock
and then a transaction also tried to modify it, the superblock would be
dirty and not part of a transaction, so an assertion would trigger.

It may be that we need to add journaled ioctls to ext3 to change the data
fields in the superblock, or find some other way to do this safely (maybe
Jeff Garzik's ext3meta filesystem to just read/write the "label" file?).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

