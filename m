Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSEUGiB>; Tue, 21 May 2002 02:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316533AbSEUGiB>; Tue, 21 May 2002 02:38:01 -0400
Received: from surf.viawest.net ([216.87.64.26]:10892 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S316532AbSEUGiA>;
	Tue, 21 May 2002 02:38:00 -0400
Date: Mon, 20 May 2002 23:37:57 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.17: hfs no go
Message-ID: <20020521063757.GA16181@wizard.com>
In-Reply-To: <20020521063205.GA16131@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 11:36pm  up  5:37,  2 users,  load average: 0.00, 0.18, 0.35
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 11:32:05PM -0700, A Guy Called Tyketto wrote:
> 
>         subject sez it all:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE 
> -DMODVERSIONS -include /usr/src/linux-2.5.15/include/linux/modversions.h 
> -DKBUILD_BASENAME=trans -c -o trans.o trans.c
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE 
> -DMODVERSIONS -include /usr/src/linux-2.5.15/include/linux/modversions.h 
> -DKBUILD_BASENAME=version -c -o version.o version.c
> ld -m elf_i386 -r -o hfs.o balloc.o bdelete.o bfind.o bins_del.o binsert.o 
> bitmap.o bitops.o bnode.o brec.o btree.o catalog.o dir.o dir_cap.o dir_dbl.o 
> dir_nat.o extent.o file.o file_cap.o file_hdr.o inode.o mdb.o part_tbl.o 
> string.o super.o sysdep.o trans.o version.o
> ld: cannot open inode.o: No such file or directory
> make[2]: Leaving directory `/usr/src/linux-2.5.15/fs/hfs'

        Sorry.. left out the important part. here's the bulk of the compile 
leading to the problem:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.5.15/include/linux/modversions.h 
-DKBUILD_BASENAME=file_hdr -c -o file_hdr.o file_hdr.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.5.15/include/linux/modversions.h 
-DKBUILD_BASENAME=inode -c -o inode.o inode.c
inode.c: In function `hfs_prepare_write':
inode.c:242: dereferencing pointer to incomplete type
gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.5.15/include/linux/modversions.h 
-DKBUILD_BASENAME=mdb -c -o mdb.o mdb.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.5.15/include/linux/modversions.h 
-DKBUILD_BASENAME=part_tbl -c -o part_tbl.o part_tbl.c

.
.
.

gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.5.15/include/linux/modversions.h 
-DKBUILD_BASENAME=sysdep -c -o sysdep.o sysdep.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.5.15/include/linux/modversions.h 
-DKBUILD_BASENAME=trans -c -o trans.o trans.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.5.15/include/linux/modversions.h 
-DKBUILD_BASENAME=version -c -o version.o version.c
ld -m elf_i386 -r -o hfs.o balloc.o bdelete.o bfind.o bins_del.o binsert.o 
bitmap.o bitops.o bnode.o brec.o btree.o catalog.o dir.o dir_cap.o dir_dbl.o 
dir_nat.o extent.o file.o file_cap.o file_hdr.o inode.o mdb.o part_tbl.o 
string.o super.o sysdep.o trans.o version.o
ld: cannot open inode.o: No such file or directory
make[2]: Leaving directory `/usr/src/linux-2.5.15/fs/hfs'

-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

