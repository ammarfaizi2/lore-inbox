Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289487AbSAVWRL>; Tue, 22 Jan 2002 17:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289486AbSAVWRC>; Tue, 22 Jan 2002 17:17:02 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:4871 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id <S289484AbSAVWQr>; Tue, 22 Jan 2002 17:16:47 -0500
Date: Tue, 22 Jan 2002 17:16:45 -0500
Message-Id: <200201222216.g0MMGj317058@enterprise.bidmc.harvard.edu>
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
To: linux-kernel@vger.kernel.org
CC: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [Patch - 2.4.17++] Fix undefined ksym in minix.o, ext2.o, sysv.o
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, et al,

Compiling minix as a module results in an unresolved symbol,
waitfor_one_page:

pinhead:~# depmod -a -e
depmod: *** Unresolved symbols in
/lib/modules/BootsAs/n18p4/kernel/fs/minix/minix.o
depmod:         waitfor_one_page
pinhead:~#

Looks as if EXT2 and SYSV are also affected.

Trivial patch [tested on i386] appended.

Kris

##################

--- linux-2.4.18p6/kernel/ksyms.c	Tue Jan 22 17:12:25 2002
+++ linux/kernel/ksyms.c	Tue Jan 22 17:01:25 2002
@@ -268,6 +268,9 @@
 EXPORT_SYMBOL(lock_may_read);
 EXPORT_SYMBOL(lock_may_write);
 EXPORT_SYMBOL(dcache_readdir);
+#if defined(CONFIG_EXT2_FS)||defined(CONFIG_MINIX_FS)||defined(CONFIG_SYSV_FS)
+EXPORT_SYMBOL(waitfor_one_page);
+#endif
 
 /* for stackable file systems (lofs, wrapfs, cryptfs, etc.) */
 EXPORT_SYMBOL(default_llseek);
