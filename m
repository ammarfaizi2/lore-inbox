Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293035AbSCJN3W>; Sun, 10 Mar 2002 08:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293036AbSCJN3N>; Sun, 10 Mar 2002 08:29:13 -0500
Received: from 99dyn73.com21.casema.net ([62.234.30.73]:52137 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S293035AbSCJN3C>; Sun, 10 Mar 2002 08:29:02 -0500
Message-Id: <200203101328.OAA15987@cave.bitwizard.nl>
Subject: RAID superblock....
To: mingo@redhat.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Date: Sun, 10 Mar 2002 14:28:57 +0100 (MET)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice1: This Email contains my Email address. This grants you the right
X-notice2: to communicate with me using this address, related to the subject
X-notice3: in this message. Unsollicitated mass-mailings are explictly 
X-notice4: forbidden here, and by Dutch law. 
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The MD code I see doing: 


488         sb_offset = calc_dev_sboffset(rdev->dev, rdev->mddev, 1);
489         rdev->sb_offset = sb_offset;
490         fsync_dev(dev);
491         set_blocksize (dev, MD_SB_BYTES);
492         bh = bread (dev, sb_offset / MD_SB_BLOCKS, MD_SB_BYTES);


where sb_offset is calculated as: 

290         if (blk_size[MAJOR(dev)])
291                 size = blk_size[MAJOR(dev)][MINOR(dev)];

Now, for aguments sake, I have a 4k disk. I'd expect the size to be 4
(1k blocks, according to the comment near the definition of blk_size). 

Thus the "bread" would effectively try to read the block at offset 4k. 

That would be past the end of my mini-disk, right?

I would have expected a "-1" in there somewhere, to get the last block
of the dev, and not the block just past the end of the drive.

Anyway on the old machine, I still cannot find the raid superblock by
hand, but the drives now mount, so the kernel must have been able to
locate them somehow......

The machine is still running 2.4.16 + IDE patches for 48 bit
addressing.

The working machine is an 850MHz PIII w/384Mb RAM, the non-working
machine is an AMD 1800+ MP w/1G RAM (with another one of those
processors sitting idle close by)...

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
