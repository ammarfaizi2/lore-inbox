Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317576AbSG2SXF>; Mon, 29 Jul 2002 14:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317579AbSG2SXF>; Mon, 29 Jul 2002 14:23:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:6288 "EHLO e1.ny.us.ibm.com.")
	by vger.kernel.org with ESMTP id <S317576AbSG2SW6>;
	Mon, 29 Jul 2002 14:22:58 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200207291825.g6TIPj026021@eng2.beaverton.ibm.com>
Subject: [PATCH] vfs_read/vfs_write small bug fix (2.5.29)
To: linux-kernel@vger.kernel.org
Date: Mon, 29 Jul 2002 11:25:45 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch to fix small bug in for vfs_read/vfs_write.

Please apply.

Thanks,
Badari

--- linux-2.5.29/fs/read_write.c	Mon Jul 29 11:07:32 2002
+++ linux.new/fs/read_write.c	Mon Jul 29 11:07:57 2002
@@ -184,7 +184,7 @@
 		return -EBADF;
 	if (!file->f_op || !file->f_op->read)
 		return -EINVAL;
-	if (pos < 0)
+	if (*pos < 0)
 		return -EINVAL;
 
 	ret = locks_verify_area(FLOCK_VERIFY_READ, inode, file, *pos, count);
@@ -209,7 +209,7 @@
 		return -EBADF;
 	if (!file->f_op || !file->f_op->write)
 		return -EINVAL;
-	if (pos < 0)
+	if (*pos < 0)
 		return -EINVAL;
 
 	ret = locks_verify_area(FLOCK_VERIFY_WRITE, inode, file, *pos, count);
