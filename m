Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316214AbSFJUiM>; Mon, 10 Jun 2002 16:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316195AbSFJUgj>; Mon, 10 Jun 2002 16:36:39 -0400
Received: from psmtp1.dnsg.net ([193.168.128.41]:29610 "HELO psmtp1.dnsg.net")
	by vger.kernel.org with SMTP id <S316192AbSFJUg3>;
	Mon, 10 Jun 2002 16:36:29 -0400
Subject: 2.5.21 - remove ccwcache_init.
To: linux-kernel@vger.kernel.org
Date: Tue, 11 Jun 2002 00:24:42 +0200 (CEST)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17HXac-0000Y0-00@skybase>
From: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
with the new dasd driver that has been added with 2.5.21 the ccwcache is a
thing of the past. The initialization call ccwcache_init() in init/main.c is
the only thing left of it and has to go. This removes another one of those
ugly early initialization calls for s390.

blue skies,
  Martin.

diff -urN linux-2.5.21/init/main.c linux-2.5.21-s390/init/main.c
--- linux-2.5.21/init/main.c	Sun Jun  9 07:27:42 2002
+++ linux-2.5.21-s390/init/main.c	Mon Jun 10 11:30:35 2002
@@ -34,7 +34,6 @@
 
 #if defined(CONFIG_ARCH_S390)
 #include <asm/s390mach.h>
-#include <asm/ccwcache.h>
 #endif
 
 #ifdef CONFIG_MTRR
@@ -393,9 +392,6 @@
 	buffer_init();
 	vfs_caches_init(mempages);
 	radix_tree_init();
-#if defined(CONFIG_ARCH_S390)
-	ccwcache_init();
-#endif
 	signals_init();
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
