Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129155AbRCHPA3>; Thu, 8 Mar 2001 10:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRCHPAU>; Thu, 8 Mar 2001 10:00:20 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:61611 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129131AbRCHPAC>;
	Thu, 8 Mar 2001 10:00:02 -0500
Date: Thu, 8 Mar 2001 09:59:35 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Question: fs meta data, page cache and locking
In-Reply-To: <5.0.2.1.2.20010308131755.00a53990@pop.cus.cam.ac.uk>
Message-ID: <Pine.GSO.4.21.0103080952001.7720-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Mar 2001, Anton Altaparmakov reposted:

> >But user space will never see metadata pages anyway, so you
> >should be the only one, who cares about them. Just be prepared to
> >writepage() and readpage() and the like.

ITYM ->prepare_write()/->commit_write().

See ftp.math.psu.edu/pub/viro/ext2-dir-patch-S2.gz for example of
metadata in pagecache. For deeper metadata (== stuff that can
be needed to access with some pages locked, in case of ext2 that
would be indirect blocks, inode/block bitmaps and group descriptors)
you need to set ->gfp_mask of address_space to prohibit IO on
allocation. See drivers/block/loop.c - it has to do the same to
->i_mapping of underlying file.
							Cheers,
								Al

