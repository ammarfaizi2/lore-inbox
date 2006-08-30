Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWH3Mpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWH3Mpw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWH3Mpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:45:51 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:62446 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750912AbWH3Mpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:45:46 -0400
Date: Wed, 30 Aug 2006 14:45:44 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] __exit cleanup.
Message-ID: <20060830124544.GI22276@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] __exit cleanup.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/hypfs/hypfs_diag.c   |    2 +-
 arch/s390/kernel/vmlinux.lds.S |    2 +-
 drivers/s390/block/dasd_eer.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/arch/s390/hypfs/hypfs_diag.c linux-2.6-patched/arch/s390/hypfs/hypfs_diag.c
--- linux-2.6/arch/s390/hypfs/hypfs_diag.c	2006-08-30 14:24:50.000000000 +0200
+++ linux-2.6-patched/arch/s390/hypfs/hypfs_diag.c	2006-08-30 14:25:01.000000000 +0200
@@ -535,7 +535,7 @@ __init int hypfs_diag_init(void)
 	return rc;
 }
 
-__exit void hypfs_diag_exit(void)
+void hypfs_diag_exit(void)
 {
 	diag224_delete_name_table();
 	diag204_free_buffer();
diff -urpN linux-2.6/arch/s390/kernel/vmlinux.lds.S linux-2.6-patched/arch/s390/kernel/vmlinux.lds.S
--- linux-2.6/arch/s390/kernel/vmlinux.lds.S	2006-08-30 14:24:47.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/vmlinux.lds.S	2006-08-30 14:25:01.000000000 +0200
@@ -118,7 +118,7 @@ SECTIONS
 
   /* Sections to be discarded */
   /DISCARD/ : {
-	*(.exitcall.exit)
+	*(.exit.text) *(.exit.data) *(.exitcall.exit)
 	}
 
   /* Stabs debugging sections.  */
diff -urpN linux-2.6/drivers/s390/block/dasd_eer.c linux-2.6-patched/drivers/s390/block/dasd_eer.c
--- linux-2.6/drivers/s390/block/dasd_eer.c	2006-08-30 14:24:12.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eer.c	2006-08-30 14:25:01.000000000 +0200
@@ -678,7 +678,7 @@ int __init dasd_eer_init(void)
 	return 0;
 }
 
-void __exit dasd_eer_exit(void)
+void dasd_eer_exit(void)
 {
 	WARN_ON(misc_deregister(&dasd_eer_dev) != 0);
 }
