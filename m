Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283497AbRK3Eqo>; Thu, 29 Nov 2001 23:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283500AbRK3Eqg>; Thu, 29 Nov 2001 23:46:36 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:26642 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S283497AbRK3EqX>; Thu, 29 Nov 2001 23:46:23 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix tty_io.c warning
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 30 Nov 2001 13:45:53 +0900
Message-ID: <87adx4zx1a.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/devel/src/linux/source/linux-2.5.1-pre4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c tty_io.c
tty_io.c: In function `tty_init':
tty_io.c:2322: warning: implicit declaration of function `console_map_init'

The following patch fix the above warning. Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--- linux-2.5.1-pre4.orig/drivers/char/tty_io.c	Fri Nov 30 12:24:28 2001
+++ linux-2.5.1-pre4/drivers/char/tty_io.c	Fri Nov 30 13:01:04 2001
@@ -102,10 +102,6 @@
 
 #include <linux/kmod.h>
 
-#ifdef CONFIG_VT
-extern void con_init_devfs (void);
-#endif
-
 #define CONSOLE_DEV MKDEV(TTY_MAJOR,0)
 #define TTY_DEV MKDEV(TTYAUX_MAJOR,0)
 #define SYSCONS_DEV MKDEV(TTYAUX_MAJOR,1)
@@ -2246,6 +2242,8 @@
 static struct tty_driver dev_ptmx_driver;
 #endif
 #ifdef CONFIG_VT
+extern void con_init_devfs (void);
+extern void console_map_init(void);
 static struct tty_driver dev_console_driver;
 #endif
 
