Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316471AbSEOSyb>; Wed, 15 May 2002 14:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316472AbSEOSya>; Wed, 15 May 2002 14:54:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38662 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316471AbSEOSya>; Wed, 15 May 2002 14:54:30 -0400
Date: Wed, 15 May 2002 19:54:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for initrd breakage in 2.5.13+
Message-ID: <20020515195421.C28997@flint.arm.linux.org.uk>
In-Reply-To: <200205151653.g4FGrV702962@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 12:53:31PM -0400, James Bottomley wrote:
> initrd was completely broken by your change set 1.447.69.4 ([PATCH] (4/6) 
> blksize_size[] removal).  As part of this change, you completely divorced the 
> ramdisk from the setup parameter rd_blocksize, so it now has the default 512 
> byte block size and thus initrd fails to mount.

Al has a far nicer patch for this, which works for me.  Al?

 Date:	Mon, 6 May 2002 03:03:04 -0400 (EDT)
 From:	Alexander Viro <viro@math.psu.edu>
 To:	Linus Torvalds <torvalds@transmeta.com>
 cc:	linux-kernel@vger.kernel.org
 Subject: [PATCH] rd.c blocksize fix

(fallout from blksize_size[] removal)

rd.c depends on exact value of blocksize being set from the very
beginning.

--- drivers/block/rd.c	Fri May  3 03:26:05 2002
+++ /tmp/rd.c	Mon May  6 03:00:00 2002
@@ -376,6 +376,7 @@
 		rd_bdev[unit] = bdget(kdev_t_to_nr(inode->i_rdev));
 		rd_bdev[unit]->bd_openers++;
 		rd_bdev[unit]->bd_inode->i_mapping->a_ops = &ramdisk_aops;
+		rd_bdev[unit]->bd_block_size = rd_blocksize;
 	}
 
 	return 0;

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

