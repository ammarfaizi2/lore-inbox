Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132387AbQL2Vfr>; Fri, 29 Dec 2000 16:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132384AbQL2Vfg>; Fri, 29 Dec 2000 16:35:36 -0500
Received: from [195.84.105.112] ([195.84.105.112]:63498 "HELO
	petrus.schuldei.org") by vger.kernel.org with SMTP
	id <S132383AbQL2Vfb>; Fri, 29 Dec 2000 16:35:31 -0500
Date: Fri, 29 Dec 2000 22:08:20 +0100
From: Andreas Schuldei <andreas@schuldei.org>
Cc: linux-kernel@vger.kernel.org
Subject: ext2's inode i_version gone, what now? (stable branch)
Message-ID: <20001229220820.C28926@sigrid.schuldei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to use the Steganographic filesystem stegfs on top of a 2.2.18 kernel,
while the stegfs patch was against 2.2.14. The patch applied allmost clean,
but that was easy to fix. 

However a real problem (for me) is that the author (whom I can not reach by
email) build stegfs on top of the ext2 filesystem. There he uses ext2's inode
structure and at some places reads/writes from ext2 inode's i_version.
However, this is not there in ext2_fs_i.h. But I am working with source for
2.2.18 and a lot could have happend since 2.2.14. I would not have expected
the inode struct to change, though.

Why was it taken away? How is compatibility maintained? What could I use 
instead to fix the problem?

Anyone who is interested in this:
http://ban.joh.cam.ac.uk/~adm36/StegFS/download.html

the error happens at 
make[3]: Entering directory `/usr/src/linux/fs/stegfs'
cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686   -c -o inode.o inode.c
inode.c: In function `stegfs_read_inode':
inode.c:1376: structure has no member named `i_version'
inode.c: In function `stegfs_update_inode':
inode.c:1785: structure has no member named `i_version'

please cc me, I am not on this list.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
