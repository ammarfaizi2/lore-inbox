Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293132AbSB1Xze>; Thu, 28 Feb 2002 18:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310208AbSB1XxH>; Thu, 28 Feb 2002 18:53:07 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:8905 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S310204AbSB1Xt3>; Thu, 28 Feb 2002 18:49:29 -0500
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: nfs-devel@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.5: compile error in fs/filesystems.c
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Fri, 01 Mar 2002 00:49:15 +0100
Message-ID: <87vgchi2v8.fsf@tigram.bogus.local>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

here is a patch to fix fs/filesystems.c, if you configure neither NFSD
nor NFSD_MODULE, but CONFIG_MODULES.

Regards, Olaf.

--- v2.5.5/fs/filesystems.c	Thu Feb 28 22:41:18 2002
+++ linux/fs/filesystems.c	Fri Mar  1 00:16:29 2002
@@ -15,14 +15,17 @@
 #include <linux/linkage.h>
 
 #if ! defined(CONFIG_NFSD)
+#if defined(CONFIG_NFSD_MODULES)
 struct nfsd_linkage *nfsd_linkage;
+EXPORT_SYMBOL(nfsd_linkage);
+#endif
 
 long
 asmlinkage sys_nfsservctl(int cmd, void *argp, void *resp)
 {
 	int ret = -ENOSYS;
 	
-#if defined(CONFIG_MODULES)
+#if defined(CONFIG_NFSD_MODULES)
 	lock_kernel();
 
 	if (nfsd_linkage ||
@@ -36,6 +39,5 @@
 #endif
 	return ret;
 }
-EXPORT_SYMBOL(nfsd_linkage);
 
 #endif /* CONFIG_NFSD */
