Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291780AbSCDGQY>; Mon, 4 Mar 2002 01:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291787AbSCDGQO>; Mon, 4 Mar 2002 01:16:14 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:7668 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S291780AbSCDGP6>;
	Mon, 4 Mar 2002 01:15:58 -0500
Date: Sun, 3 Mar 2002 23:14:42 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Daniel Phillips <phillips@bonn-fries.net>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] delayed disk block allocation
Message-ID: <20020303231442.M4188@lynx.adilger.int>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au> <E16hhuI-0000S6-00@starship.berlin> <20020304050450.GF353@matchmail.com> <20020303223103.J4188@lynx.adilger.int> <20020304054025.GH353@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020304054025.GH353@matchmail.com>; from mfedyk@matchmail.com on Sun, Mar 03, 2002 at 09:40:25PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 03, 2002  21:40 -0800, Mike Fedyk wrote:
> On Sun, Mar 03, 2002 at 10:31:03PM -0700, Andreas Dilger wrote:
> > Actually, there are a whole bunch of performance issues with 1kB block
> > ext2 filesystems.  For very small files, you are probably better off
> > to have tails in EAs stored with the inode, or with other tails/EAs in
> > a shared block.  We discussed this on ext2-devel a few months ago, and
> > while the current ext2 EA design is totally unsuitable for that, it
> > isn't impossible to fix.
> 
> Do you think it'll look like block tails (like ffs?) or will it be more like
> tail packing in reiserfs?

It will be like tail packing in reiserfs, I believe.  FFS has fixed-sized
'fragments' while reiserfs has arbitrary-sized 'tails'.  The ext2 tail
packing will be arbitrary-sized tails, stored as an extended attribute
(along with any other EAs that this inode has.  With proper EA design,
you can share multiple inode's EAs in the same block.  We also discussed
for very small files that you could store the tail (or other EA data)
within the inode itself.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

