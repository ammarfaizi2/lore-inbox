Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316019AbSEJTMV>; Fri, 10 May 2002 15:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316081AbSEJTMU>; Fri, 10 May 2002 15:12:20 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:51186 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S316019AbSEJTMT>; Fri, 10 May 2002 15:12:19 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15580.7052.396951.568702@wombat.chubb.wattle.id.au>
Date: Sat, 11 May 2002 05:12:12 +1000
To: Jeremy Andrews <jeremy@kerneltrap.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <20020510084713.43ce396e.jeremy@kerneltrap.org>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeremy" == Jeremy Andrews <jeremy@kerneltrap.org> writes:

Jeremy> Peter, Out of curiousity, what then does the new filesystem
Jeremy> limit become, on a 64-bit system?  Will all filesystems
Jeremy> support your changes?

This depends on the file system.
See
	 http://www.gelato.unsw.edu.au/~peterc/lfs.html
(which I'm intending to update next week, after some testing to
check the new limits with my new code -- I found the 1TB limit in
the generic code (someone using a signed int instead of unsigned long))

There are three different limits that apply:

 --- The physical layout on disc (e.g., ext2 uses 32-bit for block
     numbers within a file system; thus the max size is
     (2^32-1)*block_size;  although it's theoretically possible to use
     larger blocksizes, the current toolchain has a maximum of 4k,
     thus the largest size of an ext[23] filesystem is ((2^32)-1)*4k
     bytes --- around 16TB)

     It's extremely unlikely that you'd want to use a non-journalled
     file system on such a large partition, so your best bets are
     reiserfs, jfs or XFS.  jfs and xfs work well on enormous
     partitions on other platforms; the current version of reiserfs is
     somewhat limited, but version 4 will allow larger file systems.


 --- Limitations imposed by the partitioning scheme.
     As far as I know, only the EFI GUID partitioning scheme uses
     64-bit block offsets, so under any other scheme you're limited to
     2^32 or 2^31 blocks per disc; some use the underlying hardware
     sector size, some use a block size that's  multiple of this.

 --- The page cache limit (which on a 32-bit system is 16TB; on a 64
     bit system is 18 EB


Jeremy>   Mind if I quote what you say on my webpage?

Go ahead

--
Peter Chubb
peterc@gelato.unsw.edu.au	http://www.gelato.unsw.edu.au
