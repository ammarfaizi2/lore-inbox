Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129623AbRBCSGJ>; Sat, 3 Feb 2001 13:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130639AbRBCSF7>; Sat, 3 Feb 2001 13:05:59 -0500
Received: from m1smtpisp03.wanadoo.es ([62.36.220.63]:5613 "EHLO
	smtp.wanadoo.es") by vger.kernel.org with ESMTP id <S129623AbRBCSFv>;
	Sat, 3 Feb 2001 13:05:51 -0500
Message-ID: <3A7C485F.15BC3FF9@wanadoo.es>
Date: Sat, 03 Feb 2001 19:05:19 +0100
From: Javi Roman <javiroman@wanadoo.es>
X-Mailer: Mozilla 4.75 [es] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: low memory
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I don´t know if this is a suitable forum where I must ask this question,
sorry.
I´m attempting develop a install proccess from a PCMCIA memory card in
a 4MB RAM pc.

My problem is the RAM memory, it`s very low for this purpose.
I have the following:

- kernel image (2.2.5-15) : 301 KB (I can`t make it smaller).
- "initrd": 1003 KB. This initrd has a "init" (19KB) program
(similar to init.c from Red Hat) and a "install" (955KB) program
which execute the next programs (this programs are in the PC card):
        - sfdisk.
        - mkswap (swapon).
        - mke2fs ---> this program hang the system.


The situation just before mke2fs execution:

                            Total     Used     Free     Shared
Buffers     Cached

Mem              2740224 2600960 139264 294919 1064960 876544
Swap              17539072     0 17539072
MemTotal     2676 KB
MemFree      136  KB
MemShared 288  KB
Buffers          1040 KB
Cached          856  KB
SwapTotal    17128 KB
SwapFree     17128 KB


"install" program executes "mke2fs /dev/hda1" where /dev/hda1 partition
has 500MB.
So in the step: "Writing inode tables: 6/63" the system hang.


Well, I have found a solution for my problem: 4mb-Laptops-HOWTO
Bruce Richardson says:

1. Find something that will boot in 4mb ram and which can also create
ext2 partitions.
2. Use it to create a swap partition and a small ext2 partition on the
laptop's hard disk.
3. Uncompress the installation root image and copy it onto the ext2
partition.
4. Boot the laptop from the installation boot disk, pointing it at the
ext2 partition on the hard disk.
5. The installation should go more or less as normal from here.


I have done a swap partition and small ext2 partition (mke2fs don't
hang) and I kill "install" (linuxrc)
and when the system attempt change to new root filesytem (the old
filesystem is the ramdisk) the system says:

"kernel panic: VFS : unable to mount root fs on 03:02"

I can see that 03:02 is /dev/hda2 which it's my swap partition,
"/linux/fs/super.c" attempt mount all knows
filesystem, but he dosen't try my /dev/hda1 small ext2 partiton, why?


I have booted the system without initrd and I obtain the same panic.
My small partiton has a /bin/sh program (main.c attempt this
posibility).
But I should obtain other error.

I have booted other system (with whole installation) using my pc card
whithout
initrd and root file system chages correctly.

Somebody can help me?

Sincery: Javi Roman.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
