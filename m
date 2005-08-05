Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263039AbVHEPmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbVHEPmh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVHEPja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:39:30 -0400
Received: from smtp6.clb.oleane.net ([213.56.31.26]:37830 "EHLO
	smtp6.clb.oleane.net") by vger.kernel.org with ESMTP
	id S263058AbVHEPi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:38:56 -0400
Date: Fri, 5 Aug 2005 17:38:47 +0200
From: Christophe Lucas <clucas@rotomalug.org>
To: akpm@osdl.org, kernel-janitors@lists.osdl.org
Cc: domen@coderock.org, linux-kernel@vger.kernel.org
Message-ID: <20050805153847.GI5233@rhum.iomeda.fr>
Mime-Version: 1.0
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux / 2.6.13-rc3-kj (i686)
X-Homepage: http://odie.mcom.fr/~clucas/
X-Crypto: GnuPG/1.2.4 http://www.gnupg.org
X-GPG-Key: http://odie.mcom.fr/~clucas/downloads/clucas-public-key.txt
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Mail-From: clucas@rotomalug.org
Subject: [PATCH] sh64 (kernel/process.c): procfs_failure && create_proc*
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

diff -urpNX dontdiff linux-2.6.13-rc4-mm1.orig/arch/sh64/kernel/process.c linux-2.6.13-rc4-mm1/arch/sh64/kernel/process.c
--- linux-2.6.13-rc4-mm1.orig/arch/sh64/kernel/process.c	2005-07-29 00:44:44.000000000 +0200
+++ linux-2.6.13-rc4-mm1/arch/sh64/kernel/process.c	2005-08-03 12:42:07.000000000 +0200
@@ -953,8 +953,11 @@ asids_proc_info(char *buf, char **start,
 
 static int __init register_proc_asids(void)
 {
-  create_proc_read_entry("asids", 0, NULL, asids_proc_info, NULL);
-  return 0;
+	struct proc_dir_entry* ent;
+	ent = create_proc_read_entry("asids", 0, NULL, asids_proc_info, NULL);
+	if (!ent)
+		procfs_failure("process: Unable to create asids /proc entry.\n");
+	return 0;
 }
 
 __initcall(register_proc_asids);
