Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130653AbQKCQzU>; Fri, 3 Nov 2000 11:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130826AbQKCQzK>; Fri, 3 Nov 2000 11:55:10 -0500
Received: from w090.z064003079.san-ca.dsl.cnc.net ([64.3.79.90]:64252 "HELO
	mail.land-5.com") by vger.kernel.org with SMTP id <S130691AbQKCQzC>;
	Fri, 3 Nov 2000 11:55:02 -0500
Date: Fri, 3 Nov 2000 09:53:42 -0800 (PST)
From: jsack <jsack@land-5.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: raid5 2.4-test10: EXT2-fs corruption during sync
Message-ID: <Pine.LNX.4.10.10011030906190.1087-100000@jgs.land-5.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running mke2fs on a raid5 which is still syncing causes a *variety* of
filesystem corruption errors:

(sample errs)
-------------
- ...kernel: EXT2-fs error (device md(9,0)): ext2_check_descriptors:
Block bitmap for group 4 not in group (block 0)!

- e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09 Group descriptors
look bad... trying backup blocks... e2fsck: Bad magic number in
super-block while trying to open /dev/md0

The superblock could not be read

- e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
...Pass 5: Checking group summary information
Padding at end of block bitmap is not set. Fix<y>? yes
--------------
(/sample errs)

Raid operations seem stable after fixing errors or if mke2fs is run after
sync is complete. Delaying mke2fs is not a real workaround, because the
fs corruption also occurs when resyncing (a spare) after a disk failure.


This behaviour has also been seen with test9, but does not occur with 2.2
kernels. Non-exhaustive testing indicates it does not occur with raid1.

Where do I go from here?

..jim

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
