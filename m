Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272727AbRIIQ7G>; Sun, 9 Sep 2001 12:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272728AbRIIQ64>; Sun, 9 Sep 2001 12:58:56 -0400
Received: from adsl-216-102-162-162.dsl.snfc21.pacbell.net ([216.102.162.162]:41741
	"EHLO janus") by vger.kernel.org with ESMTP id <S272727AbRIIQ6p>;
	Sun, 9 Sep 2001 12:58:45 -0400
Date: Sun, 09 Sep 2001 09:59:05 -800
Content-Type: text/plain; charset=US-ASCII
Subject: Fwd: 2.4.10-pre6 ramdisk driver =?iso-8859-1?q?broken=3F?= won't compile
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Originating-IP: [217.80.154.139]
In-Reply-To: <E15g7jk-0007Rb-00@the-village.bc.nu>
From: Stephan Gutschke <stephan@kernel.gutschke.com>
To: linux-kernel@vger.kernel.org
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Message-Id: <E15g7vG-00053f-00@janus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Stephan Gutschke <stephan@kernel.gutschke.com>
To: Majordomo@vger.kernel.org
Date: Sun, 09 Sep 2001 09:55:14 -800

Hi there,

my kernel stops compiling with this:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.10-pre6/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -
mpreferred-stack-boundary=2 -march=i686    -c -o rd.o rd.c
rd.c: In function `rd_ioctl':
rd.c:262: invalid type argument of `->'
make[3]: *** [rd.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.10-pre6/drivers/block'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.10-pre6/drivers/block'
make[1]: *** [_subdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.10-pre6/drivers'
make: *** [_dir_drivers] Error 2

I checked the patch (patch-2.4.10-pre6) and thought maybe there is 
a "&" missing, where someone changed &inode->... to rd_bdev[... ?
Anyways, i changed it and it seems to compile ;)

@@ -259,7 +259,7 @@
                        /* special: we want to release the ramdisk memory,
                           it's not like with the other blockdevices where
                           this ioctl only flushes away the buffer cache. */
-                       if ((atomic_read(&inode->i_bdev->bd_openers) > 2))
+                       if ((atomic_read(rd_bdev[minor]->bd_openers) > 2))
                                return -EBUSY;
                        destroy_buffers(inode->i_rdev);
                        rd_blocksizes[minor] = 0;



Bye
Stephan

