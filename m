Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751950AbWFWTEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbWFWTEL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbWFWTEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:04:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:28618 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751944AbWFWTDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:03:43 -0400
Message-Id: <20060623185825.158050000@klappe.arndb.de>
References: <20060623185746.037897000@klappe.arndb.de>
Date: Fri, 23 Jun 2006 20:57:51 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 5/5] spufs: fix spufs_mfc_flush prototype
Content-Disposition: inline; filename=spufs-flush.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The prototype for the flush file operation now has another
argument in 2.6.18.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linus-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -1150,7 +1150,7 @@ static unsigned int spufs_mfc_poll(struc
 	return mask;
 }
 
-static int spufs_mfc_flush(struct file *file)
+static int spufs_mfc_flush(struct file *file, fl_owner_t id)
 {
 	struct spu_context *ctx = file->private_data;
 	int ret;
@@ -1176,7 +1176,7 @@ out:
 static int spufs_mfc_fsync(struct file *file, struct dentry *dentry,
 			   int datasync)
 {
-	return spufs_mfc_flush(file);
+	return spufs_mfc_flush(file, 0);
 }
 
 static int spufs_mfc_fasync(int fd, struct file *file, int on)

--

