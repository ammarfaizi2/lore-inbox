Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265454AbRF2JCv>; Fri, 29 Jun 2001 05:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265789AbRF2JCb>; Fri, 29 Jun 2001 05:02:31 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:25334 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S265454AbRF2JCU>; Fri, 29 Jun 2001 05:02:20 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200106290902.f5T924Qv014328@webber.adilger.int>
Subject: Re: "Trying to free nonexistent swap-page" error message.
In-Reply-To: <la8zibpur5.fsf@glass.netfonds.no> "from Johan Simon Seland at Jun
 29, 2001 10:15:10 am"
To: Johan Simon Seland <johans@netfonds.no>
Date: Fri, 29 Jun 2001 03:02:03 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Seland
> One one of our Linux Oracle servers the following messages has started
> to appear : 
> 
> Jun 29 07:16:32 blanco kernel: swap_free: Trying to free nonexistent swap-page
> Jun 29 07:16:32 blanco kernel: swap_free: Trying to free nonexistent swap-page
> 
> I also find some of these:
> 
> Jun 29 06:25:01 blanco kernel: EXT2-fs error (device sd(8,10)): ext2_readdir: bad entry in directory #172258: rec_len %% 4 != 0 - offset=192, inode=812610409, rec_len=11833, name_len=115
> Jun 29 06:25:32 blanco kernel: EXT2-fs error (device sd(8,10)): ext2_readdir: bad entry in directory #172258: rec_len %% 4 != 0 - offset=192, inode=812610409, rec_len=11833, name_len=115
> 
> Machine is a 2x933MhZ P3 with 2GB of memory. Kernel version is now
> 2.2.19, but the same problem appeared with 2.2.18 as well.

My first guess would be some sort of hardware/software problem with your
SCSI controller, cables, disk, etc.  I'm not sure about the swap problem,
but the ext2 problems are caused by corruption of the disk or memory.

It is not just a single-bit error either, because rec_len % 4 != 0 AND it
is larger than a page size, so the value is totally bogus, as is the inode
number.  Interestingly, converting the above ext2 numbers into ascii gives:

0x69 0x73 0x6f 0x30 0x39 0x2e 0x73 => iso09.s

(in the order they are layed out in ext2_dir_entry_2).  Coincidence or bug?
I would suggest a full fsck for the filesystem, as it is likely that there
are other problems.

Now when you say "servers" do you mean you have the same problem on
multiple machines?  Are they identical, or different?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
