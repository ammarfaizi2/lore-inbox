Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315546AbSFKBHW>; Mon, 10 Jun 2002 21:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSFKBHV>; Mon, 10 Jun 2002 21:07:21 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:46829 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S315546AbSFKBHU>; Mon, 10 Jun 2002 21:07:20 -0400
From: brendanburns@attbi.com
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: compiling hfs module in 2.5.21
Date: Tue, 11 Jun 2002 01:05:32 +0000
X-Mailer: AT&T Message Center Version 1 (Apr 29 2002)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NextPart_Webmail_9m3u9jl4l_23256_1023757532"
Message-Id: <20020611010535.IEDK11426.rwcrmhc51.attbi.com@rwcrwbc55>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NextPart_Webmail_9m3u9jl4l_23256_1023757532
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hello,
I ran into a problem compiling the hfs (hierarchical file
system) as a module in kernel 2.5.21. I'm running gcc
version 2.95.4 20011002 (Debian prerelease) on a x86. 
The error message from gcc is:
  gcc -Wp,-MD,.inode.o.d -D__KERNEL__
-I/usr/src/linux-2.5.21/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686 -nostdinc
-iwithprefix include -DMODULE -include
/usr/src/linux-2.5.21/include/linux/modversions.h  
-DKBUILD_BASENAME=inode   -c -o inode.o inode.c
inode.c: In function `hfs_prepare_write':
inode.c:242: dereferencing pointer to incomplete type
make[3]: *** [inode.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.21/fs/hfs'
make[2]: *** [_subdir_hfs] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.21/fs'
make[1]: *** [fs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.21'
make: *** [modules] Error 2

My solution is to add #include <linux/mm.h> to
fs/hfs/inode.c, a patch to do this is attached.

Thanks!
--brendan

--NextPart_Webmail_9m3u9jl4l_23256_1023757532
Content-Type: application/octet-stream; name="inode-header.patch"
Content-Transfer-Encoding: 7bit

--- a/fs/hfs/inode.c	Thu Jun  6 18:15:07 2002
+++ b/fs/hfs/inode.c	Thu Jun  6 18:13:13 2002
@@ -17,6 +17,7 @@
  */
 
 #include "hfs.h"
+#include <linux/mm.h>
 #include <linux/hfs_fs_sb.h>
 #include <linux/hfs_fs_i.h>
 #include <linux/hfs_fs.h>

--NextPart_Webmail_9m3u9jl4l_23256_1023757532--
