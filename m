Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271798AbRH1QKN>; Tue, 28 Aug 2001 12:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271801AbRH1QKE>; Tue, 28 Aug 2001 12:10:04 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:38666 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S271798AbRH1QJu>; Tue, 28 Aug 2001 12:09:50 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix msdos warnings
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 29 Aug 2001 01:09:54 +0900
Message-ID: <87vgj8f9nx.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

gcc -D__KERNEL__ -I/devel/src/linux/source/msdos_warning-2.4.10-pre1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o namei.o namei.c
namei.c: In function `msdos_lookup':
namei.c:237: warning: implicit declaration of function `fat_brelse'
namei.c: In function `msdos_add_entry':
namei.c:266: warning: implicit declaration of function `fat_mark_buffer_dirty'
gcc -D__KERNEL__ -I/devel/src/linux/source/msdos_warning-2.4.10-pre1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -DEXPORT_SYMTAB -c msdosfs_syms.c
rm -f msdos.o
ld -m elf_i386  -r -o msdos.o namei.o msdosfs_syms.o

The following patch fix the above warnings.
Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.4.10-pre1/fs/msdos/namei.c msdos_warning-2.4.10-pre1/fs/msdos/namei.c
--- linux-2.4.10-pre1/fs/msdos/namei.c	Mon Aug 13 03:13:59 2001
+++ msdos_warning-2.4.10-pre1/fs/msdos/namei.c	Tue Aug 28 23:26:48 2001
@@ -17,6 +17,8 @@
 
 #include <asm/uaccess.h>
 
+#include "../fat/msbuffer.h"
+
 #define MSDOS_DEBUG 0
 #define PRINTK(x)

