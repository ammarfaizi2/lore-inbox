Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270657AbRHNSbO>; Tue, 14 Aug 2001 14:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270651AbRHNSaO>; Tue, 14 Aug 2001 14:30:14 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:65296 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S270643AbRHNSaI>; Tue, 14 Aug 2001 14:30:08 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix fat/msdos warning
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 14 Aug 2001 18:05:30 +0900
Message-ID: <877kw7royt.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

fixed the warning of fat/msdos. 

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.4.9-pre3/fs/fat/cache.c warning-2.4.9-pre3/fs/fat/cache.c
--- linux-2.4.9-pre3/fs/fat/cache.c	Tue Aug 14 17:43:13 2001
+++ warning-2.4.9-pre3/fs/fat/cache.c	Tue Aug 14 17:25:13 2001
@@ -15,6 +15,8 @@
 #include <linux/stat.h>
 #include <linux/fat_cvf.h>
 
+#include "msbuffer.h"
+
 #if 0
 #  define PRINTK(x) printk x
 #else
diff -urN linux-2.4.9-pre3/fs/fat/dir.c warning-2.4.9-pre3/fs/fat/dir.c
--- linux-2.4.9-pre3/fs/fat/dir.c	Thu Apr 19 03:49:12 2001
+++ warning-2.4.9-pre3/fs/fat/dir.c	Tue Aug 14 17:25:13 2001
@@ -590,7 +590,7 @@
 	void * buf,
 	const char * name,
 	int name_len,
-	off_t offset,
+	loff_t offset,
 	ino_t ino,
 	unsigned int d_type)
 {
diff -urN linux-2.4.9-pre3/fs/msdos/namei.c warning-2.4.9-pre3/fs/msdos/namei.c
--- linux-2.4.9-pre3/fs/msdos/namei.c	Tue Aug 14 17:43:13 2001
+++ warning-2.4.9-pre3/fs/msdos/namei.c	Tue Aug 14 17:25:13 2001
@@ -17,6 +17,8 @@
 
 #include <asm/uaccess.h>
 
+#include "../fat/msbuffer.h"
+
 #define MSDOS_DEBUG 0
 #define PRINTK(x)
 

