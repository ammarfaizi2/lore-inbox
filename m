Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbSK1DFi>; Wed, 27 Nov 2002 22:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265111AbSK1DFi>; Wed, 27 Nov 2002 22:05:38 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:36027 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S265114AbSK1DFi>; Wed, 27 Nov 2002 22:05:38 -0500
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15845.35413.304242.606651@sofia.bsd2.kbnes.nec.co.jp>
Date: Thu, 28 Nov 2002 12:15:33 +0900
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/namei.c fix
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of Greg KH's security cleanups reversed the sense of a test.
Without this patch, 2.5.50 oopses at boot.  Please apply.

===== fs/namei.c 1.59 vs edited =====
--- 1.59/fs/namei.c	Thu Nov 28 08:11:14 2002
+++ edited/fs/namei.c	Thu Nov 28 12:09:53 2002
@@ -1648,7 +1648,7 @@
 		error = -EBUSY;
 	else {
 		error = security_inode_unlink(dir, dentry);
-		if (error)
+		if (!error)
 			error = dir->i_op->unlink(dir, dentry);
 	}
 	up(&dentry->d_inode->i_sem);



