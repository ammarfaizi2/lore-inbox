Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWC0T1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWC0T1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 14:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWC0T1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 14:27:51 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:64723 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751440AbWC0T1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 14:27:50 -0500
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH] fix __init/__exit annotations for spufs
Date: Mon, 27 Mar 2006 21:27:40 +0200
User-Agent: KMail/1.9.1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
In-Reply-To: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603272127.40590.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spufs_init and spufs_exit should be marked correctly so
they can be removed when not needed.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/inode.c
@@ -442,7 +442,7 @@ static struct file_system_type spufs_typ
 	.kill_sb = kill_litter_super,
 };
 
-static int spufs_init(void)
+static int __init spufs_init(void)
 {
 	int ret;
 	ret = -ENOMEM;
@@ -472,7 +472,7 @@ out:
 }
 module_init(spufs_init);
 
-static void spufs_exit(void)
+static void __exit spufs_exit(void)
 {
 	spu_sched_exit();
 	unregister_spu_syscalls(&spufs_calls);
