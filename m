Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131829AbRCZPmc>; Mon, 26 Mar 2001 10:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131845AbRCZPmX>; Mon, 26 Mar 2001 10:42:23 -0500
Received: from mail4.one.net ([206.112.192.132]:7036 "EHLO mail4.one.net")
	by vger.kernel.org with ESMTP id <S131829AbRCZPmM>;
	Mon, 26 Mar 2001 10:42:12 -0500
Date: Mon, 26 Mar 2001 10:40:19 -0500
To: linux-kernel@vger.kernel.org
Subject: ext2 corruption in 2.4.2, scsi only system
Message-ID: <20010326104019.A30975@clifton-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Dale E Martin <dmartin@cliftonlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  I've got a dual PPro machine running 2.4.2, and Debian (stable + a
little bit of "testing".)  This machine is heavily loaded about 3/4 of the
time, doing a daily regression test on a project we're working on.
Bascially, the machine runs g++ about 18 hours a day on machine generated
code.

With 2.2.17 the machine would have process hangs after a couple of days -
this was repeatable.  (specifically g++ would start hanging, even compiling
"hello world".) 

I had had good luck with 2.4.x on other boxes, so I put it on this machine
as well.  Several times now I've seen ext2 corruption with no other
noteworthy logs.  


The last time we saw this after no other kernel messages:
Mar 23 18:40:02 woodlawn kernel: EXT2-fs error (device sd(8,6)):
ext2_free_blocks: Freeing blocks in system zones - Block = 655552, count = 1
Mar 23 19:18:33 woodlawn kernel: EXT2-fs error (device sd(8,6)):
ext2_new_block: Allocating block in system zone - block = 655552
Mar 24 18:40:04 woodlawn kernel: EXT2-fs error (device sd(8,6)):
ext2_free_blocks: Freeing blocks in system zones - Block = 655552, count = 1
Mar 24 19:07:22 woodlawn kernel: EXT2-fs error (device sd(8,6)):
ext2_new_block: Allocating block in system zone - block = 655552
Mar 25 16:45:01 woodlawn kernel: EXT2-fs error (device sd(8,1)):
ext2_free_blocks: bit already cleared for block 460146
Mar 25 16:45:01 woodlawn kernel: Remounting filesystem read-only
Mar 25 18:40:03 woodlawn kernel: EXT2-fs error (device sd(8,6)):
ext2_free_blocks: Freeing blocks in system zones - Block = 655552, count = 1

On the boot prior, we saw this:
Mar  8 11:34:08 woodlawn kernel: EXT2-fs error (device sd(8,6)):ext2_free_blocks: Freeing blocks in system zones - Block = 720946, count = 1
Mar  8 13:10:53 woodlawn kernel: EXT2-fs error (device sd(8,6)):ext2_new_block:
 Allocating block in system zone - block = 720946
Mar  8 13:13:49 woodlawn kernel: EXT2-fs error (device sd(8,6)): ext2_free_block
s: Freeing blocks in system zones - Block = 720946, count = 1
Mar  8 15:32:52 woodlawn kernel: EXT2-fs error (device sd(8,6)): ext2_new_block:
 Allocating block in system zone - block = 720946
Mar  8 15:35:20 woodlawn kernel: EXT2-fs error (device sd(8,6)): ext2_free_block
s: Freeing blocks in system zones - Block = 720946, count = 1
Mar  9 06:26:07 woodlawn kernel: init_special_inode: bogus imode (52171)
Mar  9 06:26:07 woodlawn kernel: init_special_inode: bogus imode (30564)
Mar  9 06:26:07 woodlawn kernel: init_special_inode: bogus imode (51522)
Mar  9 06:26:07 woodlawn kernel: init_special_inode: bogus imode (71400)
Mar  9 06:26:07 woodlawn kernel: init_special_inode: bogus imode (70072)
Mar  9 06:26:07 woodlawn kernel: init_special_inode: bogus imode (72163)
Mar  9 06:26:07 woodlawn kernel: init_special_inode: bogus imode (57522)
Mar  9 06:26:07 woodlawn kernel: init_special_inode: bogus imode (30062)
Mar  9 06:26:07 woodlawn kernel: init_special_inode: bogus imode (31137)
Mar  9 06:26:07 woodlawn kernel: init_special_inode: bogus imode (30532)
Mar  9 06:26:07 woodlawn kernel: init_special_inode: bogus imode (0)
Mar  9 06:26:07 woodlawn kernel: init_special_inode: bogus imode (0)
Mar  9 06:26:07 woodlawn kernel: init_special_inode: bogus imode (71563)

At that point, there were some large and not easily removed files that
appeared on the filesystem in question.

The machine is a dual PPro, it has a Buslogic BT958 with a single 9G
scsi/wide drive in it.  There aren't any logs related to physical disk
problems.  If the machine starts doing this again, I'll take a look in
/proc/scsi/Buslogic and see if it's showing any errors in there.

Thanks for any help, and please let me know if I need to supply any other
info.  I guess the only other thing I can think of is the kernel is
compiled with gcc 2.95.2, which I realize is considered "slightly risky" or
so....

Thanks,
	Dale
-- 
Dale E. Martin, Clifton Labs, Inc.
Senior Computer Engineer
dmartin@cliftonlabs.com
http://www.cliftonlabs.com
pgp key available
