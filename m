Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132570AbQKWHLC>; Thu, 23 Nov 2000 02:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132615AbQKWHKw>; Thu, 23 Nov 2000 02:10:52 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:44023 "EHLO
        webber.adilger.net") by vger.kernel.org with ESMTP
        id <S132570AbQKWHKk>; Thu, 23 Nov 2000 02:10:40 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011230640.eAN6eb223846@webber.adilger.net>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <3A1CB07C.CEE01F1F@haque.net> "from Mohammad A. Haque at Nov 23,
 2000 00:51:56 am"
To: "Mohammad A. Haque" <mhaque@haque.net>
Date: Wed, 22 Nov 2000 23:40:36 -0700 (MST)
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohammad A. Haque writes:
> I just got these while doing many compiles on my box ....
> 
> Nov 23 00:40:06 viper kernel: EXT2-fs warning (device ide0(3,3)):
> ext2_unlink: Deleting nonexistent file (622295), 0
> Nov 23 00:40:06 viper kernel: = 1
> Nov 23 00:40:06 viper kernel: EXT2-fs error (device ide0(3,3)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 540028982,
> count = 1
> Nov 23 00:40:06 viper kernel: EXT2-fs error (device ide0(3,3)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 540024880,
> count = 1
> Nov 23 00:40:06 viper kernel: EXT2-fs error (device ide0(3,3)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 170926128,
> count = 1

I'm not sure where the nonexistent file comes from.  According to the
printf statement, you're trying to unlink a file with no links, so it
would be interesting to see if 622295 is a valid inode number (it
should be, or there would have been more error messages).  Doing

dumpe2fs -h /dev/hda3

may help to find out where this bogus inode came from.

These block numbers decode to ASCII data:

540028982 = 0x20303036 = " 336"
540024880 = 0x20302030 = " 3 3"
170926128 = 0x0a302030 = "\n3 3"


There were problems like this quite a while ago (block numbers that are
really ASCII data)...  I can't recall what the problem turned out to be
at that time.

I would suggest a full fsck to start with (you have probably already
done so).  If you haven't done a full fsck on this filesystem in a long
time, there is a chance the corruption was from the old kernel bug.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
