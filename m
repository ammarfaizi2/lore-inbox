Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131775AbRCUVCz>; Wed, 21 Mar 2001 16:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131776AbRCUVCp>; Wed, 21 Mar 2001 16:02:45 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:64917 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131775AbRCUVCh>;
	Wed, 21 Mar 2001 16:02:37 -0500
Date: Wed, 21 Mar 2001 16:01:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: James Lewis Nance <jlnance@intrex.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: spinlock usage - ext2_get_block, lru_list_lock
In-Reply-To: <20010321131559.A28454@bessie.dyndns.org>
Message-ID: <Pine.GSO.4.21.0103211513330.739-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Mar 2001, James Lewis Nance wrote:

> On Wed, Mar 21, 2001 at 12:16:47PM -0500, Alexander Viro wrote:
> 
> > Obext2: <plug>
> > Guys, help with testing directories-in-pagecache patch. It works fine
> > here and I would really like it to get serious beating.
> > Patch is on ftp.math.psu.edu/pub/viro/ext2-dir-patch-b-S2.gz (against
> > 2.4.2, but applies to 2.4.3-pre* too).
> > </plug>
> 
> I would love to test this patch, but I really dont want it touching my other
> ext2 file systems (like /).  I assume it would be possible to copy the ext2
> code over to something like linux/fs/extnew, patch that, and then mount my
> scratch partitions as extnew.  I can try an cook something like this up, but
> I thought you might already have it, so I am posting here to see.

cp -a fs/ext{2,69}
cp -a include/linux/ext{2,69}_fs.h
cp -a include/linux/ext{2,69}_fs_i.h
cp -a include/linux/ext{2,69}_fs_sb.h
for i in fs/ext69/* include/linux/ext69*; do
	vi '-cse ext|%s/(ext|EXT)2/\169/g|x' $i;
done
vi '-c/EXT/|y|pu|s/2/69/|s/Second/FUBAR/|x' fs/Config.in
vi '-c/ext2/|y|pu|s/ext2/ext69/g|//|y|pu|&g|//|y|pu|&g|//|y|pu|&g|x' include/linux/fs.h

had done the trick last time I needed something like that, but that was long
time ago...
							Cheers,
									Al

