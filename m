Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVHDPkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVHDPkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVHDPiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:38:10 -0400
Received: from smtp5.clb.oleane.net ([213.56.31.25]:26827 "EHLO
	smtp5.clb.oleane.net") by vger.kernel.org with ESMTP
	id S262585AbVHDPgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:36:43 -0400
Date: Thu, 4 Aug 2005 17:36:13 +0200
From: Christophe Lucas <clucas@rotomalug.org>
To: akpm@osdl.org, kernel-janitors@lists.osdl.org
Cc: domen@coderock.org, linux-kernel@vger.kernel.org
Message-ID: <20050804153613.GC25500@rhum.iomeda.fr>
References: <20050727130115.GE5089@rhum.iomeda.fr>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20050727130115.GE5089@rhum.iomeda.fr>
X-Operating-System: Debian GNU/Linux / 2.6.13-rc3-kj (i686)
X-Homepage: http://odie.mcom.fr/~clucas/
X-Crypto: GnuPG/1.2.4 http://www.gnupg.org
X-GPG-Key: http://odie.mcom.fr/~clucas/downloads/clucas-public-key.txt
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Mail-From: clucas@rotomalug.org
Subject: [PATCH] sh64 (mm/ioremap.c): procfs_failure && create_proc*
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 3.1 (built mer oct 29 11:46:13 CET 2003)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

description:
audit return code of create_proc_* function is a entry in janitors
TODO list. Audit this return and printk() when it fails, can spam a lot
system without compiled proc support. So this patch can audit return
code by means of procfs_failure().

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>

diff -urpNX dontdiff linux-2.6.13-rc4-mm1.orig/arch/sh64/mm/ioremap.c linux-2.6.13-rc4-mm1/arch/sh64/mm/ioremap.c
--- linux-2.6.13-rc4-mm1.orig/arch/sh64/mm/ioremap.c	2005-07-29 00:44:44.000000000 +0200
+++ linux-2.6.13-rc4-mm1/arch/sh64/mm/ioremap.c	2005-08-03 12:41:14.000000000 +0200
@@ -460,9 +460,11 @@ ioremap_proc_info(char *buf, char **star
 
 static int __init register_proc_onchip(void)
 {
-#ifdef CONFIG_PROC_FS
-	create_proc_read_entry("io_map",0,0, ioremap_proc_info, &shmedia_iomap);
-#endif
+	struct proc_dir_entry* ent;
+	ent = create_proc_read_entry("io_map",0,0, 
+		ioremap_proc_info, &shmedia_iomap);
+	if (!ent)
+		procfs_failure("ioremap.c: Unable to create /proc entry.\n");
 	return 0;
 }
 
