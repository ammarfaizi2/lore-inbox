Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270797AbRHSVXo>; Sun, 19 Aug 2001 17:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270708AbRHSVXY>; Sun, 19 Aug 2001 17:23:24 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:8508 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S270676AbRHSVXS>; Sun, 19 Aug 2001 17:23:18 -0400
Message-ID: <3B802776.5F4F39D9@mindspring.com>
Date: Sun, 19 Aug 2001 13:54:14 -0700
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.9 compiler warnings & errors NTFS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay I tried kernel the patch to 2.4.9 (I applied 2.4.8 patch on top of
a 2.4.7 kernel then 2.4.9 patch).

The NTFS module wont build in 2.4.9.  It seems that there is a missing
include file in fs/ntfs/unistr.c .  After I added

#include <linux/fs.h>

to the file it seems to have fixed the problem. (patch at bottom of
mail)

Joe

The following is the error before I added the include:

make[3]: Circular passthrough.h <- hwaccess.h dependency dropped.
namei.c: In function `msdos_lookup':
namei.c:237: warning: implicit declaration of function `fat_brelse'
namei.c: In function `msdos_add_entry':
namei.c:266: warning: implicit declaration of function
`fat_mark_buffer_dirty'
unistr.c: In function `ntfs_collate_names':
unistr.c:99: warning: implicit declaration of function `min'
unistr.c:99: parse error before `unsigned'
unistr.c:99: parse error before `)'
unistr.c:97: warning: `c1' might be used uninitialized in this function
unistr.c: At top level:
unistr.c:118: parse error before `if'
unistr.c:123: warning: type defaults to `int' in declaration of `c1'
unistr.c:123: `name1' undeclared here (not in a function)
unistr.c:123: warning: data definition has no type or storage class
unistr.c:124: parse error before `if'
make[2]: *** [unistr.o] Error 1
make[1]: *** [_modsubdir_ntfs] Error 2
make: *** [_mod_fs] Error 2
cp: cannot stat `ntfs.o': No such file or directory


This is the error after I added the include. (It compiled too)

sym53c8xx.c: In function `ncr_soft_reset':
sym53c8xx.c:6994: warning: `istat' might be used uninitialized in this
function
make[3]: Circular passthrough.h <- hwaccess.h dependency dropped.
namei.c: In function `msdos_lookup':
namei.c:237: warning: implicit declaration of function `fat_brelse'
namei.c: In function `msdos_add_entry':
namei.c:266: warning: implicit declaration of function
`fat_mark_buffer_dirty'
dir.c: In function `umsdos_readdir_x':
dir.c:142: warning: passing arg 3 of `fat_readdir' from incompatible
pointer type
dir.c: In function `UMSDOS_readdir':
dir.c:315: warning: passing arg 5 of `umsdos_readdir_x' from
incompatible pointer type
ioctl.c: In function `UMSDOS_ioctl_dir':
ioctl.c:146: warning: passing arg 3 of `fat_readdir' from incompatible
pointer type
rdir.c: In function `UMSDOS_rreaddir':
rdir.c:70: warning: passing arg 3 of `fat_readdir' from incompatible
pointer type

################## patch

--- fs/ntfs/unistr.c Sun Aug 19 12:31:03 2001
+++ linux-test/fs/ntfs/unistr.c Sun Aug 19 13:32:46 2001
@@ -24,6 +24,8 @@
 #include <linux/string.h>
 #include <asm/byteorder.h>

+#include <linux/fs.h>
+
 #include "unistr.h"
 #include "macros.h"




