Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270741AbRHNSwd>; Tue, 14 Aug 2001 14:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270705AbRHNSwP>; Tue, 14 Aug 2001 14:52:15 -0400
Received: from [212.18.191.178] ([212.18.191.178]:45576 "EHLO smtp.netc.pt")
	by vger.kernel.org with ESMTP id <S270733AbRHNSwH>;
	Tue, 14 Aug 2001 14:52:07 -0400
From: Paulo Andre <baggio@netc.pt>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Problem with 2.4.9-pre3 and FAT/msdos fs
Date: Tue, 14 Aug 2001 16:36:40 +0100
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
Cc: Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Message-Id: <01081416364000.05770@nirvana.local.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Noticed these non-critical errors when attempting to compile 2.4.9-pre3 on
top of 2.4.9 vanilla. Both when compiling the image and the modules. It still
compiled fine and didn't notice anything going wrong... yet. Here's the
output:

...
make bzImage
....

make -C fat
make[2]: Entering directory `/usr/src/linux/fs/fat'
make all_targets
make[3]: Entering directory `/usr/src/linux/fs/fat'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686    -c -o buffer.o buffer.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686    -c -o cache.o cache.c
cache.c: In function `default_fat_access':
cache.c:57: warning: implicit declaration of function `fat_bread'
cache.c:57: warning: assignment makes pointer from integer without a cast
cache.c:64: warning: assignment makes pointer from integer without a cast
cache.c:65: warning: implicit declaration of function `fat_brelse'
cache.c:107: warning: implicit declaration of function
 `fat_mark_buffer_dirty' cache.c:113: warning: assignment makes pointer from
 integer without a cast cache.c:116: warning: assignment makes pointer from
 integer without a cast gcc -D__KERNEL__ -I/usr/src/linux/include -Wall
 -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686    -c -o dir.o dir.c
dir.c: In function `fat_dir_ioctl':
dir.c:656: warning: passing arg 4 of `fat_readdirx' from incompatible pointer
type
dir.c:665: warning: passing arg 4 of `fat_readdirx' from incompatible pointer
type
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686    -c -o file.o file.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686    -c -o inode.o inode.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686    -c -o misc.o misc.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686    -c -o cvf.o cvf.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c
fatfs_syms.c
rm -f fat.o
ld -m elf_i386  -r -o fat.o buffer.o cache.o dir.o file.o inode.o misc.o
cvf.o fatfs_syms.o
make[3]: Leaving directory `/usr/src/linux/fs/fat'
make[2]: Leaving directory `/usr/src/linux/fs/fat'

...
make modules
...

make -C msdos modules
make[2]: Entering directory `/usr/src/linux/fs/msdos'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o namei.o
namei.cnamei.c: In function `msdos_lookup':
namei.c:237: warning: implicit declaration of function `fat_brelse'
namei.c: In function `msdos_add_entry':
namei.c:266: warning: implicit declaration of function
 `fat_mark_buffer_dirty' gcc -D__KERNEL__ -I/usr/src/linux/include -Wall
 -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -DEXPORT_SYMTAB -c
msdosfs_syms.c
rm -f msdos.o
ld -m elf_i386  -r -o msdos.o namei.o msdosfs_syms.o
make[2]: Leaving directory `/usr/src/linux/fs/msdos'
make -C nls modules
make[2]: Entering directory `/usr/src/linux/fs/nls'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/usr/src/linux/fs/nls'
make -C umsdos modules
make[2]: Entering directory `/usr/src/linux/fs/umsdos'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o dir.o dir.c
dir.c: In function `umsdos_readdir_x':
dir.c:142: warning: passing arg 3 of `fat_readdir' from incompatible pointer
type
dir.c: In function `UMSDOS_readdir':
dir.c:315: warning: passing arg 5 of `umsdos_readdir_x' from incompatible
pointer type
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o inode.o
inode.cgcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o ioctl.o
ioctl.cioctl.c: In function `UMSDOS_ioctl_dir':
ioctl.c:146: warning: passing arg 3 of `fat_readdir' from incompatible
pointer type
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o mangle.o
mangle.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o namei.o
namei.cgcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o rdir.o rdir.c
rdir.c: In function `UMSDOS_rreaddir':
rdir.c:70: warning: passing arg 3 of `fat_readdir' from incompatible pointer
type
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o emd.o emd.c
rm -f umsdos.o
ld -m elf_i386  -r -o umsdos.o dir.o inode.o ioctl.o mangle.o namei.o rdir.o
emd.o
make[2]: Leaving directory `/usr/src/linux/fs/umsdos'
make[1]: Leaving directory `/usr/src/linux/fs'


Cheers,

// Paulo Andre'
