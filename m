Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281795AbRKQWkk>; Sat, 17 Nov 2001 17:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281045AbRKQWkb>; Sat, 17 Nov 2001 17:40:31 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:18165 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281795AbRKQWkU>;
	Sat, 17 Nov 2001 17:40:20 -0500
Date: Sat, 17 Nov 2001 15:38:08 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andrew Morton <akpm@zip.com.au>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, Brian <hiryuu@envisiongames.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: File server FS?
Message-ID: <20011117153808.U1308@lynx.no>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Theodore Ts'o <tytso@mit.edu>, Brian <hiryuu@envisiongames.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net> <20011113175348.B24864@mikef-linux.matchmail.com> <20011117181253.B5003@kushida.jlokier.co.uk>, <20011117181253.B5003@kushida.jlokier.co.uk> <20011117135542.H21354@mikef-linux.matchmail.com> <3BF6E039.923E0577@zip.com.au> <20011117142326.I21354@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011117142326.I21354@mikef-linux.matchmail.com>; from mfedyk@matchmail.com on Sat, Nov 17, 2001 at 02:23:26PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 17, 2001  14:23 -0800, Mike Fedyk wrote:
> That's what I meant by "as long as the inode number is the same".  Since it
> is a normal file, the only thing ext2resize might overlook would be the
> inode number for the jounal that's kept in the super block.  If, in fact
> ext2resize does decide to change inode numbers for some reason.  I don't
> know if it does. 

ext2resize will only move inodes at the end of the fs, and only if you are
shrinking the fs.  I suppose in some cases (creating a journal on an old
fs) there might be a journal not in the first group, but it is unlikely,
since ext2 will always allocate files in the same group as the parent
(the root inode), so it would always be in the first group, unless you
were out of inodes there (unlikely).  With newer e2fsck's, it also moves
the journal to the reserved inode (#8) so it would remove that problem.

With online resizing (not that it works with ext3 yet, but) since you are
only ever growing the fs, you would also not renumber the inodes.

> Can ext2resize change the block size too?  If the journal is larger than
> 100MB then it would need to be made smaller for 1k blocks 200MB for 2k
> blocks, and left at 400MB for 4k blocks.

No, that is a very difficult problem (especially growing the blocksize,
which is what most people would want to do), because none of the 1kB
blocks would be aligned properly.  You would need to move basically all
of the data in the filesystem, at which point you are far better off to
create a new fs and copy over the data - faster and much less likely to
have any problems.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

