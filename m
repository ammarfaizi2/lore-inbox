Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbSJOF1w>; Tue, 15 Oct 2002 01:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262479AbSJOF1v>; Tue, 15 Oct 2002 01:27:51 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:53497 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262302AbSJOF1v>; Tue, 15 Oct 2002 01:27:51 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 14 Oct 2002 23:31:18 -0600
To: Andrew Morton <akpm@digeo.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021015053118.GA15552@clusterfs.com>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>, tytso@mit.edu,
	linux-kernel@vger.kernel.org
References: <E181IS8-0001DQ-00@snap.thunk.org> <3DAB9DA5.42008138@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAB9DA5.42008138@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 14, 2002  21:46 -0700, Andrew Morton wrote:
> btw, gcc-2.91.66 is saying:
> 
> fs/ext2/xattr.c: In function `ext2_xattr_set':
> fs/ext2/xattr.c:612: warning: `block' might be used uninitialized in this function
> 
> But the code is:
> 
>                 int block = EXT2_I(inode)->i_file_acl;
> 
> which is rather bizarre.  Never seen it do that before.

There's a "goto bad_block" in that function, and it enters _after_
block is set (block is a local variable), so it is impossible for
it to have a valid value.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

