Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131630AbQLPLUI>; Sat, 16 Dec 2000 06:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131380AbQLPLT7>; Sat, 16 Dec 2000 06:19:59 -0500
Received: from baghira.han.de ([212.63.63.2]:63236 "EHLO baghira.han.de")
	by vger.kernel.org with ESMTP id <S131636AbQLPLTs>;
	Sat, 16 Dec 2000 06:19:48 -0500
Message-ID: <20001216113152.A24440@ichabod.han.de>
Date: Sat, 16 Dec 2000 11:31:52 +0100
From: Michail Brzitwa <michail@brzitwa.de>
To: linux-kernel@vger.kernel.org
Subject: test12 & raid0 -> fs corruption?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using plain test12, an ide raid0 configuration and raidtools 0.90 I
found that within at most one hour of normal work my /dev/md0 (ext2)
suffered from the same sort of corruption mentioned here for some
test12-pre versions.

The setup: two IBM ide disks (UDMA 100) connected to a Promise PDC20265
on an Asus A7V. Both disks contained the same partitioning: one swap
(same priority on both disks) and one autoraid partition, mkraid'ed to
a raid0 /dev/md0. The ide disk accesses itself were ok, I ran several
bonnie -s 500 before copying real data, moreover there were no swap
errors at any time (bonnies block read speed reached 70MB/s btw).

After moving my whole /usr and /home dirs to md0, rebooting and doing
some editing and compiling I suddenly noticed my .viminfo and .newsrc
containing small parts of a mail folder file (not sure how much but
<= 4k anyway). Several files in /var/log were corrupted as well.

The mail folder file in question hasn't been accessed since the last
reboot so parts of it shouldn't have been in the buffer cache. After
a reboot and another half an hour or so the same sort of file corruption
happened again, this time binary data. On both occasions there were no
kernel complaints, both times an fsck of /dev/md0 found no errors.

I then deleted md0 and put /usr into one former autoraid partitions
and /home into the other. No corruption since then. I can provide more
information if necessary.
-- 
Michail Brzitwa           <michail@brzitwa.de>            +49-511-343215
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
