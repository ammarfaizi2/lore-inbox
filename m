Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbRBVXkx>; Thu, 22 Feb 2001 18:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129310AbRBVXko>; Thu, 22 Feb 2001 18:40:44 -0500
Received: from mail.valinux.com ([198.186.202.175]:20755 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129211AbRBVXkg>;
	Thu, 22 Feb 2001 18:40:36 -0500
To: adilger@turbolinux.com
CC: phillips@innominate.de, Linux-kernel@vger.kernel.org,
        adilger@turbolinux.com, hch@ns.caldera.de,
        ext2-devel@lists.sourceforge.net, viro@math.psu.edu
In-Reply-To: <200102221816.f1MIGWt04170@webber.adilger.net> (message from
	Andreas Dilger on Thu, 22 Feb 2001 11:16:32 -0700 (MST))
Subject: Re: [Ext2-devel] [rfc] Near-constant time directory index for Ext2
From: tytso@valinux.com
Phone: (781) 391-3464
In-Reply-To: <200102221816.f1MIGWt04170@webber.adilger.net>
Message-Id: <E14W5La-0008Bc-00@beefcake.hdqt.valinux.com>
Date: Thu, 22 Feb 2001 15:40:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andreas Dilger <adilger@turbolinux.com>
   Date: Thu, 22 Feb 2001 11:16:32 -0700 (MST)

   One important question as to the disk format is whether the "." and ".."
   interception by VFS is a new phenomenon in 2.4 or if this also happened
   in 2.2?  If so, then having these entries on disk will be important
   for 2.2 compatibility, and you don't want to have different on-disk formats
   between 2.2 and 2.4.

Well, you need to have the '.' and '..' there for compatibility if you
for the full backwards compatibility.   That's clear.

If you don't care about backwards compatibility, it's important that
there be a way to find the parent directory, but there doesn't have to
be explicit '.' and '..'  entries.

So if Daniel is going to try implementing it both ways then that's one
place where the #ifdef's might get a bit more complicated.  After it's
done, we should do some benchmarks comparing it both ways; if the
difference is negligible, I'd argue for simply always providing
backwards compatibility.  One of the key advantages of ext2/ext3 is its
backwards compatibility, and so if it's not too costly to preserve it
(as I suspect will be the case), we should try to do so.

						- Ted
