Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281773AbRLAWHZ>; Sat, 1 Dec 2001 17:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281893AbRLAWHQ>; Sat, 1 Dec 2001 17:07:16 -0500
Received: from adsl-63-193-243-214.dsl.snfc21.pacbell.net ([63.193.243.214]:55936
	"EHLO dmz.ruault.com") by vger.kernel.org with ESMTP
	id <S281773AbRLAWHE>; Sat, 1 Dec 2001 17:07:04 -0500
Message-ID: <3C0954D5.6AA3532B@ruault.com>
Date: Sat, 01 Dec 2001 14:08:21 -0800
From: Charles-Edouard Ruault <ce@ruault.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: File system Corruption with 2.4.16
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

i've experienced very weird behaviour with kernel 2.4.16 ( on at least 2
different machines with different motherboards & CPUs ).
I'm having ext2 filesystem problems on both machines now, one is totally
unusable i need to reinstall it from scratch.
I've noticed the problem on different points :
- first lots of problems with symlinks ....
 unable to compile the kernel for example it bails out with "too many
symlinks levels" ,

/usr/include/asm/pgtable.h:109:33:
/usr/src/linux/include/asm/pgtable-2level.h: Too many levels of symbolic
links
In file included from /usr/src/linux/include/linux/pagemap.h:16,
                 from /usr/src/linux/include/linux/locks.h:8,
                 from /usr/src/linux/include/linux/devfs_fs_kernel.h:6,
                 from init/main.c:16:

and then looking in /usr/src/linux i saw this :
/usr/src/linux/include/asm -> asm

i tried to recreate the link :

 ln -s asm-i386 asm
 ls -l asm
lrwxrwxrwx    1 root     root            3 Dec  1 10:54 asm -> asm

which is really weird .....
then i did rm -f asm
strace  ln -s asm-i386 asm
and then ends shows :
stat64("asm", 0xbffff950)               = -1 ENOENT (No such file or
directory)
lstat64("asm", 0xbffff8e0)              = -1 ENOENT (No such file or
directory)
lstat64("asm", 0xbffff8e0)              = -1 ENOENT (No such file or
directory)
symlink("asm-i386", "asm")              = 0
_exit(0)                                = ?

but ls -l asm shows again :
lrwxrwxrwx    1 root     root            3 Dec  1 10:55 asm -> asm


- second : i had my mailserver running on one of the boxes and i stoped
receiving mails about 2 days ago, looking a the logs i found this on all
the incoming messages :
fB1IY3801640: SYSERR(root): cannot rename(./tffB1IY3801640,
./qffB1IY3801640), uid=0: No such file or directory
in my mailqueue dir all the tXX files where there, i renamed them to
qXXX and sendmail was able to process them.


I backtracked to kernel 2.4.14 and now after doing an fsck on all my
partitions ( only one problem reported on /home ) , everything is back
to normal.

I've read that there was a filesystem problem in 2.4.15 that is supposed
to be fixed in 2.4.16.
These 2 machines did run 2.4.15 from it's birtday until 2.4.16 was born
so maybe the problem was created in 2.4.15 but showed up in 2.4.16 ...
If someone has an explanation to this behaviour, i would be really happy
....

Charles-Edouard Ruault


