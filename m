Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbSJPRCL>; Wed, 16 Oct 2002 13:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbSJPRCK>; Wed, 16 Oct 2002 13:02:10 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:6132 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S265246AbSJPRCJ>; Wed, 16 Oct 2002 13:02:09 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 16 Oct 2002 11:05:39 -0600
To: "Theodore Ts'o" <tytso@mit.edu>,
       "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Add extended attributes to ext2/3
Message-ID: <20021016170539.GA1201@clusterfs.com>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Henning P. Schmiedehausen" <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
References: <E181a3S-0006Nq-00@snap.thunk.org> <aojc1q$l37$1@forge.intermeta.de> <20021016161620.GC8210@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016161620.GC8210@think.thunk.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 16, 2002  12:16 -0400, Theodore Ts'o wrote:
> We do have one place where the 512 byte sector count is used, and
> that's in inode->i_blocks, which is stored as 512 byte sectors,
> regardless of the blocksize.  *That's* due to st_blocks in the stat
> structure being returned in 512 byte sectors, and for no other good
> reason.  As a result of this particular bit of history, ext2
> filesystems are limited to 2TB, even when using a 4k blocksize.
> Without this bit of "design history", we'd be able to support 16TB
> filesystems with 2.6's CONFIG_LBD support, without needing to going to
> a 64-bit block numbers.  Making this change is actually pretty easy,
> and I may try to get that change to Linus before 2.6 closes.

Err, wouldn't that be a 2TB FILE limit, and not a FILESYSTEM limit?

Also, this limit only applies for allocated space within the file and
not the total size of the file (for sparse files).  However, I don't
thing we have any checking in the kernel to ensure we don't overflow
2^32 allocated blocks for a single file (probably needs to be done in
ext*_alloc_block() or similar to ensure we have less than or equal to
"2^32 - (sb->blocksize >> 9)" blocks allocated to a file.  I don't
know if we still have the old "limit total file size to 2TB" check
in there still.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

