Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268919AbRHBNFG>; Thu, 2 Aug 2001 09:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268924AbRHBNE4>; Thu, 2 Aug 2001 09:04:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31076 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268919AbRHBNEm>; Thu, 2 Aug 2001 09:04:42 -0400
Date: Thu, 2 Aug 2001 15:05:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: jeremy@classic.engr.sgi.com
Subject: o_direct-11 and blkdev-pagecache-8
Message-ID: <20010802150529.A24436@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here the latest release against 2.4.8pre3.

For the blkdev-pagecache I decreased performance going to 1k I/O
granularity to provide total backwards compatibility, otherwise it was
not possible to read the last bytes of the device if the size of the
device was not a multiple of 4k and there's no way to work around that
without intensive changes :(, this in turn means the doing O_DIRECT on
the blkdevice now has a constraint of 1k I/O granularity on the
read/write API (not anymore the more restrictive 4k granularity).

The O_DIRECT patch includes a one liner I got from the GFS folks to
update the i_size of the inode correctly.

They must be applyed in order:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.8pre3/o_direct-11
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.8pre3/blkdev-pagecache-8

Now it would be nice to have a patch incremental to those so that rawio
also uses the preallocated per-file iobuf (note: the preallocation
should happen in the rawio layer, not in the vfs like we just do with
the generic O_DIRECT).

Andrea
