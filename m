Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317413AbSFCQ2T>; Mon, 3 Jun 2002 12:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317415AbSFCQ2S>; Mon, 3 Jun 2002 12:28:18 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:45045 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317413AbSFCQ2R>; Mon, 3 Jun 2002 12:28:17 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 3 Jun 2002 10:26:30 -0600
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Alexander Viro <aviro@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] iput() cleanup (was Re: [patch 12/16] fix race between writeback and unlink)
Message-ID: <20020603162630.GC7905@turbolinux.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Andrew Morton <akpm@zip.com.au>, Alexander Viro <aviro@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CF91E48.C76B34FA@zip.com.au> <Pine.LNX.4.44.0206022119300.1030-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 02, 2002  21:27 -0700, Linus Torvalds wrote:
> This is a first cut at cleaning up "iput()" and getting rid of some of the
> magic VFS-level behaviour of the i_nlink field which many filesystems do
> not actually want - as shown by the number of "force_delete" users out
> there.
> 
> It does not change any real behaviour, but it splits up the "iput()"
> behaviour into several functions ("common_delete_inode()",
> "common_forget_inode()" and "common_drop_inode()"), and adds a place for a
> low-level filesystem to hook into the behaviour at inode drop time,
> through the "drop_inode" superblock operation.

If I had one minor note it would be to rename "common_*()" to "generic_*()"
to match the other VFS helper routines.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

